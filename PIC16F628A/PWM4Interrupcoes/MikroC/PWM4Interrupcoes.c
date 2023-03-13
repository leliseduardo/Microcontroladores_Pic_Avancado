/* 

        Neste c�digo iremos fazer todos os timers (tmr0, tmr1, tmr2) ter o mesmo tempo de interrup��o (overflow)
        
        Considerando:

                     Clock = 4MHz e Ciclo de maquina = 1us
                     
         Timer0:
         overflow = ciclo de maquina x prescaler x TMR0
         overflow = 1us x 1 x 256 = 256us
         
         Timer1:
         overflow = ciclo de maquina x prescaler x TMR1L
         overflow = 1us x 1 x 256 = 256us
         
         Timer0:
         overflow = ciclo de maquina x prescaler x tmr2
         overflow = 1us x 1 x 256 = 256us
         
         Esse tempo para a interrup��o resulta numa frequencia de:
         
         f = 1/256us = 3906 Hz ~= 4KHz
*/

// Lcd pinout settings
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// Configura��o de hardware
#define led0 RA2_bit
#define led1 RA1_bit
#define botAumenta RA5_bit
#define botDiminui RA3_bit
#define pwmOut1 RA0_bit
#define pwmOut2 RA4_bit // RB4 � um pino de dreno aberto, e s� funciona como current sinking ou com um circuito externo para fazer sourcing
#define pwmOut3 RB1_bit

// Fun��o auxiliar
void alteraPWM();

// Vari�veis auxiliares
unsigned char PWM1, PWM2, PWM3;
unsigned char controlPWM = 0x01;
char txt[7];
bit botA,
    botD;
    
void interrupt(){

     if(INTF_bit){
     
       INTF_bit = 0x00;
       
       controlPWM++;
       
       if(controlPWM > 3) controlPWM = 0x01;
     }
     
     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       
       if(pwmOut1){
         
         TMR0 = PWM1;
         pwmOut1 = 0x00;
       }
       else{

         TMR0 = 255 - PWM1;
         pwmOut1 = 0x01;
       }
     }
     
     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1H = 0xFF;
       
       if(pwmOut2){

         TMR1L = PWM2;
         pwmOut2 = 0x00;
       }
       else{
       
         TMR1L = 255 - PWM2;
         pwmOut2 = 0x01;
       }
     }
     
     if(TMR2IF_bit){
     
       TMR2IF_bit = 0x00;
       
       if(pwmOut3){
       
         TMR2 = PWM3;
         pwmOut3 = 0x00;
       }
       else{
       
         TMR2 = 255 - PWM3;
         pwmOut3 = 0x01;
       }
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos

     // Registradores do timer0, timer1, timer2 e interrup��o externa

     // Timer0, interru��o externa, interrup��o global e por perif�ricos
     OPTION_REG = 0x88; // Liga pullups internos, interrup. externa por borda de descida, tmr0 por ciclo de maquina interno, utilizando
                        // prescaler associado ao WTD em 1:1
     INTCON = 0xF0; // Habilita a interrup��o global, por perif�ricos e ativa a interrup��o do timer1 e interrup��o externa

     // Timer1
     T1CON = 0x01; // Ativa o timer1 e configura o prescaler para 1:1
     TMR1IE_bit = 0x01; // Habilita a interrup��o pelo timer1. Essa flag � do registrador PIE1
     TMR1H = 0xFF; // Fazendo o neeble mais significativo igual a 0xFF = 0b11111111, simula-se um timer de 8 bits, j� que tmr1 � de 16
                   // Assim, quando TMR1L contar at� 255, o tmr1 estoura, pois TMR1H j� est� em 255. Logo, tmr1 conta 8 bits somente
                   
     // Timer2
     T2CON = 0x04; // Ativa o timer2 e configura o prescaler para 1:1 e o postscaler para 1:1
     TMR2IE_bit = 0x01; // Habilita a interrup��o do timer2, comparando TMR2 com PR2
     PR2 = 0xFF; // Faz o TMR2 contar at� 0xFF. O TMR2, diferentemente de TMR0 e TMR1, conta de 0 at� um n�mero, e n�o a partir de um
                 // n�mero at� 255. O n�mero que o TMR2 conta at� ele, � o PR2, como PR2 = 0xFF, TMR2 conta at� 0xFF

     // Registradores de ports
     
     TRISA = 0xE8; // Configura apenas RA0, RA1 e RA4 como sa�das digitais
     TRISB = 0x01; // Configura todo o portb como sa�da digital
     PORTA = 0xE8; // Inicia apenas RA0, RA1 e RA4 em Low
     PORTB = 0x01; // Inicia todo portb em Low
     
     // Inicializa��o de vari�veis
     
     botA = 0x00;
     botD = 0x00;
     
     PWM1 = 0x80;  // Inicia os tr�s PWMs em 0x80 (hexadecimal) = 128 (decimal), que corresponde a um dutyCicle de 50%
     PWM2 = 0x80;
     PWM3 = 0x80;
     
     // Inicializa��o do display lcd
     
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     delay_ms(100);
     
     while(1){
     
       alteraPWM();
     }
}

void alteraPWM(){

     if(!botAumenta) botA = 0x01;
     if(!botDiminui) botD = 0x01;
     
     if(botAumenta && botA){  // Este if, que teste se o botao n�o est� pressionado e testa se a vari�vel bot1 est� em 0x01, � uma forma
                              // de fazer com que o if s� funcione se retirarmos o dedo do botao. � uma alternativa para o bouncing
       botA = 0x00;
       
       switch(controlPWM){
       
         case 0x01: PWM1 = PWM1 + 4;
         break;
         case 0x02: PWM2 = PWM2 + 4;
         break;
         case 0x03: PWM3 = PWM3 + 4;
         break;
       }
     }
     
     if(botDiminui && botD){
     
       botD = 0x00;
     
       switch(controlPWM){
       
         case 0x01: PWM1 = PWM1 - 4;
         break;
         case 0x02: PWM2 = PWM2 - 4;
         break;
         case 0x03: PWM3 = PWM3 - 4;
         break;
       }
     }
     
     switch(controlPWM){
     
       case 0x01: 
            led0 = 0x01;
            led1 = 0x00;
            lcd_out(1,1, "PWM 1");
            IntToStr(PWM1, txt);
            lcd_out(2,1, txt);
       break;
       case 0x02:
            led0 = 0x00;
            led1 = 0x01;
            lcd_out(1,1, "PWM 2");
            IntToStr(PWM2, txt);
            lcd_out(2,1, txt);
       break;
       case 0x03:
            led0 = 0x01;
            led1 = 0x01;
            lcd_out(1,1, "PWM 3");
            IntToStr(PWM3, txt);
            lcd_out(2,1, txt);
       break;
     }
}
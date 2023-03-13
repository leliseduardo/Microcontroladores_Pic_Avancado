/* 

        O obejtivo deste programa é ajustar o brilho e o contraste do display lcd através do encoder. Para isso, serão usados os dois últimos pro-
    jetos, denominados "BrilhoContraste" e "EncoderSimples". Os dois programas irão se complementar. a função leitura_Encoder do programa
    "EncoderSimples" irá substituir a função leitura_botoes do programa "BrilhoContraste". Por outro lado, a função leitura_Encoder irá incrementar
    duty1 e duty2, ao invés das variáveis cont, usadas do programa "EncoderSimples". Ainda, o encoder usa o timer1, que será acrescentado. Ou seja,
    os programas se complementam.
        Este programa e circuito são muito importantes e de grande aprendizado. Com ele, consegui usar o encoder rotativo pela primeira vez e,
    ainda, aprendi um novo tipo de driver, o que utiliza o filtro passa-baixas e o buffer. No programa, estão sendo usados três timers, o timer1,
    timer2 e timer3. A leitura do encoder está sendo feita por interrupção, e os dois pwm's que controlam brilho e contraste estão sendo feitos
    por interrupção, do timer2 e timer3. Logo, tanto na parte de eletrônica quanto de circuito, este programa é de muito aprendizado.

        A pinagem do encoder está descrita no caderno.
        
        O circuito e o programa funcionaram perfeitamente.

*/


// Configuração do display lcd
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

// Mapeamento de hardware
#define encoderA RB0_bit
#define encoderB RB1_bit
#define pwm1 LATC0_bit
#define pwm2 LATC1_bit
#define botao RC2_bit

// Funções auxiliares
void imprime_Display();
void leitura_Encoder();

// Variáveis auxiliares

unsigned short duty1 = 128,
               duty2 = 40;

char baseTempo = 0x00;

bit flagEnc;
bit control;
bit flagBotao;

// Funções de interrupção

void interrupt(){

     if(TMR1IF_bit){

       TMR1IF_bit = 0x00;
       TMR1H = 0xFF;
       TMR1L = 0x37;

       baseTempo += 0x01;

       if(baseTempo == 0x64){ // Lê o encoder a cada 5ms

         baseTempo = 0x00;

         leitura_Encoder();

       } // end if baseTempo == 0x64

     } // end TMR1IF_Bit

     if(TMR2IF_bit){

       TMR2IF_bit = 0x00;

       if(pwm1){

         TMR2 = duty1;
         pwm1 = 0x00;

       } // end if pwm1
       else{

         TMR2 = 255 - duty1;
         pwm1 = 0x01;

       } // end else pwm1

     } // end if TMR2IF_bit

     if(TMR3IF_bit){

       TMR3IF_bit = 0x00;
       TMR3H = 0xFF;

       if(pwm2){

         TMR3L = duty2;
         pwm2 = 0x00;

       } // end if pwm2
       else{

         TMR3L = 255 - duty2;
         pwm2 = 0x01;

       } // end else pwm2

     } // end if TMR3IF_bit

} // end void interrupt

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais
     TRISC = 0xFC; // Configura apenas RC0 e RC1 como saídas digitais
     LATC = 0xFC; // Inicia todas as saídas do portc em Low

     INTCON = 0xC0; // Habilita a interrupção global e por periféricos
     TMR1IE_bit = 0x01; // Registrador PIE1. Hablita a interrupção por overflow do timer1
     TMR2IE_bit = 0x01; // Registrador PIE1. Habilita a interrupção por overflow do timer2
     TMR3IE_bit = 0x01; // Resgistrador PIE2. Habilita a interrupção por overflow do timer3

     T1CON = 0x01; // Habilita o timer1, configura com 8 bits, prescale em 1:1, incrementa com ciclo de maquina
     TMR1H = 0xFF;
     TMR1L = 0x37; // Inicia em 55 para uma contagem de 200
     T2CON = 0x05; // Habilita o timer2, configura o prescale em 1:4 e o postscale em 1:1
     PR2 = 0xFF; // Configura a contagem do TMR2 até 0xFF = 255
     T3CON = 0x21; // Habilita o timer3, configura com 8 bits, prescale em 1:4 e incrementa com ciclo de clock
     TMR3H = 0xFF;
     TMR3L = 0x00;

     flagEnc = 0x00;
     control = 0x00;
     flagBotao = 0x00;

     // Inicialização do display lcd
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_chr(1, 1, 'B');
     lcd_chr_cp('r');
     lcd_chr_cp('i');
     lcd_chr_cp('l');
     lcd_chr_cp('h');
     lcd_chr_cp('o');
     lcd_chr_cp(':');
     lcd_chr_cp(' ');
     lcd_chr(2, 1, 'C');
     lcd_chr_cp('o');
     lcd_chr_cp('n');
     lcd_chr_cp('t');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('s');
     lcd_chr_cp('t');
     lcd_chr_cp('e');
     lcd_chr_cp(':');
     lcd_chr_cp(' ');

     // Loop infinito
     while(1){
     
       if(!botao) flagBotao = 0x01;
       
       if(botao && flagBotao){
       
         flagBotao = 0x00;
         control = ~control;
       
       } // end if botao && flagBotao

       imprime_Display();

     } // end Loop infinito

} // end void main


void imprime_Display(){

     char cen1, dez1, uni1, cen2, dez2, uni2;

     cen1 = duty1/100;
     dez1 = (duty1%100)/10;
     uni1 = duty1%10;

     lcd_chr(1, 9, cen1 + 0x30);
     lcd_chr_cp(dez1 + 0x30);
     lcd_chr_cp(uni1 + 0x30);

     cen2 = duty2/100;
     dez2 = (duty2%100)/10;
     uni2 = duty2%10;

     lcd_chr(2, 12, cen2 + 0x30);
     lcd_chr_cp(dez2 + 0x30);
     lcd_chr_cp(uni2 + 0x30);

} // end void imprime_Display()

void leitura_Encoder(){

     if(!encoderA){

       if(!flagEnc){

         if(!control){
           flagEnc = 0x01;
           duty1 += 0x01;
         } // end if !control
         if(control){
           flagEnc = 0x01;
           duty2 += 0x01;
         } // end if !control

       } // end if !flagEnc

     } // end if !encoderA
     else{

       if(!encoderB){

         if(!flagEnc){

           if(!control){
           flagEnc = 0x01;
           duty1 -= 0x01;
         } // end if !control
         if(control){
           flagEnc = 0x01;
           duty2 -= 0x01;
         } // end if !control

         } // end if !flagEnc

       } // end if !encoderB

     } // end else !encoderA

     if(encoderA){

       if(encoderB) flagEnc = 0x00;

     } // end if encoderA

} // end void leitura_Encoder
















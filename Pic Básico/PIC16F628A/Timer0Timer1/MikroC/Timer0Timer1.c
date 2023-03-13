#define luzLcd RB3_bit

sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// Variaveis globais
bit change;
unsigned cont1 = 0x00;
unsigned cont2 = 0x00;
char *txt1 = "Hakuna";
char *txt2 = "matata!";

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       TMR0 = 0x06;
       
       cont1++;
       
       if(cont1 == 500){
       
         cont1 = 0x00;
         
         luzLcd = ~luzLcd;
       }
     }
     
     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1H = 0xCF;
       TMR1L = 0x2C;
       
       cont2++;
       
       if(cont2 == 10){
       
         cont2 = 0;
         
         change = ~change;
       }
     }
}

/* 

   ciclo de maquina = 1 / (4MHz / 4) = 1us

   overflow = ciclo de maquina x prescaler x tmrX
   
   ******timer0, overflow = 1ms******
   
   tmr0 = overflow / (ciclo de maquina x prescaler) = 1ms / (1us x 4) = 250
   
   para contar até 250, tmr0 deve ser iniciado em 256 - 250 = 6. Logo, inicia-se tmr0 = 0x06;
   
   
   ******timer1, overflow = 100ms******
   
   tmr1 = overflow / (ciclo de maquina x prescaler) = 100ms / (1us * 8) = 12500
   
   para contar até 12500, (TMR1H::TMR1L) deve ser iniciado em 65536 - 12500 = 53036 = 0x CF 2C, ou seja, TMR1H = CF e TMR1L = 2C
*/

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     T1CON = 0x31; // Configura o prescaler do timer1 para 1:8 e ativa o timer1
     OPTION_REG = 0x81; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:4
     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x01; // Habilita a interrupção por perifericos
     T0IE_bit = 0x01; // Habilita a interrupção do timer0
     TMR1IE_bit = 0x01; // Habilita a interrupção do timer1
     
     TMR0 = 0x06; // Inicia a contagem do timer0 em 6
     TMR1H = 0xCF; // Inicia a contagem do timer1 em 53036
     TMR1L = 0x2C;
     TRISA = 0xFF; // Configura todo porta como entrada digital
     TRISB = 0x00; // COnfigura todo portb como saída digital
     PORTA = 0xFF; // Inicia todo porta em High
     PORTB = 0x00; // Inicia todo portb em Low
     
     change = 0x00;
     
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     delay_ms(100);
     
     while(1){
     
       if(!change)
         lcd_out(1,2,txt1);
       else
         lcd_out(1,2,txt2);
     }
}
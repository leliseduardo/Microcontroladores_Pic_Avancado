#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Timer0Timer1/MikroC/Timer0Timer1.c"


sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;


sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;


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

  RB3_bit  = ~ RB3_bit ;
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
#line 79 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Timer0Timer1/MikroC/Timer0Timer1.c"
void main() {

 CMCON = 0x07;
 T1CON = 0x31;
 OPTION_REG = 0x81;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;
 TMR1IE_bit = 0x01;

 TMR0 = 0x06;
 TMR1H = 0xCF;
 TMR1L = 0x2C;
 TRISA = 0xFF;
 TRISB = 0x00;
 PORTA = 0xFF;
 PORTB = 0x00;

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

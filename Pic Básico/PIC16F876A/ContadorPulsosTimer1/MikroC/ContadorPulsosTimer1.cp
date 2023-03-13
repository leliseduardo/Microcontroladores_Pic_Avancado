#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ContadorPulsosTimer1/MikroC/ContadorPulsosTimer1.c"

sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;


sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

unsigned pulse;

char txt[7];

void main() {

 CMCON = 0x07;
 T1CON = 0x03;


 TMR1L = 0x00;
 TMR1H = 0x00;

 TRISB = 0x03;
 TRISC = 0xEF;

 PORTB = 0x00;
 PORTC = 0xEF;
#line 51 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ContadorPulsosTimer1/MikroC/ContadorPulsosTimer1.c"
 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);

 while(1){

 lcd_out(1,1,"Pulse: ");

 pulse = (TMR1H << 8) + TMR1L;

 IntToStr(pulse, txt);

 lcd_out(2,1,txt);

 if(pulse > 20)
 RC4_bit = 0x01;
 }

}

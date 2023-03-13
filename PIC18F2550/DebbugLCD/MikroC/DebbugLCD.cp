#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/DebbugLCD/MikroC/DebbugLCD.c"
#line 15 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/DebbugLCD/MikroC/DebbugLCD.c"
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;


sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;






void imprime_Display();
void decimal_Hexadecimal(unsigned char n, unsigned char col);

void main() {

 ADCON1 = 0x0F;

 T0CON = 0x07;
 TMR0L = 0x00;
 TMR0H = 0x00;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);


 while(1){

 imprime_Display();
 decimal_Hexadecimal((unsigned char)TMR0H, 10);
 decimal_Hexadecimal((unsigned char)TMR0L, 12);

 if(! RC0_bit )
 TMR0ON_bit = 0x01;
 else
 TMR0ON_bit = 0x00;

 if(! RC1_bit ){

 T0PS2_bit = 0x00;
 T0PS1_bit = 0x00;
 T0PS0_bit = 0x00;



 }
 else {

 T0PS2_bit = 0x01;
 T0PS1_bit = 0x01;
 T0PS0_bit = 0x01;



 }

 }

}


void imprime_Display(){

 char cen, dez, uni;

 lcd_chr(2, 4, 'T');
 lcd_chr_cp('M');
 lcd_chr_cp('R');
 lcd_chr_cp('0');

}


void decimal_Hexadecimal(unsigned char n, unsigned char col){

 unsigned char valorL;
 unsigned char valorH;

 valorH = n & 0xF0;

 valorH = valorH >> 4;
 if(valorH > 0x09)
 valorH += 0x37;
 else
 valorH += 0x30;

 valorL = n & 0x0F;
 if(valorL > 0x09)
 valorL += 0x37;
 else
 valorL += 0x30;

 lcd_chr(2, col, valorH);
 lcd_chr_cp(valorL);

}

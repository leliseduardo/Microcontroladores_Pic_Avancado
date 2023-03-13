#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/ComparadorIntLuminosidade/MikroC/ComparadorIntLuminosidade.c"
#line 19 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/ComparadorIntLuminosidade/MikroC/ComparadorIntLuminosidade.c"
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;


sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;


void textoDisplay();
void luzBaixa();
void luzAlta();





void main() {


 CMCON = 0x04;

 TRISA = 0xFF;
 TRISB = 0xFE;
 LATB = 0x00;



 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);

 textoDisplay();


 while(1){

 if(C1OUT_bit){

 LATB0_bit = 0x01;
 luzBaixa();
 }
 else{

 LATB0_bit = 0x00;
 luzAlta();
 }
 }
}

void textoDisplay(){

 lcd_chr(1, 1, 'S');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp('r');
 lcd_chr_cp(' ');
 lcd_chr_cp('L');
 lcd_chr_cp('u');
 lcd_chr_cp('z');
}

void luzBaixa(){

 lcd_chr(2, 1, 'L');
 lcd_chr_cp('u');
 lcd_chr_cp('z');
 lcd_chr_cp(' ');
 lcd_chr_cp('B');
 lcd_chr_cp('a');
 lcd_chr_cp('i');
 lcd_chr_cp('x');
 lcd_chr_cp('a');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
}

void luzAlta(){

 lcd_chr(2, 1, 'L');
 lcd_chr_cp('u');
 lcd_chr_cp('z');
 lcd_chr_cp(' ');
 lcd_chr_cp('A');
 lcd_chr_cp('l');
 lcd_chr_cp('t');
 lcd_chr_cp('a');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/DisplayeADCSimples/MikroC/DisplayeLCDSimples.c"
#line 20 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/DisplayeADCSimples/MikroC/DisplayeLCDSimples.c"
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


void imprimeLCD();
void leituraADC();


int adc = 0x00;


void main() {

 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA = 0xFF;
 TRISB = 0x03;


 lcd_Init();
 lcd_Cmd(_LCD_CURSOR_OFF);
 lcd_Cmd(_LCD_CLEAR);

 while(1){

 imprimeLCD();
 leituraADC();
 }
}

void leituraADC(){

 unsigned char mil, cen, dez, uni;

 adc = adc_read(0);

 mil = adc/1000;
 cen = (adc%1000)/100;
 dez = (adc%100)/10;
 uni = adc%10;

 lcd_chr(2, 4, mil+48);
 lcd_chr_cp(cen+48);
 lcd_chr_cp(dez+48);
 lcd_chr_cp(uni+48);




}

void imprimeLCD(){

 lcd_chr(1, 2, 'L');
 lcd_chr_cp('e');
 lcd_chr_cp('i');
 lcd_chr_cp('t');
 lcd_chr_cp('u');
 lcd_chr_cp('r');
 lcd_chr_cp('a');
 lcd_chr_cp(' ');
 lcd_chr_cp('A');
 lcd_chr_cp('D');
 lcd_chr_cp('C');
}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/HexadecimalLCD/MikroC/HexadecimalLCD.c"
#line 12 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/HexadecimalLCD/MikroC/HexadecimalLCD.c"
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
void decimal_Hexadecimal(unsigned char n);


unsigned char valor = 0x00;

void main() {

 ADCON1 = 0x0F;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);


 while(1){

 valor += 0x01;

 imprime_Display();

 decimal_Hexadecimal(valor);

 delay_ms(1000);

 }

}


void imprime_Display(){

 char cen, dez, uni;

 lcd_chr(1, 1, 'D');
 lcd_chr_cp('e');
 lcd_chr_cp('c');
 lcd_chr_cp(' ');
 lcd_chr_cp('p');
 lcd_chr_cp('a');
 lcd_chr_cp('r');
 lcd_chr_cp('a');
 lcd_chr_cp(' ');
 lcd_chr_cp('H');
 lcd_chr_cp('e');
 lcd_chr_cp('x');
 lcd_chr_cp('a');
 lcd_chr_cp('d');
 lcd_chr_cp('e');
 lcd_chr_cp('c');

 cen = valor/100;
 dez = (valor%100)/10;
 uni = valor%10;

 lcd_chr(2, 2, cen + 0x30);
 lcd_chr_cp(dez + 0x30);
 lcd_chr_cp(uni + 0x30);

}


void decimal_Hexadecimal(unsigned char n){

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

 lcd_chr(2, 10, valorH);
 lcd_chr_cp(valorL);

}

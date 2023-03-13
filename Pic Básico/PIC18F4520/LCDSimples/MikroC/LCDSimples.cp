#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/LCDSimples/MikroC/LCDSimples.c"
#line 23 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/LCDSimples/MikroC/LCDSimples.c"
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




void HelloWorld();

void main() {

 ADCON0 = 0x00;
 ADCON1 = 0x0F;



 lcd_Init();
 lcd_Cmd(_LCD_CURSOR_OFF);
 lcd_Cmd(_LCD_CLEAR);

 while(1){

 HelloWorld();



 }
}


void HelloWorld(){

 lcd_Chr(1, 3, 'H');
 lcd_Chr_Cp('e');
 lcd_Chr_Cp('l');
 lcd_Chr_Cp('l');
 lcd_Chr_Cp('o');
 lcd_Chr_Cp(' ');
 lcd_Chr_Cp('W');
 lcd_Chr_Cp('o');
 lcd_Chr_Cp('r');
 lcd_Chr_Cp('l');
 lcd_Chr_Cp('d');
 lcd_Chr_Cp('!');

 lcd_Chr(2, 4, 'P');
 lcd_Chr_Cp('I');
 lcd_Chr_Cp('C');
 lcd_Chr_Cp('1');
 lcd_Chr_Cp('8');
 lcd_Chr_Cp('F');
 lcd_Chr_Cp('4');
 lcd_Chr_Cp('5');
 lcd_Chr_Cp('2');
 lcd_Chr_Cp('0');
}

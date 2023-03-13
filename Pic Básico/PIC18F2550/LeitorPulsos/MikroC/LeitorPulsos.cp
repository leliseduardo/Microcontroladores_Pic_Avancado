#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/LeitorPulsos/MikroC/LeitorPulsos.c"
#line 25 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/LeitorPulsos/MikroC/LeitorPulsos.c"
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


unsigned short cont = 0x00,
 pulso = 0x00;

int baseTempo = 0;



void interrupt(){

 if(INT0IF_bit){

 INT0IF_bit = 0x00;
 baseTempo = 0x00;
 pulso++;
 cont = pulso;

 }

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

 baseTempo++;

 if(baseTempo == 2000){

 baseTempo = 0;

 pulso = 0x00;

 }

 }

}


void main() {

 ADCON1 = 0x0F;
 TRISB = 0x03;

 INTCON = 0xD0;
 INTEDG0_bit = 0x01;
 TMR2ON_bit = 0x01;
 PR2 = 200;
 TMR2IE_bit = 0x01;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_chr(1, 1, 'P');
 lcd_chr_cp('u');
 lcd_chr_cp('l');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp(' ');
 lcd_chr_cp('S');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp('r');


 while(1){

 imprime_Display();

 }

}


void imprime_Display(){

 char cen, dez, uni;

 cen = cont/100;
 dez = (cont%100)/10;
 uni = cont%10;

 lcd_chr(2, 8, cen + 0x30);
 lcd_chr_cp(dez + 0x30);
 lcd_chr_cp(uni + 0x30);

}

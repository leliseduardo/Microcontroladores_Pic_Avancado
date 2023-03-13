#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/EncoderSimples/MikroC/EncoderSimples.c"
#line 23 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/EncoderSimples/MikroC/EncoderSimples.c"
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






void leitura_Encoder();
void imprime_Display();


char baseTempo = 0x00,
 cont = 0x00;

bit flagEnc;



void interrupt(){

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1H = 0xFF;
 TMR1L = 0x37;

 baseTempo += 0x01;

 if(baseTempo == 0x64){

 baseTempo = 0x00;

 leitura_Encoder();

 }

 }

}


void main() {

 ADCON1 = 0x0F;
 TRISB = 0x03;

 INTCON = 0xC0;
 TMR1IE_bit = 0x01;
 T1CON = 0x01;
 TMR1H = 0xFF;
 TMR1L = 0x37;

 flagEnc = 0x00;


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1, 2, "Teste Encoder");


 while(1){

 imprime_Display();

 }

}



void leitura_Encoder(){

 if(! RB0_bit ){

 if(!flagEnc){

 flagEnc = 0x01;
 cont += 0x01;

 }

 }
 else{

 if(! RB1_bit ){

 if(!flagEnc){

 flagEnc = 0x01;
 cont -= 0x01;

 }

 }

 }

 if( RB0_bit ){

 if( RB1_bit ) flagEnc = 0x00;

 }

}



void imprime_Display(){

 char cen, dez, uni;

 cen = cont/100;
 dez =(cont%100)/10;
 uni = cont%10;

 lcd_chr(2, 8, cen + 0x30);
 lcd_chr_cp(dez + 0x30);
 lcd_chr_cp(uni + 0x30);

}

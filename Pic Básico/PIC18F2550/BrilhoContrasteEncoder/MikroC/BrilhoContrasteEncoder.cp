#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/BrilhoContrasteEncoder/MikroC/BrilhoContrasteEncoder.c"
#line 22 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/BrilhoContrasteEncoder/MikroC/BrilhoContrasteEncoder.c"
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
void leitura_Encoder();



unsigned short duty1 = 128,
 duty2 = 40;

char baseTempo = 0x00;

bit flagEnc;
bit control;
bit flagBotao;



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

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

 if( LATC0_bit ){

 TMR2 = duty1;
  LATC0_bit  = 0x00;

 }
 else{

 TMR2 = 255 - duty1;
  LATC0_bit  = 0x01;

 }

 }

 if(TMR3IF_bit){

 TMR3IF_bit = 0x00;
 TMR3H = 0xFF;

 if( LATC1_bit ){

 TMR3L = duty2;
  LATC1_bit  = 0x00;

 }
 else{

 TMR3L = 255 - duty2;
  LATC1_bit  = 0x01;

 }

 }

}

void main() {

 ADCON1 = 0x0F;
 TRISB = 0x03;
 TRISC = 0xFC;
 LATC = 0xFC;

 INTCON = 0xC0;
 TMR1IE_bit = 0x01;
 TMR2IE_bit = 0x01;
 TMR3IE_bit = 0x01;

 T1CON = 0x01;
 TMR1H = 0xFF;
 TMR1L = 0x37;
 T2CON = 0x05;
 PR2 = 0xFF;
 T3CON = 0x21;
 TMR3H = 0xFF;
 TMR3L = 0x00;

 flagEnc = 0x00;
 control = 0x00;
 flagBotao = 0x00;


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_chr(1, 1, 'B');
 lcd_chr_cp('r');
 lcd_chr_cp('i');
 lcd_chr_cp('l');
 lcd_chr_cp('h');
 lcd_chr_cp('o');
 lcd_chr_cp(':');
 lcd_chr_cp(' ');
 lcd_chr(2, 1, 'C');
 lcd_chr_cp('o');
 lcd_chr_cp('n');
 lcd_chr_cp('t');
 lcd_chr_cp('r');
 lcd_chr_cp('a');
 lcd_chr_cp('s');
 lcd_chr_cp('t');
 lcd_chr_cp('e');
 lcd_chr_cp(':');
 lcd_chr_cp(' ');


 while(1){

 if(! RC2_bit ) flagBotao = 0x01;

 if( RC2_bit  && flagBotao){

 flagBotao = 0x00;
 control = ~control;

 }

 imprime_Display();

 }

}


void imprime_Display(){

 char cen1, dez1, uni1, cen2, dez2, uni2;

 cen1 = duty1/100;
 dez1 = (duty1%100)/10;
 uni1 = duty1%10;

 lcd_chr(1, 9, cen1 + 0x30);
 lcd_chr_cp(dez1 + 0x30);
 lcd_chr_cp(uni1 + 0x30);

 cen2 = duty2/100;
 dez2 = (duty2%100)/10;
 uni2 = duty2%10;

 lcd_chr(2, 12, cen2 + 0x30);
 lcd_chr_cp(dez2 + 0x30);
 lcd_chr_cp(uni2 + 0x30);

}

void leitura_Encoder(){

 if(! RB0_bit ){

 if(!flagEnc){

 if(!control){
 flagEnc = 0x01;
 duty1 += 0x01;
 }
 if(control){
 flagEnc = 0x01;
 duty2 += 0x01;
 }

 }

 }
 else{

 if(! RB1_bit ){

 if(!flagEnc){

 if(!control){
 flagEnc = 0x01;
 duty1 -= 0x01;
 }
 if(control){
 flagEnc = 0x01;
 duty2 -= 0x01;
 }

 }

 }

 }

 if( RB0_bit ){

 if( RB1_bit ) flagEnc = 0x00;

 }

}

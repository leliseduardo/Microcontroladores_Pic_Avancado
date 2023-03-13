#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/PWM4Interrupcoes/MikroC/PWM4Interrupcoes.c"
#line 27 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/PWM4Interrupcoes/MikroC/PWM4Interrupcoes.c"
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
#line 52 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/PWM4Interrupcoes/MikroC/PWM4Interrupcoes.c"
void alteraPWM();


unsigned char PWM1, PWM2, PWM3;
unsigned char controlPWM = 0x01;
char txt[7];
bit botA,
 botD;

void interrupt(){

 if(INTF_bit){

 INTF_bit = 0x00;

 controlPWM++;

 if(controlPWM > 3) controlPWM = 0x01;
 }

 if(T0IF_bit){

 T0IF_bit = 0x00;

 if( RA0_bit ){

 TMR0 = PWM1;
  RA0_bit  = 0x00;
 }
 else{

 TMR0 = 255 - PWM1;
  RA0_bit  = 0x01;
 }
 }

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1H = 0xFF;

 if( RA4_bit ){

 TMR1L = PWM2;
  RA4_bit  = 0x00;
 }
 else{

 TMR1L = 255 - PWM2;
  RA4_bit  = 0x01;
 }
 }

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

 if( RB1_bit ){

 TMR2 = PWM3;
  RB1_bit  = 0x00;
 }
 else{

 TMR2 = 255 - PWM3;
  RB1_bit  = 0x01;
 }
 }
}

void main() {

 CMCON = 0x07;




 OPTION_REG = 0x88;

 INTCON = 0xF0;


 T1CON = 0x01;
 TMR1IE_bit = 0x01;
 TMR1H = 0xFF;



 T2CON = 0x04;
 TMR2IE_bit = 0x01;
 PR2 = 0xFF;




 TRISA = 0xE8;
 TRISB = 0x01;
 PORTA = 0xE8;
 PORTB = 0x01;



 botA = 0x00;
 botD = 0x00;

 PWM1 = 0x80;
 PWM2 = 0x80;
 PWM3 = 0x80;



 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 delay_ms(100);

 while(1){

 alteraPWM();
 }
}

void alteraPWM(){

 if(! RA5_bit ) botA = 0x01;
 if(! RA3_bit ) botD = 0x01;

 if( RA5_bit  && botA){

 botA = 0x00;

 switch(controlPWM){

 case 0x01: PWM1 = PWM1 + 4;
 break;
 case 0x02: PWM2 = PWM2 + 4;
 break;
 case 0x03: PWM3 = PWM3 + 4;
 break;
 }
 }

 if( RA3_bit  && botD){

 botD = 0x00;

 switch(controlPWM){

 case 0x01: PWM1 = PWM1 - 4;
 break;
 case 0x02: PWM2 = PWM2 - 4;
 break;
 case 0x03: PWM3 = PWM3 - 4;
 break;
 }
 }

 switch(controlPWM){

 case 0x01:
  RA2_bit  = 0x01;
  RA1_bit  = 0x00;
 lcd_out(1,1, "PWM 1");
 IntToStr(PWM1, txt);
 lcd_out(2,1, txt);
 break;
 case 0x02:
  RA2_bit  = 0x00;
  RA1_bit  = 0x01;
 lcd_out(1,1, "PWM 2");
 IntToStr(PWM2, txt);
 lcd_out(2,1, txt);
 break;
 case 0x03:
  RA2_bit  = 0x01;
  RA1_bit  = 0x01;
 lcd_out(1,1, "PWM 3");
 IntToStr(PWM3, txt);
 lcd_out(2,1, txt);
 break;
 }
}

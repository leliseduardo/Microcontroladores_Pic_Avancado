#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/SensorDistancia/MikroC/SensorDistancia.c"



sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;


sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;



void trigger();



unsigned tempoH;
char tmrH, tmrL;
char txt[7];
char distancia;

void interrupt(){

 if(CCP1IF_bit && CCP1CON.B0){

 CCP1IF_bit = 0x00;
 TMR1H = 0x00;
 TMR1L = 0x00;
 CCP1IE_bit = 0x00;
 CCP1CON = 0x04;
 CCP1IE_bit = 0x01;
 TMR1ON_bit = 0x01;
 }
 else if(CCP1IF){
 CCP1IF_bit = 0x00;
 TMR1ON_bit = 0x00;
 CCP1IE_bit = 0x00;
 CCP1CON = 0x05;
 CCP1IE_bit = 0x01;
 tmrH = CCPR1H;
 tmrL = CCPR1L;
 }
}

void main() {

 CMCON = 0x07;
 INTCON = 0xC0;
 TMR1IE_bit = 0x00;
 CCP1IE_bit = 0x01;
 CCP1CON = 0x05;


 T1CKPS1_bit = 0x00;
 T1CKPS0_bit = 0x00;
 TMR1CS_bit = 0x00;
 TMR1ON_bit = 0x00;

 TRISA = 0xFF;
 TRISB = 0x09;
 PORTA = 0xFF;
 PORTB = 0x00;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1,1,"Distancia");
 lcd_out(2,14,"cm");
 delay_ms(100);

 while(1){

 trigger();

 delay_ms(100);

 tempoH = (tmrH << 8) + tmrL;

 distancia = tempoH / 58;

 IntToStr(distancia, txt);

 lcd_out(2,8,txt);
 }
}

void trigger(){

  RB0_bit  = 0x01;
 delay_ms(10);
  RB0_bit  = 0x00;
}

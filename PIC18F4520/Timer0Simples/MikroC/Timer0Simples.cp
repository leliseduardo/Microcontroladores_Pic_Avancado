#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic B�sico/PIC18F4520/Timer0Simples/MikroC/Timer0Simples.c"
#line 30 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic B�sico/PIC18F4520/Timer0Simples/MikroC/Timer0Simples.c"
 short cont = 0x00;


 void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xB0;
 TMR0H = 0x03C;

 cont++;

 if(cont == 0x0A){

 cont = 0x00;

  LATB7_bit  = ~ LATB7_bit ;
 }

 }
 }

void main() {


 INTCON = 0xA0;


 TMR0ON_bit = 0x01;
 T08BIT_bit = 0x00;
 T0CS_bit = 0x00;
 PSA_bit = 0x01;


 TMR0L = 0xB0;
 TMR0H = 0x3C;

 ADCON1 = 0x0F;
 TRISB = 0x3F;
  LATB6_bit  = 0x01;
  LATB7_bit  = 0x00;


 while(1){

  LATB6_bit  = ~ LATB6_bit ;
 delay_ms(500);
 }

}

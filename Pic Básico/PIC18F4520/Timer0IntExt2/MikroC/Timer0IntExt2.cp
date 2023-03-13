#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Timer0IntExt2/MikroC/Timer0IntExt2.c"
#line 47 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Timer0IntExt2/MikroC/Timer0IntExt2.c"
void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xB0;
 TMR0H = 0x3C;

  LATB7_bit  = ~ LATB7_bit ;
 }

 if(INT1IF_bit){

 INT1IF_bit = 0x00;

  LATB6_bit  = ~ LATB6_bit ;
 }
}


void main() {




 IPEN_bit = 0x00;


 INTCON = 0xE0;


 INTEDG1_bit = 0x01;
 TMR0IP_bit = 0x00;


 INT1IE_bit = 0x01;
 INT1IP_bit = 0x01;


 TMR0ON_bit = 0x01;
 T08BIT_bit = 0x00;
 T0CS_bit = 0x00;
 PSA_bit = 0x01;


 TMR0L = 0xB0;
 TMR0H = 0x3C;

 ADCON1 = 0x0F;
 TRISB = 0x3F;
  LATB6_bit  = 0x00;
  LATB7_bit  = 0x00;


 while(1){

 if( RB5_bit ) IPEN_bit = 0x01;

 else IPEN_bit = 0x00;
 }
}

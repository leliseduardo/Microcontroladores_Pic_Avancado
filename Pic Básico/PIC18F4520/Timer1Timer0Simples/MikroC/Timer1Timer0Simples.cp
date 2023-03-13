#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Timer1Timer0Simples/MikroC/Timer1Timer0Simples.c"
#line 40 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Timer1Timer0Simples/MikroC/Timer1Timer0Simples.c"
void interrupt(){

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1L = 0x00;
 TMR1H = 0x00;

  LATB6_bit  = ~ LATB6_bit ;

 }

}

void interrupt_low(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xB0;
 TMR0H = 0x3C;

  LATB7_bit  = ~ LATB7_bit ;

 }

}


void main() {




 IPEN_bit = 0x01;


 INTCON = 0xE0;



 TMR0IP_bit = 0x00;


 TMR0ON_bit = 0x01;
 T08BIT_bit = 0x00;
 T0CS_bit = 0x00;
 PSA_bit = 0x01;


 TMR0L = 0xB0;
 TMR0H = 0x3C;


 TMR1IE_bit = 0x01;


 T1CON = 0x81;


 TMR1IP_bit = 0x01;


 TMR1L = 0x00;
 TMR1H = 0x00;

 ADCON1 = 0x0F;
 TRISB = 0x3F;
  LATB6_bit  = 0x00;
  LATB7_bit  = 0x00;


 while(1){



 }

}

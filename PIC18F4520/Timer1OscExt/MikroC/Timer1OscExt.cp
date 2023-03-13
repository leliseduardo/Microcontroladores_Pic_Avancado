#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Timer1OscExt/MikroC/Timer1OscExt.c"
#line 30 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Timer1OscExt/MikroC/Timer1OscExt.c"
void interrupt(){

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1L = 0x0C;
 TMR1H = 0xFE;

  LATB7_bit  = ~ LATB7_bit ;

 }

}


void main() {



 IPEN_bit = 0x00;


 INTCON = 0xC0;


 TMR1IE_bit = 0x01;


 T1CON = 0x83;


 TMR1L = 0x0C;
 TMR1H = 0xFE;

 ADCON1 = 0x0F;
 TRISB = 0x7F;
  LATB7_bit  = 0x00;



 while(1){



 }

}

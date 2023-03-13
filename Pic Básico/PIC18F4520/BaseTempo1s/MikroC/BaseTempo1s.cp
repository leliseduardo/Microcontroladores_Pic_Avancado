#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/BaseTempo1s/MikroC/BaseTempo1s.c"
#line 35 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/BaseTempo1s/MikroC/BaseTempo1s.c"
void interrupt(){

 if(TMR1IF_bit){

 asm BSF TMR1H,7;



 TMR1IF_bit = 0x00;

  LATB7_bit  = ~ LATB7_bit ;
 }
}

void main() {


 INTCON = 0xC0;


 TMR1IE_bit = 0x01;


 T1CON = 0x0B;



 TMR1L = 0x00;
 TMR1H = 0x80;

 ADCON1 = 0x07;
 TRISB = 0x7F;
  LATB7_bit  = 0x00;

 while(1){


 }
}

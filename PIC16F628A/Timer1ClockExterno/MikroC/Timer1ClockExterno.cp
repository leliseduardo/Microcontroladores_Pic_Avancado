#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Timer1ClockExterno/MikroC/Timer1ClockExterno.c"
#line 28 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Timer1ClockExterno/MikroC/Timer1ClockExterno.c"
char cont = 0x00;

void interrupt(){

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1H = 0xFE;
 TMR1L = 0x66;

 cont++;

 if(cont == 0x03){

 cont = 0x00;
  RB0_bit  = ~ RB0_bit ;
 }
 }
}

void main() {

 CMCON = 0x07;

 T1CON = 0x03;



 TMR1H = 0xFE;
 TMR1L = 0x66;

 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR1IE_bit = 0x01;

 TRISB = 0xFE;
  RB0_bit  = 0x00;

 while(1){


 }
}

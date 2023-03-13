#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Timer1OscExterno/MikroC/Timer1OscExterno.c"
#line 30 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Timer1OscExterno/MikroC/Timer1OscExterno.c"
void interrupt(){

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1H = 0xFE;
 TMR1L = 0x66;

  RB0_bit  = ~ RB0_bit ;
 }
}

void main() {

 CMCON = 0x07;

 T1CON = 0x3F;




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

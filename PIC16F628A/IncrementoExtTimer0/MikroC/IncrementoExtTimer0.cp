#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/IncrementoExtTimer0/MikroC/IncrementoExtTimer0.c"


void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;
 TMR0 = 250;

  RA0_bit  = ~ RA0_bit ;
 }
}

void main() {

 CMCON = 0x07;
 OPTION_REG = 0xB8;

 INTCON = 0xA0;
 TMR0 = 250;

 TRISA = 0xFE;
  RA0_bit  = 0x00;

 while(1){


 }
}

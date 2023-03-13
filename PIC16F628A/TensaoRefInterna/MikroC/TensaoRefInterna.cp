#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/TensaoRefInterna/MikroC/TensaoRefInterna.c"


void interrupt(){

 if(CMIF_bit){

 CMIF_bit = 0;

 if(!C1OUT_bit)
  RB0_bit  = 0x01;
 else
  RB0_bit  = 0x00;
 }
}

void main() {

 CMCON = 0x02;
 VRCON = 0xBC;
 INTCON = 0xC0;
 CMIE_bit = 0x01;

 TRISA = 0xFF;
 TRISB = 0xFE;
  RB0_bit  = 0x00;

 while(1){


 }
}

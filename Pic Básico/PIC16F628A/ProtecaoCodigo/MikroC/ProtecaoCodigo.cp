#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/ProtecaoCodigo/MikroC/ProtecaoCodigo.c"



void main() {

 CMCON = 0x07;

 TRISB = 0xFC;
 PORTB = 0xFC;

 while(1){

  RB0_bit  = 0x01;
  RB1_bit  = 0x00;
 delay_ms(600);
  RB0_bit  = 0x00;
  RB1_bit  = 0x01;
 delay_ms(600);
 }
}

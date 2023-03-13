#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/MultiplexacaoLeds/MikroC/MultiplexacaoLeds.c"





void main() {

 CMCON = 0X07;
 TRISA = 0X03;
 PORTA = 0x03;

 while(1){

  RA2_bit  = 0x01;
  RA3_bit  = 0x00;
 delay_ms(10);
  RA2_bit  = 0x00;
  RA3_bit  = 0x01;
 delay_ms(10);

 }
}

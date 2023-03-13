#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/WatchDogSimples/MikroC/WatchDogSimples.c"


void main() {


 OPTION_REG = 0x8E;

 TRISB = 0x7E;
 PORTB = 0x8E;

 asm clrwdt;

 while(1){

 asm clrwdt;

  RB0_bit  = 0x01;
 delay_ms(300);
  RB0_bit  = 0x00;
 delay_ms(300);
 }

}

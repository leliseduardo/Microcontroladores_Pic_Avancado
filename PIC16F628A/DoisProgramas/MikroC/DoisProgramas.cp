#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/DoisProgramas/MikroC/DoisProgramas.c"






void main() {

 CMCON = 7;
 TRISA = 3;
 PORTA = 3;

 while(1){
 if( RA0_bit  == 0){
 while(1){
  RA3_bit  = 0;
  RA2_bit  = 1;
 delay_ms(500);
  RA3_bit  = 1;
  RA2_bit  = 0;
 delay_ms(500);
 }
 }

 if( RA1_bit  == 0){
 while(1){
  RA3_bit  = 1;
  RA2_bit  = 1;
 delay_ms(500);
  RA3_bit  = 0;
  RA2_bit  = 0;
 delay_ms(500);
 }
 }
 }



}

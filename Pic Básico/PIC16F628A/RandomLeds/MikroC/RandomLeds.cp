#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/RandomLeds/MikroC/RandomLeds.c"





int numbers;

void main() {

 CMCON = 7;
 TRISA = 3;
 PORTA = 3;

 while(1){

 numbers = rand();

  RA3_bit  = numbers;
  RA2_bit  = ~ RA3_bit ;

 while( RA3_bit  == 1){
 if( RA0_bit  == 0)
  RA3_bit  = 0;

 delay_ms(70);
 }

 while( RA2_bit  == 1){
 if( RA1_bit  == 0)
  RA2_bit  = 0;

 delay_ms(70);
 }

 delay_ms(500);

 }

}

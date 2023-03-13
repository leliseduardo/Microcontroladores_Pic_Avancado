#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/ContadorPassagem/TesteLed/TesteLed.c"


void main() {

 CMCON = 0x07;
 TRISA = 0x00;
 TRISB = 0xFF;
 PORTA = 0x00;
 PORTB = 0xFF;

 while(1){

 unsigned long int i = 0;

 while(i < 7000){
  RA1_bit  = 0x01;
 delay_us(14);
  RA1_bit  = 0x00;
 delay_us(14);
 i++;
 }

 i = 0;

 delay_ms(200);
 }

}

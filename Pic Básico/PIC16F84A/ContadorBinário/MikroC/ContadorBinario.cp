#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic B�sico/PIC16F84A/ContadorBin�rio/MikroC/ContadorBinario.c"
void main() {

 TRISB = 0b00000000;
 PORTB = 0b00000000;

 while(1){

 PORTB++;
 delay_ms(100);

 }

}

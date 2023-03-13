#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/HelloWorld/MikroC/HelloWorld.c"
#line 8 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/HelloWorld/MikroC/HelloWorld.c"
void main() {

 ADCON1 = 0x0F;

 TRISB = 0xFE;

 while(1){

 LATB0_bit = 0x01;
 delay_ms(200);
 LATB0_bit = 0x00;
 delay_ms(200);
 }
}

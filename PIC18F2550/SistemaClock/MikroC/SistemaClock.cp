#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/SistemaClock/MikroC/SistemaClock.c"
#line 18 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/SistemaClock/MikroC/SistemaClock.c"
void pisca_Led();


void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
 LATB0_bit = 0x00;


 while(1){

 pisca_Led();

 }

}

void pisca_Led(){

 LATB0_bit = 0x01;
 delay_ms(200);
 LATB0_bit = 0x00;
 delay_ms(200);

}

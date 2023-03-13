#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/Frequencimetro8Bits/MikroC/Frequencimetro8Bits.c"
#line 17 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/Frequencimetro8Bits/MikroC/Frequencimetro8Bits.c"
unsigned frequencia;

void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
 LATB0_bit = 0x00;
 T0CON = 0xE8;

 TMR0L = 0x00;


 while(1){

 frequencia = TMR0L;

 if(frequencia < 100)  LATB0_bit  = 0x01;
 else  LATB0_bit  = 0x00;

 TMR0L = 0x00;

 delay_ms(1000);

 }

}

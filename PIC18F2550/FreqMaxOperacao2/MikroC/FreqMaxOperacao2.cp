#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/FreqMaxOperacao2/MikroC/FreqMaxOperacao2.c"
#line 21 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/FreqMaxOperacao2/MikroC/FreqMaxOperacao2.c"
void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
 LATB0_bit = 0x00;
#line 37 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/FreqMaxOperacao2/MikroC/FreqMaxOperacao2.c"
 loop:

 asm bsf LATB,0;
 asm nop;
 asm nop;
 asm bcf LATB,0;

 goto loop;

}

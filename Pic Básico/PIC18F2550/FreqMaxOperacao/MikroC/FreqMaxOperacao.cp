#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/FreqMaxOperacao/MikroC/FreqMaxOperacao.c"
#line 23 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/FreqMaxOperacao/MikroC/FreqMaxOperacao.c"
void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
 LATB0_bit = 0x00;
#line 39 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/FreqMaxOperacao/MikroC/FreqMaxOperacao.c"
 loop:

 asm bsf LATB,0;
 asm bcf LATB,0;

 goto loop;

}

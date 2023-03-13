#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/Timer1Simples/MikroC/Timer1Simples.c"
#line 12 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/Timer1Simples/MikroC/Timer1Simples.c"
void main() {

 CMCON = 0x07;
 T1CON = 0x01;
 TMR1L = 0x00;
 TMR1H = 0x00;

 TRISC = 0xEF;
 RC4_bit = 0x00;

 while(1){

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;

 RC4_bit = ~RC4_bit;
 }
 }
}

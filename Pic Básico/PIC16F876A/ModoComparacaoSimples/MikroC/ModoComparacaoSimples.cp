#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ModoComparacaoSimples/MikroC/ModoComparacaoSimples.c"


void main() {

 CMCON = 0x07;
 T1CON = 0x31;
 TMR1L = 0x00;
 TMR1H = 0x00;


 CCP1CON = 0x0B;
 CCPR1L = 0xFF;
 CCPR1H = 0xFF;

 TRISC = 0xFA;
 RC2_bit = 0x00;
 RC0_bit = 0x00;
#line 30 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ModoComparacaoSimples/MikroC/ModoComparacaoSimples.c"
 while(1){

 if(CCP1IF_bit){

 CCP1IF_bit = 0x00;

 RC0_bit = ~RC0_bit;
 }
 }

}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/InterrupTimer1Simples/MikroC/InterrupTimer1SImples.c"
#line 26 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/InterrupTimer1Simples/MikroC/InterrupTimer1SImples.c"
char aux = 0x00;

void interrupt(){
 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1L = 0x18;
 TMR1H = 0xFC;

 RC4_bit = 0x00;

 aux++;

 if(aux == 50){

 aux = 0x00;

 RC4_bit = 0x01;
 RC5_bit = ~RC5_bit;
 }
 }
}

void main() {

 CMCON = 0x07;
 T1CON = 0x31;
 TMR1L = 0x18;
 TMR1H = 0xFC;

 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR1IE_bit = 0x01;

 TRISC = 0xCF;
 RC4_bit = 0x00;
 RC5_bit = 0x00;

}

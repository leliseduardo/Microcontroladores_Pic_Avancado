#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/TemporizacaoTMR0/MikroC/TemporizacaoTMR0.c"
#line 37 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/TemporizacaoTMR0/MikroC/TemporizacaoTMR0.c"
void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
  LATB0_bit  = 0x00;

 T0CON = 0x84;
 TMR0L = 0xEE;
 TMR0H = 0x85;


 while(1){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xEE;
 TMR0H = 0x85;
  LATB0_bit  = ~ LATB0_bit ;

 }

 }

}

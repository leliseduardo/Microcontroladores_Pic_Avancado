#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PrecisaoTimers/MikroC/PrecisaoTimers.c"
#line 18 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PrecisaoTimers/MikroC/PrecisaoTimers.c"
signed long cont = 15625;


void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;

 cont -= 256;

 if(cont <= 0){

 cont += 15625;

  LATB0_bit  = ~ LATB0_bit ;

 }

 }

}

void main() {



 INTCON = 0xA0;


 TMR0ON_bit = 0x01;
 T08BIT_bit = 0x01;
 T0CS_bit = 0x00;
 PSA_bit = 0x00;
 T0PS1_bit = 0x00;

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
  LATB0_bit  = 0x00;

 while(1);

}

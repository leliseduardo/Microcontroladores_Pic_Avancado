#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/BotaoNumeroCliques/MikroC/BotaoNumeroCliques.c"
#line 14 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/BotaoNumeroCliques/MikroC/BotaoNumeroCliques.c"
void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
 LATB0_bit = 0x00;
 T0CON = 0xF8;

 TMR0L = 250;



 while(1){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 250;

  LATB0_bit  = ~ LATB0_bit ;

 }

 }

}

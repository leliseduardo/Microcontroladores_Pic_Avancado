#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/BotaoLed/MikroC/BotaoLed.c"
#line 22 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/BotaoLed/MikroC/BotaoLed.c"
void main() {

 ADCON1 = 0x0F;
 INTCON2 = 0x7F;

 TRISB = 0xFE;

  LATB0_bit  = 0x00;

 while(1){

 if(! RB1_bit ){

  LATB0_bit  = 0x01;
 delay_ms(500);
  LATB0_bit  = 0x00;
 }
 }
}

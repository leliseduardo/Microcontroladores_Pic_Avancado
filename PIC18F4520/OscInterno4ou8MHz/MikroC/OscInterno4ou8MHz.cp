#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/OscInterno4ou8MHz/MikroC/OscInterno4ou8MHz.c"
#line 15 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/OscInterno4ou8MHz/MikroC/OscInterno4ou8MHz.c"
void osc();

void main() {

 ADCON1 = 0x0F;
 INTCON2 = 0x7F;
 OSCCON = 0x70;

 TRISB = 0xFE;

  LATB0_bit  = 0x00;

 while(1){

  LATB0_bit  = 0x01;
 osc();
  LATB0_bit  = 0x00;
 osc();
 }
}

void osc(){

 unsigned char i, j;

 for(i = 255; i; i--){

 if(! RB1_bit ) IRCF0_bit = ~IRCF0_bit;



 for(j = 255; j; j--);
 }
}

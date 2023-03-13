#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/TMR0Simples/MikroC/TMR0Simples.c"
#line 28 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/TMR0Simples/MikroC/TMR0Simples.c"
void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xEE;

  LATB0_bit  = ~ LATB0_bit ;

 }

}

void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
  LATB0_bit  = 0x01;

 INTCON = 0xA0;

 T0CON = 0xC0;
 TMR0L = 0xEE;


 while(1){



 }

}

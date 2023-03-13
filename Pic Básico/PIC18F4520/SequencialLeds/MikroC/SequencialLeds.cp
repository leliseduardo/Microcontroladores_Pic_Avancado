#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SequencialLeds/MikroC/SequencialLeds.c"
#line 10 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SequencialLeds/MikroC/SequencialLeds.c"
unsigned char controle = 0x01;

void main() {

 ADCON1 = 0x0F;

 TRISB = 0x00;
 LATB = 0x00;

 while(1){

 LATB = controle;
 delay_ms(500);

 controle = controle << 0x01;

 if(controle == 0x00) controle = 0x01;
 }
}

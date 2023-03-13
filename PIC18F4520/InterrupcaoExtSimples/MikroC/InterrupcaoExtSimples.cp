#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/InterrupcaoExtSimples/MikroC/InterrupcaoExtSimples.c"
#line 23 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/InterrupcaoExtSimples/MikroC/InterrupcaoExtSimples.c"
void interrupt(){

 if(INT0IF_bit){

 INT0IF_bit = 0x00;

  LATB7_bit  = ~ LATB7_bit ;
 }
}

void main() {


 INTCON = 0x90;
 INTEDG0_bit = 0x00;
 TRISB = 0x7F;
 ADCON1 = 0x0F;

  LATB7_bit  = 0x00;


 while(1){


 }

}

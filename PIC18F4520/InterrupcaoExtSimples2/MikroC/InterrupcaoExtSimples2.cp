#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/InterrupcaoExtSimples2/MikroC/InterrupcaoExtSimples2.c"
#line 17 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/InterrupcaoExtSimples2/MikroC/InterrupcaoExtSimples2.c"
void interrupt(){

 if(INT0IF_bit){

 INT0IF_bit = 0x00;

  LATB5_bit  = ~ LATB5_bit ;
 }

 if(INT2IF_bit){

 INT2IF_bit = 0x00;

  LATB7_bit  = ~ LATB7_bit ;
 }

 if(INT1IF_bit){

 INT1IF_bit = 0x00;

  LATB6_bit  = ~ LATB6_bit ;
 }
}

void main() {


 INTCON = 0x90;


 INTEDG0_bit = 0x00;
 INTEDG1_bit = 0x01;
 INTEDG2_bit = 0x00;


 INT1IE_bit = 0x01;
 INT2IE_bit = 0x01;

 ADCON1 = 0x0F;

 TRISB = 0x1F;

  LATB5_bit  = 0x00;
  LATB6_bit  = 0x00;
  LATB7_bit  = 0x00;


 while(1){


 }

}

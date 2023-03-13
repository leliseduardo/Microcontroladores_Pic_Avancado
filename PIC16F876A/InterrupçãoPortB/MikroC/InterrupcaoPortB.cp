#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/InterrupçãoPortB/MikroC/InterrupcaoPortB.c"

void interrupt(){

 if(RBIF_bit){

 RBIF_bit = 0x00;

 RC4_bit = ~RC4_bit;
 }
}

void main() {

 CMCON = 0x07;
 RBIE_bit = 0x01;
 RBIF_bit = 0x00;
 GIE_bit = 0x01;

 TRISB = 0xFF;
 TRISC = 0xEF;

 while(1){


 }
}

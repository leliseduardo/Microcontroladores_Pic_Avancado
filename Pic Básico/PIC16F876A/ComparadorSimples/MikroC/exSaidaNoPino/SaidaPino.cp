#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ComparadorSimples/MikroC/exSaidaNoPino/SaidaPino.c"

void interrupt(){

 if(CMIF_bit){

 CMIF_bit = 0x00;
 }
}

void main() {

 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 CMIE_bit = 0x01;
 CMCON = 0x03;

 TRISA = 0x0F;
}

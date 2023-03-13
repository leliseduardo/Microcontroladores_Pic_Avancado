#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SPISimples/MikroC/SPISimples.c"
#line 11 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SPISimples/MikroC/SPISimples.c"
unsigned char cont = 0x00;

void main() {

 TRISC = 0x00;
 LATC0_bit = 0x01;

 SSPSTAT = 0x00;
 SSPEN_bit = 0x01;

 while(1){

 SSPBUF = cont++;

 delay_ms(200);

 }

}

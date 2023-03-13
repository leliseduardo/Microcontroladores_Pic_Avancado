#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Display7Seg/MikroC/Display7Seg.c"
void main() {


unsigned char anodo, cont = 0x00;
unsigned char numero[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0xFF,0x6F};

CMCON = 0x07;
TRISB = 0X00;
PORTB = 0X00;

 while(1){

 anodo = numero[cont];

 PORTB = anodo;

 cont++;
 if(cont == 10)
 cont = 0;

 delay_ms(1000);

 }

}

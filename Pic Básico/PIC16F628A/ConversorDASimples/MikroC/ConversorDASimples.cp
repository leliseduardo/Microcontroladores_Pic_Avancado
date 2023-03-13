#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/ConversorDASimples/MikroC/ConversorDASimples.c"


void main() {

 CMCON = 0x07;
 TRISA = 0xFF;

 VRCON = 0xE7;


 while(1){

 VRCON = 0xE7;
 delay_ms(50);
 VRCON = 0xE6;
 delay_ms(50);
 VRCON = 0xE5;
 delay_ms(50);
 VRCON = 0xE4;
 delay_ms(50);
 VRCON = 0xE3;
 delay_ms(50);
 VRCON = 0xE2;
 delay_ms(50);
 VRCON = 0xE1;
 delay_ms(50);
 }
}

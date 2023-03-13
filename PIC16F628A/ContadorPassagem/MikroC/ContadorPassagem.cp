#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/ContadorPassagem/MikroC/ContadorPassagem.c"

int cont = 0;

void escreveDisplay(int num);

void interrupt(){

 if(INTF_bit){

 INTF_bit = 0x00;

 cont++;
 if(cont > 9)
 cont = 0;

 escreveDisplay(cont);
 }
}

void main() {

 CMCON = 0x07;

 GIE_bit = 0x01;
 PEIE_bit = 0x00;
 INTE_bit = 0x01;
 INTEDG_bit = 0x01;

 TRISA = 0xFF;
 TRISB = 0x01;
 PORTA = 0xFF;
 PORTB = 0x7F;


 while(1){


 }
}

void escreveDisplay(int num){

 int anodo[] = {0x7F, 0x0D, 0xB7, 0x9F, 0xCD, 0xDB, 0xF9, 0x0F, 0xFF, 0xCF};

 char aux;

 aux = anodo[num];

 PORTB = aux;
}

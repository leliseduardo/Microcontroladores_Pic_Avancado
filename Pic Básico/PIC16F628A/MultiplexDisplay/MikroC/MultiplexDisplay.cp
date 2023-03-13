#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/MultiplexDisplay/MikroC/MultiplexDisplay.c"






int display(int num);
void contagem();

int unid, dez, cent, cont = 0;

void main() {

 CMCON = 0X07;
 TRISA = 0X03;
 TRISB = 0X00;
  PORTA.F2  = 0x00;
  PORTA.F3  = 0x00;

 while(1){



 contagem();


 cent = (cont/100) - ((cont%100)/100);
 PORTB = display(cent);
  PORTA.F3  = 1;
 delay_ms(5);
  PORTA.F3  = 0;


 dez = (cont%100);
 dez = (dez/10) - ((dez%10)/10);
 PORTB = display(dez);
  PORTA.F2  = 1;
 delay_ms(5);
  PORTA.F2  = 0;


 unid = cont%10;
 PORTB = display(unid);
  PORTB.F7  = 1;
 delay_ms(5);
  PORTB.F7  = 0;
 }
}

int display(int num){

 int vetorDisplay[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0xF7F,0x67};
 int aux;

 aux = vetorDisplay[num];

 return aux;
}

void contagem(){

 while( PORTA.F1  == 1){
 cont = cont + 10;
 delay_ms(180);
 if(cont > 300)
 cont = 300;
 }

 while( PORTA.F0  == 1){
 cont = cont - 10;
 delay_ms(180);
 if(cont < 1)
 cont = 0;
 }
}

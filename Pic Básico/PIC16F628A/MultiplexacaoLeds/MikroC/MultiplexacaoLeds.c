#define s1 RA0_bit
#define s2 RA1_bit
#define led1 RA2_bit
#define led2 RA3_bit

void main() {

     CMCON = 0X07;
     TRISA = 0X03; // Ou 0b00000011, seleciona os pinos 0 e 1 como entradas digitais
     PORTA = 0x03; // Ou 0b00000011, inicia os pinos 0 e 1 em nivel logico alto
     
     while(1){

       led1 = 0x01;
       led2 = 0x00;
       delay_ms(10);
       led1 = 0x00;
       led2 = 0x01;


     }
}
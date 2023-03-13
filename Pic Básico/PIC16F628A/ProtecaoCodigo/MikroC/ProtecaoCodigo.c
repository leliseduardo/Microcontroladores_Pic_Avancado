#define led1 RB0_bit
#define led2 RB1_bit

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     
     TRISB = 0xFC; // Configura apenas RB0 e RB1 como saídas digitais
     PORTB = 0xFC; // Inicia RB0 e RB1 em Low
     
     while(1){
     
       led1 = 0x01;
       led2 = 0x00;
       delay_ms(600);
       led1 = 0x00;
       led2 = 0x01;
       delay_ms(600);
     }
}
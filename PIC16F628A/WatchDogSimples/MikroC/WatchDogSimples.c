#define led RB0_bit

void main() {

     //CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0x8E; // Ou 0b10001110, desabilita os pull-ups internos e habilita o watchDog timer com prescaler 1:128
     
     TRISB = 0x7E; // Ou 0b01111110, configura RB0 e RB7 como saídas digitais
     PORTB = 0x8E; // Ou 0b10001110, Inicia RB0 em Low e RB7 em High
     
     asm clrwdt;
     
     while(1){

       asm clrwdt;

       led = 0x01;
       delay_ms(300);
       led = 0x00;
       delay_ms(300);
     }

}
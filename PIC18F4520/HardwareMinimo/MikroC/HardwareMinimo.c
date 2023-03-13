/*

   Programa igual ao "Hello World", que vai servir apenas para testar o hardware mínimo do pic18f4520 na prática

*/


void main() {

     ADCON1 = 0x0F; // Configura todas as portas analógicar do portb como portas digitais

     TRISB = 0xFE; // Configura apenas RB0_bit como saída digital

     while(1){

       LATB0_bit = 0x01; // É a mesma coisa que RB0_bit
       delay_ms(500);
       LATB0_bit = 0x00;
       delay_ms(500);
     }
}
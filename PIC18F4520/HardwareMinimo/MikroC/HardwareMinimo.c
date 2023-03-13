/*

   Programa igual ao "Hello World", que vai servir apenas para testar o hardware m�nimo do pic18f4520 na pr�tica

*/


void main() {

     ADCON1 = 0x0F; // Configura todas as portas anal�gicar do portb como portas digitais

     TRISB = 0xFE; // Configura apenas RB0_bit como sa�da digital

     while(1){

       LATB0_bit = 0x01; // � a mesma coisa que RB0_bit
       delay_ms(500);
       LATB0_bit = 0x00;
       delay_ms(500);
     }
}
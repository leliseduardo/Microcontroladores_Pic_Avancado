/* 

   Programa apenas para iniciar na familia 18 do pic, com o pic 18f4520. N�o ser� feita nenhuma pr�tica com este programa

*/


void main() {

     ADCON1 = 0x0F; // Configura todas as portas anal�gicar do portb como portas digitais
     
     TRISB = 0xFE; // Configura apenas RB0_bit como sa�da digital
     
     while(1){
     
       LATB0_bit = 0x01; // � a mesma coisa que RB0_bit
       delay_ms(200);
       LATB0_bit = 0x00;
       delay_ms(200);
     }
}
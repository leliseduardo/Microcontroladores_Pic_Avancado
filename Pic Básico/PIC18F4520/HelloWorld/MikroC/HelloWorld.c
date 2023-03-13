/* 

   Programa apenas para iniciar na familia 18 do pic, com o pic 18f4520. Não será feita nenhuma prática com este programa

*/


void main() {

     ADCON1 = 0x0F; // Configura todas as portas analógicar do portb como portas digitais
     
     TRISB = 0xFE; // Configura apenas RB0_bit como saída digital
     
     while(1){
     
       LATB0_bit = 0x01; // É a mesma coisa que RB0_bit
       delay_ms(200);
       LATB0_bit = 0x00;
       delay_ms(200);
     }
}
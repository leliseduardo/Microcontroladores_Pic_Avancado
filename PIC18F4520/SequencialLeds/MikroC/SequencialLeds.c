/* 

   Este programa tem a função de ligar um led por vez, do bit menos significativo do portb ao mais significativo, fazendo um sequencial
   de leds acesos

*/

// Variáveis globais

unsigned char controle = 0x01;

void main() {

     ADCON1 = 0x0F; // Ou 0b0000 1111, que configura todas as portas que podem ser entradas analógicas, como portas digitais
     
     TRISB = 0x00; // Configura todo o portb como saída digital
     LATB = 0x00; // Leds iniciam desligados
     
     while(1){
     
       LATB = controle; // LATB é o registrador que inicia o estado do portb. É o registrador equivalente ao PORTB da família pic 16f e 12f
       delay_ms(500);
       
       controle = controle << 0x01; // o comando << represente shift-left que, no caso, move todos os bits de cont 1(0x01) bit para esquerda
       
       if(controle == 0x00) controle = 0x01;
     }
}
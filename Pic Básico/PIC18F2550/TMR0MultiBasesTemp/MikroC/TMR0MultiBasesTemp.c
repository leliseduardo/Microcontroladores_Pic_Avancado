/* 

         O objetivo deste programa � utilizar um �nico timer, o timer0, e criar v�rias bases de tempo. Isso quer dizer que o timer0 vai estourar
     num tempo fixo base e, atrav�s de outras vari�veis contadoras, executar outras fun��es a cada tempo espec�fico dependente da vari�vel conta-
     dora. Ou seja, se o timer0 estoura a cada 25ms, pode-se ter uma vari�vel que conte at� 4 (4 x 25ms) e, a cada 100ms, realize uma fun��o
     espec�fica. Ao mesmo tempo, pode-se ter uma vari�vel que conte at� 6 (6x25ms) e, realize uma fun��o espec�fica a cada 150ms. Assim, a partir
     do tempo base de 25ms, pode-se ter v�rias bases de tempo para realizar v�rias fun��es de tempos em tempos, de acordo com o que se queira.
         � claro que seria muito bom se os tempos fossem sempre precisos. Por�m, utilizando esta forma de programa��o e utiliza��o dos timers,
     haver� um pequeno atraso nas bases de tempos que forem programadas por �ltimo. Isso porque elas ter�o que esperar as outras fun��es serem
     realizadas para poderem executar. E as outras fun��es demandam tempo a cada instru��o que executam. Assim, ocorrem pequenos atrasos nas
     �ltimas bases de tempo. Ainda assim, vale a pena utilizar esse tipo de programa��o, uma vez que os atrasos s�o da ordem dos milisegundos e,
     dependendo do projeto, isso n�o atrapalha a correta execu��o. E na maioria dos projetos, realmente n�o atrapalha.
     
     ***** Tempo base do timer0 de 25ms ****************************************
     
     tempo de estouro = contagem * prescale * ciclo de m�quina
     25ms = contagem * 4 * 250ns (16MHz)
     contagem = 25000
     
     65536 - 25000 = 40536(decimal) = 0x9E58(hexadecimal)
     TMR0H = 0x9E
     TMR0L = 0x58
     
     Overflow = (65536 - <TMR0H::TMR0L>) * prescaler * ciclo de maquina
     Overflow = (65536 - 40536) * 4 * 250ns
     Overflow = 25000 * 4 * 250ns
     Overflow = 25ms
     
     ***************************************************************************

         Na simula��o do proteus, de acordo com o oscilosc�pio vitural, os sinal responderam de acordo com o que programei, um em rela��o ao
      outro. Por�m, os tempos n�o condizem com a programa��o e as bases de tempo. Como o professor n�o simula nada no proteus, acredito que o
      microcontrolador utilizado n�o responda bem � simula��o.
         Na pr�tica o circuito funcionou perfeitamente, apesar de eu n�o ter um oscilosc�pio e n�o ter medido os sinais de sa�da, os leds parecem
      ter piscado no tempo certo.

*/

// Mapeamento de hardware
#define led1 LATB0_bit
#define led2 LATB1_bit
#define led3 LATB2_bit
#define led4 LATB3_bit

// Fun��es auxiliares
void base_Tempo();

// Vari�veis auxiliares
unsigned baseTempo1 = 0x00,
         baseTempo2 = 0x00,
         baseTempo3 = 0x00,
         baseTempo4 = 0x00;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xF0; // Configura o primeiro nible como sa�da digital e o segundo como entrada
     LATB = 0xF0; // Inicia todas as sa�das em Low
     
     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de m�quina e prescaler 1:4
     TMR0H = 0x9E; // Inicia o contador do timer0 em 40536, para uma contagem de 25000
     TMR0L = 0x58;
     
     // Loop infinito
     while(1){
     
       if(TMR0IF_bit){
       
         TMR0IF_bit = 0x00;
         TMR0H = 0x9E;
         TMR0L = 0x58;
         
         baseTempo1 += 1;
         baseTempo2 += 1;
         baseTempo3 += 1;
         baseTempo4 += 1;
         
         base_Tempo();
       
       } // end if TMR0IF_bit
     
     } // end Loop infinito

} // end void main



void base_Tempo(){

     if(baseTempo1 == 0x02){ // a cada 50ms
     
       baseTempo1 = 0x00;
       
       led1 = ~led1;
     
     } // end if baseTempo1 == 0x02
     
     
     
     if(baseTempo2 == 0x0A){ // a cada 250ms

       baseTempo2 = 0x00;

       led2 = ~led2;

     } // end if baseTempo2 == 0x0A
     
     
     
     if(baseTempo3 == 0x14){ // a cada 500ms

       baseTempo3 = 0x00;

       led3 = ~led3;

     } // end if baseTempo1 == 0x14
     
     
     
     if(baseTempo4 == 0x28){ // a cada 1s

       baseTempo4 = 0x00;

       led4 = ~led4;

     } // end if baseTempo1 == 0x28

} // end void base_Tempo










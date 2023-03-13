/* 

         O objetivo deste programa é utilizar um único timer, o timer0, e criar várias bases de tempo. Isso quer dizer que o timer0 vai estourar
     num tempo fixo base e, através de outras variáveis contadoras, executar outras funções a cada tempo específico dependente da variável conta-
     dora. Ou seja, se o timer0 estoura a cada 25ms, pode-se ter uma variável que conte até 4 (4 x 25ms) e, a cada 100ms, realize uma função
     específica. Ao mesmo tempo, pode-se ter uma variável que conte até 6 (6x25ms) e, realize uma função específica a cada 150ms. Assim, a partir
     do tempo base de 25ms, pode-se ter várias bases de tempo para realizar várias funções de tempos em tempos, de acordo com o que se queira.
         É claro que seria muito bom se os tempos fossem sempre precisos. Porém, utilizando esta forma de programação e utilização dos timers,
     haverá um pequeno atraso nas bases de tempos que forem programadas por último. Isso porque elas terão que esperar as outras funções serem
     realizadas para poderem executar. E as outras funções demandam tempo a cada instrução que executam. Assim, ocorrem pequenos atrasos nas
     últimas bases de tempo. Ainda assim, vale a pena utilizar esse tipo de programação, uma vez que os atrasos são da ordem dos milisegundos e,
     dependendo do projeto, isso não atrapalha a correta execução. E na maioria dos projetos, realmente não atrapalha.
     
     ***** Tempo base do timer0 de 25ms ****************************************
     
     tempo de estouro = contagem * prescale * ciclo de máquina
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

         Na simulação do proteus, de acordo com o osciloscópio vitural, os sinal responderam de acordo com o que programei, um em relação ao
      outro. Porém, os tempos não condizem com a programação e as bases de tempo. Como o professor não simula nada no proteus, acredito que o
      microcontrolador utilizado não responda bem à simulação.
         Na prática o circuito funcionou perfeitamente, apesar de eu não ter um osciloscópio e não ter medido os sinais de saída, os leds parecem
      ter piscado no tempo certo.

*/

// Mapeamento de hardware
#define led1 LATB0_bit
#define led2 LATB1_bit
#define led3 LATB2_bit
#define led4 LATB3_bit

// Funções auxiliares
void base_Tempo();

// Variáveis auxiliares
unsigned baseTempo1 = 0x00,
         baseTempo2 = 0x00,
         baseTempo3 = 0x00,
         baseTempo4 = 0x00;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xF0; // Configura o primeiro nible como saída digital e o segundo como entrada
     LATB = 0xF0; // Inicia todas as saídas em Low
     
     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler 1:4
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










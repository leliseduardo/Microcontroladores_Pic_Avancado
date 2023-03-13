/* 

        O objetivo deste programa é gerar um sinal que represente o sinal de saída de um roda fônica. Uma roda fônica nada mais é do que um encoder
     usado em motores para determinar sua velocidade e posição. Este tipo de sensor é utilizado em motores automotivos, em carros que utilizam
     injeção eletrônica. Ainda, é muito utilizado em autocação e robótica para no controle de motores.
        O encoder tem o formato de uma engrenagem, ou um disco com furos que fica acoplado ao eixo do motor. Assim, um sensor de barreira infra-
     vermelho aciona caso um haja um furo ou caso haja um dente da engrenagem, ou também o sensor desaciona nesses casos.
        Aqui neste programa não será feita uma leitura de um encoder, ou roda fônica, e sim uma simulação do seu sinal de saída, que consiste
     num sinal quadrado de pulsos, onde o pulso High representa uma engrenagem ou distância entre furos, ou então representa a distância entre
     os dentes da engrenagem ou um futo do disco. Existem os dois tipos de encoder.
        Para esta aplicação será utilizado o programa do último projeto, denominado "MultiplasTarefas", com o intuito de mostrar que várias tarefas
     podem ser executadas ao mesmo tempo, incluindo assim, a saída do sinal do encoder. Logo, a partir do código já pronto, basta adicionar o sinal
     de saída do encoder, a partir de outro timer, o timer2.
     
     ***** Tempo base do timer0 de 25ms ****************************************

     tempo de estouro = contagem * prescale * ciclo de máquina
     25ms = contagem * 4 * 250ns (16MHz)
     contagem = 25000

     65536 - 25000 = 40536(decimal) = 0x9E58(hexadecimal)
     TMR0H = 0x9E
     TMR0L = 0x58

     Overflow = (65536 - <TMR0H::TMR0L>) * prescale * ciclo de maquina
     Overflow = (65536 - 40536) * 4 * 250ns
     Overflow = 25000 * 4 * 250ns
     Overflow = 25ms

     ***************************************************************************

     ***** Tempo base do timer1 de 100ms ****************************************

     tempo de estouro = contagem * prescale * ciclo de máquina
     100ms = contagem * 8 * 250ns (16MHz)
     contagem = 50000

     65536 - 50000 = 15536(decimal) = 0x3CB0(hexadecimal)
     TMR0H = 0x3C
     TMR0L = 0xB0

     Overflow = (65536 - <TMR0H::TMR0L>) * prescale * ciclo de maquina
     Overflow = (65536 - 15536) * 8 * 250ns
     Overflow = 50000 * 8 * 250ns
     Overflow = 100ms

     ***************************************************************************
     ***** Tempo base do timer2 ************************************************

     Overflow = (PR2 - TMR2) * prescale * postscale * ciclo de maquina
     Overflow = (170 - 0) * 1 * 16 * 250ns
     Overflow = 170 * 1 * 16 * 250ns
     Overflow = 680us
     
     Período de oscilação da saída do encoder = 2 x Overflow = 2 x 680us = 1,36ms
     
     PR2 = 170(deciamal) = 0xAA(hexadecimal)

     ***************************************************************************

        Na simulação, a lógica do circuito funcionou perfeitamente. Os tempos, assim como nos projetos anteriores, não responde ao que foi progra-
     mado, mas isso muito provavelmente é uma limitação do proteus, já que nem o professor simula os circuitos com o microcontrolador que está
     sendo utilizado.
        Na prática não tenho como testar o funcionamento por falta de um osciloscópio, mas como a lógica funcionou na simulação, com certeza iria
     funcionar perfeitamente na prática.

*/

// Mapeamento de hardware
#define led1 LATB0_bit
#define led2 LATB1_bit
#define motor LATB2_bit
#define rpm LATB3_bit
#define botao RB7_bit

// Funções auxiliares
void base_Tempo();
void leitura_Botao();

// Variáveis auxiliares
unsigned baseTempo1 = 0x00,
         baseTempo2 = 0x00,
         contMotor = 0x06,
         contTMR1 = 0x00;
         
unsigned short rpmEncoder = 0x00;

bit flagBotao;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     INTCON2.F7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
     TRISB = 0xF0; // Configura o primeiro nible como saída digital, o segundo como entrada
     LATB = 0xF0; // Inicia todas as saídas em Low

     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler 1:4
     TMR0H = 0x9E; // Inicia o contador do timer0 em 40536, para uma contagem de 25000
     TMR0L = 0x58;

     T1CON = 0xB1; // Configura com 16 bits, Pic com outra fonte de clock, prescaler 1:8 e habilita o timer1
     TMR0H = 0x3C; // Inicia o contador do timer1 em 15536, para uma contagem de 50000
     TMR0L = 0xB0;
     
     T2CON = 0x7C; // Configura o postscale em 1:16, habilita o timer2, configura o prescaler em 1:1
     PR2 = 0xAA; // O contador do timer2 conta até 170

     flagBotao = 0x00;

     // Loop infinito
     while(1){

       if(TMR0IF_bit){

         TMR0IF_bit = 0x00;
         TMR0H = 0x9E;
         TMR0L = 0x58;

         baseTempo1 += 1;
         baseTempo2 += 1;

         base_Tempo();

       } // end if TMR0IF_bit

       if(TMR1IF_bit){

         TMR1IF_bit = 0x00;
         TMR0H = 0x3C;
         TMR0L = 0xB0;

         contTMR1 += 1;

         if(contTMR1 == 0x0A){

           contTMR1 = 0x00;
           contMotor += 1;

           if(contMotor == 0x05){

             contMotor = 0x06;
             motor = 0x00;

           } // end if contMotor = 0x05

         } // end if contTMR1 = 0x0A

         leitura_Botao();

       } // end if TMR1IF_bit
       
       if(TMR2IF_bit){
       
         TMR2IF_bit = 0x00;
         
         rpmEncoder++;
         
         if(rpmEncoder < 116) rpm = ~rpm;
         else rpm = 0x00;
         
         if(rpmEncoder == 120) rpmEncoder = 0x00;
         
         /* 
            A lógica aqui presente faz com que a saída rpm simule o sinal de saída do encoder. O sinal irá alternar entre High e Low no período
            de 1,36ms, que dá uma frequência de 735Hz. O sinal simula um encoder do tipo engrenagem, que tem 60 engrenagens menos 2, isto é, 58
            engrenagens e 2 espaços vazios. Assim, o que acontece é que o sinal alterna entre High e Low 58 vezes e fica em Low por 2 períodos.
            Por isso, na lógica acima, o rpm alterna 116 vezes, pois isso significa a alternancia de High e Low 58 vezes (58 x 2 = 116). Ainda,
            o rpm fica em Low por dois períodos, que representa 4 vezes a passagem pelo timer2. Isto é, rpmEncoder = 117 até rpmEncoder = 120
            representa dois períodos, que são os período em Low, que representam a falta das duas engrenagens (espaço vazio).
         */
       
       } // end if TMR2IF_bit

     } // end Loop infinito

} // end void main



void base_Tempo(){

     if(baseTempo1 == 0x0A){ // a cada 250ms

       baseTempo1 = 0x00;

       led1 = ~led1;

     } // end if baseTempo1 == 0x02



     if(baseTempo2 == 0x014){ // a cada 500ms

       baseTempo2 = 0x00;

       led2 = ~led2;

     } // end if baseTempo2 == 0x0A


} // end void base_Tempo



void leitura_Botao(){

     if(!botao) flagBotao = 0x01;

     if(botao && flagBotao){

       flagBotao = 0x00;
       motor = 0x01;
       contMotor = 0x00;

     } // end botao && flagBotao

} // end void leitura_Botao

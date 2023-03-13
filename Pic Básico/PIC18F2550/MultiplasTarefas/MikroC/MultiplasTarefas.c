/* 

        O objetivo deste programa � demonstrar como os timers s�o importantes para projetos que executam multiplas tarefas. Isso porque uma tarefa
     n�o podem interromper ou atrapalhar a outra, e o timer tem a fun��o de realizar alguma tarefa em determinado tempo sem que essa tarefa atra-
     palhe as demais execu��es do programa.
        Para este exemplo, parte do c�digo do �ltimo projeto ser� utilizado, o projeto denominado "TMR0MultiBasesTemp". E ser� incrementado para
     utilizar o timer1 e criar uma outra tarefa que consiste em ligar um motor durante 5s, sem atrapalhar a execu��o do timer0.
        Neste c�digo ainda n�o se utiliza interrup��o e as tarefas dos timers ocorrem no loop infinito, na fun��o principal. Por�m, ainda sim,
     a utiliza��o dos timers no auxilio � execu��o de mais de uma tarefa � essencial, uma vez que em projetos de circuitos microcontrolados, as
     temporiza��es s�o cruciais para a execu��o do programa.


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
     
     ***** Tempo base do timer1 de 100ms ****************************************

     tempo de estouro = contagem * prescale * ciclo de m�quina
     100ms = contagem * 8 * 250ns (16MHz)
     contagem = 50000

     65536 - 50000 = 15536(decimal) = 0x3CB0(hexadecimal)
     TMR0H = 0x3C
     TMR0L = 0xB0

     Overflow = (65536 - <TMR0H::TMR0L>) * prescaler * ciclo de maquina
     Overflow = (65536 - 15536) * 8 * 250ns
     Overflow = 50000 * 8 * 250ns
     Overflow = 100ms

     ***************************************************************************
     
        Na simula��o do proteus, a l�gica funcionou corretamente, apesar dos tempos estem errados. Como j� falei antes, nem o professor simula,
     ent�o, provavelmente o proteus n�o deve conseguir simular o microcontrolador usado de forma correta.
        Na pr�tica o circuito e o programa funcionaram perfeitamente.
*/

// Mapeamento de hardware
#define led1 LATB0_bit
#define led2 LATB1_bit
#define motor LATB2_bit
#define botao RB7_bit

// Fun��es auxiliares
void base_Tempo();
void leitura_Botao();

// Vari�veis auxiliares
unsigned baseTempo1 = 0x00,
         baseTempo2 = 0x00,
         contMotor = 0x06,
         contTMR1 = 0x00;
         
bit flagBotao;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     INTCON2.F7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
     TRISB = 0xF8; // Configura RB0, RB1 e RB2 como sa�das digitais, o resto como entrada
     LATB = 0xF8; // Inicia todas as sa�das em Low

     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de m�quina e prescaler 1:4
     TMR0H = 0x9E; // Inicia o contador do timer0 em 40536, para uma contagem de 25000
     TMR0L = 0x58;
     
     T1CON = 0xB1; // Configura com 16 bits, Pic com outra fonte de clock, prescaler 1:8 e habilita o timer1
     TMR0H = 0x3C; // Inicia o contador do timer1 em 15536, para uma contagem de 50000
     TMR0L = 0xB0;
     
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


















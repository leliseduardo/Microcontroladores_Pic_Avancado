/* 

        O objetivo deste programa é demonstrar como os timers são importantes para projetos que executam multiplas tarefas. Isso porque uma tarefa
     não podem interromper ou atrapalhar a outra, e o timer tem a função de realizar alguma tarefa em determinado tempo sem que essa tarefa atra-
     palhe as demais execuções do programa.
        Para este exemplo, parte do código do último projeto será utilizado, o projeto denominado "TMR0MultiBasesTemp". E será incrementado para
     utilizar o timer1 e criar uma outra tarefa que consiste em ligar um motor durante 5s, sem atrapalhar a execução do timer0.
        Neste código ainda não se utiliza interrupção e as tarefas dos timers ocorrem no loop infinito, na função principal. Porém, ainda sim,
     a utilização dos timers no auxilio à execução de mais de uma tarefa é essencial, uma vez que em projetos de circuitos microcontrolados, as
     temporizações são cruciais para a execução do programa.


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
     
     ***** Tempo base do timer1 de 100ms ****************************************

     tempo de estouro = contagem * prescale * ciclo de máquina
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
     
        Na simulação do proteus, a lógica funcionou corretamente, apesar dos tempos estem errados. Como já falei antes, nem o professor simula,
     então, provavelmente o proteus não deve conseguir simular o microcontrolador usado de forma correta.
        Na prática o circuito e o programa funcionaram perfeitamente.
*/

// Mapeamento de hardware
#define led1 LATB0_bit
#define led2 LATB1_bit
#define motor LATB2_bit
#define botao RB7_bit

// Funções auxiliares
void base_Tempo();
void leitura_Botao();

// Variáveis auxiliares
unsigned baseTempo1 = 0x00,
         baseTempo2 = 0x00,
         contMotor = 0x06,
         contTMR1 = 0x00;
         
bit flagBotao;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     INTCON2.F7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
     TRISB = 0xF8; // Configura RB0, RB1 e RB2 como saídas digitais, o resto como entrada
     LATB = 0xF8; // Inicia todas as saídas em Low

     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler 1:4
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


















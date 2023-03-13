/* 

        Esta aula tem o objetivo de demonstrar o timer0, por�m, sem interrup��o, usando-o apenas como temporizador. Quando o contador do timer0
    estourar sua contagem, o registrador TMR0IF ir� setar em High, assim, trocando o estado de um led. Por�m, como dito, isso n�o ser� uma inter-
    rup��o, e sim uma rotina do programa principal.
        Na aula, este programa foi feito em Assembly, para exemplificar a linguagem Assembly em Pic's da fam�lia 18F, por�m, o c�digo pode ser
    feito em C facilmente.
    
        Para uma troca de estado do led a cada 250ms, temos que calcular em qual n�mero a contagem do timer0 ir� come�ar. Para isso, definimos
    o prescaler em 32 e o ciclo de m�quna j� esta definido, uma vez que o oscilador � de 16MHz.
    
        Tempo de contagem = contagem * prescaler * ciclo de maquina
              250ms       = contagem * 32 * 250ns
              contagem =    250ms
                        -------------
                         32 * 250ns
                         
              contagem = 31250
              
        Logo
        
        65536 - <TMR0H::TMR0L> = 31250
        <TMR0H::TMR0L> = 65536 - 31250
        <TMR0H::TMR0L> = 34286(decimal) = 0x85EE(hexadecimal)
        TMR0L = 0xEE;
        TMR0H = 0x85;


        Na pr�tica o circuito, o programa e a temporiza��o funcionaram perfeitamente. No proteus, a temporiza��o, por algum motivo, ficou com
    40ms, o que est� errado. Portanto, se funcionou na pr�tica, deve ser algum problema com o proteus.

*/

// Configura��o de hardware
#define led LATB0_bit

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     led = 0x00; // Inicia LATB0 em Low
     
     T0CON = 0x84; // Habilita o timer0, configura com 16 bits, incremento por ciclo de m�quina e prescaler de 1:32
     TMR0L = 0xEE; // Inicia <TMR0H::TMR0L> para contar 31250
     TMR0H = 0x85;

     // Loop infinito
     while(1){
     
       if(TMR0IF_bit){
       
        TMR0IF_bit = 0x00;
        TMR0L = 0xEE;
        TMR0H = 0x85;
        led = ~led;
       
       } // end if TMR0IF_bit
     
     } // end Loop infinito
     
} // end void main











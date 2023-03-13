/* 

        Esta aula tem o objetivo de demonstrar o timer0, porém, sem interrupção, usando-o apenas como temporizador. Quando o contador do timer0
    estourar sua contagem, o registrador TMR0IF irá setar em High, assim, trocando o estado de um led. Porém, como dito, isso não será uma inter-
    rupção, e sim uma rotina do programa principal.
        Na aula, este programa foi feito em Assembly, para exemplificar a linguagem Assembly em Pic's da família 18F, porém, o código pode ser
    feito em C facilmente.
    
        Para uma troca de estado do led a cada 250ms, temos que calcular em qual número a contagem do timer0 irá começar. Para isso, definimos
    o prescaler em 32 e o ciclo de máquna já esta definido, uma vez que o oscilador é de 16MHz.
    
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


        Na prática o circuito, o programa e a temporização funcionaram perfeitamente. No proteus, a temporização, por algum motivo, ficou com
    40ms, o que está errado. Portanto, se funcionou na prática, deve ser algum problema com o proteus.

*/

// Configuração de hardware
#define led LATB0_bit

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     led = 0x00; // Inicia LATB0 em Low
     
     T0CON = 0x84; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler de 1:32
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











/* 

        O objetivo deste programa � utilizar um bot�o que muda a fun��o do programa atrav�s de m�ltiplos cliques. Para isso, utiliza-se o timer0
     na fun��o de oscilador externo por borda de descida. Isto �, sempre que o bot�o for clicado, o contador do timero incrementa. A utiliza��o
     do timer0 ainda ser� sem interrup��o, estando sua rotina no loop infinito, na fun��o principal.
        Aqui ser� feito apenas o prot�tipo, por�m, este programa d� a base para fazer projetos em que um bot�o apenas realiza v�rias fun��es,
     bastando apenas clicar tantas vezes no bot�o.

*/

// Mapeamento de hardware
#define out LATB0_bit

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digiais em High
     LATB0_bit = 0x00; // Inicia a sa�da LATB0 em Low
     T0CON = 0xF8; // Habilita o timer0, configura com 8 bits, incrementa pelo clock no pino T0CLK, incrementa na borda de descida, n�o associa
                   // o prescaler, o que equivale a 1:1
     TMR0L = 250; // Inicia em 250 para contagem de 6, isto �, 6 cliques do bot�o. Quando o timer0 est� configurado com 8 bits, inicia-se somente
                  // TMRL, e n�o se usa o TMR0H.
     
     // Loop infinito
     while(1){
     
       if(TMR0IF_bit){
       
         TMR0IF_bit = 0x00;
         TMR0L = 250;
         
         out = ~out;
       
       } // end if TMR0IF_bit
     
     } // end Looop infinito
     
} // end void main



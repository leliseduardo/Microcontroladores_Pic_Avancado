/* 

        O objetivo deste programa � finalmente entrar na interrup��es. Para isso, utiliza-se o timer0 para fazer uma simples interrup��o. Como
    fun��o de interrup��o o programa ir� simplesmente alterar o estado da sa�da LATB0.
        Este programa, na aula, � feito em Assembly e serve apenas para demonstrar o fluxo do programa quando h� uma interrup��o e, ainda, demons-
    trar como funcionam os fluxos de interrup��o programados em Assembly e os novos comandos para a fam�lia 18F.
        Por�m, usarei este programa para relembrar a configura��o do timer0 com interrup��o simples e j� ir exercitando a programa��o desta
    poderosa ferramenta.
    
    ******************** Timer 0 ***********************************************
    
    ciclo de m�quina = 250ns
    TMR0L = 0xEE = 238
    
    Overflow = (256 - TMR0L) * prescale * ciclo de maquina
    Overflow = (256 - 238) * 2 * 250ns
    Overflow = 18 * 2 * 250ns
    Overflow = 9us
    
    ****************************************************************************

*/

// Mapeamento de hardware
#define out LATB0_bit

// Fun��o de interrup��o
void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xEE;
       
       out = ~out;
     
     } // end TMR0IF_bit

} // end void interrupt

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser digitais como anal�gicos
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     out = 0x01; // Inicia LATB0 em Low
     
     INTCON = 0xA0; // Habilita a interrup��o global e a interrup��o por overflow do timer0
     
     T0CON = 0xC0; // Habilita o timer0, configura com 8 bits, incrementa com ciclo de m�quina e prescaler 1:2
     TMR0L = 0xEE;
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrup��o
     
     } // end loop infinito

} // end void main

















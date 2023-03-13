/* 

        O objetivo deste programa � mostrar uma forma de se obter mais precis�o dos timers do Pic. Para isso, uma solu��o via hardware ser� feita,
     por�m, a explica��o de como este hardware diminui o erro n�o ser� aqui explicada, pois tem na v�deo aula 118 no curso de Pic b�sico/Inter-
     medi�rio. Como tenho esse v�deo salvo, n�o farei as explica��es aqui, uma vez que essa aplica��o � muito espec�fica e dificilmente irei
     utiliza-la.
        Ainda sim, � importante conhecer esta t�cnica para ver como a programa��o pode ser vers�til na resolu��o de programas.

        Na simula��o do proteus funcionou perfeitamente, mas sem um oscilosc�pio n�o tem porque fazer na pr�tica. A explica��o e demonstra��o dadas
     pelo professor s�o suficientes.
     
*/

// Configura��o de hardware
#define Led LATB0_bit

// Vari�veis auxiliares
signed long cont = 15625;

// Fun��o de interrup��o
void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       
       cont -= 256;
       
       if(cont <= 0){
       
         cont += 15625;
         
         Led = ~Led;
       
       } // end if cont <=0
     
     } // end if TMR0IF_bit

} // end void interrupt

void main() {

     // Configura��o de registradores
     
     INTCON = 0xA0; // Habilita a interrup��o global e a interrup��o por overflow do timer0
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x01; // Configura o timer0 com 8 bits
     T0CS_bit = 0x00; // Configura o incremento do timer0 com o ciclo de m�quina
     PSA_bit = 0x00; // Associa o prescaler ao Timer0
     T0PS1_bit = 0x00; // Configura o prescaler como 1:64
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0_bit como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia as entradas digitais em High
     Led = 0x00; // Inicia LATB0 em Low
     
     while(1); // Loop infinito apenas aguarda a interrup��o

}







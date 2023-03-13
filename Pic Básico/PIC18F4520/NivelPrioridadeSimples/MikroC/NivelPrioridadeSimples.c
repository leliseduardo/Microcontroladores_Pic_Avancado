/* 

        Este programa tem a fun��o de corrigir o erro do �ltimo projeto, denominado "Timer0IntExt2", onde n�o foi utilizada a fun��o
     "interrupt_low" para interrup��es de baixa prioridade. A aula deste projeto foi exatamente dizendo que houve este erro no �ltimo
     projeto. 
        Como explicado em "Timer0IntExt2", se n�o usar-mos a fun��o "interrupt_low", h� um funcionamento errado das prioridades de inter-
     rup��o, fazendo com que a interrup��o com baixa prioridade s� execute sua fun��o depois que a interrup��o com alta prioridade tiver
     sua interrup��o, mesmo que isso demore para acontecer.
        Portanto, esse projeto � o primeiro utilizando interrup��es com n�veis de prioridade alto e baixo. Para isso, utiliza-se a inter-
     rup��o do timer0 e a interrup��o externa INT1.
        O programa � muito parecido com o programa do projeto "Timer0IntExt2", por�m, n�o usa a chave que liga e desliga os n�veis de
     prioridade da interrup��o.

        Neste programa o timer0 ir� contar at� 50.000, na configura��o de 16 bits. O c�lculo para iniciar sua contagem �:

        2^16 = 65536 - 50000 = 15536
        15536 (decimal) = 0x3CB0 (hexadecimal)

        TMR0L = 0xB0
        TMR1H = 0x3C

        O c�lculo de overflow do timer0 �:

        Overflow = (65536 - <TMR0L::TMR0H>) * Prescaler * Ciclo de m�quina
        Overflow = (65536 - 15536) * Prescaler * Ciclo de m�quina
        Overflow = 50000 * 1 * 1us (4MHz)
        Overflow = 50ms

        Outro erro que descobri sozinho foi no registrador INTCON, a flag PEIE/GIEL precisa ser 0x01, para que seja habilitada a interrup��o
     por n�vel dos perif�ricos. Na aula n�o foi falado mas no c�digo que foi disponibilizado, esta flag est� configurada assim.
        Provavelmente, para funcionar a fun��o interrupt_low, deve-se ter que fazer PEIE/GIEL = 0x01

*/

// Configura��o de hardware
#define outInt1 LATB6_bit
#define outT0 LATB7_bit

// Fun��es de interrup��o
void interrupt(){ // Fun��o para interrup��es de prioridade alta

     if(INT1IF_bit){
     
       INT1IF_bit = 0x00;
       
       outInt1 = ~outInt1;
     
     } // end if INT1IF_bit
     
} // end void interrupt

void interrupt_low(){ // Fun��o para interrup��es de prioridade baixa

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xB0;
       TMR0H = 0x3C;
       
       outT0 = ~outT0;
     
     } // end if TOIF_bit

} // end void interrupt_low

// Programa principal
void main() {

     // Configura��o de registradores
     
     // Registrador RCON
     IPEN_bit = 0x01; // Habilita as interrup��es por n�vel de prioridade (alta e baixa)
     
     // Registrador INTCON
     INTCON = 0xE0; // Habilita a interrup��o global, habilita a interrup��o dos perif�ricos por prioridade e habilita a interrup��o do timer0
     
     // Registrador INTCON2
     INTEDG1_bit = 0x01; // Configura a interrup��o externa INT1 por borda de subida
     TMR0IP_bit = 0x00; // Configura a interrup��o do timer0 com baixa prioridade
     
     // Registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrup��o externa INT1
     INT1IP_bit = 0x01; // Configura a interrup��o externa INT1 com prioridade alta
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o timer0 para incrementar atrav�s do ciclo de m�quina
     PSA_bit = 0x01; // N�o associa o timer0 ao prescaler, isto �, o timer0 fica sem prescaler, o que equivale a 1:1
     
     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para uma contagem de 50000
     TMR0H = 0x3C;

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0x3F; // Configura RB6 e RB7 como sa�das digitais, o resto como entrada
     outInt1 = 0x00; // Inicia LATB6 em Low
     outT0 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda as interrup��es...

     } // end while

} // end void mais














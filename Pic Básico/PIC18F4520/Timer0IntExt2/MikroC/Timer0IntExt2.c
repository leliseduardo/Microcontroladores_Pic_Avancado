/* 

        Este programa � muito semelhante ao �ltimo, o projeto "Timer0IntExt". Por�m, foi resultado de um erro do professor, como ele mesmo
     falou em um dos coment�rios do v�deos e vai falar na pr�xima aula, denominada "Fun��o interrupt_low do mikroC", aula de n�mero 96.
        O que est� errado neste c�digo � o fato de n�o se usar a fun��o "interrupt_low" para uma interrup��o de baixa prioridade. O que
     resulta num processamento errado das interrup��es de baixa prioridade. Quando se ativa o modo de prioridades das interrup��es, � neces-
     s�rio usar a fun��o "interrupt_low" pois, caso se coloque tudo em "interrupt", a interrup��o de baixa prioridade ir� esperar a
     interrup��o de alta prioridade ocorrer para a� sim acontecer, mesmo que a de baixa prioridade ocorra antes, ela n�o ser� executada.
        O erro deste c�digo � exatamente esse. A interrup��o do timer0 ocorre a cada 50ms e a interrup��o externa, a cada 200ms, pois o
     sinal externo tem 5Hz. Ainda, a interrup��o que tem alta prioridade � a interrup��o externa. Assim, nota-se que � poss�vel ter tr�s
     interrup��es completas, pelo menos, do timer0, antes que ocorra a interrup��o externa. Sendo assim, no final da quarta interrup��o
     do timer0 ou no in�cio da quinta, ocorreria a interrup��o externa, que pararia o processo do timer0, realizaria o processo da inter-
     rup��o externa e retornaria ao processo do timer0. Por�m, o que ocorre � que o processo do timer0 s� acontece ap�s ocorrer o a inter-
     rup��o externa. Ou seja, a interrup��o do timer0 espera a interrup��o externa ocorrer para ser processada. Este erro ocorre justamente
     por n�o se ter usado a fun��o "interrupt_low" para o timer0, que tinha baixa prioridade.
        Ainda sim � interessante fazer este programa para se ver os erros que podem acontecer e aprender com eles. No caso, o erro � a forma
     como o MikroC lida com as prioridades de interrup��o e o modo certo como elas devem ser implementadas para que se tenha o funcionamento
     que se espera dessas interrup��es e de suas prioridades.

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
#define chave RB5_bit

// Fun��o de interrup��o

void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xB0;
       TMR0H = 0x3C;
       
       outT0 = ~outT0;
     }
     
     if(INT1IF_bit){
     
       INT1IF_bit = 0x00;
       
       outInt1 = ~outInt1;
     }
}


void main() {

     // Configura��o de registradores
     
     // Resgistrador RCON
     IPEN_bit = 0x00; // Desabilita as interrup��es por n�vel de prioridade (alta e baixa)
     
     // Registrador INTCON
     INTCON = 0xE0; // Habilita a interrup��o global, habilita a interrup��o dos perif�ricos por prioridade e habilita a interrup��o do timer0
     
     // Registrador INTCON2
     INTEDG1_bit = 0x01; // Configura a interrup��o externa INT1 por borda de subida
     TMR0IP_bit = 0x00; // Configura a interrup��o do timer0 com baixa prioridade
     
     // Registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrup��o externa INT1
     INT1IP_bit = 0x01; // Configura a interrup��o externa INT1 com alta prioridade
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o incremento do timer0 a partir do ciclo de m�quina
     PSA_bit = 0x01; // N�o associa o prescaler ao timer0, isto �, o timer0 fica sem prescaler, o que equivale a 1:1

     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para um contagem de 50000
     TMR0H = 0x3C;
     
     ADCON1 = 0x0F; // Configura todos os bot�es que poderiam ser anal�gicos como digitais
     TRISB = 0x3F; // Ou 0b00111111, que configura apenas RB6 e RB7 como sa�das digitais e o resto como entrada
     outInt1 = 0x00; // Inicia LATB6 em Low
     outT0 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     while(1){
     
       if(chave) IPEN_bit = 0x01; // Se chave em High, habilita a interrup��o por n�vel de prioridade (alta e baixa)
       
       else IPEN_bit = 0x00; // Se chave em Low, desabilita a interrup��o por n�vel de prioridade (alta e baixa)
     } // end while
} // end void main

















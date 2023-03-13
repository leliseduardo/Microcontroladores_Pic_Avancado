/* 

        Este programa tem a fun��o de apresentar o timer1 com incremento externo. Isto �, ao inv�s de incrementar o timer1 com o ciclo
     de m�quina, incrementa com um sinal externo, por borda de subida.
        Este tipo de incremento serve par muitas aplica��es onde precisa-se contar o tempo, os pulsos e fazer leitura de sensores.
        
        Para este programa, o sinal externo aplicado ao pino RC0 ser� de 1KHz e, assim, com per�do de pulsos de 1ms. Fazendo uma contagem
     de 500 no timer 1, consegue-se um overflow (estouro) a cada 500ms. Sendo assim:
     
     2^16 = 65536 - 500 = 65036
     65036 (decimal) = 0xFE0C
     
     TMR1L = 0x0C;
     TMR1H = 0xFE;
     
     Overflow = (65536 - <TMR0H::TMR0L>) * prescaler * Per�odo Osc Externo
     Overflow = (65536 - 65036) * 1 * (1/1KHz)
     Overflow = 500 * 1 * 1ms
     Overflow = 500ms
     
     Por algum motivo, na simu��o do proteus o timer1 s� come�a a incrementar depois de o pic ser resetado. Talvez seja erro de proces-
   samento do proteus.

*/

// Configura��o de hardware
#define outT1 LATB7_bit

// Fun��o de interrup��o
void interrupt(){

     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1L = 0x0C;
       TMR1H = 0xFE;
       
       outT1 = ~outT1;
     
     } // end if TMR1IF_bit

} // end void interrupt

// Programa principal
void main() {

     // Configura��o dos registradores
     
     IPEN_bit = 0x00;
     
     // Registrador INTCON
     INTCON = 0xC0; // Habilita a interrup��o global e a interrup��o por perif�ricos

     // Registrador PIE1
     TMR1IE_bit = 0x01; // Habilita a interrup��o do timer1 por overflow
     
     // Registrador T1CON
     T1CON = 0x83; // Configura o timer1 com 16 bits, habilita o timer1, configura clock s�ncrono e configura o incremento por clock externo
     
     // Registrador <TMR1H::TMR1L>
     TMR1L = 0x0C;
     TMR1H = 0xFE;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0x7F; // Configura apenas RB7 como sa�da digital, o resto como entrada, pois n�o ser�o usados
     outT1 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     
     while(1){
     
       // Apenas aguarda a interrup��o...
     
     } // end while

} // end void mais













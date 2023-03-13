/* 

        O objetivo deste programa � conhecer o timer1, muito parecido com o timer0 e com o pr�prio timer1 da fam�lia 16F. Com este progra-
     ma ser� poss�vel familiarizar-se com os registradores do timer1, assim como fixar o conte�da j� estudado, uma vez que o timer0 tamb�m
     ser� usado e configurado com prioridade baixa, enquanto o timer1 ter� prioridade alta.
        Os dois timers ir�o simplesmente trocar os estados das portas RB6 e RB7, cada um com um tempo diferente. Abaixo est� o c�lculo
     dos tempos de overflow.
     
     Ciclo de m�quina = 1/ (4MHz/4) = 1 / 1MHz = 1us
     
     *** TIMER 0 ***
     
     Contagem = 50000
     2^16 = 65536 - 50000 = 15536
     15536(decimal) = 0x3CB0(hexadecimal)
     
     TMR0L = 0xB0
     TMR0H = 0x3C
     
     Overflow = (65536 - <TMR0H::TMR0L>) * prescaler * ciclo de m�quina (4MHz)
     Overflow = (65536 - 15536) * 1 * 1us
     Overflow = 50000 * 1 * 1us
     Overflow = 50ms
     
     *** Timer 1 ***
     
     Contagem = 65536
     
     Overflow = <TMR1H::TMR1L> * prescaler * ciclo de m�quina (4MHz)
     Overflow = 65536 * 1 * 1us
     Overflow = 65,54ms

*/

// Configura��o de hardware
#define outT1 LATB6_bit
#define outT0 LATB7_bit

// Fun��es de interrup��o
void interrupt(){

     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1L = 0x00;
       TMR1H = 0x00;
       
       outT1 = ~outT1;
     
     } // end if TMR1IF_bit

} // end void interrupt

void interrupt_low(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xB0;
       TMR0H = 0x3C;
       
       outT0 = ~outT0;
     
     } // end if TMR0IF_bit

} // end void interrupt_low

// Programa principal
void main() {

     // Configura��o de registradores
     
     // Registrador RCON
     IPEN_bit = 0x01; // Habilita as interrup��es por n�vel de prioridade
     
     // Registrador INTCON
     INTCON = 0xE0; // Habilita a interrup��o global, a interrup��o por perif�ricos com n�vel de interrup��o e habilita a interrup��o
                    // do timer0 por overflow
     
     // Registrador INTCON2
     TMR0IP_bit = 0x00; // Configura a interrup��o do timer0 com baixa prioridade
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o incremento do timer0 com o ciclo de m�quina
     PSA_bit = 0x01; // N�o associa o timer0 ao prescaler, isto �, o timer0 fica sem prescaler, o que equivale a 1:1
     
     // Registrador <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para contagem de 50000
     TMR0H = 0x3C;
     
     // Registrador PIE1
     TMR1IE_bit = 0x01; // Habilita a interrup��o do timer1 por overflow
     
     // Registrador T1CON
     T1CON = 0x81; // Configura o timer1 com 16 bits e habilita o timer1. Flags setadas: RD16 e TMR1ON
     
     // Registrador IPR1
     TMR1IP_bit = 0x01; // Configura a interrup��o do timer1 com alta prioridade
     
     // Registrador <TMR1H::TMR1L>
     TMR1L = 0x00; // Inicia a contagem do timer1 em 0, para contagem de 65536
     TMR1H = 0x00;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0x3F; // Configura RB6 e RB7 como sa�das digitais, o resto como entrada
     outT1 = 0x00; // Inicia LATB6 em Low
     outT0 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrup��o...
     
     } // end while

} // end void mais

















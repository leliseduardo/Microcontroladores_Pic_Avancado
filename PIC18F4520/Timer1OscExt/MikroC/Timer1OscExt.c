/* 

        Este programa tem a função de apresentar o timer1 com incremento externo. Isto é, ao invés de incrementar o timer1 com o ciclo
     de máquina, incrementa com um sinal externo, por borda de subida.
        Este tipo de incremento serve par muitas aplicações onde precisa-se contar o tempo, os pulsos e fazer leitura de sensores.
        
        Para este programa, o sinal externo aplicado ao pino RC0 será de 1KHz e, assim, com perído de pulsos de 1ms. Fazendo uma contagem
     de 500 no timer 1, consegue-se um overflow (estouro) a cada 500ms. Sendo assim:
     
     2^16 = 65536 - 500 = 65036
     65036 (decimal) = 0xFE0C
     
     TMR1L = 0x0C;
     TMR1H = 0xFE;
     
     Overflow = (65536 - <TMR0H::TMR0L>) * prescaler * Período Osc Externo
     Overflow = (65536 - 65036) * 1 * (1/1KHz)
     Overflow = 500 * 1 * 1ms
     Overflow = 500ms
     
     Por algum motivo, na simução do proteus o timer1 só começa a incrementar depois de o pic ser resetado. Talvez seja erro de proces-
   samento do proteus.

*/

// Configuração de hardware
#define outT1 LATB7_bit

// Função de interrupção
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

     // Configuração dos registradores
     
     IPEN_bit = 0x00;
     
     // Registrador INTCON
     INTCON = 0xC0; // Habilita a interrupção global e a interrupção por periféricos

     // Registrador PIE1
     TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
     
     // Registrador T1CON
     T1CON = 0x83; // Configura o timer1 com 16 bits, habilita o timer1, configura clock síncrono e configura o incremento por clock externo
     
     // Registrador <TMR1H::TMR1L>
     TMR1L = 0x0C;
     TMR1H = 0xFE;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x7F; // Configura apenas RB7 como saída digital, o resto como entrada, pois não serão usados
     outT1 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     
     while(1){
     
       // Apenas aguarda a interrupção...
     
     } // end while

} // end void mais













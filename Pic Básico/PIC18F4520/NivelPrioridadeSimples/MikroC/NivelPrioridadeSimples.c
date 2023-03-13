/* 

        Este programa tem a função de corrigir o erro do último projeto, denominado "Timer0IntExt2", onde não foi utilizada a função
     "interrupt_low" para interrupções de baixa prioridade. A aula deste projeto foi exatamente dizendo que houve este erro no último
     projeto. 
        Como explicado em "Timer0IntExt2", se não usar-mos a função "interrupt_low", há um funcionamento errado das prioridades de inter-
     rupção, fazendo com que a interrupção com baixa prioridade só execute sua função depois que a interrupção com alta prioridade tiver
     sua interrupção, mesmo que isso demore para acontecer.
        Portanto, esse projeto é o primeiro utilizando interrupções com níveis de prioridade alto e baixo. Para isso, utiliza-se a inter-
     rupção do timer0 e a interrupção externa INT1.
        O programa é muito parecido com o programa do projeto "Timer0IntExt2", porém, não usa a chave que liga e desliga os níveis de
     prioridade da interrupção.

        Neste programa o timer0 irá contar até 50.000, na configuração de 16 bits. O cálculo para iniciar sua contagem é:

        2^16 = 65536 - 50000 = 15536
        15536 (decimal) = 0x3CB0 (hexadecimal)

        TMR0L = 0xB0
        TMR1H = 0x3C

        O cálculo de overflow do timer0 é:

        Overflow = (65536 - <TMR0L::TMR0H>) * Prescaler * Ciclo de máquina
        Overflow = (65536 - 15536) * Prescaler * Ciclo de máquina
        Overflow = 50000 * 1 * 1us (4MHz)
        Overflow = 50ms

        Outro erro que descobri sozinho foi no registrador INTCON, a flag PEIE/GIEL precisa ser 0x01, para que seja habilitada a interrupção
     por nível dos periféricos. Na aula não foi falado mas no código que foi disponibilizado, esta flag está configurada assim.
        Provavelmente, para funcionar a função interrupt_low, deve-se ter que fazer PEIE/GIEL = 0x01

*/

// Configuração de hardware
#define outInt1 LATB6_bit
#define outT0 LATB7_bit

// Funções de interrupção
void interrupt(){ // Função para interrupções de prioridade alta

     if(INT1IF_bit){
     
       INT1IF_bit = 0x00;
       
       outInt1 = ~outInt1;
     
     } // end if INT1IF_bit
     
} // end void interrupt

void interrupt_low(){ // Função para interrupções de prioridade baixa

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xB0;
       TMR0H = 0x3C;
       
       outT0 = ~outT0;
     
     } // end if TOIF_bit

} // end void interrupt_low

// Programa principal
void main() {

     // Configuração de registradores
     
     // Registrador RCON
     IPEN_bit = 0x01; // Habilita as interrupções por nível de prioridade (alta e baixa)
     
     // Registrador INTCON
     INTCON = 0xE0; // Habilita a interrupção global, habilita a interrupção dos periféricos por prioridade e habilita a interrupção do timer0
     
     // Registrador INTCON2
     INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
     TMR0IP_bit = 0x00; // Configura a interrupção do timer0 com baixa prioridade
     
     // Registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
     INT1IP_bit = 0x01; // Configura a interrupção externa INT1 com prioridade alta
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o timer0 para incrementar através do ciclo de máquina
     PSA_bit = 0x01; // Não associa o timer0 ao prescaler, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
     
     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para uma contagem de 50000
     TMR0H = 0x3C;

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x3F; // Configura RB6 e RB7 como saídas digitais, o resto como entrada
     outInt1 = 0x00; // Inicia LATB6 em Low
     outT0 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda as interrupções...

     } // end while

} // end void mais














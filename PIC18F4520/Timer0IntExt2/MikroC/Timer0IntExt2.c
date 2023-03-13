/* 

        Este programa é muito semelhante ao último, o projeto "Timer0IntExt". Porém, foi resultado de um erro do professor, como ele mesmo
     falou em um dos comentários do vídeos e vai falar na próxima aula, denominada "Função interrupt_low do mikroC", aula de número 96.
        O que está errado neste código é o fato de não se usar a função "interrupt_low" para uma interrupção de baixa prioridade. O que
     resulta num processamento errado das interrupções de baixa prioridade. Quando se ativa o modo de prioridades das interrupções, é neces-
     sário usar a função "interrupt_low" pois, caso se coloque tudo em "interrupt", a interrupção de baixa prioridade irá esperar a
     interrupção de alta prioridade ocorrer para aí sim acontecer, mesmo que a de baixa prioridade ocorra antes, ela não será executada.
        O erro deste código é exatamente esse. A interrupção do timer0 ocorre a cada 50ms e a interrupção externa, a cada 200ms, pois o
     sinal externo tem 5Hz. Ainda, a interrupção que tem alta prioridade é a interrupção externa. Assim, nota-se que é possível ter três
     interrupções completas, pelo menos, do timer0, antes que ocorra a interrupção externa. Sendo assim, no final da quarta interrupção
     do timer0 ou no início da quinta, ocorreria a interrupção externa, que pararia o processo do timer0, realizaria o processo da inter-
     rupção externa e retornaria ao processo do timer0. Porém, o que ocorre é que o processo do timer0 só acontece após ocorrer o a inter-
     rupção externa. Ou seja, a interrupção do timer0 espera a interrupção externa ocorrer para ser processada. Este erro ocorre justamente
     por não se ter usado a função "interrupt_low" para o timer0, que tinha baixa prioridade.
        Ainda sim é interessante fazer este programa para se ver os erros que podem acontecer e aprender com eles. No caso, o erro é a forma
     como o MikroC lida com as prioridades de interrupção e o modo certo como elas devem ser implementadas para que se tenha o funcionamento
     que se espera dessas interrupções e de suas prioridades.

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
#define chave RB5_bit

// Função de interrupção

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

     // Configuração de registradores
     
     // Resgistrador RCON
     IPEN_bit = 0x00; // Desabilita as interrupções por nível de prioridade (alta e baixa)
     
     // Registrador INTCON
     INTCON = 0xE0; // Habilita a interrupção global, habilita a interrupção dos periféricos por prioridade e habilita a interrupção do timer0
     
     // Registrador INTCON2
     INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
     TMR0IP_bit = 0x00; // Configura a interrupção do timer0 com baixa prioridade
     
     // Registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
     INT1IP_bit = 0x01; // Configura a interrupção externa INT1 com alta prioridade
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o incremento do timer0 a partir do ciclo de máquina
     PSA_bit = 0x01; // Não associa o prescaler ao timer0, isto é, o timer0 fica sem prescaler, o que equivale a 1:1

     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para um contagem de 50000
     TMR0H = 0x3C;
     
     ADCON1 = 0x0F; // Configura todos os botões que poderiam ser analógicos como digitais
     TRISB = 0x3F; // Ou 0b00111111, que configura apenas RB6 e RB7 como saídas digitais e o resto como entrada
     outInt1 = 0x00; // Inicia LATB6 em Low
     outT0 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     while(1){
     
       if(chave) IPEN_bit = 0x01; // Se chave em High, habilita a interrupção por nível de prioridade (alta e baixa)
       
       else IPEN_bit = 0x00; // Se chave em Low, desabilita a interrupção por nível de prioridade (alta e baixa)
     } // end while
} // end void main

















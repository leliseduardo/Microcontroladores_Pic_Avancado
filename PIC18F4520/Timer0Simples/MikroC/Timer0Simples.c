 /* 
 
        Este programa tem a função de apresentar o timer0 e suas diferenças em relação a família 16F. Ainda não se utiliza alta prioridade
     na interrupção.
        O timer0 da família 18F, diferentemente da família 16F, apresenta a opção de ser usado com 16 bits. Ainda, apresenta um prescaler
     próprio, não compartilhado com o WhachDog Timer. O timer0 pode ser incrementado a partir de um clock externo ou pelo ciclo de máquina,
     assim como apresenta intorrupção por Overflow, isto é, por estouro de contagem.
     
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
 
 */
 
 // Configuração de hardware
 #define outP LATB6_bit
 #define outT0 LATB7_bit
 
 // Variáveis auxiliares
 short cont = 0x00;
 
 // Função de interrupção
 void interrupt(){
 
      if(TMR0IF_bit){
      
        TMR0IF_bit = 0x00;
        TMR0L = 0xB0;
        TMR0H = 0x03C;
        
        cont++;
        
        if(cont == 0x0A){
        
          cont = 0x00;
        
          outT0 = ~outT0;
        } // end if
        
      } // end if
 } // end void interrupt

void main() {

     // Configuração de registradores
     INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção por overflow do timer0
     
     // Flags do registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16bits
     T0CS_bit = 0x00; // Configura o timer0 para incrementar com o ciclo de máquina
     PSA_bit = 0x01; // Não associa o prescaler ao timer0, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
     
     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0, configurado para 16its, em 15536, para uma contagem de 50.000
     TMR0H = 0x3C;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x3F; // Configura RB6 e RB7 como saídas digitais
     outP = 0x01; // Inicia LATB6 em High
     outT0 = 0x00; // Inicia LATB7 em Low

     // Loop infinito
     while(1){
     
       outP = ~outP;
       delay_ms(500);
     } // end while
     
} // end void main
 /* 
 
        Este programa tem a fun��o de apresentar o timer0 e suas diferen�as em rela��o a fam�lia 16F. Ainda n�o se utiliza alta prioridade
     na interrup��o.
        O timer0 da fam�lia 18F, diferentemente da fam�lia 16F, apresenta a op��o de ser usado com 16 bits. Ainda, apresenta um prescaler
     pr�prio, n�o compartilhado com o WhachDog Timer. O timer0 pode ser incrementado a partir de um clock externo ou pelo ciclo de m�quina,
     assim como apresenta intorrup��o por Overflow, isto �, por estouro de contagem.
     
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
 
 */
 
 // Configura��o de hardware
 #define outP LATB6_bit
 #define outT0 LATB7_bit
 
 // Vari�veis auxiliares
 short cont = 0x00;
 
 // Fun��o de interrup��o
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

     // Configura��o de registradores
     INTCON = 0xA0; // Habilita a interrup��o global e habilita a interrup��o por overflow do timer0
     
     // Flags do registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16bits
     T0CS_bit = 0x00; // Configura o timer0 para incrementar com o ciclo de m�quina
     PSA_bit = 0x01; // N�o associa o prescaler ao timer0, isto �, o timer0 fica sem prescaler, o que equivale a 1:1
     
     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0, configurado para 16its, em 15536, para uma contagem de 50.000
     TMR0H = 0x3C;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0x3F; // Configura RB6 e RB7 como sa�das digitais
     outP = 0x01; // Inicia LATB6 em High
     outT0 = 0x00; // Inicia LATB7 em Low

     // Loop infinito
     while(1){
     
       outP = ~outP;
       delay_ms(500);
     } // end while
     
} // end void main
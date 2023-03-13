/* 

   Na familia dos pics 12f e 16f, n�o existe prioridade alta e baixa para uma interrup��o, isto �, no chip, existe apenas um vetor
   para a interrup��o, ao contr�rio da familia 18f, que possui mais de um vetor, conseguindo, assim, definir prioridade alta e baixa
   para as interrup��es. Por�m, pode-se simular uma certa prioridade de interrup��o na familia 12f e 16f, programando uma interrup��o
   primeiro que a outra. Como o programa � processado de forma sequencial, a interrup��o programada antes ser� processada antes. Desta
   forma pode-se dizer que existe uma certa prioridade, mesmo que simpl�ria.
   
   Clock = 4MHz, Ciclo de m�quina = 1us
   
   Overflow0 = Ciclo de maquina x prescaler x TMR0
   Overflow0 = 1us x 1 x 256 = 256us
   
   Overflow1 = Ciclo de maquina x prescaler x (TMR1H::TMR1L)
   Overflow1 = 1us x prescaler x 256 = 256us
   
   Overflow2 = Ciclo de maquina x prescaler x TMR2 x postscaler
   Overflow2 = 1us x 1 x 256 x 1 = 256us
   
   Como a cada interrup��o, os pinos de output ir�o inverter, o pe�rodo T � igual a 2 x Overflow, logo:
   
   T = 2 x 256us = 512us
   f = 1/T = 1953 Hz
   
   Como a interrup��o externa s� ocorre por borda de subida, para que seja invertido duas vezes o valor do output relacionado a ela, dever�o 
   ocorrer duas bordas de subida. Para que a frequencia seja a mesma dos outros outputs, a frequencia de entrada na interrup��o externa
   dever� ser duas vezes a frequencia dos timers.
   Logo, a frequencia do sinal de entrada na interrup��o externa deve ser:
   
   F(int. Ext.) = 2f = 3906 Hz

*/

// Hardware

#define out1 RB1_bit
#define out2 RB2_bit
#define out3 RB3_bit
#define out4 RB4_bit

void interrupt(){

     if(INTF_bit){
     
       INTF_bit = 0x00;
       
       out1 = ~out1;
     }
     
     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       
       out2 = ~out2;
     }
     
     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1H = 0xFF;
       
       out3 = ~out3;
     }
     
     if(TMR2IF_bit){
     
       TMR2IF_bit = 0x00;
       
       out4 = ~out4;
     }
}

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     OPTION_REG = 0x08; // Ativa os pull-ups internos
                        // Interrup��o externa por borda de descida
                        // TMR0 incrementa com o ciclo de maquina
                        // Configura o prescaler em 1:1, associado ao timer do WatchDog (WTD)
     INTCON = 0xF0; // Ativa a interrup��o global, por perif�ricos, do timer0 e externa
     
     T1CON = 0x01; // Ativa o TMR1 e configura o prescaler para 1:1
     TMR1IE_bit = 0x01; // Ativa a interrup��o do timer1 (flag do registrador PIE1) PIE = peripheral interrupt enable
     TMR1H = 0xFF; // Como o timer1 � de 16 bits, configura-se o neeble mais significativo para come�ar a contagem j� em 256,
                   // assim, somente o primeiro neeble conta e o timer de 16 bits simula um timer de 8 nits, contando s� at� 256
     
     T2CON = 0x04; // Ativa o timer2 e configura o prescaler como 1:1 e o postscaler como 1:1
     TMR2IE_bit = 0x01; // Ativa a interrup��o do timer2 (flag do registrador PIE1)
     PR2 = 0xFF; // Faz o contador do timer2, TMR2, contar de 0 a 255(valor de PR2). O timer2, internamente, compara o valor de TMR2
                 // como o de PR2 e, quando s�o iguais, ocorre a interrup��o. Nesse caso PR2 = 0xFF(hexadecimal) = 256(decimal)
                 
     TRISA = 0xFF; // Configura todo porta como entrada digital, pois n�o ser�o usadas
     TRISB = 0xE1; // Configura RB4, RB3, RB2 e RB1 como sa�das digitais e o resto como entrada digital
     PORTA = 0xFF; // Inicia todo porta em High
     PORTB = 0xE1; // Inicia RB4, RB3, RB2 e RB1 em Low e o resto em High
     
}














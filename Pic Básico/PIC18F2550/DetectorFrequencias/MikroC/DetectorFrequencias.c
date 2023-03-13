/* 

        O objetivo deste programa é usar o timer3 para detectar se existe uma frequência em seu pino de clock externo. Se existir, um led piscará,
     se não existir, o led ficará apagado. A frequência que o led pisca é diretamente proporcional à frequência do sinal de entrada.

*/

#define led LATB0_bit

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que pdoeriam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital
     LATB = 0xFE; // Inicia LATB0 em Low
     
     T3CON = 0x83; // Configura com 16 bits, prescale 1:1, clock externo e habilita o timer3
     
     while(1){
     
       if(TMR3IF_bit){
       
         TMR3IF_bit = 0x00;
         
         led = ~led;
       
       } // end if TMR3IF_bit

       //led = 0x00;

     } // end loop infinito

} // end void main
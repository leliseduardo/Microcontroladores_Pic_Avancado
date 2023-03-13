/* 

        O objetivo deste programa � usar o timer3 para detectar se existe uma frequ�ncia em seu pino de clock externo. Se existir, um led piscar�,
     se n�o existir, o led ficar� apagado. A frequ�ncia que o led pisca � diretamente proporcional � frequ�ncia do sinal de entrada.

*/

#define led LATB0_bit

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que pdoeriam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital
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
/* 

   Nos pics da fam�lia 18f, ao inv�s de termos PORTB, temos o registrador LATB, que diz respeito aos latches presentes nos ports do pic. Os
   latches servem para os pinos que s�o configurados para sa�da digital. Por isso, ao se referir a um pino que foi configurado como sa�da
   digital, seja para declarar, iniciar ou mudar de estado, usa-se o comando LATB0_bit, por exemplo, ou LATA5_bit, tamb�m como exemplo.
   Para um pino que foi configurado como entrada, utiliza-se RB0_bit ou RA5_bit normalmente, por exemplo.
   Tal mudan�a, em rela��o aos pics das familias 16f e 12f, ajuda, no codigo, a diferenciar as portas configuradas como sa�da das portas
   configuradas como entrada.
   
   Neste c�digo foram habilitados os pull-ups internos do portb. Assim, economiza-se espa�o com componentes externos (resistores de pull-up).
   Quando os pull-ups est�o habilitados, todas as portas configuradas como entrada digital utilizam esses pull-ups. As configuradas como
   sa�da, obviamente, n�o utilizam. No proteus, as portas n�o usadas ter�o sua indica��o dos pinos em vermelho, indicando que a entrada 
   est� em n�vel alto, justamente por causa dessa configura��o.

*/

// Configura��o de hardware

#define led LATB0_bit
#define bot RB1_bit

void main() {

     ADCON1 = 0x0F; // Configura todas as portas que podem ser anal�gicas, como digitais
     INTCON2 = 0x7F; // Ou 0b0111 1111, que habilita os pull-ups internos no portb
     
     TRISB = 0xFE; // Ou 0b1111 1110, que configura apenas RB0 como sa�da digital
     
     led = 0x00;
     
     while(1){
     
       if(!bot){
       
         led = 0x01;
         delay_ms(500);
         led = 0x00;
       }
     }
}
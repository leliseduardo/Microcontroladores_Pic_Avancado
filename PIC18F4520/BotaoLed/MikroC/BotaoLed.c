/* 

   Nos pics da família 18f, ao invés de termos PORTB, temos o registrador LATB, que diz respeito aos latches presentes nos ports do pic. Os
   latches servem para os pinos que são configurados para saída digital. Por isso, ao se referir a um pino que foi configurado como saída
   digital, seja para declarar, iniciar ou mudar de estado, usa-se o comando LATB0_bit, por exemplo, ou LATA5_bit, também como exemplo.
   Para um pino que foi configurado como entrada, utiliza-se RB0_bit ou RA5_bit normalmente, por exemplo.
   Tal mudança, em relação aos pics das familias 16f e 12f, ajuda, no codigo, a diferenciar as portas configuradas como saída das portas
   configuradas como entrada.
   
   Neste código foram habilitados os pull-ups internos do portb. Assim, economiza-se espaço com componentes externos (resistores de pull-up).
   Quando os pull-ups estão habilitados, todas as portas configuradas como entrada digital utilizam esses pull-ups. As configuradas como
   saída, obviamente, não utilizam. No proteus, as portas não usadas terão sua indicação dos pinos em vermelho, indicando que a entrada 
   está em nível alto, justamente por causa dessa configuração.

*/

// Configuração de hardware

#define led LATB0_bit
#define bot RB1_bit

void main() {

     ADCON1 = 0x0F; // Configura todas as portas que podem ser analógicas, como digitais
     INTCON2 = 0x7F; // Ou 0b0111 1111, que habilita os pull-ups internos no portb
     
     TRISB = 0xFE; // Ou 0b1111 1110, que configura apenas RB0 como saída digital
     
     led = 0x00;
     
     while(1){
     
       if(!bot){
       
         led = 0x01;
         delay_ms(500);
         led = 0x00;
       }
     }
}
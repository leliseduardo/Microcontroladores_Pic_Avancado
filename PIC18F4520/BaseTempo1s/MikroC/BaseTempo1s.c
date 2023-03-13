/* 

        Este programa tem o objetivo de criar uma base de tempo precisa de 1s com o timer1 configurado com clock externo. Para isso utili-
     za-se um cristal de 32768Hz, valor muito utilizado para esse tipo de aplica��o.
        Esta base de tempo pode ser usado em v�rios projetos n�o cr�ticos, inclusive rel�gios para uso geral. O que limita este circuito �
     a lat�ncia de interrup��o, que mesmo sendo da ordem de micro-segundos, em aplica��es onde o circuito ficaria ligado sempre, a base de
     tempo poderia acabar atrasando.
        O professor comentou que deixar o clock em modo ass�ncrono � mais aconselh�vel com frequ�ncias altas e, 4MHz, a frequ�ncia aqui
     usada, � relativamente baixa. Por isso, o timer1 foi configurado no modo s�ncrono. O modo ass�ncrono permite entrar no modo de baixo
     consumo, onde o microcontrolador para sua execu��o principal, com o clock principal e funciona apenas com o clock externo, no caso do
     timer1. Dessa forma, apenas as rotinas de interrup��o do timer1, que s�o associadas ao crystal externo do timer1, funcinam. No modo
     s�ncrono n�o � poss�vel utilizar o modo de baixo consumo.
        Ainda segundo o professor, a configura��o do timer1 com 8 bits n�o quer dizer uma contagem de 8 bits, e sim que a manipula��o dos
     registradores que formam o contador do timer1, TMR1H e TMR1L, � feita de forma independente. Isso, para utiliza��o em bases de tempo,
     � aconselh�vel.
     
     *** Timer1 ***
     
     contagem at� 32768
     65536 - 32768 = 32768
     32768(decimal) = 0x8000(hexadecimal)
     
     TMR1L = 0x00
     TMR1H = 0x80
     
     Overflow = (65536 - <TMR1H::TMR1L>) * prescaler * per�odo do oscilador externo
     Overflow = (65536 - 32768) * 1 * (1/32768Hz)
     Overflow = 32768 * 1 * 30,52us
     Overflow = 1s

*/

#define outT1 LATB7_bit

void interrupt(){

     if(TMR1IF_bit){
     
       asm BSF TMR1H,7; // Comando em assembly denominado Bit Set File, que seta High no bit de um registrador, no caso o bit 7 do
                        // registrador TMR1H, fazendo ele ficar TMR1H = 0b10000000 = 0x80. TMRL = 0x00 se atualiza sozinho,
                        // com o estouro. Logo se tem TRM0H = 0x80 e TMR0L = 0x00, come�ando a contagem de 0x8000, como se quer
       
       TMR1IF_bit = 0x00;
       
       outT1 = ~outT1;
     }
}

void main() {

     // Registrador INTCON
     INTCON = 0xC0; // Habilita a interrup��o global e por perif�ricos
     
     // Registrador PIE1
     TMR1IE_bit = 0x01; // Habilita a interrup��o do timer1 por overflow
     
     //Registrador T1CON
     T1CON = 0x0B; // Configura o timer1 com 8bits, clock de outra fonte, prescaler 1:1, habilita o oscilador do timer1, s�ncrono,
                   // oscilador externo, habilita o timer1
                   
     // Registrador <TMR1H::TMR1L>
     TMR1L = 0x00; // Inicia a contagem em 32768, para uma contagem de 32768
     TMR1H = 0x80;
     
     ADCON1 = 0x07; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0x7F; // Configura apenas RB7 como sa�da digital, o resto como entrada, pois n�o ser�o utilizados
     outT1 = 0x00; // Inicia LATB7 em Low
     
     while(1){
     
       // Apenas aguarda a interrup��o...
     }
}
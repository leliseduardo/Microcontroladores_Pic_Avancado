/* 

        Este programa tem como objetivo apresentar o protocolo de comunica��o SPI do Pic. � um programa simples que envia uma contagem para um
    registrador de deslocamento e este tem em sua sa�da uma contagem bin�ria.
        Preciso aprender sobre protocolos de comunica��o, principalmente os que o PIC cont�m para, assim, entender melhor como a comunica��o �
    realizada e suas aplica��es.
        Tamb�m preciso aprofundar no conte�do sobre eletr�nica digital e aprender sobre registradores de deslocamento.

*/

unsigned char cont = 0x00;

void main() {

     TRISC = 0x00; // Configura todo o portc como sa�da digital
     LATC0_bit = 0x01; // Inicia LATC0 em High
     
     SSPSTAT = 0x00;
     SSPEN_bit = 0x01; // Configura o SPI como mestre e o clock em Fosc/4
     
     while(1){
     
       SSPBUF = cont++;
       
       delay_ms(200);
     
     }
     
}
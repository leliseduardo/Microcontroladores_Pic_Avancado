/* 

        Este programa tem como objetivo apresentar o protocolo de comunicação SPI do Pic. É um programa simples que envia uma contagem para um
    registrador de deslocamento e este tem em sua saída uma contagem binária.
        Preciso aprender sobre protocolos de comunicação, principalmente os que o PIC contém para, assim, entender melhor como a comunicação é
    realizada e suas aplicações.
        Também preciso aprofundar no conteúdo sobre eletrônica digital e aprender sobre registradores de deslocamento.

*/

unsigned char cont = 0x00;

void main() {

     TRISC = 0x00; // Configura todo o portc como saída digital
     LATC0_bit = 0x01; // Inicia LATC0 em High
     
     SSPSTAT = 0x00;
     SSPEN_bit = 0x01; // Configura o SPI como mestre e o clock em Fosc/4
     
     while(1){
     
       SSPBUF = cont++;
       
       delay_ms(200);
     
     }
     
}
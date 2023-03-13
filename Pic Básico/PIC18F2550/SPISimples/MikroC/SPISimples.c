/* 

        O objetivo deste programa � iniciar o uso do protocolo SPI do microcontrolador PIC18F4550/2550. Para isso, ser� usada a biblioteca do
    MikroC para o uso do SPI.
        O programa ir� ler dois bot�es, de incremento e decremento, que ir�o definir o dado a ser enviado por SPI. Este protrocolo serve para
    comunica��o com algum m�dulo que esteja perto. Estes m�dulos podem ser mem�rias externas, leitores de cart�o SD, entre outros.
        Assim como para o protocolo I2C, n�o conseguirei fazer pr�ticas ou simula��es para os projetos que envolvem SPI.

*/

// Configura��o protocolo SPI
sbit Chip_Select at RC0_bit;
sbit Chip_Select_Direction at TRISC0_bit;


// Mapeamento de hardware
#define incremento RB7_bit
#define decremento RB6_bit

// Fun��es auxiliares
void leitura_Botoes();

// Vari�veis auxiliares
unsigned char flagBotoes = 0x00;

unsigned short valor = 0x00,
               dado = 0x01;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     
     Chip_Select = 1;                       // Deselect DAC
     Chip_Select_Direction = 0;             // Set CS# pin as Output
     SPI1_Init();                           // Initialize SPI module


     // Loop infinito
     while(1){
     
       leitura_Botoes();
       
       Chip_Select = 0;
       
       SPI1_Write(valor);
       
       Chip_Select = 1;
       delay_ms(1);
     
     } // end Loop infinito

} // end void main



void leitura_Botoes(){

     if(!incremento) flagBotoes.B0 = 0x01;
     if(!decremento) flagBotoes.B1 = 0x01;
     
     if(incremento && flagBotoes.B0){
     
       flagBotoes.B0 = 0x00;
       dado++;
       
       if(dado > 0x05) dado = 0x01;

     } // end if incremento && flagBotoes.B0
     
     if(decremento && flagBotoes.B1){
     
       flagBotoes.B1 = 0x00;
       dado--;
       
       if(dado < 1) dado = 0x05;
     
     } // if decremento && flagBotoes.B1
     
     switch(dado){
     
          case 0x01: valor = 0x01;
                     break;
          case 0x02: valor = 0x02;
                     break;
          case 0x03: valor = 0x72;
                     break;
          case 0x04: valor = 0xBD;
                     break;
          case 0x05: valor = 0xAA;
                     break;
     
     } // end switch dado

} // end void leitura_Botoes

















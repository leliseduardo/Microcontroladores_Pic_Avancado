/* 

        O objetivo deste programa é iniciar o uso do protocolo SPI do microcontrolador PIC18F4550/2550. Para isso, será usada a biblioteca do
    MikroC para o uso do SPI.
        O programa irá ler dois botões, de incremento e decremento, que irão definir o dado a ser enviado por SPI. Este protrocolo serve para
    comunicação com algum módulo que esteja perto. Estes módulos podem ser memórias externas, leitores de cartão SD, entre outros.
        Assim como para o protocolo I2C, não conseguirei fazer práticas ou simulações para os projetos que envolvem SPI.

*/

// Configuração protocolo SPI
sbit Chip_Select at RC0_bit;
sbit Chip_Select_Direction at TRISC0_bit;


// Mapeamento de hardware
#define incremento RB7_bit
#define decremento RB6_bit

// Funções auxiliares
void leitura_Botoes();

// Variáveis auxiliares
unsigned char flagBotoes = 0x00;

unsigned short valor = 0x00,
               dado = 0x01;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     
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

















/* 

        O objetivo deste programa � continuar trabalhando com o protocolo I2C, por�m, agora, uma aplica��o mais pr�tica para ele. O programa ir�
     ter tr�s botoes, um de incremento, um de descremento e um enter. Os de incremento e decremento ir�o atuar em uma vari�vel contadora, enquanto
     o enter servir� para salvar tal vari�vel na mem�ria EEPROM externa. O enter tamb�m servir� para mostrar o que est� salvo na mem�ria e, para
     isso, dever� estar pressionado quando o Pic reinicia.
        Esta aplica��o � muito importante em projetos que deseja-se salvar par�metros de vari�veis. Um exemplo b�sico seria salvar a temperatura
     m�nima e m�xima. Assim, mesmo desligando o circuito n�o se perderia tais dados. Outra aplica��o seria um par�metro configurado no sistema e
     que se quer que fique salvo, para n�o ter que reconfigurar tal sistema.

        No meu proteus o programa parece n�o funcionar corretamente, talvez porque a mem�ria externa n�o salve os dados quando se reinicia a simu-
     la��o. Talvez, na pr�tica, funciona-se bem. Por�m, n�o tenho o CI 2402C para testar, mas pelo menos sei como funciona a programa��o do Pic
     para uma grava��o numa mem�ria externa.

*/

// Configura��o do LCD
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

// Configura��o de hardware
#define enter RB7_bit
#define mais RB6_bit
#define menos RB5_bit

// Fun��es auxiliares
void leitura_EEPROM();
void escrita_EEPROM(unsigned short info);

// Vari�veis auxiliares
unsigned char flagEnter = 0x00,
              flagMais = 0x00,
              flagMenos = 0x00;

unsigned short cont = 0x00, memoria = 0x00;
char txt[7];

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderia ser anal�gicos como digitais
     TRISB = 0xFF; // Configura todo o portb como entrada digital
     PORTB = 0xFF; // Inicia todo o portb em High

     // Inicializa��o do protocolo I2C
     I2C1_Init(100000);         // initialize I2C communication
     I2C1_Start();              // issue I2C start signal
     I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
     I2C1_Wr(2);
                     // send byte (address of EEPROM location)
     I2C1_Stop();               // issue I2C stop signal
     delay_ms(100);

     // Inicializa��o do display LCD
     lcd_init();
     lcd_cmd(_LCD_CLEAR);
     lcd_CMD(_LCD_CURSOR_OFF);
     
     if(!enter){
     
       leitura_EEPROM();
       delay_ms(100);
     
     } // end if enter
     
     // Loop infinito
     while(1){
     
       if(!mais) flagMais = 0x01;
       if(!menos) flagMenos = 0x01;
       if(!enter) flagEnter = 0x01;

       if(mais && flagMais){
       
         flagMais = 0x00;
         cont++;
       
       } // end if mais && flagMais
       
       if(menos && flagMenos){

         flagMenos = 0x00;
         cont--;

       } // end if mais && flagMais
       
       if(enter && flagEnter){

         flagEnter = 0x00;
         escrita_EEPROM(cont);
         delay_ms(100);

       } // end if mais && flagMais
       
       IntToSTR(cont, txt);
       
       lcd_out(1, 5, txt);
     
     } // end loop infinito

} // end void main

void leitura_EEPROM(){

     I2C1_Start();              // issue I2C start signal
     I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
     I2C1_Wr(2);                // send byte (data address)
     I2C1_Repeated_Start();     // issue I2C signal repeated start
     I2C1_Wr(0xA3);             // send byte (device address + R)
     memoria = I2C1_Rd(0u);       // Read the data (NO acknowledge)
     I2C1_Stop();               // issue I2C stop signal

     cont = memoria;

} // end void leitura_EEPROM

void escrita_EEPROM(unsigned short info){

      I2C1_Init(100000);         // initialize I2C communication
      I2C1_Start();              // issue I2C start signal
      I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
      I2C1_Wr(2);                // send byte (address of EEPROM location)
      I2C1_Wr(info);             // send data (data to be written)
      I2C1_Stop();               // issue I2C stop signal

     delay_ms(100);

} // end void escrita_EEPROM
/* 

        O obejtivo deste programa é mostrar uma aplicação do protocolo I2C a partir do último projeto, denominado "I2CEEPROMExterna". Agora, a
     variável "cont" servirá para alterar o Duty Cicle de um PWM. Assim, será salvo na memória EEPROM externa o valor do Duty Cicle que se queira
     gravar. Quando o sistema reiniciar, o PWM continua desse valor salvo, caso se queira.
        O programa é exatamente o mesmo do último projeto, acrescentando apenas a biblioteca de PWM.

*/

// Configuração do LCD
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

// Configuração de hardware
#define enter RB7_bit
#define mais RB6_bit
#define menos RB5_bit

// Funções auxiliares
void leitura_EEPROM();
void escrita_EEPROM(unsigned short info);

// Variáveis auxiliares
unsigned char flagEnter = 0x00,
              flagMais = 0x00,
              flagMenos = 0x00;

unsigned short cont = 0x0A, memoria = 0x00;
char txt[7];

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderia ser analógicos como digitais
     TRISB = 0xFF; // Configura todo o portb como entrada digital
     PORTB = 0xFF; // Inicia todo o portb em High

     // Inicialização do protocolo I2C
     I2C1_Init(100000);         // initialize I2C communication
     I2C1_Start();              // issue I2C start signal
     I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
     I2C1_Wr(2);
                     // send byte (address of EEPROM location)
     I2C1_Stop();               // issue I2C stop signal
     delay_ms(100);
     
     // Inicialização do PWM1
     PWM1_Init(1000);
     PWM1_Set_Duty(128);
     PWM1_Start();

     // Inicialização do display LCD
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

       PWM1_Set_Duty(cont);
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
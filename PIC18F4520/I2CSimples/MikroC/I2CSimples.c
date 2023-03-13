/* 

        Este programa tem a função de apresentar o módulo de comunicação I2C do Pic. Para isso, utiliza-se a biblioteca do MikroC para este proto-
    colo. Neste programa em específico, será usado um exemplo da própria biblioteca I2C.
        O programa iá escreve um dado em uma EEPROM externa e depois irá ler a informação passada diretamente da memória externa. A informação
    lida da memória externa será impressa no display LCD.

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

// Variáveis auxiliares
unsigned short info = 0x00;
char txt[7];

void main() {

     TRISB = 0x00; // Configura todo o portb como saída digital
     PORTB = 0x00; // Inicia todo o portb em Low

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);

     I2C1_Init(100000);         // initialize I2C communication
     I2C1_Start();              // issue I2C start signal
     I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
     I2C1_Wr(2);                // send byte (address of EEPROM location)
     I2C1_Wr(0xAB);             // send data (data to be written)
     I2C1_Stop();               // issue I2C stop signal

     Delay_100ms();

     I2C1_Start();              // issue I2C start signal
     I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
     I2C1_Wr(2);                // send byte (data address)
     I2C1_Repeated_Start();     // issue I2C signal repeated start
     I2C1_Wr(0xA3);             // send byte (device address + R)
     info = I2C1_Rd(0u);       // Read the data (NO acknowledge)
     I2C1_Stop();               // issue I2C stop signal
     
     IntToStr(info, txt);
     
     lcd_out(1, 7, txt);
}


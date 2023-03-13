/* 

        Este programa é uma continuação do último projeto, denominado "EEPROMExterna16bits", cujo objetivo é salvar um dado de 16 bits na EEPROM
    externa. Neste programa, o objetivo será acrescentar a leitura da última memória gravada na EEPROM. Tal leitura será feita ao energizar ou
    reiniciar o Pic, isto é, antes do programa entrar no Loop infinito. O valor lido será o último valor gravado na EEPROM antes do pic ser des-
    ligado ou reiniciado.

*/


// Configuração do display lcd
// Lcd pinout settings
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// Mapeamento de hardware
#define incremento RC0_bit
#define decremento RC1_bit

// Funções auxiliares
void imprime_Display();
void EEPROM_Escreve16bits();
void EEPROM_Leitura16bits();

// Variáveis auxiliares
int // memoriaVelha = 0x00,
    memoriaNova = 0x00;

unsigned short memoriaH = 0x00,
               memoriaL = 0x00;

void main() {

   ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais

   lcd_init();
   lcd_cmd(_LCD_CURSOR_OFF);
   lcd_cmd(_LCD_CLEAR);
   lcd_out(1, 2, "Valor 16 bits");

   I2C1_Init(400000);         // Inicializa a comunicação I2C
   
   EEPROM_Leitura16bits();

// Loop infinito
   while(1){

     imprime_Display();

     if(!incremento){

       memoriaNova += 0x01;
       EEPROM_Escreve16bits();

     } // end if !incremento

     if(!decremento){

       memoriaNova -= 0x01;
       EEPROM_Escreve16bits();

     } // end if !decremento

   } // end Loop infinito

} // end void main


void EEPROM_Escreve16bits(){

      memoriaH = memoriaNova >> 0x08;
      memoriaL = memoriaNova % 256;

      I2C1_Start();              // Inicializa o I2C
      I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
      I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
      I2C1_Wr(memoriaH);               // Envia o valor que se quer gravar
      I2C1_Stop();               // Para o I2C
      delay_ms(100);
      I2C1_Start();              // Inicializa o I2C
      I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
      I2C1_Wr(0x06);             // Envia a posição de memória a ser escrita
      I2C1_Wr(memoriaL);               // Envia o valor que se quer gravar
      I2C1_Stop();               // Para o I2C
      delay_ms(100);

} // end void EEPROM_Escreve16bits

void EEPROM_Leitura16bits(){

     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
     I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
     memoriaH = I2C1_Rd(0u); // Le o dado e armazena na variável memoria
     I2C1_Stop();               // Para o I2C
     delay_ms(100);
     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
     I2C1_Wr(0x06);             // Envia a posição de memória a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
     memoriaL = I2C1_Rd(0u);// Le o dado e armazena na variável memoria
     I2C1_Stop();
     delay_ms(100);
     
     memoriaNova = (memoriaH<<8) + memoriaL;
     
     delay_ms(200);

} // end void EEPROM_Leitura16bits


void imprime_Display(){

     char dezmil, mil, cen, dez, uni;

     dezmil = memoriaNova/10000;
     mil = (memoriaNova%10000)/1000;
     cen = (memoriaNova%1000)/100;
     dez = (memoriaNova%100)/10;
     uni = memoriaNova%10;

     lcd_chr(2, 10, dezmil + 0x30);
     lcd_chr_cp(mil + 0x30);
     lcd_chr_cp(cen + 0x30);
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

} // end void imprime_Display
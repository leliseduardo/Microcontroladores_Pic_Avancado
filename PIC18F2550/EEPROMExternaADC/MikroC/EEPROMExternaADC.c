/* 

        O objetivo deste programa � salvar na EEPROM externa os valores lidos pelo conversor AD. Assim, quando o circuito for desligado ou reini-
    ciado, o �ltimo valor lido pelo conversor AD ser� carregado e mostrado no display.
        Este projeto � importante e serve como base para projetos que utilizem o conversor AD e que se quer gravar os valores lidos, como tempera-
    tura, tens�o e muitos outros par�metros poss�veis.
        Como base ser� usado o c�digo do �ltimo projeto, denominado "EEPROMExterna16bits2" e, ainda, n�o ser� poss�vel testar na pr�tica e nem
    simular este projeto, uma vez que o proteus n�o simula o microcontrolador usado e eu n�o tenho a mem�ria externa para testar.
        Ainda sim, a escrita deste c�digo � importante para fixar o conte�do e me preparar para quando de fato for usar a mem�ria EEPROM externa
    e a comunica��o I2C na pr�tica.

*/

// Configura��o do display lcd
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

// Fun��es auxiliares
void imprime_Display();
void EEPROM_Escreve16bits();
void EEPROM_Leitura16bits();

// Vari�veis auxiliares
int memoriaVelha = 0x00,
    memoriaNova = 0x00;

unsigned short memoriaH = 0x00,
               memoriaL = 0x00;

void main() {

   ADCON0 = 0x01; // Seleciona o canal AN0 como anal�gico e habilita o conversor AD
   ADCON1 = 0x0E; // Configura o intervalo de convers�o entre Vss e Vdd e configura apenas AN0 como porta anal�gica

   lcd_init();
   lcd_cmd(_LCD_CURSOR_OFF);
   lcd_cmd(_LCD_CLEAR);
   lcd_out(1, 2, "Valor 16 bits");

   I2C1_Init(400000);         // Inicializa a comunica��o I2C

   EEPROM_Leitura16bits();

// Loop infinito
   while(1){

     imprime_Display();
     
     memoriaNova = adc_read(0);
     
     EEPROM_Escreve16bits();

     /*
     if(!incremento){

       memoriaNova += 0x01;
       EEPROM_Escreve16bits();

     } // end if !incremento

     if(!decremento){

       memoriaNova -= 0x01;
       EEPROM_Escreve16bits();

     } // end if !decremento
     */

   } // end Loop infinito

} // end void main


void EEPROM_Escreve16bits(){

      memoriaH = memoriaNova >> 0x08;
      memoriaL = memoriaNova % 256;

      I2C1_Start();              // Inicializa o I2C
      I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escrita (endere�o da mem�ria + W)
      I2C1_Wr(0x05);             // Envia a posi��o de mem�ria a ser escrita
      I2C1_Wr(memoriaH);               // Envia o valor que se quer gravar
      I2C1_Stop();               // Para o I2C
      delay_ms(100);
      I2C1_Start();              // Inicializa o I2C
      I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escrita (endere�o da mem�ria + W)
      I2C1_Wr(0x06);             // Envia a posi��o de mem�ria a ser escrita
      I2C1_Wr(memoriaL);               // Envia o valor que se quer gravar
      I2C1_Stop();               // Para o I2C
      delay_ms(100);

} // end void EEPROM_Escreve16bits

void EEPROM_Leitura16bits(){

     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escreita  (device address + W)
     I2C1_Wr(0x05);             // Envia a posi��o de mem�ria a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endere�o e configurando leitura
     memoriaH = I2C1_Rd(0u); // Le o dado e armazena na vari�vel memoria
     I2C1_Stop();               // Para o I2C
     delay_ms(100);
     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escreita  (device address + W)
     I2C1_Wr(0x06);             // Envia a posi��o de mem�ria a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endere�o e configurando leitura
     memoriaL = I2C1_Rd(0u);// Le o dado e armazena na vari�vel memoria
     I2C1_Stop();
     delay_ms(100);

     memoriaVelha = (memoriaH<<8) + memoriaL;

     delay_ms(200);

} // end void EEPROM_Leitura16bits


void imprime_Display(){

     char mil, cen, dez, uni, mil2, cen2, dez2, uni2;

     mil = (memoriaNova%10000)/1000;
     cen = (memoriaNova%1000)/100;
     dez = (memoriaNova%100)/10;
     uni = memoriaNova%10;
     
     mil2 = (memoriaVelha%10000)/1000;
     cen2 = (memoriaVelha%1000)/100;
     dez2 = (memoriaVelha%100)/10;
     uni2 = memoriaVelha%10;

     lcd_chr(2, 2, mil + 0x30);
     lcd_chr_cp(cen + 0x30);
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);
     
     lcd_chr(2, 10, mil2 + 0x30);
     lcd_chr_cp(cen2 + 0x30);
     lcd_chr_cp(dez2 + 0x30);
     lcd_chr_cp(uni2 + 0x30);

} // end void imprime_Display
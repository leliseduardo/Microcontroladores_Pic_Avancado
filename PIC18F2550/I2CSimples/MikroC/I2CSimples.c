/* 

        O objetivo deste programa � implementar uma comunica��o I2C simples com uma mem�ria EEPROM externa, o dispositivo 24C02C. O programa ir�
    simplesmente escrever um dado na mem�ria da mem�ria EEPROM, ler o conte�do escrito e imprimir no display. Para fazer isso, ser� usada a biblio-
    teca para comunica��o I2C do MikroC.
        Infelizmente n�o poderei testar este projeto na pr�tica, pois n�o tenho o dispositivo 24C02C. Tamb�m n�o ser� poss�vel simular o circuito,
    pois, como j� foi percebido, o proteus n�o simula o microcontrolador usado.
        De qualquer forma, escrever o programa servir� para fixar o conte�do aprendido e, quando for a hora, aplicar este conhecimento.

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

// Vari�veis auxiliares
unsigned short memoria = 0x00;
char txt[15];

void main() {

     ADCON1 = 0x0F; // Configura todas as portar que poderiam ser anal�gicas como digitais
     
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1, 1, "EEPROM Externa");
     
     I2C1_Init(400000);         // Inicializa a comunica��o I2C
     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escrita (endere�o da mem�ria + W)
     I2C1_Wr(0x05);             // Envia a posi��o de mem�ria a ser escrita
     I2C1_Wr(39);               // Envia o valor que se quer gravar
     I2C1_Stop();               // Para o I2C

     delay_ms(100);

     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escreita  (device address + W)
     I2C1_Wr(0x05);             // Envia a posi��o de mem�ria a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endere�o e configurando leitura
     memoria = I2C1_Rd(0u);     // Le o dado e armazena na vari�vel memoria
     I2C1_Stop();               // Para o I2C
     
     IntToStr(memoria, txt);
     
     lcd_out(2, 1, txt);
     
     // Loop inifinito
     while(1){
     
       // N�o executa nada...
     
     } // end Loop infinito

} // end void main

















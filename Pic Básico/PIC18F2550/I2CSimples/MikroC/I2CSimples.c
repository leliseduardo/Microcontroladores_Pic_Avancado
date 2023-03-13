/* 

        O objetivo deste programa é implementar uma comunicação I2C simples com uma memória EEPROM externa, o dispositivo 24C02C. O programa irá
    simplesmente escrever um dado na memória da memória EEPROM, ler o conteúdo escrito e imprimir no display. Para fazer isso, será usada a biblio-
    teca para comunicação I2C do MikroC.
        Infelizmente não poderei testar este projeto na prática, pois não tenho o dispositivo 24C02C. Também não será possível simular o circuito,
    pois, como já foi percebido, o proteus não simula o microcontrolador usado.
        De qualquer forma, escrever o programa servirá para fixar o conteúdo aprendido e, quando for a hora, aplicar este conhecimento.

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

// Variáveis auxiliares
unsigned short memoria = 0x00;
char txt[15];

void main() {

     ADCON1 = 0x0F; // Configura todas as portar que poderiam ser analógicas como digitais
     
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1, 1, "EEPROM Externa");
     
     I2C1_Init(400000);         // Inicializa a comunicação I2C
     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
     I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
     I2C1_Wr(39);               // Envia o valor que se quer gravar
     I2C1_Stop();               // Para o I2C

     delay_ms(100);

     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
     I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
     memoria = I2C1_Rd(0u);     // Le o dado e armazena na variável memoria
     I2C1_Stop();               // Para o I2C
     
     IntToStr(memoria, txt);
     
     lcd_out(2, 1, txt);
     
     // Loop inifinito
     while(1){
     
       // Não executa nada...
     
     } // end Loop infinito

} // end void main

















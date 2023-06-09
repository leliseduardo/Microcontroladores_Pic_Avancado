/* 

        O objetivo deste programa � implementar um volt�metro com o conversor AD e salvar as tens�es m�ximas e m�nimas. Para isso utiliza-se uma
    EEPROM externa. As tens�es lidas ter�o uma tens�o m�xima de leitura de 5V. O programa funcionar� de forma que, quando ligado, mostra a tens�o
    m�xima e m�nima por um tempo e depois desse tempo mostra a leitura que est� sendo feita intant�neamente.
        Como base utiliza-se o c�digo do projeto passado, denominado "EEPROMExternaADC".

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
#define botao RC0_bit


// Fun��es auxiliares
void imprime_Display();
void imprime_Max_Min();
void EEPROM_Escreve16bits(unsigned char endereco, unsigned dado);
void EEPROM_Leitura16bits();
unsigned calcula_Tensao(int n);

// Vari�veis auxiliares
int valorMaximo = 0x00,
    valorMinimo = 500;
   
   
unsigned valor = 0x00,
         adc = 0x00;

unsigned short memoriaH = 0x00,
               memoriaL = 0x00;

void main() {

   ADCON0 = 0x01; // Seleciona o canal AN0 como anal�gico e habilita o conversor AD
   ADCON1 = 0x0E; // Configura o intervalo de convers�o entre Vss e Vdd e configura apenas AN0 como porta anal�gica

   lcd_init();
   lcd_cmd(_LCD_CURSOR_OFF);
   lcd_cmd(_LCD_CLEAR);

   I2C1_Init(400000);         // Inicializa a comunica��o I2C

   EEPROM_Leitura16bits();
   imprime_Max_Min();
   delay_ms(2000);
   lcd_cmd(_LCD_CLEAR);

// Loop infinito
   while(1){

     adc = adc_read(0);
     
     imprime_Display();

     if(!botao){

       lcd_out(2,1, "CLR");
       valorMaximo = 0x00;
       valorMinimo = 500;
       EEPROM_Escreve16bits(0x05, valorMaximo);
       EEPROM_Escreve16bits(0x07, valorMinimo);
       delay_ms(200);
       lcd_out(2,1, "   ");

     } // end if !incremento



   } // end Loop infinito

} // end void main


void EEPROM_Escreve16bits(unsigned char endereco, unsigned dado){

      memoriaH = dado >> 0x08;
      memoriaL = dado % 256;

      I2C1_Start();              // Inicializa o I2C
      I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escrita (endere�o da mem�ria + W)
      I2C1_Wr(endereco);             // Envia a posi��o de mem�ria a ser escrita
      I2C1_Wr(memoriaH);               // Envia o valor que se quer gravar
      I2C1_Stop();               // Para o I2C
      delay_ms(100);
      I2C1_Start();              // Inicializa o I2C
      I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escrita (endere�o da mem�ria + W)
      I2C1_Wr(endereco);  // Envia a posi��o de mem�ria a ser escrita
      I2C1_Wr(memoriaL);         // Envia o valor que se quer gravar
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

     valorMaximo = (memoriaH<<8) + memoriaL;

     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escreita  (device address + W)
     I2C1_Wr(0x07);             // Envia a posi��o de mem�ria a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endere�o e configurando leitura
     memoriaH = I2C1_Rd(0u); // Le o dado e armazena na vari�vel memoria
     I2C1_Stop();               // Para o I2C
     delay_ms(100);
     I2C1_Start();              // Inicializa o I2C
     I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escreita  (device address + W)
     I2C1_Wr(0x08);             // Envia a posi��o de mem�ria a ser escrita
     I2C1_Repeated_Start();     // Reinicia o I2C
     I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endere�o e configurando leitura
     memoriaL = I2C1_Rd(0u);// Le o dado e armazena na vari�vel memoria
     I2C1_Stop();
     delay_ms(100);

     valorMinimo = (memoriaH<<8) + memoriaL;

     delay_ms(200);

} // end void EEPROM_Leitura16bits


void imprime_Display(){

     char mil, cen, dez, uni;
     
     valor = calcula_Tensao(adc);
     
     if(valor > valorMaximo){
       valorMaximo = valor;
       EEPROM_Escreve16bits(0x05, valorMaximo);
     }
     if(valor < valorMinimo){
       valorMinimo = valor;
       EEPROM_Escreve16bits(0x07, valorMinimo);
     }

     lcd_out(1, 2, "Valor 16 bits");
     
     mil = (valor%10000)/1000;
     cen = (valor%1000)/100;
     dez = (valor%100)/10;
     uni = valor%10;
     
     lcd_chr(2, 6, mil + 0x30);
     lcd_chr_cp(cen + 0x30);
     lcd_chr_cp('.');
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

} // end void imprime_Display


void imprime_Max_Min(){

     char mil, cen, dez, uni, mil2, cen2, dez2, uni2;
     
     lcd_out(1, 2, "Max");
     lcd_out(1, 10, "Min");

     mil = (valorMaximo%10000)/1000;
     cen = (valorMaximo%1000)/100;
     dez = (valorMaximo%100)/10;
     uni = valorMaximo%10;

     mil2 = (valorMinimo%10000)/1000;
     cen2 = (valorMinimo%1000)/100;
     dez2 = (valorMinimo%100)/10;
     uni2 = valorMinimo%10;

     lcd_chr(2, 2, mil + 0x30);
     lcd_chr_cp(cen + 0x30);
     lcd_chr_cp('.');
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

     lcd_chr(2, 10, mil2 + 0x30);
     lcd_chr_cp(cen2 + 0x30);
     lcd_chr_cp('.');
     lcd_chr_cp(dez2 + 0x30);
     lcd_chr_cp(uni2 + 0x30);

} // end void imprime_Display

unsigned calcula_Tensao(int n){

     float tensao;
     
     tensao = ((n * 500.0) / 1023.0);
     
     return (unsigned)tensao;

} // end unsigned calcula_Tensao




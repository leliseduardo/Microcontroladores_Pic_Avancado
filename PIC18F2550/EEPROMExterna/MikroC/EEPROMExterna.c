/* 

        O objetivo deste programa � utilizar uma mem�ria EEPROM externa para salvar o valor de uma vari�vel e, assim, quando o Pic for desenergi-
    zado ou reiniciar, o valor da vari�vel estar� salvo e ser� carregado. Essa vari�vel salva poder� ser incrementada ou decrementada a partir
    de dois bot�es e, assim que sofrer uma mudan�a j� ser� salva na mem�ria externa. Quando o programa inicia ele carrega o �ltimo valor salvo
    desta vari�vel.
        No display, ser� mostrado tanto a �ltima vari�vel salva quando o pic foi desenergizado, quanto o valor atual, que est� sendo salvo.
        
        Como dito nos projetos que envolvem a EEPROM externa, n�o terei como testar este circuito na pr�tica ou na simula��o, mas a escrita do
    c�digo serve para a fixa��o do conte�do da aula e, quando for necess�rio, os conhecimentos sobre o uso de I2C e EEPROM externa j� ter�o sido
    adquiridos.
    
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

// Vari�veis auxiliares
unsigned char memoriaVelha = 0x00,
              memoriaNova = 0x00;

void main() {

   ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais

   lcd_init();
   lcd_cmd(_LCD_CURSOR_OFF);
   lcd_cmd(_LCD_CLEAR);
   lcd_out(1, 2, "Velho");
   lcd_out(1, 10, "Novo");
   
   I2C1_Init(400000);         // Inicializa a comunica��o I2C
   I2C1_Start();              // Inicializa o I2C
   I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escreita  (device address + W)
   I2C1_Wr(0x05);             // Envia a posi��o de mem�ria a ser escrita
   I2C1_Repeated_Start();     // Reinicia o I2C
   I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endere�o e configurando leitura
   memoriaVelha = I2C1_Rd(0u);// Le o dado e armazena na vari�vel memoria
   I2C1_Stop();               // Para o I2C

// Loop infinito
   while(1){

     imprime_Display();
     
     if(!incremento){
     
       memoriaNova += 0x01;
       I2C1_Start();              // Inicializa o I2C
       I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escrita (endere�o da mem�ria + W)
       I2C1_Wr(0x05);             // Envia a posi��o de mem�ria a ser escrita
       I2C1_Wr(memoriaNova);               // Envia o valor que se quer gravar
       I2C1_Stop();               // Para o I2C
       delay_ms(250);
     
     } // end if !incremento
     
     if(!decremento){
     
       memoriaNova -= 0x01;
       I2C1_Start();              // Inicializa o I2C
       I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endere�o e configurando escrita (endere�o da mem�ria + W)
       I2C1_Wr(0x05);             // Envia a posi��o de mem�ria a ser escrita
       I2C1_Wr(memoriaNova);               // Envia o valor que se quer gravar
       I2C1_Stop();               // Para o I2C
       delay_ms(250);
     
     } // end if !decremento

   } // end Loop infinito

} // end void main



void imprime_Display(){

     char cenVelho, dezVelho, uniVelho, cenNovo, dezNovo, uniNovo;
     
     cenVelho = memoriaVelha/100;
     dezVelho = (memoriaVelha%100)/10;
     uniVelho = memoriaVelha%10;
     
     cenNovo = memoriaNova/100;
     dezNovo = (memoriaNova%100)/10;
     uniNovo = memoriaNova%10;
     
     lcd_chr(2, 3, cenVelho + 0x30);
     lcd_chr_cp(dezVelho + 0x30);
     lcd_chr_cp(uniVelho + 0x30);

     lcd_chr(2, 11, cenNovo + 0x30);
     lcd_chr_cp(dezNovo + 0x30);
     lcd_chr_cp(uniNovo + 0x30);

} // end void imprime_Display
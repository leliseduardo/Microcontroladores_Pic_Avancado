/* 

        O objetivo deste programa é utilizar uma memória EEPROM externa para salvar o valor de uma variável e, assim, quando o Pic for desenergi-
    zado ou reiniciar, o valor da variável estará salvo e será carregado. Essa variável salva poderá ser incrementada ou decrementada a partir
    de dois botões e, assim que sofrer uma mudança já será salva na memória externa. Quando o programa inicia ele carrega o último valor salvo
    desta variável.
        No display, será mostrado tanto a última variável salva quando o pic foi desenergizado, quanto o valor atual, que está sendo salvo.
        
        Como dito nos projetos que envolvem a EEPROM externa, não terei como testar este circuito na prática ou na simulação, mas a escrita do
    código serve para a fixação do conteúdo da aula e, quando for necessário, os conhecimentos sobre o uso de I2C e EEPROM externa já terão sido
    adquiridos.
    
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

// Variáveis auxiliares
unsigned char memoriaVelha = 0x00,
              memoriaNova = 0x00;

void main() {

   ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais

   lcd_init();
   lcd_cmd(_LCD_CURSOR_OFF);
   lcd_cmd(_LCD_CLEAR);
   lcd_out(1, 2, "Velho");
   lcd_out(1, 10, "Novo");
   
   I2C1_Init(400000);         // Inicializa a comunicação I2C
   I2C1_Start();              // Inicializa o I2C
   I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
   I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
   I2C1_Repeated_Start();     // Reinicia o I2C
   I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
   memoriaVelha = I2C1_Rd(0u);// Le o dado e armazena na variável memoria
   I2C1_Stop();               // Para o I2C

// Loop infinito
   while(1){

     imprime_Display();
     
     if(!incremento){
     
       memoriaNova += 0x01;
       I2C1_Start();              // Inicializa o I2C
       I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
       I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
       I2C1_Wr(memoriaNova);               // Envia o valor que se quer gravar
       I2C1_Stop();               // Para o I2C
       delay_ms(250);
     
     } // end if !incremento
     
     if(!decremento){
     
       memoriaNova -= 0x01;
       I2C1_Start();              // Inicializa o I2C
       I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
       I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
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
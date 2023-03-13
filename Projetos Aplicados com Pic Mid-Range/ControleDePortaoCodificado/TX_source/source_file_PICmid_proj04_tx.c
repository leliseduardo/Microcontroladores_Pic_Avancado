/* ============================================================================

     Controle de Portão Codificado com módulos TXRX 433MHz

     Software do Transmissor


     MCU: PIC16F628A    Clock: Interno 4MHz


     Autor: Eng. Wagner Rambo    Data: Maio de 2018



============================================================================ */


// ============================================================================
// --- Protótipo das Funções ---
void tx_func(char comand, char value);         //Função para envio de dados tx
void cmd_code();                               //Função para codificação do comando enviado


// ============================================================================
// --- Variáveis Globais ---
char key = 0x00;


// ============================================================================
// --- Função Principal ---
void main()
{
   CMCON = 0x07;                               //desabilita os comparadores internos
   TRISB = 0xFD;                               //configura RB2 como saída (TX)
   UART1_Init(1200);                           //inicializa UART1 com 1200 baud rate
   delay_ms(100);                              //aguarda estabilizar
     
     
   while(1)                                    //Loop Infinito
   {
      cmd_code();                              //codifica o comando
      
      if(!RB0_bit) tx_func(key,1);             //se RB0 em LOW, envia comando key e dado 1
      else if(!RB1_bit) tx_func(key,1);        //se RB1 em LOW, envia comando key e dado 1
      else tx_func(key,0);                     //senão, envia comando key e dado 0




   } //end while

} //end main


// ============================================================================
// --- Protótipo das Funções ---


// ============================================================================
// --- Função para envio de dados tx ---
void tx_func(char comand, char value)
{

   UART1_Write(0xFF);                          //byte de start
   delay_ms(10);                               //aguarda
   UART1_Write(comand);                        //envia comando
   delay_ms(10);                               //aguarda
   UART1_Write(value);                         //envia valor do dado
   delay_ms(10);                               //aguarda
   UART1_Write(~(char)(comand+value));         //faz checksum
   delay_ms(10);
   
   
} //end tx_func


// ============================================================================
// --- Função para codificação do comando ---
void cmd_code()
{
   if(RB7_bit) key.B7 = 0x01;
   else        key.B7 = 0x00;
   
   if(RB6_bit) key.B6 = 0x01;
   else        key.B6 = 0x00;
   
   if(RB5_bit) key.B5 = 0x01;
   else        key.B5 = 0x00;
   
   if(RB4_bit) key.B4 = 0x01;
   else        key.B4 = 0x00;
   
   if(RA3_bit) key.B3 = 0x01;
   else        key.B3 = 0x00;
   
   if(RA2_bit) key.B2 = 0x01;
   else        key.B2 = 0x00;
   
   if(RA1_bit) key.B1 = 0x01;
   else        key.B1 = 0x00;
   
   if(RA0_bit) key.B0 = 0x01;
   else        key.B0 = 0x00;


} //end cmd_code
/* ============================================================================

     Controle de Port�o Codificado com m�dulos TXRX 433MHz

     Software do Transmissor


     MCU: PIC16F628A    Clock: Interno 4MHz


     Autor: Eng. Wagner Rambo    Data: Maio de 2018



============================================================================ */


// ============================================================================
// --- Prot�tipo das Fun��es ---
void tx_func(char comand, char value);         //Fun��o para envio de dados tx
void cmd_code();                               //Fun��o para codifica��o do comando enviado


// ============================================================================
// --- Vari�veis Globais ---
char key = 0x00;


// ============================================================================
// --- Fun��o Principal ---
void main()
{
   CMCON = 0x07;                               //desabilita os comparadores internos
   TRISB = 0xFD;                               //configura RB2 como sa�da (TX)
   UART1_Init(1200);                           //inicializa UART1 com 1200 baud rate
   delay_ms(100);                              //aguarda estabilizar
     
     
   while(1)                                    //Loop Infinito
   {
      cmd_code();                              //codifica o comando
      
      if(!RB0_bit) tx_func(key,1);             //se RB0 em LOW, envia comando key e dado 1
      else if(!RB1_bit) tx_func(key,1);        //se RB1 em LOW, envia comando key e dado 1
      else tx_func(key,0);                     //sen�o, envia comando key e dado 0




   } //end while

} //end main


// ============================================================================
// --- Prot�tipo das Fun��es ---


// ============================================================================
// --- Fun��o para envio de dados tx ---
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
// --- Fun��o para codifica��o do comando ---
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
/*

        O objetivo deste programa é usar o encoder rotativo, que eu finalmente consegui definir seu pinout, sem datasheet. Logo, seu giro em um
     sentido irá incrementar uma variável e seu giro no sentido inverso irá decrementar uma variável. Tal variável será impressa pelo display.


****************************** Timer 1 *****************************************

  Ciclo de máquina = 250ns
  Prescale = 1
  Contagem = 200
  
  Overflow = contagem * precale * ciclo de maquina
  Overflow = 200 * 1 * 250ns
  Overflow = 50u

********************************************************************************

  A pinagem do encoder está descrita no caderno.

  O circuito e o programa funcionaram perfeitamente.

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
#define encoderA RB0_bit
#define encoderB RB1_bit

// Funções auxiliares
void leitura_Encoder();
void imprime_Display();

// Variáveis auxiliares
char baseTempo = 0x00,
     cont = 0x00;

bit flagEnc;


// Funções de interrupção
void interrupt(){

     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1H = 0xFF;
       TMR1L = 0x37;
       
       baseTempo += 0x01;
       
       if(baseTempo == 0x64){ // Lê o encoder a cada 5ms
       
         baseTempo = 0x00;
       
         leitura_Encoder();
         
       } // end if baseTempo == 0x64
     
     } // end TMR1IF_Bit

} // end void interrupt


void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como saída
     
     INTCON = 0xC0;
     TMR1IE_bit = 0x01; // Registrador PIE1. Hablita a interrupção por overflow do timer1
     T1CON = 0x01; // Habilita o timer1, configura com 8 bits, prescale em 1:1, incrementa com ciclo de maquina
     TMR1H = 0xFF;
     TMR1L = 0x37; // Inicia em 55 para uma contagem de 200

     flagEnc = 0x00;

     // Inicialização do display
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1, 2, "Teste Encoder");
     
     // Loop infinito
     while(1){
     
       imprime_Display();
     
     } // end Loop infinito

} // end void main



void leitura_Encoder(){

     if(!encoderA){
     
       if(!flagEnc){

         flagEnc = 0x01;
         cont += 0x01;
       
       } // end if !flagEnc
     
     } // end if !encoderA
     else{
     
       if(!encoderB){
       
         if(!flagEnc){
         
           flagEnc = 0x01;
           cont -= 0x01;
         
         } // end if !flagEnc
       
       } // end if !encoderB
     
     } // end else !encoderA
     
     if(encoderA){
     
       if(encoderB) flagEnc = 0x00;
     
     } // end if encoderA

} // end void leitura_Encoder



void imprime_Display(){

     char cen, dez, uni;
     
     cen = cont/100;
     dez =(cont%100)/10;
     uni = cont%10;
     
     lcd_chr(2, 8, cen + 0x30);
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

} // end void imprime_Display














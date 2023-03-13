/* 

        O objetivo deste programa é visualizar o conteúdo de um registrador, no caso o contador do timer0, no display LCD. Assim, é possível fazer
     um debbug do programa em tempo real. Este programa serve como base para se fazer um debbuger em tempo real para diversos registradores, variá-
     veis e registradores de controle. Dessa forma, torna-se possível projetar códigos muito mais eficientes, entendendo o passo a passo de como
     seus registradores e variáveis funcionam. Ainda, fica mais fácil encontrar possíveis problemas de lógica ou de funcionamento no programa.
        Para visualizar o conteúdo de um registrador em hexadecimal, será usado como base o código do projeto passado, denominado "HexadecimalLCD".

        O circuito e o programa funcionaram perfeitamente na prática.

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
#define incrementoT0 RC0_bit
#define prescaleT0 RC1_bit

// Funções auxiliares
void imprime_Display();
void decimal_Hexadecimal(unsigned char n, unsigned char col);

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     
     T0CON = 0x07; // Desabilita o timer0, configura com 16 bits, incremento com ciclo de máquina e prescale em 1:256
     TMR0L = 0x00;
     TMR0H = 0x00;

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);

     // Loop infinito
     while(1){

       imprime_Display();
       decimal_Hexadecimal((unsigned char)TMR0H, 10);
       decimal_Hexadecimal((unsigned char)TMR0L, 12);
       
       if(!incrementoT0)
         TMR0ON_bit = 0x01; // Liga o timer0
       else
         TMR0ON_bit = 0x00; // Desliga o timer0
         
       if(!prescaleT0){
       
         T0PS2_bit = 0x00;
         T0PS1_bit = 0x00;
         T0PS0_bit = 0x00;
         
         // Configura o prescale em 1:2
       
       } // end if !prescaleT0
       else {
       
         T0PS2_bit = 0x01;
         T0PS1_bit = 0x01;
         T0PS0_bit = 0x01;
         
         // Configura o prescale em 1:256
       
       } // end else !prescaleT0

     } // end Loop infinito

} // end void main


void imprime_Display(){

     char cen, dez, uni;

     lcd_chr(2, 4, 'T');
     lcd_chr_cp('M');
     lcd_chr_cp('R');
     lcd_chr_cp('0');

} // end void imprime_Display


void decimal_Hexadecimal(unsigned char n, unsigned char col){

     unsigned char valorL;
     unsigned char valorH;

     valorH = n & 0xF0; // Faz com que em valorH só se mantenha o valor do nible mais significativo, e o nible menos significativo todo em 0.
                        // Ex: ValorH = 0b 1101 0101. Com valorH = n & 0xF0, valorH = 1101 0000
     valorH = valorH >> 4; // valorH = 1101 0000, por exemplo. Com o comando valorH = valorH >> 4, valorH = 000 1101
     if(valorH > 0x09)
       valorH += 0x37; // Se valorH for maior que 9, soma-se o número 0x37 da tabela ASC para imprimir o número como letra, de A a F
     else
       valorH += 0x30; // Se valorH for menor que 9, soma-se o número 0x30 da tabela ASC para imprimir o número correspondente, de 0 a 9

     valorL = n & 0x0F;
     if(valorL > 0x09)
       valorL += 0x37;
     else
       valorL += 0x30;

     lcd_chr(2, col, valorH);
     lcd_chr_cp(valorL);

} // end void decimal_Hexadecimal
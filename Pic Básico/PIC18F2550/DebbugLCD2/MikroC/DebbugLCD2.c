/* 

        O objetivo deste programa é melhorar o debbug em tempo real, com lcd, que foi feito no último projeto, denominado "DebbugLCD". Para isso,
    o código do último programa servirá de base para melhorar o debbugger com LCD.
        Neste programa, os botões servirão para alterar a visualização dos registradores. A medida que se clica, aparece um registrador diferente.
    Esta ferramenta é muito importante, como já falado, para encontrar erros e para otimizar os códigos, observando o funcionamento dos registrado-
    res de configuração, das variáveis e dos registradores de controle.
    
       Quando eu declaro TRM0L antes de TMR0H, por alguma motivo TMR0H é zerado. Pelo menos da demonstração do display. O motivo eu não faço
    idéia.
    
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
#define incremento RC0_bit
#define decremento RC1_bit

// Funções auxiliares
void imprime_Display(unsigned char msg);
void decimal_Hexadecimal(unsigned char n, unsigned char col);

// Variáveis auxiliares
unsigned char valor = 0x01;

unsigned char flagBotoes = 0x00;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais

     T0CON = 0x07; // Desabilita o timer0, configura com 16 bits, incremento com ciclo de máquina e prescale em 1:256
     TMR0H = 0x97;
     TMR0L = 0xEE;

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);

     // Loop infinito
     while(1){

       if(!incremento) flagBotoes.B0 = 0x01;
       if(!decremento) flagBotoes.B1 = 0x01;
       
       if(incremento && flagBotoes.B0){
       
         flagBotoes.B0 = 0x00;
         
         valor += 0x01;
         
         if(valor > 0x05) valor = 0x01;
       
       } // end if incremento && flagBotoes.B0
       
       if(decremento && flagBotoes.B1){

         flagBotoes.B1 = 0x00;

         valor -= 0x01;

         if(valor < 0x01) valor = 0x05;

       } // end if decremento && flagBotoes.B1
       
       switch(valor){
       
         case 0x01: imprime_Display(0x01);
                    decimal_Hexadecimal((unsigned char)TMR0H, 10);
                    break;
         case 0x02: imprime_Display(0x02);
                    decimal_Hexadecimal((unsigned char)TMR0L, 10);
                    break;
         case 0x03: imprime_Display(0x03);
                    decimal_Hexadecimal((unsigned char)T0CON, 10);
                    break;
         case 0x04: imprime_Display(0x04);
                    decimal_Hexadecimal((unsigned char)TRISC, 10);
                    break;
         case 0x05: imprime_Display(0x05);
                    decimal_Hexadecimal((unsigned char)STATUS, 10);
                    break;
       
       } // end switch valor
       
       imprime_Display(0);

     } // end Loop infinito

} // end void main


void imprime_Display(unsigned char msg){

     switch(msg){
     
       case 0x00: lcd_chr(1, 2, 'R');
                  lcd_chr_cp('e');
                  lcd_chr_cp('g');
                  lcd_chr_cp('i');
                  lcd_chr_cp('s');
                  lcd_chr_cp('t');
                  lcd_chr_cp('r');
                  lcd_chr_cp('a');
                  lcd_chr_cp('d');
                  lcd_chr_cp('o');
                  lcd_chr_cp('r');
                  lcd_chr_cp('e');
                  lcd_chr_cp('s');
                  break;
       case 0x01: lcd_chr(2, 2, 'T');
                  lcd_chr_cp('M');
                  lcd_chr_cp('R');
                  lcd_chr_cp('0');
                  lcd_chr_cp('H');
                  lcd_chr_cp(' ');
                  break;
       case 0x02: lcd_chr(2, 2, 'T');
                  lcd_chr_cp('M');
                  lcd_chr_cp('R');
                  lcd_chr_cp('0');
                  lcd_chr_cp('L');
                  lcd_chr_cp(' ');
                  break;
       case 0x03: lcd_chr(2, 2, 'T');
                  lcd_chr_cp('0');
                  lcd_chr_cp('C');
                  lcd_chr_cp('O');
                  lcd_chr_cp('N');
                  lcd_chr_cp(' ');
                  break;
       case 0x04: lcd_chr(2, 2, 'T');
                  lcd_chr_cp('R');
                  lcd_chr_cp('I');
                  lcd_chr_cp('S');
                  lcd_chr_cp('C');
                  lcd_chr_cp(' ');
                  break;
       case 0x05: lcd_chr(2, 2, 'S');
                  lcd_chr_cp('T');
                  lcd_chr_cp('A');
                  lcd_chr_cp('T');
                  lcd_chr_cp('U');
                  lcd_chr_cp('S');
                  break;

     } // end switch msg

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
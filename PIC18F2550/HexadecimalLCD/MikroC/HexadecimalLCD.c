/* 

        O objetivo deste programa é escrever números hexadecimais no display LCD. Para isso, será criada uma função que converte número decimais
    em números hexadecimais. O LCD irá imprimir os dois valores equivalentes lado a lado.
    
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

// Funções auxiliares
void imprime_Display();
void decimal_Hexadecimal(unsigned char n);

// Variáveis auxiliares
unsigned char valor = 0x00;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     
     // Loop infinito
     while(1){
     
       valor += 0x01;
       
       imprime_Display();
       
       decimal_Hexadecimal(valor);
       
       delay_ms(1000);
     
     } // end Loop infinito

} // end void main


void imprime_Display(){

     char cen, dez, uni;

     lcd_chr(1, 1, 'D');
     lcd_chr_cp('e');
     lcd_chr_cp('c');
     lcd_chr_cp(' ');
     lcd_chr_cp('p');
     lcd_chr_cp('a');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp('H');
     lcd_chr_cp('e');
     lcd_chr_cp('x');
     lcd_chr_cp('a');
     lcd_chr_cp('d');
     lcd_chr_cp('e');
     lcd_chr_cp('c');
     
     cen = valor/100;
     dez = (valor%100)/10;
     uni = valor%10;
     
     lcd_chr(2, 2, cen + 0x30);
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

} // end void imprime_Display


void decimal_Hexadecimal(unsigned char n){

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
       
     lcd_chr(2, 10, valorH);
     lcd_chr_cp(valorL);

} // end void decimal_Hexadecimal
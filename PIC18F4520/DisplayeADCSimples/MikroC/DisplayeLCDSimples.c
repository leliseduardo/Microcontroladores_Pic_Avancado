/*

        Este programa tem como fun��o exibir no display LCD a leitura feira do conversor AD do Pic. A leitura ser� simples e pura, isto �,
    n�o ser� feito nenhum equacionamento com a leitura ADC e ser� mostrado o valor ADC lido, de 0 a 1023.
        Ainda, neste programa ser� demonstrado como o uso da fun��o "IntToStr" ocupa mais espa�o de mem�ria se comparado com a convers�o
    do valor lido do ADC em String no pr�prio c�digo. Assim como o uso da fun��o "lcd_Out", que escreve textos completos no display, na
    linha especificada e a partir da coluna tamb�m especificada.
        Para demonstrar o uso de menos mem�ria, ser� feito um c�digo que converte o valor lido em string de forma simples, utilizando
    algumas equa��es e, ainda, ser� usada a fun��o "lcd_Chr" e "lcd_Chr_Cp" para imprimir caracter por caracter no display, uma vez que
    o uso destas fun��es ocupa menos espa�o do que a ufun��o "lcd_Out", como visto no projeto "LCDSimples".
    
        No pr�prio programa estar�o os comando que ocupam mais espa�o, mas estar�o comentados e, caso eles sejam usados, o programa ocupa
    4% da mem�ria ROM, enquanto do jeito onde n�o se utiliza "lcd_out" e "intToStr", o programa ocupa 3% da mem�ria ROM.
        Num programa no qual mem�ria � um problema, por ser muito grande, esses pequenos detalher fazer a diferen�a.

*/

// Configura��o do LCD
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

// Fun��es auxiliares
void imprimeLCD(); // Fun��o que imprime "Leitura ADC" no display
void leituraADC();

// Vari�veis auxiliares
int adc = 0x00;
//char txt[7];

void main() {

     ADCON0 = 0x01; // Seleciona e habilita o canal AN0 e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de convers�o como sendo o intervalo da fonte (Vss a Vdd) e configura apenas AN0 como anal�gico

     TRISA = 0xFF; // Configura todo porta como entrada
     TRISB = 0x03; // Configura apenas RD0 e RD1 como entradas digitais, pois n�o ser�o usados

     // Inicializa��o do display
     lcd_Init();
     lcd_Cmd(_LCD_CURSOR_OFF);
     lcd_Cmd(_LCD_CLEAR);

     while(1){

       imprimeLCD(); // Imprime o texto "Leitura ADC" no display
       leituraADC();
     }
}

void leituraADC(){

     unsigned char mil, cen, dez, uni;

     adc = adc_read(0); // Leitura do conversor AD no canal 0

     mil = adc/1000;
     cen = (adc%1000)/100;
     dez = (adc%100)/10;
     uni = adc%10;

     lcd_chr(2, 4, mil+48);
     lcd_chr_cp(cen+48);
     lcd_chr_cp(dez+48);
     lcd_chr_cp(uni+48);
     
     //IntToStr(adc, txt);
     
     //lcd_Out(2, 4, txt);
}

void imprimeLCD(){

     lcd_chr(1, 2, 'L');
     lcd_chr_cp('e');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp('A');
     lcd_chr_cp('D');
     lcd_chr_cp('C');
}

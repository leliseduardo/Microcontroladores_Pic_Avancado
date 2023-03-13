/*

        Este programa tem como função exibir no display LCD a leitura feira do conversor AD do Pic. A leitura será simples e pura, isto é,
    não será feito nenhum equacionamento com a leitura ADC e será mostrado o valor ADC lido, de 0 a 1023.
        Ainda, neste programa será demonstrado como o uso da função "IntToStr" ocupa mais espaço de memória se comparado com a conversão
    do valor lido do ADC em String no próprio código. Assim como o uso da função "lcd_Out", que escreve textos completos no display, na
    linha especificada e a partir da coluna também especificada.
        Para demonstrar o uso de menos memória, será feito um código que converte o valor lido em string de forma simples, utilizando
    algumas equações e, ainda, será usada a função "lcd_Chr" e "lcd_Chr_Cp" para imprimir caracter por caracter no display, uma vez que
    o uso destas funções ocupa menos espaço do que a ufunção "lcd_Out", como visto no projeto "LCDSimples".
    
        No próprio programa estarão os comando que ocupam mais espaço, mas estarão comentados e, caso eles sejam usados, o programa ocupa
    4% da memória ROM, enquanto do jeito onde não se utiliza "lcd_out" e "intToStr", o programa ocupa 3% da memória ROM.
        Num programa no qual memória é um problema, por ser muito grande, esses pequenos detalher fazer a diferença.

*/

// Configuração do LCD
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

// Funções auxiliares
void imprimeLCD(); // Função que imprime "Leitura ADC" no display
void leituraADC();

// Variáveis auxiliares
int adc = 0x00;
//char txt[7];

void main() {

     ADCON0 = 0x01; // Seleciona e habilita o canal AN0 e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão como sendo o intervalo da fonte (Vss a Vdd) e configura apenas AN0 como analógico

     TRISA = 0xFF; // Configura todo porta como entrada
     TRISB = 0x03; // Configura apenas RD0 e RD1 como entradas digitais, pois não serão usados

     // Inicialização do display
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

/* 

        O objetivo deste programa é utilizar o protocolo SPI para escrever um arquivo txt em um cartão SD. Para isso será utilizado um outro
    arquivo .C dentro da pasta deste projeto. O arquivo .C conterá as funções para o uso do SD Card e será denominada "SDCard.c".
    
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

// Configuração do cartão SD
sbit Mmc_Chip_Select           at LATC0_bit;  // for writing to output pin always use latch (PIC18 family)
sbit Mmc_Chip_Select_Direction at TRISC0_bit;


// Funções auxiliares
void imprime_Display();
unsigned calcula_Tensao(int n);

extern void start_SD();
extern void novo_Arquivo();

// Variáveis auxiliares
int valorMaximo = 0x00,
    valorMinimo = 500;


unsigned valor = 0x00,
         adc = 0x00;

void main() {

     ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura apenas AN0 como porta analógica

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     start_SD();
     lcd_cmd(_LCD_CLEAR);
     
     // Loop infinito
     while(1){
     
       adc = adc_read(0);
       
       imprime_Display();
       
       delay_ms(1000);
     
     } // end Loop infinito

} // end void main


void imprime_Display(){

     char mil, cen, dez, uni;

     valor = calcula_Tensao(adc);

     if(valor > valorMaximo){
     
       valorMaximo = valor;

     } // end if valor > valorMaximo
     
     if(valor < valorMinimo){
       
       valorMinimo = valor;

     } // end if valor > valorMinimo

     lcd_out(1, 2, "Voltimetro");

     mil = valor/1000;
     cen = (valor%1000)/100;
     dez = (valor%100)/10;
     uni = valor%10;

     lcd_chr(2, 6, mil + 0x30);
     lcd_chr_cp(cen + 0x30);
     lcd_chr_cp('.');
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

} // end void imprime_Display


unsigned calcula_Tensao(int n){

     float tensao;

     tensao = ((n * 500.0) / 1023.0);

     return (unsigned)tensao;

} // end unsigned calcula_Tensao



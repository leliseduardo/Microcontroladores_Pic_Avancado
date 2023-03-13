/* 

        Este programa tem a função de iniciar o uso dos comparadores internos. Para isso, o comparador interno é configurado para comparar
    uma tensão de referência ajustada por um trimpot com uma tensão que varia de acordo com a luminosidade, a partir do uso de um LDR.
        Sabe-se que um LDR diminui sua resistência quanto mair for a luminosidade do local. E aumenta a resistência quanto menor a lumi-
    nosidade. Assim, quando a luz estiver baixa e o LDR com uma resistência mais alta, o comparador interno receberá uma tensão mais alta
    na sua porta não-inversora (onde está o LDR) e o comparador terá sua saída em nível alto, fazendo com que RB0 fique em High e acione
    o backlight do display lcd.

        Para não confundir:
        
        LDR -> Porta não-inversora
        Trimpot -> Porta inversora
        
*/

// Configuração display lcd
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
void textoDisplay();
void luzBaixa();
void luzAlta();

// Variáveis auxiliares



void main() {

     // Configuração de registradores
     CMCON = 0x04; // Configura os comparadores internos para ter a entrada não-inversora em comum e a inversora em RA0 (comparador 1)
                   // e RA1 (comparador 2). Quando a saída do comparador muda de estado, altera a flag C1OUT
     TRISA = 0xFF; // Configura todo o porta como entrada
     TRISB = 0xFE; // Configura apenas RB0 como saída digital
     LATB = 0x00; // Inicia todo portb em Low
     
     
     // Inicialização do LCD
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     
     textoDisplay();
     
     // Loop infinito
     while(1){
     
       if(C1OUT_bit){
       
         LATB0_bit = 0x01;
         luzBaixa();
       }
       else{
       
         LATB0_bit = 0x00;
         luzAlta();
       } // end if
     } // end while
} // end void mais

void textoDisplay(){

     lcd_chr(1, 1, 'S');
     lcd_chr_cp('e');
     lcd_chr_cp('n');
     lcd_chr_cp('s');
     lcd_chr_cp('o');
     lcd_chr_cp('r');
     lcd_chr_cp(' ');
     lcd_chr_cp('L');
     lcd_chr_cp('u');
     lcd_chr_cp('z');
}

void luzBaixa(){

     lcd_chr(2, 1, 'L');
     lcd_chr_cp('u');
     lcd_chr_cp('z');
     lcd_chr_cp(' ');
     lcd_chr_cp('B');
     lcd_chr_cp('a');
     lcd_chr_cp('i');
     lcd_chr_cp('x');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
}

void luzAlta(){

     lcd_chr(2, 1, 'L');
     lcd_chr_cp('u');
     lcd_chr_cp('z');
     lcd_chr_cp(' ');
     lcd_chr_cp('A');
     lcd_chr_cp('l');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
}







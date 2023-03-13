/*

        O objetivo deste programa � demonstrar a leitura de um encoder rotativo. Este encoder rotativo � um potenci�metro digital e que gira sem
     fim, muito utilizado em aparelho de som. Com ele � poss�vel implementar v�rios projetos onde necessita-se controlar uma vari�vel de controle.
     Isto �, pode-se controlar o PWM de sa�da do Pic, a luminosidade de um led o qualquer outro par�metro que se queira.
        Este c�digo � um projeto base para o uso do encoder rotativo. As fun��es espec�ficas de leitura do encoder foram criadas pelo professor e
     est�o demonstradas na v�deo aula 119. Cabe a mim entender e procurar as informa��es necess�rias para entender as fun��es, uma vez que elas
     utilziam t�cnicas de programa��o que eu n�o conhe�o.

        A simula��o no proteus funcionou perfeitamente, mas na pr�tica, preciso encontrar o datasheet do meu encoder ou ent�o comprar um encoder
     novo que tenha o datasheet f�cil de ser achado.
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
void display_Encoder();
char leitura_Encoder();

// Vari�veis auxiliares
char txt[5];

void main() {

     ADCON1 = 0x0F; // Configura todos os ports que poderiam ser anal�gicos como digitais

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     
     // Loop infinito
     while(1){
     
       lcd_out(1, 2, "Teste Enconder");
       display_Encoder();
     
     } // end Loop nnfinito

} // end void main

void display_Encoder(){

     static unsigned short cont = 0x00;
     unsigned char cen = 0x00, dez = 0x00, uni = 0x00;
     unsigned short encoder;
     
     encoder = leitura_Encoder();
     
     if(encoder){
     
       lcd_cmd(_LCD_CLEAR);
       cont += encoder;
     
     } // end if encoder
     
     cen = cont/100;
     dez = (cont%100)/10;
     uni = cont%10;
     
     lcd_chr(2, 7, cen + 48);
     lcd_chr_cp(dez + 48);
     lcd_chr_cp(uni + 48);

} // end void display_Encoder

char leitura_Encoder(){

     static unsigned short estadosEncoder[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
     static unsigned short AB = 0x00;
     
     AB <<= 2;
     AB |= ( PORTC & 0x03);
     
     return ( estadosEncoder[( AB & 0x0F )]);

} // end void leitura_Encoder














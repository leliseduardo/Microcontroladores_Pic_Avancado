/* 

    Este programa � o primeiro programa que se utiliza o display LCD 16x2 com o PIC18. Portanto, sua �nica fun��o � escrever um texto de
  "Hello World" no display. Ainda, existe uma grande dica dada pelo professor. No uso do display, quando se tem que usar muitas mensagens,
  pode acontecer de o Pic ficar sem espa�o, isto �, se consumir toda mem�ria ROM escrevendo tais mensagens. Uma forma de ocupar menos espa�o
  com cada mensagem que se deseja escrever, por incr�vel que pare�a, � criar uma fun��o para cada mensagem que se quer passar. Assim, quando
  for a hora da mensagem ser escrita, a fun��o deve ser chamada. Ainda, dentro dessa fun��o deve ser passado para o display caracter por
  caracter, utilizando o comando "Lcd_Chr_Cp('');" da biblioteca de display LCD do MikroC. Este comando faz com que o programa ocupe menos
  espa�o se comparado ao comando "Lcd_Out(Lin, Col, "");", que escreve textos inteiro de uma s� vez.
    Ou seja, o comando
    
       Lcd_Chr_Cp('');, que escreve um �nico caracter depois do �ltimo caracter escrito, ocupa menos espa�o que o comando
       
       Lcd_Out(Lin, Col, "");, que escreve um texto inteiro na linha especificada, a partir da coluna especificada.
       
    Portanto, � uma boa t�cnica e boa pr�tica criar fun��es para cada mensagem que se quer escrever, com o nome da fun��o sendo o nome
  de tal mensagem, utilizando o comando Lcd_Chr_Cp('') para escrever cada caracter da mensagem separadamente.

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


// Fun��o auxiliar

void HelloWorld();

void main() {

    ADCON0 = 0x00; // Desabilita os conversores AD
    ADCON1  = 0x0F; // Configura todas as portas que podem ser anal�gicas, como digitais
    
    // Inicializa��o do display LCD
    
    lcd_Init();
    lcd_Cmd(_LCD_CURSOR_OFF);
    lcd_Cmd(_LCD_CLEAR);
    
    while(1){
    
       HelloWorld();
       // Os comandos abaixo servem para demonstrar que a fun��o "lcd_Out" ocupa mais espa�o que a fun��o HelloWorld. Basta descomentar
       // lcd_Out(1, 3, "Hello World");
       // lcd_Out(2, 4, "PIC18F4520");
    } //end while
} // end void main


void HelloWorld(){

     lcd_Chr(1, 3, 'H'); // Fun��o que escreve um �nico caracter na linha e coluna especificada
     lcd_Chr_Cp('e'); // Fun��o que escreve um �nico caracter na pr�xima posi��o vazia, isto �, ap�s o �ltimo caracter escrito
     lcd_Chr_Cp('l');
     lcd_Chr_Cp('l');
     lcd_Chr_Cp('o');
     lcd_Chr_Cp(' ');
     lcd_Chr_Cp('W');
     lcd_Chr_Cp('o');
     lcd_Chr_Cp('r');
     lcd_Chr_Cp('l');
     lcd_Chr_Cp('d');
     lcd_Chr_Cp('!');
     
     lcd_Chr(2, 4, 'P');
     lcd_Chr_Cp('I');
     lcd_Chr_Cp('C');
     lcd_Chr_Cp('1');
     lcd_Chr_Cp('8');
     lcd_Chr_Cp('F');
     lcd_Chr_Cp('4');
     lcd_Chr_Cp('5');
     lcd_Chr_Cp('2');
     lcd_Chr_Cp('0');
} // end void HelloWorld
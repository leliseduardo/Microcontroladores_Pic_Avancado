/* 

        O objetivo deste programa � introduzir o conceito de menus no display LCD e apresentar uma maneira de fazer uma limpeza inteligente do LCD.
    Assim, antes de mostrar o pr�ximo menu, o programa ir� realizar uma limpeza em todo o display, para que nenhum caracter do menu anterior perma-
    ne�a na tela do display e atrapalhe a visualiza��o de cada menu. Outras formas de apagar o display, por exemplo utilizando de qualquer forma
    a fun��o "lcd_cmd(_LCD_CLEAR)" acaba atrapalhando uma visualiza��o clara do display, uma vez que essa fun��o, se n�o foi condicionada para
    ser executada apenas uma vez, ir� apagar constantemente o display. Assim como utilizar o comando "lcd_chr(x, x, ' ')" para escrever um espa�o
    vazio no display tamb�m n�o � aconselh�vel, uma vez que no caso de se ter muitos menus, utilizar sempre este artif�cio ir� consumir muita
    mem�ria de programa.
        Portanto, neste programa � apresentado uma forma inteligente de se usar a fun��o "lcd_cmd(_LCD_CLEAR)", no qual ela fica condicionada a
    ser executada uma �nica vez sempre que o menu mudar.
    
        Tanto no proteus quanto na pr�tica o circuito funcionou perfeitamente. Ele troca os menus e n�o permanece nenhum caractere indevido e que
    pertence a outro menu. Portanto, a limpeza de forma inteligente est� funcionando.

*/

// Configura��o do display LCD
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

// Configura��o de hardware
#define voltaMenu RB6_bit
#define avancaMenu RB7_bit

// Fun��es auxiliares
void leitura_Botoes();
void apaga_Display();

void menu1();
void menu2();
void menu3();
void menu4();


// Vari�veis auxiliares
char flagBotoes = 0x00;

bit apagaDisplay;
char menuControl = 0x01;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFF; // Configura todo o portb como entrada digital

     apagaDisplay = 0;

     lcd_init();
     lcd_cmd(_LCD_CLEAR);
     lcd_cmd(_LCD_CURSOR_OFF);
     
     // Loop infinito
     while(1){
     
       leitura_Botoes();
       
       switch(menuControl){
       
         case 0x01: menu1();
                    break;
         case 0x02: menu2();
                    break;
         case 0x03: menu3();
                    break;
         case 0x04: menu4();
                    break;
                    
       } // end switch menuControl
       
     } // end Loop infinito
     
} // end void main

void leitura_Botoes(){

     if(!voltaMenu) flagBotoes.B0 = 0x01;
     if(!avancaMenu) flagBotoes.B1 = 0x01;
     
     if(voltaMenu && flagBotoes.B0){
     
       flagBotoes.B0 = 0x00;
       apagaDisplay = 1;
       menuControl--;
       
       if(menuControl == 0x00) menuControl = 0x04;
     
     } // end if voltaMenu && flagBotoes.B0
     
     if(avancaMenu && flagBotoes.B1){
     
       flagBotoes.B1 = 0x00;
       apagaDisplay = 1;
       menuControl++;
       
       if(menuControl == 0x05) menuControl = 0x01;
     
     } // end if avancaMenu && flagBotoes.B1

} // end void leitura_Botoes

void apaga_Display(){

     if(apagaDisplay){
     
       apagaDisplay = 0;
       
       lcd_cmd(_LCD_CLEAR);
     
     } // end if apagaDisplay
     
} // end void apaga_Display

void menu1(){

     apaga_Display();
     
     lcd_chr(1, 1, 'R');
     lcd_chr_cp('e');
     lcd_chr_cp('c');
     lcd_chr_cp('e');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp('C');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('v');
     lcd_chr_cp('e');
     lcd_chr_cp('j');
     lcd_chr_cp('a');
     
     lcd_chr(2, 2, 'P');
     lcd_chr_cp('i');
     lcd_chr_cp('l');
     lcd_chr_cp('s');
     lcd_chr_cp('e');
     lcd_chr_cp('n');
     
     lcd_chr(2, 10, 'D');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp(':');
     lcd_chr_cp('2');
     lcd_chr_cp('h');

} // end void menu1

void menu2(){

     apaga_Display();

     lcd_chr(1, 1, 'R');
     lcd_chr_cp('e');
     lcd_chr_cp('c');
     lcd_chr_cp('e');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp('C');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('v');
     lcd_chr_cp('e');
     lcd_chr_cp('j');
     lcd_chr_cp('a');

     lcd_chr(2, 2, 'I');
     lcd_chr_cp('p');
     lcd_chr_cp('a');
     
     lcd_chr(2, 10, 'D');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp(':');
     lcd_chr_cp('3');
     lcd_chr_cp('h');

} // end void menu2

void menu3(){

     apaga_Display();

     lcd_chr(1, 1, 'R');
     lcd_chr_cp('e');
     lcd_chr_cp('c');
     lcd_chr_cp('e');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp('C');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('v');
     lcd_chr_cp('e');
     lcd_chr_cp('j');
     lcd_chr_cp('a');

     lcd_chr(2, 2, 'S');
     lcd_chr_cp('t');
     lcd_chr_cp('o');
     lcd_chr_cp('u');
     lcd_chr_cp('t');
     
     lcd_chr(2, 10, 'D');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp(':');
     lcd_chr_cp('5');
     lcd_chr_cp('h');

} // end void menu3

void menu4(){

     apaga_Display();

     lcd_chr(1, 1, 'R');
     lcd_chr_cp('e');
     lcd_chr_cp('c');
     lcd_chr_cp('e');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp(' ');
     lcd_chr_cp('C');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('v');
     lcd_chr_cp('e');
     lcd_chr_cp('j');
     lcd_chr_cp('a');

     lcd_chr(2, 2, 'W');
     lcd_chr_cp('e');
     lcd_chr_cp('i');
     lcd_chr_cp('s');
     lcd_chr_cp('s');
     
     lcd_chr(2, 10, 'D');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp(':');
     lcd_chr_cp('2');
     lcd_chr_cp('h');

} // end void menu4















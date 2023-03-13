/* 

        O objetivo deste programa � continuar a demonstra��o de como usar menus no LCD. Ap�s ver como fazer uma limpeza inteligente no programa
    "LCDLimpezaInteligente", vamos agora implementar v�rios menus que demonstram par�metros diferentes, como temperatura interna e externa, tens�o,
    contador de tempo e as entradas que est�o setadas.
        O programa � o mesmo do projeto "LCDLimpezaInteligente", por�m, com os menus diferentes. Tamb�m, ainda n�o � implementado nenhuma fun��o
    para os menus, mas ser� uma prepara��o para fazer isso.
    
         Tanto no proteus quanto na pr�tica o circuito e o programa funcionaram perfeitamente. A troca de menus funciona da maneira como � esperada
    e a limpeza inteligente, introduzida no projeto "LCDLimpezaInteligente" continua permitindo que a troca de menus ocorra sem que nenhum caracter
    indevido atrapalhe sua visualiza��o. Agora, o programa est� pronto para receber a implementa��o de cada menu, isto �, uma fun��o para cada menu.
         Esta � uma forma organizada de implementar v�rias fun��es em um controlador e visualizar cada uma dessas fun��es de maneira separada, de
    forma que seja poss�vel alterar algum par�metro daquela fun��o espec�fica ou apenas visualizar a leitura de alguma entrada.


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

// Configua��o de hardware
#define voltaMenu RB6_bit
#define avancaMenu RB7_bit
#define numeroMenus 6

// Fun��es auxiliares
void leitura_Botoes();
void apaga_Display();

void menu1();
void menu2();
void menu3();
void menu4();
void menu5();
void menu6();

// Vari�veis auxiliares
char flagBotoes = 0x00;

bit apagaDisplay;
char menuControl = 0x01;

void main() {

     // Configura��o de registradores
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
         case 0x05: menu5();
                    break;
         case 0x06: menu6();
                    break;
       
       } // end switch menuControl
     
     } // end loop infinito

} // end void main

void leitura_Botoes(){

     if(!voltaMenu) flagBotoes.B0 = 0x01;
     if(!avancaMenu) flagBotoes.B1 = 0x01;
     
     if(voltaMenu && flagBotoes.B0){
     
       flagBotoes.B0 = 0x00;
       apagaDisplay = 1;
       menuControl--;
       
       if(menuControl == 0) menuControl = numeroMenus;
     
     } // end if voltaMenu && flagBotoes.B0
     
     if(avancaMenu && flagBotoes.B1){
     
       flagBotoes.B1 = 0x00;
       apagaDisplay = 1;
       menuControl++;
       
       if(menuControl == (numeroMenus+1)) menuControl = 0x01;
     
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
     
     lcd_chr(1, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('m');
     lcd_chr_cp('p');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('t');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     
     lcd_chr(2, 2, 'I');
     lcd_chr_cp('n');
     lcd_chr_cp('t');
     lcd_chr_cp(':');

} // end void menu1

void menu2(){

     apaga_Display();

     lcd_chr(1, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('m');
     lcd_chr_cp('p');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('t');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp('a');

     lcd_chr(2, 2, 'E');
     lcd_chr_cp('x');
     lcd_chr_cp('t');
     lcd_chr_cp(':');

} // end void menu2


void menu3(){

     apaga_Display();

     lcd_chr(1, 2, 'V');
     lcd_chr_cp('o');
     lcd_chr_cp('l');
     lcd_chr_cp('t');
     lcd_chr_cp('i');
     lcd_chr_cp('m');
     lcd_chr_cp('e');
     lcd_chr_cp('t');
     lcd_chr_cp('r');
     lcd_chr_cp('o');

     lcd_chr(2, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('n');
     lcd_chr_cp('s');
     lcd_chr_cp('a');
     lcd_chr_cp('o');
     lcd_chr_cp(':');

} // end void menu3


void menu4(){

     apaga_Display();

     lcd_chr(1, 2, 'C');
     lcd_chr_cp('o');
     lcd_chr_cp('n');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp('d');
     lcd_chr_cp('o');
     lcd_chr_cp('r');

     lcd_chr(2, 2, 'P');
     lcd_chr_cp('u');
     lcd_chr_cp('l');
     lcd_chr_cp('s');
     lcd_chr_cp('o');
     lcd_chr_cp('s');
     lcd_chr_cp(':');

} // end void menu4


void menu5(){

     apaga_Display();

     lcd_chr(1, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('m');
     lcd_chr_cp('p');
     lcd_chr_cp('o');

} // end void menu5


void menu6(){

     apaga_Display();

     lcd_chr(1, 2, 'E');
     lcd_chr_cp('n');
     lcd_chr_cp('t');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('d');
     lcd_chr_cp('a');
     lcd_chr_cp('s');
     lcd_chr_cp(' ');
     lcd_chr_cp('H');
     lcd_chr_cp('I');
     lcd_chr_cp('G');
     lcd_chr_cp('H');
     

} // end void menu6

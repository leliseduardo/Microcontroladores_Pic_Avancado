/* 

        O objetivo deste programa é fazer a leitura do sensor geral feito com o PIC12F675 e mostrar no display qual sensor foi ativado mas, dessa
    vez, criando uma função para cada sensor. Ainda, não será criada a função que cada acionamento do sensor irá executar, mas o display irá mos-
    trar quando algum estiver acionado e quando nenhum estiver.
        Para isso, o código será o mesmo do último programa, denominado "LeitorPulsos", fazendo os acrescimos necessários.
        
**************************** Timer 2 *******************************************

        Overflow = contagem * prescale * ciclo de maquina
        Overflow = 200 * 1 * 250ns
        Overflow = 50us

********************************************************************************

        Neste circuito, resolvi o problema no qual o display mostra que nenhum sensor está ativado. Isto é, quando um sensor está ativado e
    permanece ativado, o display mostra que o sensor está ativado. Se este sensor deixa de estar ativado, o display mostra a mensagem de default,
    que é "Sensores Ok!".
    
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
//void imprime_Display();
void leitura_Sensor();
void display_Digital1();
void display_Digital2();
void display_Digital3();
void display_Digital4();
void display_Analogico1();
void display_Analogico2();
void display_Default();

// Variáveis auxiliares
unsigned short cont = 0x00,
               pulso = 0x00;

int baseTempo1 = 0x00;
int baseTempo2 = 0x00;


// Funções de interrupção
void interrupt(){

     if(INT0IF_bit){

       INT0IF_bit = 0x00;
       baseTempo1 = 0x00;
       baseTempo2 = 0x00;
       pulso++;
       cont = pulso;

     } // end if INT0IF_bit

     if(TMR2IF_bit){

       TMR2IF_bit = 0x00;

       baseTempo1++;
       baseTempo2++;

       if(baseTempo1 == 2000){  // A cada 2000 x 50us = 100ms a variável pulso é limpa

         baseTempo1 = 0;

         pulso = 0x00;

       } // end if baseTempo == 2000
       
       if(baseTempo2 == 6000){
       
         baseTempo2 = 0x00;
         
         cont = 0x00;
       
       } // end if baseTempo2 == 60000

     } // end if TMR2IF_bit

} // end void interrupt


void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como saída

     INTCON = 0xD0; // Habilita a interrupção global, a interrupção por periféricos e a interrupção externa INT0
     INTEDG0_bit = 0x01; // Registrador INTCON2. Configura a interrupção externa INT0 por borda de subida
     TMR2ON_bit = 0x01; // Registrador T2CON. Habilita o timer2
     PR2 = 200; // Configura o TMR2 para contar até 200
     TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_chr(1, 1, 'P');
     lcd_chr_cp('u');
     lcd_chr_cp('l');
     lcd_chr_cp('s');
     lcd_chr_cp('o');
     lcd_chr_cp(' ');
     lcd_chr_cp('S');
     lcd_chr_cp('e');
     lcd_chr_cp('n');
     lcd_chr_cp('s');
     lcd_chr_cp('o');
     lcd_chr_cp('r');

     // Loop infinito
     while(1){

       //imprime_Display();
       
       leitura_Sensor();

     } // end Loop infinito

} // end void main


void leitura_Sensor(){

     switch(cont){
     
       case 0x01: display_Digital1();
                  break;
       case 0x02: display_Digital2();
                  break;
       case 0x03: display_Digital3();
                  break;
       case 0x04: display_Digital4();
                  break;
       case 0x05: display_Analogico1();
                  break;
       case 0x06: display_Analogico2();
                  break;
       default:   display_Default();
     
     } // end switch cont

} // end void leitura_Sensor


void display_Digital1(){

     lcd_chr(2, 2, 'D');
     lcd_chr_cp('i');
     lcd_chr_cp('g');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp('l');
     lcd_chr_cp(' ');
     lcd_chr_cp('1');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');


} // end void imprime_Display1


void display_Digital2(){

     lcd_chr(2, 2, 'D');
     lcd_chr_cp('i');
     lcd_chr_cp('g');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp('l');
     lcd_chr_cp(' ');
     lcd_chr_cp('2');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');

} // end void imprime_Display2


void display_Digital3(){

     lcd_chr(2, 2, 'D');
     lcd_chr_cp('i');
     lcd_chr_cp('g');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp('l');
     lcd_chr_cp(' ');
     lcd_chr_cp('3');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');

} // end void imprime_Display3


void display_Digital4(){

     lcd_chr(2, 2, 'D');
     lcd_chr_cp('i');
     lcd_chr_cp('g');
     lcd_chr_cp('i');
     lcd_chr_cp('t');
     lcd_chr_cp('a');
     lcd_chr_cp('l');
     lcd_chr_cp(' ');
     lcd_chr_cp('4');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');

} // end void imprime_Display4


void display_Analogico1(){

     lcd_chr(2, 2, 'A');
     lcd_chr_cp('n');
     lcd_chr_cp('a');
     lcd_chr_cp('l');
     lcd_chr_cp('o');
     lcd_chr_cp('g');
     lcd_chr_cp('i');
     lcd_chr_cp('c');
     lcd_chr_cp('o');
     lcd_chr_cp(' ');
     lcd_chr_cp('1');
     lcd_chr_cp(' ');

} // end void imprime_Display5


void display_Analogico2(){

     lcd_chr(2, 2, 'A');
     lcd_chr_cp('n');
     lcd_chr_cp('a');
     lcd_chr_cp('l');
     lcd_chr_cp('o');
     lcd_chr_cp('g');
     lcd_chr_cp('i');
     lcd_chr_cp('c');
     lcd_chr_cp('o');
     lcd_chr_cp(' ');
     lcd_chr_cp('2');
     lcd_chr_cp(' ');

} // end void imprime_Display6


void display_Default(){

     lcd_chr(2, 2, 'S');
     lcd_chr_cp('e');
     lcd_chr_cp('n');
     lcd_chr_cp('s');
     lcd_chr_cp('o');
     lcd_chr_cp('r');
     lcd_chr_cp('e');
     lcd_chr_cp('s');
     lcd_chr_cp(' ');
     lcd_chr_cp('O');
     lcd_chr_cp('k');
     lcd_chr_cp('!');

} // end void imprime_Display6



/*
void imprime_Display(){

     char cen, dez, uni;

     cen = cont/100;
     dez = (cont%100)/10;
     uni = cont%10;

     lcd_chr(2, 8, cen + 0x30);
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

} // end void imprime_Display
*/
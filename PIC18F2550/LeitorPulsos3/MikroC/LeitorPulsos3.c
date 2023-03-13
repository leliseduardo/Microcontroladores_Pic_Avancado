/* 

        Este programa tem o objetivo de resolver um problema do último projeto, denominado "LeitorPulsos2". Tal projeto tem a função de identifi-
     car qual sensor está ativado e mostrar do display. Também, se nenhum sensor estiver ativo, ele mostra a mensagem "Sensores Ok!". Porém, existe
     um problema quando há o acionamento dos display 2, 3 e 4. O que ocorre é que, para chegar nas funções específicas de cada sensor, o programa
     está passando por todas as funções dos sensores anteriores. Isto é, para chegar a função do sensor 4, o programa está passando pela função
     do sensor 1, 2 e 3. Para chegar na função do sensor 3, o programa passa pela função do sensor 1 e 2. E assim por diante. Esse erro de lógica
     pode ocasionar num grande erro no circuito prático. Caso já estivessem implementadas funções específicas ou execuções de outras funções de
     acordo com cada leitura de sensor, todas essas funções seriam executadas antes da execução do sensor 4, por exemplo. Daí, esse erro precisa
     ser corrigido.
     
**************************** Timer 2 *******************************************

        Overflow = contagem * prescale * ciclo de maquina
        Overflow = 200 * 1 * 250ns
        Overflow = 50us

********************************************************************************

        o circuito e o programa funcionaram perfeitamente na prática, e o erro de lógica foi resolvido.

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

bit flagControl; // Flag que controla a escrita no display


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
                                // Este if garante que, a cada leitura de sensor, a variável pulso seja zerada. Essa lógica funciona pois, após
                                // um sensor ser ativado, o programa espera 250ms para que os pulsos do mesmo sensor ou de outro sejam novamente
                                // executados e percebidos na entrada da interrupção externa INT0. Assim, após o último pulso, o TMR2 conta até
                                // 100ms, tempo dentro dos 250ms, e apaga a variável pulso, para que os pulsos de outra leitura não sejam somados.
         baseTempo1 = 0x00;

         pulso = 0x00;
         
         flagControl = 0x01;

       } // end if baseTempo == 2000

       if(baseTempo2 == 6000){ // A cada 6000 x 50us = 300ms a variável cont é limpa, confirmando que nenhum sensor está ativado
                               // Este if garante que, se nenhum sensor estiver ativado, o display mostrará a mensagem de default
         baseTempo2 = 0x00;

         cont = 0x00;
         
         flagControl = 0x01;

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
     
     flagControl = 0x00;

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

     if(flagControl){
     
       flagControl = 0x00;

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
     
     } // end if flagControl

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
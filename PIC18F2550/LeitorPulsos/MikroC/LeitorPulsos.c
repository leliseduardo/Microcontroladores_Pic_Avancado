/* 

        O objetivo deste programa � fazer com que o Pic leia os pulsos de um sensor geral atrav�s de sua interrup��o externa. O sensor geral �
    um sensor feito a partir do PIC12F675, que l� quatro sensores digitais e um anal�gico. O projeto deste sensor geral, denominado "SensorPic",
    est� na mesma pasta deste projeto, assim como na pasta de projetos dos microncontroladores PIC12F675.
        Neste projeto ser� utilizada a interrup��o externa e a interrup��o do timer2, assim como a impress�o no display do n�mero correspondente
    ao sensor lido pela interrup��o externa.
    
    
**************************** Timer 2 *******************************************

        Overflow = contagem * prescale * ciclo de maquina
        Overflow = 200 * 1 * 250ns
        Overflow = 50us

********************************************************************************

        O circuito e o programa funcionaram perfeitamente na pr�tica.

*/


// Configura��o do display lcd
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

// Fun��es auxiliares
void imprime_Display();

// Vari�veis auxiliares
unsigned short cont = 0x00,
               pulso = 0x00;
               
int baseTempo = 0;


// Fun��es de interrup��o
void interrupt(){

     if(INT0IF_bit){

       INT0IF_bit = 0x00;
       baseTempo = 0x00;
       pulso++;
       cont = pulso;
     
     } // end if INT0IF_bit
     
     if(TMR2IF_bit){
     
       TMR2IF_bit = 0x00;

       baseTempo++;
       
       if(baseTempo == 2000){  // A cada 2000 x 50us = 100ms a vari�vel pulso � limpa
       
         baseTempo = 0;
         
         pulso = 0x00;
       
       } // end if baseTempo == 2000
     
     } // end if TMR2IF_bit

} // end void interrupt


void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como sa�da

     INTCON = 0xD0; // Habilita a interrup��o global, a interrup��o por perif�ricos e a interrup��o externa INT0
     INTEDG0_bit = 0x01; // Registrador INTCON2. Configura a interrup��o externa INT0 por borda de subida
     TMR2ON_bit = 0x01; // Registrador T2CON. Habilita o timer2
     PR2 = 200; // Configura o TMR2 para contar at� 200
     TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrup��o por overflow do timer2

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
     
       imprime_Display();
     
     } // end Loop infinito

} // end void main


void imprime_Display(){

     char cen, dez, uni;
     
     cen = cont/100;
     dez = (cont%100)/10;
     uni = cont%10;
     
     lcd_chr(2, 8, cen + 0x30);
     lcd_chr_cp(dez + 0x30);
     lcd_chr_cp(uni + 0x30);

} // end void imprime_Display
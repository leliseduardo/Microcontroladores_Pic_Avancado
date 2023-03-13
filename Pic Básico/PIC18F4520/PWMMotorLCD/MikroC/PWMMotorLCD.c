/*

        Este programa tem a função de escolher o duty cicle do PWM antes de ele ser acionado. Para isso utiliza-se um display LCD e dois botões
    que ajustam o PWM. Logo após ter escolhido o PWM, deixa-se um dos botões apertados, até que o PWM seja acionado.
        Para fazer essa programação de botão apertado, utiliza-se o timer1, que é habilitado quando o botão é apertado e, se o botão ficar apertado
    por determinado tempo, ele seta uma flag que sai do loop que contem a leitura dos botões. Assim, o programa entra no loop infinito e aciona o
    PWM. Caso o botão seja pressionado e solto rapidamente, o programa reinicia a contagem do timer1 e o desliga, incrementando o decrementando o
    duty cicle a ser configurado.

         Para a programação do botão que aciona o PWM, utiliza-se um tempo de interrupção de 50ms do timer1. Dentro da função de interrupção,
    haverá uma variável de contagem que contará até 40, totalizando 2s. Se o botão ficar pressionado 2s ou mais, o programa sai do loop que lê
    os botões e aciona o PWM.

    ciclo de máquina = 1/(4MHz/4) = 1us
    Tempo de overflow = 50ms
    Contagem = 50ms / 1us = 50000
    <TMR1L::TMR1H> (inicio) = 65536 - 50000 = 15536
    15536(decimal) = 0x3CB0(hexadecimal)
    TMR1L = 0xB0
    TMR1H = 0x3C

    Overflow = <TMR1L::TMR1H> (contagem) * Prescaler * Ciclo de Maquina
    Overflow = 50000 * 1 * 1us
    Overflow = 50ms

*/

// Configuração do display LCD
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

// Configuração de hardware
#define decrementa RB6_bit
#define incrementa RB7_bit

// Funções auxiliares
void set_Duty();
void leitura_Botoes();

// Variáveis auxiliares
unsigned short duty = 128;
char i;
bit control;
char flagBotoes = 0x00;
char cont = 0x00;

// Função de interrupção

void interrupt(){

     if(TMR1IF_bit){

       TMR1IF_bit = 0x00;
       TMR1L = 0xB0;
       TMR1H = 0x3C;

       cont++;

       if(cont == 40){

         cont = 0x00;
         control = 1;
       } // end cont == 40

     } // end if TMR1IF_bit

} // end void interrupt

void main() {

     // Configuração de registradores
     INTCON = 0xC0; // Habilita a interrupção global e a interrupção por periféricos

     // Registrador PIE1 - Peripheral Interrupt Enable Register 1
     TMR1IE_bit = 0x01; // Habilita a interrupção por overflow do timer1

     T1CON = 0x00; // Configura o timer1 com 8 bits, prescaler 1:1, incrementa com ciclo de máquina e inicialmente timer1 desabilitado

     // <TMR1L::TMR1H>
     TMR1L = 0xB0; // Inicia em 15536, para uma contagem de 50000
     TMR1H = 0x3C;

     ADCON1 = 0x0F; // Configura todas as portas que poderiam ser analógicas como digitais
     TRISB = 0xFF; // Configura todo o portb como entrada digital
     control = 0; // Inicia o bit control em 0

     lcd_Init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);

     PWM1_Init(1000);
     PWM1_Stop();
     PWM1_Set_Duty(duty);


     set_Duty();
     for(i = 0; i < 17; i++) lcd_chr(1, i, ' ');
     lcd_out(1, 3, "Motor acionado");
     // Loop infinito
     while(1){

       PWM1_start();
       PWM1_Set_Duty(duty);
     } // end loop infinito

} // end void main

void set_Duty(){

     char cen = 0x00, dez = 0x00, uni = 0x00;

     while(!control){

       leitura_Botoes();

       lcd_chr(1, 3, 'S');
       lcd_chr_cp('e');
       lcd_chr_cp('t');
       lcd_chr_cp(' ');
       lcd_chr_cp('D');
       lcd_chr_cp('u');
       lcd_chr_cp('t');
       lcd_chr_cp('y');
       lcd_chr_cp('!');

       cen = duty/100;
       dez = (duty%100)/10;
       uni = duty%10;

       lcd_chr(2, 5, cen + 48);
       lcd_chr_cp(dez + 48);
       lcd_chr_cp(uni + 48);

     } // end while control
} // end void set_Duty


void leitura_Botoes(){

     if(!decrementa){

       flagBotoes.B0 = 0x01;

       TMR1ON_bit = 0x01;
     } // end if !decrementa

     if(!incrementa) {

       flagBotoes.B1 = 0x01;

       TMR1ON_bit = 0x01;
     } // end if !incrementa

     if(decrementa && flagBotoes.B0){

       flagBotoes.B0 = 0x00;
       TMR1ON_bit = 0x00;
       TMR1L = 0xB0;
       TMR1H = 0x3C;
       cont = 0x00;
       duty--;
     } // end if decrementa && flagBotoes.B0

     if(incrementa && flagBotoes.B1){

       flagBotoes.B1 = 0x00;
       TMR1ON_bit = 0x00;
       TMR1L = 0xB0;
       TMR1H = 0x3C;
       cont = 0x00;
       duty++;
     } // end incrementa && flagBotoes.B1

} // end void leitura_Botoes

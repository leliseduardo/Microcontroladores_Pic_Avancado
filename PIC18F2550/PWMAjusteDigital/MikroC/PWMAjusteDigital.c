/* 

        O objetivo deste programa é implementar um PWM a partir do timer2. Este PWM será ajustável digitalmente através de um botão e será possí-
     vel ver o valor do duty cicle ajustado através de um display LCD.
        Para isso, será utilizado o código do último projeto, denominado "IncInteligenteBackLight", bastando apenas, acrescentar o código referente
     ao PWM.
     
        O programa e o circuito funcionaram perfeitamente na prática. Para testar o PWM, utilizei um led.
        
        Na aula, o professor constatou que, quando duty = 0, ainda sim existia um pulso no sinal de saída do pwm, decorrente da latência existente
     na interrupção. Isso foi facilmente resolvido desligando o timer2 quando o duty = 0.

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

// Mapeamento de hardware
#define botao RB0_bit
#define backLight LATB1_bit
#define pwm LATC0_bit

// Funções auxiliares
void leitura_Botoes();
void base_Tempo();
void imprime_Display();

// Variáveis auxiliares
unsigned short valor = 0x80,
         baseTempo = 0x00,
         contBotao = 0x00,
         contTempo = 120,
         controlAdiciona = 0x00,
         duty = 0x00;

bit flagBotao;
bit controlRapido;

// Funções de interrupção
void interrupt(){

     if(TMR0IF_bit){

       TMR0IF_bit = 0x00;
       TMR0H = 0x9E;
       TMR0L = 0x58;

       baseTempo++;
       contTempo++;

       if(contTempo > 120){

         backLight = 0x00;
         contTempo = 120;
         controlAdiciona = 0x00;

       } // end if contTempo > 120

       if(flagBotao) contBotao++;

       base_Tempo();

     } // end if TMR0IF_bit
     
     if(TMR2IF_bit){
     
       TMR2IF_bit = 0x00;
       
       if(pwm){
       
         TMR2 = duty;
         pwm = 0x00;
       
       } // end if pwm
       else{
       
         TMR2 = 255 - duty;
         pwm = 0x01;
       
       } // end else pwm
     
     } // end TMR2IF_bit

} // end void interrupt

void main() {

     // Configuração de registradores
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x01; // Configura apenas RB0 como entrada digital, o resto como saída
     TRISC = 0xFE; // Configura apenas RC0 como saída digital, o resto como entrada

     INTCON = 0xE0; // Habilita a interrupção global, por perfiféricos e a interrupção por overflow do timer 0
     INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb

     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
     TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
     TMR0L = 0x58;
     
     T2CON = 0x05; // Habilita o timer2, configurao postscale em 1:1 e o prescale em 1:4
     PR2 = 0xFF; // O contador TMR2 conta até 256
     TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2

     flagBotao = 0x00;
     controlRapido = 0x00;

     // Inicialização do display lcd
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_chr(1, 2, 'D');
     lcd_chr_cp('u');
     lcd_chr_cp('t');
     lcd_chr_cp('y');
     lcd_chr_cp(':');

     // Loop infinito
     while(1){

       leitura_Botoes();

       imprime_Display();

     } // end loop infinito

} // end void main



void leitura_Botoes(){

     if(!botao){

       flagBotao = 0x01;
       backLight = 0x01;
       contTempo = 0x00;

     } // end if !botao

     if(botao && flagBotao){

       flagBotao = 0x00;
       contBotao = 0x00;
       controlRapido = 0x00;
       controlAdiciona++;

       if(controlAdiciona > 1) valor++;

     } // end if botao && flagBotao

} // end void leitura_Botoes




void base_Tempo(){

     if(contBotao == 40) controlRapido = 0x01; // Se botao ficar pressionado por 1s, ativa o incremento rapido

     if(baseTempo == 0x04){ // Tempo igual a 100ms

       baseTempo = 0x00;

       if(controlRapido) valor += 1; // Se incremento rapido ligado, incrementa a cada 100ms

     } // end if baseTempo == 0x04

} // end void base_Tempo





void imprime_Display(){

     unsigned char dig3, dig2, dig1;

     dig3 = valor/100;
     dig2 = (valor%100)/10;
     dig1 = valor%10;

     lcd_chr(1, 8, dig3 + 0x30);
     lcd_chr_cp(dig2 + 0x30);
     lcd_chr_cp(dig1 + 0x30);

     duty = valor;
     
     if(duty == 0x00){
     
       TMR2ON_bit = 0x00;
       
       pwm = 0x00;
       
     } // end if duty == 0x00
     else  TMR2ON_bit = 0x01;

} // end void imprime_Display













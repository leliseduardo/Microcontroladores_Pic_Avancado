/* 

        O objetivo deste programa é utilizar a interrupção do timer0 para uma aplicação de nível avançado. Essa aplicação consiste em utilizar
    um botão de incremento de forma inteligente, isto é, utilizar o botão de incremento para incrementar de 1 em 1 unidade e, quando pressionado
    por 1s, fazer um incremento rápido, também de 1 em 1 unidade, mas de forma rápida.
        A partir deste projeto base, pode-se implementar esta lógica para diversos circuitos e projetos fazendo, assim, o uso mais eficaz e
    inteligente de um botão ou vários botões.
    
    ****************** Timer 0 com overflow de 25ms ****************************
    
    Ciclo de máquina = 250ns
    Prescale = 4
    Overflow = contagem * prescale * ciclo de maquina
    25ms = contagem * 4 * 250ns
    contagem = 25ms / (4* 250ns)
    contagem = 25000
    
    <TMR0H::TMR0L> total = 65536
    <TMR0H::TMR0L> inicialização = 65536 - 25000 = 40536
    40536 decimal = 0x9E58 hexadecimal
    
    Logo:
    
    TMR0H = 0x9E
    TMR0L = 0x58
    
    ****************************************************************************
    
    Na prática o circuito e o programa funcionaram perfeitamente.
    
    No proteus o display não funciona e dá uma mensagem de warning. Agora, fica claro que o proteus não simula programas para o microcontrolador
    PIC18F2550. Não sei se é um problema do arquivo HEX do MikroC com o proteus, ou o próprio proteus. Deve ser por esse motivo que o professor não
    está mais simulando os circuitos no proteus.

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

// Funções auxiliares
void leitura_Botoes();
void base_Tempo();
void imprime_Display();

// Variáveis auxiliares
unsigned valor = 0x00,
         baseTempo = 0x00,
         contBotao = 0x00;

bit flagBotao;
bit controlRapido;

// Funções de interrupção
void interrupt(){

     if(TMR0IF_bit){

       TMR0IF_bit = 0x00;
       TMR0H = 0x9E;
       TMR0L = 0x58;
       
       baseTempo++;
       
       if(flagBotao) contBotao++;
       
       base_Tempo();
     
     } // end if TMR0IF_bit

} // end void interrupt

void main() {

     // Configuração de registradores
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como saída
     
     INTCON = 0xA0; // Habilita a interrupção global e a interrupção por overflow do timer 0
     INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
     
     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
     TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
     TMR0L = 0x58;
     
     flagBotao = 0x00;
     controlRapido = 0x00;

     // Inicialização do display lcd
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_chr(1, 2, 'V');
     lcd_chr_cp('a');
     lcd_chr_cp('l');
     lcd_chr_cp(':');
     
     // Loop infinito
     while(1){

       leitura_Botoes();
       
       imprime_Display();

     } // end loop infinito

} // end void main



void leitura_Botoes(){

     if(!botao) flagBotao = 0x01;
     
     if(botao && flagBotao){
     
       flagBotao = 0x00;
       valor += 1;
       contBotao = 0x00;
       controlRapido = 0x00;
     
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

     unsigned char dig5, dig4, dig3, dig2, dig1;
     
     dig5 = valor/10000;
     dig4 = (valor%10000)/1000;
     dig3 = (valor%1000)/100;
     dig2 = (valor%100)/10;
     dig1 = valor%10;
     
     lcd_chr(1, 7, dig5 + 0x30);
     lcd_chr_cp(dig4 + 0x30);
     lcd_chr_cp(dig3 + 0x30);
     lcd_chr_cp(dig2 + 0x30);
     lcd_chr_cp(dig1 + 0x30);

} // end void imprime_Display
/* 

        O objetivo deste programa é controlar o brilho e o contraste do display de forma digital. Para isso, utiliza-se dois PWM's para este
     controle. Os PWM's serão gerados a partir do timer 2 e do timer 3.
        Os detalhes do circuito para se fazer este controle estão no proteus. A novidade no circuito é um filtro passa baixas junto de um buffer.
     Este driver permite que a variação do duty do PWM varie a tensão de saída do buffer analógicamente. De certa forma, pode-se dizer que este
     driver é um tipo de conversor digital analógico. Desse modo consegue-se controlar digitalmente o que antes era controlado por um potenciômetro.

******************************** Timer 2 ***************************************

     Ciclo de máquina = 250ns
     Prescale = 4
     Contagem = 256 (8 bits)
     
     Overflow = contagem * prescale * ciclo de maquina
     Overflow = 256 * 4 * 250ns
     Overflow = 0,256us
     
     Frequência = 1 / Overflow
     Frequência = 3900Hz
     
********************************************************************************

******************************** Timer 3 ***************************************

     Ciclo de máquina = 250ns
     Prescale = 4
     Contagem = 256 (8 bits)

     Overflow = contagem * prescale * ciclo de maquina
     Overflow = 256 * 4 * 250ns
     Overflow = 0,256us

     Frequência = 1 / Overflow
     Frequência = 3900Hz

********************************************************************************

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

// Mapeamento de hardware
#define botao1 RB0_bit
#define botao2 RB1_bit
#define pwm1 LATC0_bit
#define pwm2 LATC1_bit

// Funções auxiliares
void leitura_Botao();
void imprime_Display();

// Variáveis auxiliares

unsigned short duty1 = 128,
               duty2 = 40;
               
bit flagBotao1;
bit flagBotao2;

// Funções de interrupção

void interrupt(){

     if(TMR2IF_bit){
     
       TMR2IF_bit = 0x00;

       if(pwm1){
       
         TMR2 = duty1;
         pwm1 = 0x00;
       
       } // end if pwm1
       else{
       
         TMR2 = 255 - duty1;
         pwm1 = 0x01;
       
       } // end else pwm1
     
     } // end if TMR2IF_bit
     
     if(TMR3IF_bit){
     
       TMR3IF_bit = 0x00;
       TMR3H = 0xFF;
       
       if(pwm2){
       
         TMR3L = duty2;
         pwm2 = 0x00;
       
       } // end if pwm2
       else{
       
         TMR3L = 255 - duty2;
         pwm2 = 0x01;
       
       } // end else pwm2
     
     } // end if TMR3IF_bit

} // end void interrupt

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais
     TRISC = 0xFC; // Configura apenas RC0 e RC1 como saídas digitais
     LATC = 0xFC; // Inicia todas as saídas do portc em Low
     INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entradas do portb
     
     INTCON = 0xC0; // Habilita a interrupção global e por periféricos
     TMR2IE_bit = 0x01; // Registrador PIE1. Habilita a interrupção por overflow do timer2
     TMR3IE_bit = 0x01; // Resgistrador PIE2. Habilita a interrupção por overflow do timer3
     
     T2CON = 0x05; // Habilita o timer2, configura o prescale em 1:4 e o postscale em 1:1
     PR2 = 0xFF; // Configura a contagem do TMR2 até 0xFF = 255
     T3CON = 0x21; // Habilita o timer3, configura com 8 bits, prescale em 1:4 e incrementa com ciclo de clock
     TMR3H = 0xFF;
     TMR3L = 0x00;
     
     flagBotao1 = 0x00;
     flagBotao2 = 0x00;

     // Inicialização do display lcd
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_chr(1, 1, 'B');
     lcd_chr_cp('r');
     lcd_chr_cp('i');
     lcd_chr_cp('l');
     lcd_chr_cp('h');
     lcd_chr_cp('o');
     lcd_chr_cp(':');
     lcd_chr_cp(' ');
     lcd_chr(2, 1, 'C');
     lcd_chr_cp('o');
     lcd_chr_cp('n');
     lcd_chr_cp('t');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('s');
     lcd_chr_cp('t');
     lcd_chr_cp('e');
     lcd_chr_cp(':');
     lcd_chr_cp(' ');
     
     // Loop infinito
     while(1){
              
       leitura_Botao();
       
       imprime_Display();
       
     } // end Loop infinito
     
} // end void main


void leitura_Botao(){

     if(!botao1) flagBotao1 = 0x01;
     if(!botao2) flagBotao2 = 0x01;
     
     if(botao1 && flagBotao1){
     
       flagBotao1 = 0x00;
       duty1 += 0x04;
     
     } // end if botao1 && flagBotao1
     
     if(botao2 && flagBotao2){

       flagBotao2 = 0x00;
       duty2 += 0x04;

     } // end if botao2 && flagBotao2

} // end void base_Tempo()

void imprime_Display(){

     char cen1, dez1, uni1, cen2, dez2, uni2;
     
     cen1 = duty1/100;
     dez1 = (duty1%100)/10;
     uni1 = duty1%10;
     
     lcd_chr(1, 9, cen1 + 0x30);
     lcd_chr_cp(dez1 + 0x30);
     lcd_chr_cp(uni1 + 0x30);
     
     cen2 = duty2/100;
     dez2 = (duty2%100)/10;
     uni2 = duty2%10;

     lcd_chr(2, 12, cen2 + 0x30);
     lcd_chr_cp(dez2 + 0x30);
     lcd_chr_cp(uni2 + 0x30);

} // end void imprime_Display()















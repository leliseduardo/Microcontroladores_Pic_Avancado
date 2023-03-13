/* 

        O objetivo deste programa é pegar o último projeto, denominado "PWMMotorLCD" e incrementar, além do ajuste do Duty Cicle, o ajuste da
     frequência do PWM. Para isso utiliza-se, simultâneamente, a função PWM1 do MikroC e algumas configurações manuais do módulo CCP. A grande
     diferença deste código é que, ao invés de usar a função "PWM1_Init", do MikroC, será criada uma função para iniciar manualmente a frequência
     do módulo CCP1 como PWM.
     Continua-se usando o timer1 da mesma fora, por isso:
     
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
     
     Além disso, precisa-se da equação do módulo ccp para se obter a frequência do PWM
     
                        Fosc                             4000000
     Freq = ------------------------------- = ------------------------------
               4 x prescalerT2 x (PR2+1)              4 x 1 x (PR2+1)

        Porém, no programa, irei ajusta o valor de PR2, registrador que está associado ao timer2. Logo, para exibir a fruquência vou precisar
     efetuar essa equação numa variável e exibir tal variável.
     
     Para mostrar a porcentagem do duty, basta fazer a regra de três:
     
     255  ---------- 100
     duty ---------- x
                     duty x 100
             x = -------------------
                         255
                         
        Eu programei de uma forma, que na segunda linha do LCD é mostrado a frequência de PWM configurada e a porcentagem do duty cicle. Ainda, ao
    clicar para definir a frequência não altera o duty e vice versa, isto é, a configuração de um parâmetro não altera o outro.
                      
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
void set_Frequency();
void leitura_Botoes();

// Variáveis auxiliares
unsigned short duty = 128;
char i;
bit control;
char flagBotoes = 0x00;
char cont = 0x00;

unsigned short parametro = 1;
unsigned frequencia = 0;
unsigned aux = 0;
char texto[10];

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

     set_Frequency();
     for(i = 0; i < 17; i++) lcd_chr(1, i, ' ');
     
     CCP1CON = 0x0C; // Configura o módulo CCP1 para PWM
     T2CON = 0x04; // Habilita o timer2, prescaler 1:1 e postscaler 1:1
     PR2 = parametro; // PR2 é o registrador que define até que numero o timer2 irá contar, de TMR2 até PR2
     PWM1_Stop();
     PWM1_Set_Duty(duty);

     control = 0;
     set_Duty();
     for(i = 0; i < 17; i++) lcd_chr(1, i, ' ');
     lcd_out(1, 3, "Motor acionado");
     
     PWM1_start();
     PWM1_Set_Duty(duty);
     
     // Loop infinito
     while(1){



     } // end loop infinito

} // end void main



void set_Frequency(){

     char mil = 0x00, cen = 0x00, dez = 0x00, uni = 0x00;

     while(!control){

       leitura_Botoes();

       lcd_chr(1, 2, 'S');
       lcd_chr_cp('e');
       lcd_chr_cp('t');
       lcd_chr_cp(' ');
       lcd_chr_cp('F');
       lcd_chr_cp('r');
       lcd_chr_cp('e');
       lcd_chr_cp('q');
       lcd_chr_cp('u');
       lcd_chr_cp('e');
       lcd_chr_cp('n');
       lcd_chr_cp('c');
       lcd_chr_cp('y');
       lcd_chr_cp('!');

       aux = (4 * (parametro + 1));
       frequencia  = (4000 / aux);
       
       mil = frequencia/1000;
       cen = ((frequencia%1000)/100);
       dez = ((frequencia%100)/10);
       uni = frequencia%10;

       lcd_chr(2, 1, mil + 48);
       lcd_chr_cp(cen + 48);
       lcd_chr_cp(dez + 48);
       lcd_chr_cp(uni + 48);
       lcd_chr_cp('K');
       lcd_chr_cp('H');
       lcd_chr_cp('z');
     } // end while control
} // end void set_Duty

void set_Duty(){

     char cen = 0x00, dez = 0x00, uni = 0x00;
     
     flagBotoes.B2 = 0x01;

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

       aux = ((100 * duty ) / 255);

       cen = aux/100;
       dez = (aux%100)/10;
       uni = aux%10;

       lcd_chr(2, 12, cen + 48);
       lcd_chr_cp(dez + 48);
       lcd_chr_cp(uni + 48);
       lcd_chr_cp('%');

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
       if(!flagBotoes.B2) parametro--;
       if(flagBotoes.B2) duty--;
     } // end if decrementa && flagBotoes.B0

     if(incrementa && flagBotoes.B1){

       flagBotoes.B1 = 0x00;
       TMR1ON_bit = 0x00;
       TMR1L = 0xB0;
       TMR1H = 0x3C;
       cont = 0x00;
       if(!flagBotoes.B2) parametro++;
       if(flagBotoes.B2) duty++;;
     } // end incrementa && flagBotoes.B1

} // end void leitura_Botoes

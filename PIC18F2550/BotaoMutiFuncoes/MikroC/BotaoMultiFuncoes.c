/* 

        O objetivo deste programa � implementar um bot�o multi fun��es a partir do timer0. Isto �, um �nico bot�o controlar� dois processos, neste
     exemplo, simples. Uma fun��o � trocar o estado de um led e a outra � incrementar o duty cicle de outro led.
        O timer0 � usado para temporizar mas ainda n�o faz interrup��es, e sua rotina acontece dentro do loop infinito, dentro da fun��o principal.

        O bot�o deste projeto estar� ligado direto no pino RB7, que estar� configurado com o pull-up habilitado.

        Para uma temporiza��o 250ms, temos que calcular em qual n�mero a contagem do timer0 ir� come�ar. Para isso, definimoso prescaler em 32 e o
     ciclo de m�quna j� esta definido, uma vez que o oscilador � de 16MHz.

        Tempo de contagem = contagem * prescaler * ciclo de maquina
              250ms       = contagem * 32 * 250ns
              contagem =    250ms
                        -------------
                         32 * 250ns

              contagem = 31250
              
        Ap�s alguns ajustes contra a interfer�ncia do bot�o, o cicruito funcionou perfeitamente na pr�tica. O proteus n�o consegue rodar o PWM, por
    isso a simula��o n�o foi poss�vel.
        O ajuste feito foi colocar um "else", caso o bot�o n�o fique pressionado por muito tempo, para zerar a vari�vel cont, pois ela estava
    incrementando por causa da interfer�ncia do bot�o e com o tempo mudava de fun��o por chegar � 8. Mas essa o "else" resolveu.

*/

// Mapeamento de hardware
#define led LATB0_bit
#define botao RB7_bit

// Fun��es auxiliares
void leitura_Botao();

// Vari�veis auxiliares
bit flagBotao;
bit ativaAjuste;
unsigned short duty = 128;
unsigned short cont = 0x00;
unsigned short i;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que podem ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     LATB = 0xFE; // Inicia todas as sa�das digiais em Low, no caso, somente LATB0
     
     INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entradas do portb
     
     T0CON = 0x84; // Habilita o timer0, configura com 16 bits, incremento por ciclo de m�quina e prescaler de 1:32
     TMR0L = 0xEE; // Inicia <TMR0H::TMR0L> para contar 31250
     TMR0H = 0x85;
     
     flagBotao = 0;
     ativaAjuste = 0;
     
     PWM1_Init(1500);
     PWM1_Start();
     
     // Loop infinito
     while(1){
     
       if(TMR0IF_bit){
       
         TMR0IF_bit = 0x00;
         TMR0L = 0xEE;
         TMR0H = 0x85;
         
         if(!botao && flagBotao) cont++;
         else cont = 0x00; // Necess�rio para evitar a troca de fun��o por interfer�ncia do bot�o
         
         if(cont == 0x08){
         
           cont = 0x00;
           ativaAjuste = ~ativaAjuste;
           
           for(i = 0x00; i < 0x0A; i++){
           
             led = ~led;
             delay_ms(50);
         
           } // end for i = 0x00; i < 0x0A; i++
           
           led = 0x00;
         
         } // end if cont == 0x04
       
       } // end if TMR0IF_bit
     
       leitura_Botao();
       PWM1_Set_Duty(duty);
       


     } // end Loop infinito

} // end void main


void leitura_Botao(){

     if(!botao) flagBotao = 0x01;
     
     if(botao && flagBotao){
     
       flagBotao = 0x00;
       
       if(ativaAjuste) duty += 0x0A; // 0x0A(hexadecimal) = 10(decimal)
       else led = ~led;
     
     } // end if botao && flagBotao

} // end void leitura_Botao





















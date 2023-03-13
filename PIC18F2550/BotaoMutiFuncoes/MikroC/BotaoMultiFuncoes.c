/* 

        O objetivo deste programa é implementar um botão multi funções a partir do timer0. Isto é, um único botão controlará dois processos, neste
     exemplo, simples. Uma função é trocar o estado de um led e a outra é incrementar o duty cicle de outro led.
        O timer0 é usado para temporizar mas ainda não faz interrupções, e sua rotina acontece dentro do loop infinito, dentro da função principal.

        O botão deste projeto estará ligado direto no pino RB7, que estará configurado com o pull-up habilitado.

        Para uma temporização 250ms, temos que calcular em qual número a contagem do timer0 irá começar. Para isso, definimoso prescaler em 32 e o
     ciclo de máquna já esta definido, uma vez que o oscilador é de 16MHz.

        Tempo de contagem = contagem * prescaler * ciclo de maquina
              250ms       = contagem * 32 * 250ns
              contagem =    250ms
                        -------------
                         32 * 250ns

              contagem = 31250
              
        Após alguns ajustes contra a interferência do botão, o cicruito funcionou perfeitamente na prática. O proteus não consegue rodar o PWM, por
    isso a simulação não foi possível.
        O ajuste feito foi colocar um "else", caso o botão não fique pressionado por muito tempo, para zerar a variável cont, pois ela estava
    incrementando por causa da interferência do botão e com o tempo mudava de função por chegar à 8. Mas essa o "else" resolveu.

*/

// Mapeamento de hardware
#define led LATB0_bit
#define botao RB7_bit

// Funções auxiliares
void leitura_Botao();

// Variáveis auxiliares
bit flagBotao;
bit ativaAjuste;
unsigned short duty = 128;
unsigned short cont = 0x00;
unsigned short i;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que podem ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     LATB = 0xFE; // Inicia todas as saídas digiais em Low, no caso, somente LATB0
     
     INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entradas do portb
     
     T0CON = 0x84; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler de 1:32
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
         else cont = 0x00; // Necessário para evitar a troca de função por interferência do botão
         
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





















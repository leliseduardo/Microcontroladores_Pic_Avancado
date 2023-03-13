/* 

      Este programa tem a fun��o de apresenta a amostragem do conversor AD. Para isso ser� configurado o registrador ADCON2 que, geralmente
    n�o necessita ser configurado. Este registrador configura o tempo de aquisi��o e reten��o do conversor AD. Logo, ser� mostrado que para
    sinais de frequ�ncias altas, o conversor AD n�o consegue fazer a leitura, devido � sua limita��o de tempo de aquisi��o e seu alto tempo
    de reten��o para altas frequ�ncias, o que impossibilita uma boa precis�o de leitura para altas frequ�ncias.
      O circuito de amostragem e reten��o foi estudado em uma aula do WRKits, as anota��es sobre este circuito est�o no caderno. Este tipo
    de circuito tem a fun��o de receber um sinal anal�gico e, a partir de um sinal digital amostrador, fazer a amostragem do sinal anal�gico
    digitalmente. Por�m, se n�o hover uma aquisi��o precisa do sinal anal�gico, a amostragem se torna imprecisa e a convers�o n�o funciona.
      O TAD configurado no registrador ADCON2 nada mais � do que o tempo de amostragem do circuito de amostragem e reten��o interno do pic,
    que faz parte do conversor AD interno. Nele, configura-se o tempo de convers�o, que equivale ao tempo do amostrador e, tamb�m, configu-
    ra-se o tempo de reten��o. Os bits ADCS do ADCON2 s�o respons�veis pela configura��o do tempo do amostrador, que � calculado da seguinte
    forma, por exemplo:
           Se ADCS = 000, ent�o Fosc/2
           Tempo de convers�o = tempo do amostrador = Clock/2 = 4MHz/2
           Se ADCS = 110, ent�o Fosc/64
           Tempo de convers�o = tempo do amostrador = Clock/64 = 4MHz/64
    Assim, configura-se o tempo TAD, que � o tempo de amostragem.

      A partir disso, configura-se o tempo de renten��o pelos bits ACQT, que calculam o tempo de reten��o a partir do tempo de amostragem
    (TAD). Por exemplo:
           Se ACQT = 001, ent�o 2TAD
           Logo, o tempo de reten��o � 2 x TAD, calculado nos bits ADCS
           
      Apesar de tudo, essa aula d� apenas uma explica��o superficial do circuito de amostragem e reten��o do conversor AD, para aprofundar
    mais neste assunto � necess�rio estudar conversores AD que possuem este circuito ou, ainda, estudar o curso de Assembly para pic, onde
    essas configura��es de baixo n�vel s�o vistas com mais profundidade.
    
*/

// Configura��o de hardware

#define saida LATB0_bit

// Vari�veis auxiliares

int adc = 0x00;

void main() {

     // Configura��o dos registradores do adc
     
     ADCON0 = 0x01; // Habilita AN0 como canal anal�gico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de convers�o de VSS � VDD e configura apenas AN0 como porta anal�gica
     ADCON2 = 0b000000110; // Configura o tempo de amostragem como 4MHz/64 e o tempo de reten��o 0

     // Registradores dos ports
     
     TRISA = 0xFF; // Configura todo porta como entrada
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital
     LATB = 0x00; // Inicia todas as sa�das digitais do portb em Low
     
     // Loop infinito
     
     while(1){
     
       adc = adc_Read(0);
       
       if(adc > 512) saida = 0x01;
       
       else saida = 0x00;
     } // end while
} // end void main











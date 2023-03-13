/* 

      Este programa tem a função de apresenta a amostragem do conversor AD. Para isso será configurado o registrador ADCON2 que, geralmente
    não necessita ser configurado. Este registrador configura o tempo de aquisição e retenção do conversor AD. Logo, será mostrado que para
    sinais de frequências altas, o conversor AD não consegue fazer a leitura, devido à sua limitação de tempo de aquisição e seu alto tempo
    de retenção para altas frequências, o que impossibilita uma boa precisão de leitura para altas frequências.
      O circuito de amostragem e retenção foi estudado em uma aula do WRKits, as anotações sobre este circuito estão no caderno. Este tipo
    de circuito tem a função de receber um sinal analógico e, a partir de um sinal digital amostrador, fazer a amostragem do sinal analógico
    digitalmente. Porém, se não hover uma aquisição precisa do sinal analógico, a amostragem se torna imprecisa e a conversão não funciona.
      O TAD configurado no registrador ADCON2 nada mais é do que o tempo de amostragem do circuito de amostragem e retenção interno do pic,
    que faz parte do conversor AD interno. Nele, configura-se o tempo de conversão, que equivale ao tempo do amostrador e, também, configu-
    ra-se o tempo de retenção. Os bits ADCS do ADCON2 são responsáveis pela configuração do tempo do amostrador, que é calculado da seguinte
    forma, por exemplo:
           Se ADCS = 000, então Fosc/2
           Tempo de conversão = tempo do amostrador = Clock/2 = 4MHz/2
           Se ADCS = 110, então Fosc/64
           Tempo de conversão = tempo do amostrador = Clock/64 = 4MHz/64
    Assim, configura-se o tempo TAD, que é o tempo de amostragem.

      A partir disso, configura-se o tempo de rentenção pelos bits ACQT, que calculam o tempo de retenção a partir do tempo de amostragem
    (TAD). Por exemplo:
           Se ACQT = 001, então 2TAD
           Logo, o tempo de retenção é 2 x TAD, calculado nos bits ADCS
           
      Apesar de tudo, essa aula dá apenas uma explicação superficial do circuito de amostragem e retenção do conversor AD, para aprofundar
    mais neste assunto é necessário estudar conversores AD que possuem este circuito ou, ainda, estudar o curso de Assembly para pic, onde
    essas configurações de baixo nível são vistas com mais profundidade.
    
*/

// Configuração de hardware

#define saida LATB0_bit

// Variáveis auxiliares

int adc = 0x00;

void main() {

     // Configuração dos registradores do adc
     
     ADCON0 = 0x01; // Habilita AN0 como canal analógico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão de VSS à VDD e configura apenas AN0 como porta analógica
     ADCON2 = 0b000000110; // Configura o tempo de amostragem como 4MHz/64 e o tempo de retenção 0

     // Registradores dos ports
     
     TRISA = 0xFF; // Configura todo porta como entrada
     TRISB = 0xFE; // Configura apenas RB0 como saída digital
     LATB = 0x00; // Inicia todas as saídas digitais do portb em Low
     
     // Loop infinito
     
     while(1){
     
       adc = adc_Read(0);
       
       if(adc > 512) saida = 0x01;
       
       else saida = 0x00;
     } // end while
} // end void main











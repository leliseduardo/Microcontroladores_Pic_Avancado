/*
 *      O objetivo deste programa é demonstrar a configuração de uma entrada digital no portb. Para configurar corretamente uma
 *  entrada neste port, deve-se configurar o fuse PBADEN, o colocando em OFF. Este fuse é responsável por habilitar o conversor
 *  AD no portb, dos pinos RB4 à RB0.
 *     
 *      Na prática, o circuito e o programa funcionaram perfeitamente. Ainda, constatou-se que, para configurar uma entrada
 *  digital e desabilitar os conversores AD, pode-se também utilizar o registrador ADCON1, assim como eu fazia no MikroC, nas
 *  aulas do canal WRKits. Pode-se utilizar a configuração do ADCON1 sem configurar o PBADEN, configurar ambos, ou configurar
 *  somente o PBADEN. Ambos funcionam para configurar entradas digitais do portb.
 *      A diferença entre o configurar o PBADEN e o ADCON1, é que o PBADEN controla somente as entradas analógicas do portb,
 *  enquanto o ADCON1 controla todas as entradas analógicas do Pic. Logo, se eu quisesse utilizar uma entrada digital no
 *  PORTA, por exemplo, o PBADEN não desabilitaria o conversor AD e a entrada não funcionaria como digital. Para o PORTA,
 *  apenas o ADCON1 funciona. Porém, ter um fuse como o PBADEN dá mais opções de configuração e isso nunca é inútil.
 */

// Inclusões
#include    "config.h"
#include    <xc.h>

// Variáveis e constantes
#define     _XTAL_FOSC 8000000

bit     botao1 = 0b0;

// Protótipo de funções
void setup();
void delay_ms(unsigned int tempo);

void setup(){

    OSCCON = 0b11111110; // Configura um clock interno de 8MHz e seleciona o oscilador interno
    
    //ADCON1 = 0b00001111; // Configura todas as portas que poderiam ser analógicas como digitais
    
    TRISB = 0b01111111; // Configura apenas RB7 como saída digital, o resto como entrada
    // TRISB4 = 0b1; Uma forma alternativa para configurar um bit de um registrador
    LATB7 = 0b0;        // Inicia LATB7 em Low
    
} // end void setup

void main(void) {
    
    setup();
    
    botao1 = PORTBbits.RB0;
    
    if(botao1)
        LATB7 = 1;
    else
        LATB7 = 0;
    
} // end void main

void delay_ms(unsigned int tempo){
    
    unsigned int    i;
    unsigned long   j;
    
    for(i = 0; i < tempo; i++){
        for(j = 0; j < _XTAL_FOSC/65500; j++);
    }

} // end void delay_ms
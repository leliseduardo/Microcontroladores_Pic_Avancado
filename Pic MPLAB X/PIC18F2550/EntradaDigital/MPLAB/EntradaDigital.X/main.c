/*
 *      O objetivo deste programa � demonstrar a configura��o de uma entrada digital no portb. Para configurar corretamente uma
 *  entrada neste port, deve-se configurar o fuse PBADEN, o colocando em OFF. Este fuse � respons�vel por habilitar o conversor
 *  AD no portb, dos pinos RB4 � RB0.
 *     
 *      Na pr�tica, o circuito e o programa funcionaram perfeitamente. Ainda, constatou-se que, para configurar uma entrada
 *  digital e desabilitar os conversores AD, pode-se tamb�m utilizar o registrador ADCON1, assim como eu fazia no MikroC, nas
 *  aulas do canal WRKits. Pode-se utilizar a configura��o do ADCON1 sem configurar o PBADEN, configurar ambos, ou configurar
 *  somente o PBADEN. Ambos funcionam para configurar entradas digitais do portb.
 *      A diferen�a entre o configurar o PBADEN e o ADCON1, � que o PBADEN controla somente as entradas anal�gicas do portb,
 *  enquanto o ADCON1 controla todas as entradas anal�gicas do Pic. Logo, se eu quisesse utilizar uma entrada digital no
 *  PORTA, por exemplo, o PBADEN n�o desabilitaria o conversor AD e a entrada n�o funcionaria como digital. Para o PORTA,
 *  apenas o ADCON1 funciona. Por�m, ter um fuse como o PBADEN d� mais op��es de configura��o e isso nunca � in�til.
 */

// Inclus�es
#include    "config.h"
#include    <xc.h>

// Vari�veis e constantes
#define     _XTAL_FOSC 8000000

bit     botao1 = 0b0;

// Prot�tipo de fun��es
void setup();
void delay_ms(unsigned int tempo);

void setup(){

    OSCCON = 0b11111110; // Configura um clock interno de 8MHz e seleciona o oscilador interno
    
    //ADCON1 = 0b00001111; // Configura todas as portas que poderiam ser anal�gicas como digitais
    
    TRISB = 0b01111111; // Configura apenas RB7 como sa�da digital, o resto como entrada
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
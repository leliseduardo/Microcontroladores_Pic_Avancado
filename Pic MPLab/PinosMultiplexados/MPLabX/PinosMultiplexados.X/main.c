/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 11:05
 */


/*
 
 Este programa tem a função de demonstrar que um pino pode ter mais de uma função e, por vezes, a função padrão
 não ser de I/O. Assim, deve-se desabilitar a função padrão para que se consiga utiliza-la como I/O.
 Como exemplo, tem-se o RC4, que é utlizado como padrão para comunicação USB. Porém, desabilitando essa comunicação
 pode-se utilizar o RC4 como entrada digital.
 
 Na simulação e na prática o circuito e o programa funcionaram perfeitamente. 
 
 */

// Definições
#define _XTAL_FREQ 16000000

// Inclusão de bibliotecas
#include <xc.h>
#include "config.h"

// Protótipos de funções auxiliares
void setup();

// Função de configuração
void setup(){
    
    // Configuração de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110100;
    
    // Configuração de USB
    UCFGbits.UTRDIS = 0b1; // Desabilita a transmissão de dados USB e ativa a entrada digital em RC4
    
    // Configuração de portas
    TRISBbits.RB7 = 0;
} // end void setup

// Função principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = PORTCbits.RC4;
        
    } // end loop infinito
} // end void main

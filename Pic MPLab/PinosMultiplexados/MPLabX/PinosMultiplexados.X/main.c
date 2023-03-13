/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 11:05
 */


/*
 
 Este programa tem a fun��o de demonstrar que um pino pode ter mais de uma fun��o e, por vezes, a fun��o padr�o
 n�o ser de I/O. Assim, deve-se desabilitar a fun��o padr�o para que se consiga utiliza-la como I/O.
 Como exemplo, tem-se o RC4, que � utlizado como padr�o para comunica��o USB. Por�m, desabilitando essa comunica��o
 pode-se utilizar o RC4 como entrada digital.
 
 Na simula��o e na pr�tica o circuito e o programa funcionaram perfeitamente. 
 
 */

// Defini��es
#define _XTAL_FREQ 16000000

// Inclus�o de bibliotecas
#include <xc.h>
#include "config.h"

// Prot�tipos de fun��es auxiliares
void setup();

// Fun��o de configura��o
void setup(){
    
    // Configura��o de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110100;
    
    // Configura��o de USB
    UCFGbits.UTRDIS = 0b1; // Desabilita a transmiss�o de dados USB e ativa a entrada digital em RC4
    
    // Configura��o de portas
    TRISBbits.RB7 = 0;
} // end void setup

// Fun��o principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = PORTCbits.RC4;
        
    } // end loop infinito
} // end void main

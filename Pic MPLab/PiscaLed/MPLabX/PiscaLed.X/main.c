/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 12 de Janeiro de 2021, 19:48
 */

/* 
 
 Este programa tem o objetivo de piscar um led e dmeonstrar como se manipula os registradores de entrada e
 sa�da de um pic.
 
 Na simula��o e na pr�tica o circuito e o programa funcionaram como esperado.
 
 */

// Defini��es
#define _XTAL_FREQ 8000000

// Inclus�o de bibliotecas
#include <xc.h>
#include "config.h"

// Pror�tipo de fun��es auxiliares
void setup();

// Fun��o de configura��o
void setup(){
    
    // Registradores de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110111;
    
    // Registradores de ports
    TRISBbits.RB7 = 0;
          
} // end void setup

// Fun��o principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = !LATBbits.LATB7;
        __delay_ms(1000);
    } // end loop infinito
}

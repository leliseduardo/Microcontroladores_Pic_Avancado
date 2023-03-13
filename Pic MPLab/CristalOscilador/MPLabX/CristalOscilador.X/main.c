/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 12 de Janeiro de 2021, 22:24
 */

/* 
 
 Este programa tem a fun��o de demonstrar como configurar o Pic para utilizar o cristal oscilador externo.
 
 Na simula��o e na pr�tica o circuito e o programa funcionaram como esperado.
 
 */

// Defini��es
#define _XTAL_FREQ 12000000

// Inclus�o de bibliotecas
#include <xc.h>
#include "config.h"

// Prot�tipo de fun��es auxiliares
void setup();


// Fun��o de configura��o
void setup(){
    
    // Registradores de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110100;
    
    // Registradores de ports
    TRISBbits.RB7 = 0;
} // end void setup


// Fun��o principal
void main(void) {
    
    setup();
    
    //Loop infinito
    while(1){
        
        LATBbits.LATB7 = !LATBbits.LATB7;
        __delay_ms(1000);
    } // end while
} // end void main

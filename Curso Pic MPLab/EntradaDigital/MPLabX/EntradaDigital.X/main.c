/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 10:24
 */

/* 
 
 Este programa tem a fun��o de demonstrar a configura��o de uma entrada digital.
 
 Na simula��o de na pr�tica o programa funcionou perfeitamente. Na pr�tica o mcu s� funciona satisfat�riamente 
 quando s�o configurados os fuses b�sicos, desligando o LVP, BOR (Brown-Out) e WDT. 
 
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
    
    // Configura��o de portas
    TRISBbits.RB7 = 0;
    TRISBbits.RB6 = 1;
    
    // TRISB = 0b01000000 pode ser uma alternativa de configura��o do portb
    
} // end void setup

// Fun��o principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = PORTBbits.RB6;
        
    } // end loop infinito
} // end void main


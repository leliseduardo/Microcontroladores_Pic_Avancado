/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 12 de Janeiro de 2021, 19:48
 */

/* 
 
 Este programa tem o objetivo de piscar um led e dmeonstrar como se manipula os registradores de entrada e
 saída de um pic.
 
 Na simulação e na prática o circuito e o programa funcionaram como esperado.
 
 */

// Definições
#define _XTAL_FREQ 8000000

// Inclusão de bibliotecas
#include <xc.h>
#include "config.h"

// Prorótipo de funções auxiliares
void setup();

// Função de configuração
void setup(){
    
    // Registradores de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110111;
    
    // Registradores de ports
    TRISBbits.RB7 = 0;
          
} // end void setup

// Função principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = !LATBbits.LATB7;
        __delay_ms(1000);
    } // end loop infinito
}

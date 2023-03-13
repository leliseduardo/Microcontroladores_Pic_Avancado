/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 10:24
 */

/* 
 
 Este programa tem a função de demonstrar a configuração de uma entrada digital.
 
 Na simulação de na prática o programa funcionou perfeitamente. Na prática o mcu só funciona satisfatóriamente 
 quando são configurados os fuses básicos, desligando o LVP, BOR (Brown-Out) e WDT. 
 
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
    
    // Configuração de portas
    TRISBbits.RB7 = 0;
    TRISBbits.RB6 = 1;
    
    // TRISB = 0b01000000 pode ser uma alternativa de configuração do portb
    
} // end void setup

// Função principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = PORTBbits.RB6;
        
    } // end loop infinito
} // end void main


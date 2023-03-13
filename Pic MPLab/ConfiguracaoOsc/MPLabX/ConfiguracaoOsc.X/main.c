/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 12 de Janeiro de 2021, 17:46
 */

/* 
 
 Este programa tem a fun��o de demonstrar como configurar o clock interno do Pic em 8MHz
 
 */

// Inclus�o de bibliotecas
#include <xc.h>
#include "config.h"

// Prot�tipo de fun��es 
void setup();

// Fun��es de configura��o
void setup(){
    
    OSCTUNE = 0b10001111; // Ou 0x8F, configura o clock de 31KHz interno(clock m�nimo) a partir do clock interno de 8MHz
    OSCCON = 0b11110111; // Ou 0xF7, Configura o clock como interno de 8MHz e inicializa��o est�vel do mcu
} // end void setup

// Fun��o principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        
    }// end loop infinito
} // end void main




















/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 12 de Janeiro de 2021, 17:46
 */

/* 
 
 Este programa tem a função de demonstrar como configurar o clock interno do Pic em 8MHz
 
 */

// Inclusão de bibliotecas
#include <xc.h>
#include "config.h"

// Protótipo de funções 
void setup();

// Funções de configuração
void setup(){
    
    OSCTUNE = 0b10001111; // Ou 0x8F, configura o clock de 31KHz interno(clock mínimo) a partir do clock interno de 8MHz
    OSCCON = 0b11110111; // Ou 0xF7, Configura o clock como interno de 8MHz e inicialização estável do mcu
} // end void setup

// Função principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        
    }// end loop infinito
} // end void main




















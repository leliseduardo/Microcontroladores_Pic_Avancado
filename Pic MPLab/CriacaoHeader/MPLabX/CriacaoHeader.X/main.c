/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 12:26
 */

/*
 
 Este programa tem a função de demonstrar como utilizar um arquivo Header, que irá auxiliar no agrupamento de 
 funções de uma mesma aplicação. Esse agrupamento de funções para uma mesma aplicação é denominada biblioteca. Logo,
 a partir desses headers serão criadas bibliotecas em C++, que tornarão o código principal mais limpo e mais intuitivo,
 evitando repetição de código e escondendo funções que serão utilizadas diversas vezes. Ainda, com a criação de tais
 bibliotecas, será possível reaproveitar o código e evitar a reprogramação de uma lógica já criada, para uso em 
 outros projetos.  
 
 */

// Inclusão de bibliotecas
#include "MCU_H.h"
#include "DELAY_H.h"
#include "config.h"

// Protótipo de funções auxiliares
void setup();

// Função de configuração
void setup(){
    
    // Configuração de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110100;
    
    // Configuração de portas
    TRISBbits.RB7 = 0;
    TRISBbits.RB6 = 1;
} // end void setup

void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = !LATBbits.LATB7;
        delay_ms(1000);
    } // end while
} // end void main

/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 12:26
 */

/*
 
 Este programa tem a fun��o de demonstrar como utilizar um arquivo Header, que ir� auxiliar no agrupamento de 
 fun��es de uma mesma aplica��o. Esse agrupamento de fun��es para uma mesma aplica��o � denominada biblioteca. Logo,
 a partir desses headers ser�o criadas bibliotecas em C++, que tornar�o o c�digo principal mais limpo e mais intuitivo,
 evitando repeti��o de c�digo e escondendo fun��es que ser�o utilizadas diversas vezes. Ainda, com a cria��o de tais
 bibliotecas, ser� poss�vel reaproveitar o c�digo e evitar a reprograma��o de uma l�gica j� criada, para uso em 
 outros projetos.  
 
 */

// Inclus�o de bibliotecas
#include "MCU_H.h"
#include "DELAY_H.h"
#include "config.h"

// Prot�tipo de fun��es auxiliares
void setup();

// Fun��o de configura��o
void setup(){
    
    // Configura��o de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110100;
    
    // Configura��o de portas
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

/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 09:47
 */

/* 
 
 Este programa tem o onjetivo de configurar o uso do cristal oscilador externo juntamente com o PLL interno do mcu
 
 Na simula��o e na pr�tica o circuito e programa funcionaram como esperado, na pr�tica, com algmas interfer�ncias
 provavelmente por causa da protoboard.
 N�o era interfer�ncia da protoboar, e sim por eu n�o ter configurado todos os fuses b�sicos do Pic. � necess�rio
 desabiliar o fuse BOR (Brown-Out Detect). Por algum motivo ele n�o deixava o Pic funcionar satisfat�riamente 
 quando ativado.
 Fazendo essa altera��o, na pr�tica o circuito funciona perfeitamente.
  
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
    
} // end void setup

// Fun��o principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = !LATBbits.LATB7;
        __delay_ms(1000);
    } // end loop infinito
} // end void main

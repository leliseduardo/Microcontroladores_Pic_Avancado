/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 09:47
 */

/* 
 
 Este programa tem o onjetivo de configurar o uso do cristal oscilador externo juntamente com o PLL interno do mcu
 
 Na simulação e na prática o circuito e programa funcionaram como esperado, na prática, com algmas interferências
 provavelmente por causa da protoboard.
 Não era interferência da protoboar, e sim por eu não ter configurado todos os fuses básicos do Pic. è necessário
 desabiliar o fuse BOR (Brown-Out Detect). Por algum motivo ele não deixava o Pic funcionar satisfatóriamente 
 quando ativado.
 Fazendo essa alteração, na prática o circuito funciona perfeitamente.
  
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
    
} // end void setup

// Função principal
void main(void) {
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = !LATBbits.LATB7;
        __delay_ms(1000);
    } // end loop infinito
} // end void main

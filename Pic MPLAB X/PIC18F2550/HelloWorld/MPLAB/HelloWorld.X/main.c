/*
 *
 *      O objetivo deste programa é fazer um led piscar e dar introdução ao curso
 * 
 *      Na simulação e na prática o programa e o circuito funcionaram perfeitamente.
 * 
 */

// Bibliotecas

#include "config.h"
#include <xc.h>

// Definições

#define _XTAL_FREQ  8000000

// Protótipo de funções

void setup();
void delay_ms(unsigned int tempo);

void setup(){

    OSCCON = 0b11111010; // Configura clock interno de 8MHz, configura que o mcu aguarde a estabilização do crystal osc
    TRISB = 0b00000000; // Configura todo o portd como saída digital
    // TRISD6 = 0b1, por exemplo, configura apenas um bit como entrada ou saída
    
} // end void setup

void main(void) {
    
    setup();
    
    while(1){
    
        LATB0 = 0b1;
        delay_ms(200);
        LATB0 = 0b0;
        delay_ms(200);
    
    } // end loop infinito
    
}

void delay_ms(unsigned int tempo){

    unsigned int i;
    unsigned long j;
    
    for(i = 0; i < tempo; i++){
        for(j = 0; j < _XTAL_FREQ/65500; j++);
    }

} // end void delay_ms
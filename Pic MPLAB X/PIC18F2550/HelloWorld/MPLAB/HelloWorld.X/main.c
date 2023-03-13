/*
 *
 *      O objetivo deste programa � fazer um led piscar e dar introdu��o ao curso
 * 
 *      Na simula��o e na pr�tica o programa e o circuito funcionaram perfeitamente.
 * 
 */

// Bibliotecas

#include "config.h"
#include <xc.h>

// Defini��es

#define _XTAL_FREQ  8000000

// Prot�tipo de fun��es

void setup();
void delay_ms(unsigned int tempo);

void setup(){

    OSCCON = 0b11111010; // Configura clock interno de 8MHz, configura que o mcu aguarde a estabiliza��o do crystal osc
    TRISB = 0b00000000; // Configura todo o portd como sa�da digital
    // TRISD6 = 0b1, por exemplo, configura apenas um bit como entrada ou sa�da
    
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
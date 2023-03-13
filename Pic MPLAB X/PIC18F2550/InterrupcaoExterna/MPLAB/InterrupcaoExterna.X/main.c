/*
 *      O objetivo deste programa é demonstrar como configurar a interrupção externa INT0 e, a partir dela, acender um led.
 * 
 *      Neste código são exemplificadas várias formas de se expressar um bit ou um byte, tanto em número binários como em 
 *  hexadecimais.  
 * 
 *      Após muitas tentativa tentando fazer funcionar, o programa só funcionou na prática quando desabilitei o LVP, ou 
 *  Low Voltage Program. Não sei o motivo, mas vou descobrir.
 * 
 *      Neste programa eu percebi a importância de se configurar todos os fuses mais importantes, que geralmente eu já progra-
 *  mava.
 * 
 *      Na simulação e na prática o programa e o circuito funcionaram como esperado.   
 * 
 */

// Inclusões
#include "PicLibs.h"
#include "config.h"
#include <xc.h>

// Protótipo de funções
void setup();

void setup(){

    ADCON1 = 0b00001111;       // Configura todas as portas que poderiam ser analógicas como digitais
    OSCCON = 0b11111110; // Configura um clock interno de 8MHz e seleciona o oscilador interno
    TRISB = 0b00111111; // Configura apenas RB7 e RB6 como saídas digitais, o resto como entrada
    LATB7 = 0b0;        // Inicia LATB7 em Low
    LATB6 = 0b0;        // Inicia LATB6 em Low
    
    INTCON = 0b10010000;      // Habilita a interrupção global e por periféricos
    INTCON2 = 0b10000000;     // Desabilita os pull-ups internos e configura a interrupção externa INT0 por borda de descida
    
} // end void setup

void interrupt TripaSeca(){

    if(INT0IF){                 // Testa se a flag de interrupção INT0IF setou
        
        INT0IF = 0;          // Limpa a flag de interrupção INT0IF
        
        LATB6 = 1;           
        delay_ms(2000);
        LATB6 = 0;
    
    } // end if INT0IF

} // end void interrupt TripaSeca

void main(void) {
    
    setup();
    
    while(1){
        
        LATB7 = !LATB7;
        delay_ms(220);
    
    } // end loop infinito
    
} // end void main

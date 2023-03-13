/*
 *      O objetivo deste programa � demonstrar como configurar a interrup��o externa INT0 e, a partir dela, acender um led.
 * 
 *      Neste c�digo s�o exemplificadas v�rias formas de se expressar um bit ou um byte, tanto em n�mero bin�rios como em 
 *  hexadecimais.  
 * 
 *      Ap�s muitas tentativa tentando fazer funcionar, o programa s� funcionou na pr�tica quando desabilitei o LVP, ou 
 *  Low Voltage Program. N�o sei o motivo, mas vou descobrir.
 * 
 *      Neste programa eu percebi a import�ncia de se configurar todos os fuses mais importantes, que geralmente eu j� progra-
 *  mava.
 * 
 *      Na simula��o e na pr�tica o programa e o circuito funcionaram como esperado.   
 * 
 */

// Inclus�es
#include "PicLibs.h"
#include "config.h"
#include <xc.h>

// Prot�tipo de fun��es
void setup();

void setup(){

    ADCON1 = 0b00001111;       // Configura todas as portas que poderiam ser anal�gicas como digitais
    OSCCON = 0b11111110; // Configura um clock interno de 8MHz e seleciona o oscilador interno
    TRISB = 0b00111111; // Configura apenas RB7 e RB6 como sa�das digitais, o resto como entrada
    LATB7 = 0b0;        // Inicia LATB7 em Low
    LATB6 = 0b0;        // Inicia LATB6 em Low
    
    INTCON = 0b10010000;      // Habilita a interrup��o global e por perif�ricos
    INTCON2 = 0b10000000;     // Desabilita os pull-ups internos e configura a interrup��o externa INT0 por borda de descida
    
} // end void setup

void interrupt TripaSeca(){

    if(INT0IF){                 // Testa se a flag de interrup��o INT0IF setou
        
        INT0IF = 0;          // Limpa a flag de interrup��o INT0IF
        
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

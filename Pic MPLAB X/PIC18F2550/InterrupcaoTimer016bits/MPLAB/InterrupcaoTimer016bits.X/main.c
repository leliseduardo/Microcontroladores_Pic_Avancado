/* 
 *      Este programa tem a fun��o de configurar o timer 0 com 16 bits. Para isso, assim como no �ltimo projeto ser� usado o 
 *  display e o conversor AD junto com o timer 0 16 bits. O �ltimo programa foi o "InterrupcaoTimer0", onde se usou o timer 0
 *  com 8bits.     
 * 
 *      A simula��o e o programa funcionaram como esperado.
 * 
 */

// Inclus�es 
#include "PICLibs.h"
#include "config.h"
#include <xc.h>

// Vari�veis auxiliares
unsigned int valorADC = 0;

// Prot�tipo de fun��es
void setup();

void setup(){
    
    OSCCON = 0b11111110;        // Configura um clock interno de 8MHz e seleciona o oscilador interno
    INTCON = 0xE0;              // Habilita a interrup��o global, por perif�ricos e a interrup��o por overflow do timer0
    T0CON = 0x80;               // Modo 16bits, prescaler 1:256, incrementa pelo ciclo de m�quina e habilita o timer0
    TRISA = 0xFF;               // Configura todo porta como entrada
    TRISC = 0X7F;               // Configura apenas RC7 como sa�da digital
    LATC7 = 0x00;
    
    ADC_Inicializa(0);
    valorADC = leitura_ADC(0)*64;
    TMR0H = (valorADC) >> 8;
    TMR0L = (valorADC & 0x00FF);
    
    LCD_Init();

} // end void setup

void interrupt TripaSeca(){

    if(TMR0IF){
    
        TMR0IF = 0x00;
        
        TMR0H = (valorADC) >> 8;
        TMR0L = (valorADC & 0x00FF);
        
        LATC7 = !LATC7;
    
    } // end if TMR0IF
    
} // end void interrupt TripaSeca

void main(void) {
    
    setup();
    
    while(1){
        
        valorADC = leitura_ADC(0)*64;
        TMR0H = (valorADC) >> 8;
        TMR0L = (valorADC & 0x00FF);
   
        LCD_String_xy(1, 2, "Valor Timer 0");
        LCD_Char_xy(2, 6, valorADC/10000 + 48);
        LCD_Char_xy(2, 7, (valorADC%10000)/1000 + 48);
        LCD_Char_xy(2, 8, (valorADC%1000)/100 + 48);
        LCD_Char_xy(2, 9, (valorADC%100)/10 + 48);
        LCD_Char_xy(2, 10, (valorADC%10) + 48);
        
    } // end loop infinito 
    
} // end void main

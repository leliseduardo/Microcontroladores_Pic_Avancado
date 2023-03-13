/* 
 *      Este programa tem a função de demonstrar como configurar o timer0 e já de inicio, fazer uma aplicação utilizando
 *  o timer0, o conversor AD e o display LCD. Para o display LCD e a o conversor AD, será utilizada a biblioteca feita no
 *  último projeto. O último projeto é denominado "DisplayLCD" e a biblioteca "PicLibs".     
 *  
 *      Na simulação o circuito e o programa funcionaram como esperado. Ainda, pode-se perceber que é possível configurar os
 *  registradores na notação hexadecimal, o que torna a programação mais fácil de escrever.     
 * 
 */

// Inclusões 
#include "PICLibs.h"
#include "config.h"
#include <xc.h>

// Variáveis auxiliares
unsigned int valorADC = 0;

// Protótipo de funções
void setup();

void setup(){
    
    OSCCON = 0b11111110;        // Configura um clock interno de 8MHz e seleciona o oscilador interno
    INTCON = 0xE0;              // Habilita a interrupção global, por periféricos e a interrupção por overflow do timer0
    T0CON = 0xC7;               // Modo 8bits, prescaler 1:256, incrementa pelo ciclo de máquina e habilita o timer0
    TRISA = 0xFF;               // Configura todo porta como entrada
    TRISC = 0X7F;               // Configura apenas RC7 como saída digital
    LATC7 = 0x00;
    
    ADC_Inicializa(0);
    valorADC = leitura_ADC(0);
    TMR0L = valorADC/4;
    
    LCD_Init();

} // end void setup

void interrupt TripaSeca(){

    if(TMR0IF){
    
        TMR0IF = 0x00;
        
        TMR0L = valorADC;
        
        LATC7 = !LATC7;
    
    } // end if TMR0IF
    
} // end void interrupt TripaSeca

void main(void) {
    
    setup();
    
    while(1){
        
        valorADC = leitura_ADC(0)/4;
   
        LCD_String_xy(1, 2, "Hello World!");
        LCD_Char_xy(2, 6, valorADC/100 + 48);
        LCD_Char_xy(2, 7, (valorADC/10)%10 + 48);
        LCD_Char_xy(2, 8, valorADC%10 + 48);
        
    } // end loop infinito 
    
} // end void main

/* 
 *      Este programa tem a função de demonstrar o funcionamento e configuração do timer0 com incremento a partir do clock 
 *  externo. Para isso, basta alterar a configuração do registrador T0CON.   
 * 
 *      Na simulação não funcionou, talvez por um problema do proteus em simular o clock externo no Pic.   
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
    T0CON = 0xA0;               // Modo 16bits, prescaler 1:2, incrementa pelo clock externo e habilita o timer0
    TRISA = 0xFF;               // Configura todo porta como entrada
    TRISC = 0X7F;               // Configura apenas RC7 como saída digital
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

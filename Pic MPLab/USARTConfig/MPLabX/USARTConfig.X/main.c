/*
 * File:   main.c
 * Author: Eduardo Lelis
 *
 * Created on 13 de Janeiro de 2021, 18:40
 */


// Inclusão de bibliotecas
#include "MCU_H.h"
#include "DELAY_H.h"
#include "config.h"
#include "USART_H.h"

// Protótipo de funções auxiliares
void setup();

// Função de configuração
void setup(){
    
    // Configuração de clock
    OSCTUNE = 0b10001111;
    OSCCON = 0b11110100;
    
    // Configuração de portas
    TRISBbits.RB7 = 0;
    TRISBbits.RB6 = 1;
    
    UCFGbits.UTRDIS = 0b1;
    
    // URAT
    INTCONbits.GIE = 0b1;
    INTCONbits.PEIE = 0b1;
    PIE1bits.RCIE = 0b1;
    
    UART_Init(9600);
    
} // end void setup

// Função de interrupção
void __interrupt() interrupcoes(void){   
    UART_Interrupt();
}

void main(void) {
    
    char temp[5];
    unsigned int LocatedADDR = 0;
    short FNSTATR = 0;
    
    setup();
    
    // Loop infinito
    while(1){
        
        LATBbits.LATB7 = !LATBbits.LATB7;
        delay_ms(1000);
        
//        UART_Write_Text_ln("Valor: ");
//        UART_Write('1');
//        UART_Write_ln('2');
        
        UART_Write_Text("Buffer: ");
        UART_Write_Text_ln(UARTBUFF);
        
       FNSTATR = UART_FindOnBuffer("LAMP1", &LocatedADDR);
       if(FNSTATR == 1){           
          UART_Write_Text_ln("Localizado");
          UART_ClearOnBuffer("LAMP1", LocatedADDR);
        }
                
    } // end while
} // end void main

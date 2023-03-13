/*
 *
 *      Biblioteca de funções
 * 
 */

#ifndef LelisPicLibs

#define LelisPicLibs

#include <xc.h>

#ifndef XTAL_FREQ
    #define _XTAL_FREQ 8000000
#endif

#ifdef __ADC_Inicializa
    extern void ADC_Inicializa(unsigned short canal);
#endif
    
#ifdef  __ADC_Leitura
    extern unsigned int ADC_Leitura(unsigned short canal);
#endif
    
#ifdef  __DELAY_MS
    extern void delay_ms(unsigned int tempo);
#endif
    
#endif      // end #ifndef LelisPicLibs
    
void ADC_Inicializa(unsigned short canal){
    
    ADCON1bits.VCFG0 = 0;                           // Configura referência de tensão positiva
    ADCON1bits.VCFG1 = 0;                           // Configura referência de tensão negativa
    ADCON1bits.PCFG = (0b1111 - (canal + 1));       // Configura quais canais serão habilitados
    ADCON2bits.ADFM = 1;                            // Configura a justificação do resultado (mais significativo à esquerda)
    ADCON2bits.ACQT = 0b1111;                       // Configura velocidade de aquisição (maior, menor precisão)
    ADCON2bits.ADCS = 0b000;                        // Configura clock de entrada do ADC
    
    // Esta função apenas inicializa os registradores do conversor AD
    
} // end void ADC_Inicializa

unsigned int ADC_Leitura(unsigned int canal){

    ADCON0bits.CHS = canal;                         // Informa o canal do conversor AD
    ADCON0bits.ADON = 1;                            // Habilita a conversão AD
    ADCON0bits.GODONE = 1;                          // Sinaliza inicialização da conversão AD
    while(ADCON0bits.GODONE);                       // Verifica se a conversão AD foi concluída
    return(ADRES);                                  // Retorna o valor discretizador
    
    // Essa função informa o canal, ativa o ADC, inicializa a leitura e, quando ela acabar, retorna o valor lido

} // end unsigned int ADC_Leitura

void delay_ms(unsigned int tempo){

    unsigned int i;
    unsigned long j;
    
    for(i = 0; i < tempo; i++){
        for(j = 0; j < _XTAL_FREQ/65500; j++);
    }

    // Essa função prende o programa no FOR para causar um delay
    
}
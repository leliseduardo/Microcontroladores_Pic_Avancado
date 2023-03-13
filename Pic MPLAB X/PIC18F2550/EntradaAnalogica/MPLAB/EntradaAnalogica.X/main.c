/*
 *      O objetivo deste programa é utilizar o conversor AD para fazer uma leitura de um potenciômetro. Para isso, será criado
 *  um arquivo .h que contém algumas funções para se usar o conversor AD. Tais funções são utilizadas para iniciar o conversor
 *  AD e não precisar fazer isso no código main.c. Esta é uma forma de abstrair o código.
 *      O professor demonstra uma forma na qual eu não conhecia de fazer uma leitura do conversor AD. Antes, no Mikro C, nos 
 *  cursos do WRKits, eu fazia a leitura do ADC utilizando a função própria do MikroC. Aqui, o professor Josias ensinou a criar
 *  essa função de leitura a partir dos registradores do ADC. Ou seja, nesta aula eu aprendi a criar uma função de leitura ADC
 *  independente de qualquer função da IDE, apenas utilizando os registradores do ADC. De quebra, o professor ensinou a criar um
 *  arquivo .h de biblioteca. Isto é, um arquivo no qual eu posso criar várias funções e para serem usadas no programa principal.
 *  Esta é uma forma de abstrair do programa a configuração de inicialização do ADC, por exemplo, e várias outras funções que 
 *  muito se utiliza em códigos para Pic.
 * 
 *      Na simulação e na prática o programa e o circuito funcionaram perfeitamente.
 */

// Inclusões
#include "PicLibs.h"
#include "config.h"
#include <xc.h>

// Variáveis e constantes


bit     botao1 = 0b0;

// Protótipo de funções
void setup();

void setup(){

    OSCCON = 0b11111110; // Configura um clock interno de 8MHz e seleciona o oscilador interno
    TRISB = 0b01111111; // Configura apenas RB7 como saída digital, o resto como entrada
    LATB7 = 0b0;        // Inicia LATB7 em Low
    
    ADC_Inicializa(0);
    
} // end void setup

void main(void) {
    
    int pot = 0;
    
    setup();
    
    pot = ADC_Leitura(0);
    
    if(pot > 512)
        LATB7 = 1;
    else
        LATB7 = 0;
    
} // end void main

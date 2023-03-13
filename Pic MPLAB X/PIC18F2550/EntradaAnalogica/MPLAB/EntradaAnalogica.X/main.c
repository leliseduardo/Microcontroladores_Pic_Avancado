/*
 *      O objetivo deste programa � utilizar o conversor AD para fazer uma leitura de um potenci�metro. Para isso, ser� criado
 *  um arquivo .h que cont�m algumas fun��es para se usar o conversor AD. Tais fun��es s�o utilizadas para iniciar o conversor
 *  AD e n�o precisar fazer isso no c�digo main.c. Esta � uma forma de abstrair o c�digo.
 *      O professor demonstra uma forma na qual eu n�o conhecia de fazer uma leitura do conversor AD. Antes, no Mikro C, nos 
 *  cursos do WRKits, eu fazia a leitura do ADC utilizando a fun��o pr�pria do MikroC. Aqui, o professor Josias ensinou a criar
 *  essa fun��o de leitura a partir dos registradores do ADC. Ou seja, nesta aula eu aprendi a criar uma fun��o de leitura ADC
 *  independente de qualquer fun��o da IDE, apenas utilizando os registradores do ADC. De quebra, o professor ensinou a criar um
 *  arquivo .h de biblioteca. Isto �, um arquivo no qual eu posso criar v�rias fun��es e para serem usadas no programa principal.
 *  Esta � uma forma de abstrair do programa a configura��o de inicializa��o do ADC, por exemplo, e v�rias outras fun��es que 
 *  muito se utiliza em c�digos para Pic.
 * 
 *      Na simula��o e na pr�tica o programa e o circuito funcionaram perfeitamente.
 */

// Inclus�es
#include "PicLibs.h"
#include "config.h"
#include <xc.h>

// Vari�veis e constantes


bit     botao1 = 0b0;

// Prot�tipo de fun��es
void setup();

void setup(){

    OSCCON = 0b11111110; // Configura um clock interno de 8MHz e seleciona o oscilador interno
    TRISB = 0b01111111; // Configura apenas RB7 como sa�da digital, o resto como entrada
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

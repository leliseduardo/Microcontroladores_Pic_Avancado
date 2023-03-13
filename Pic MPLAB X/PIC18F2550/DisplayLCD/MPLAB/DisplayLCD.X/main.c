/* 
 *      Este programa tem o objetivo de demonstrar como utilizar um display lcd de 20x4 ou 16x2. Para isso, ao invés de usar
 *  uma biblioteca pronta, o professor demonstrou como criar uma. Isso é muito interessante, visto que no MikroC eu usava a 
 *  biblioteca já pronta. Aqui tenho a possibilidade de entender como ela funciona e, ainda, entender como funciona a biblioteca
 *  do display 20x4, visto que até hoje só utilizei o 16x2, que será usado novamente na prática.
 *      A criação de bibliotecas para utilizar os periféricos é uma forma de se aproximar do hardware do microcontrolador, uma
 *  vez que é necessário, em certos casos, configurar um periférico diretamente nos registradores, ao invés de simplesmente 
 *  utilizar uma biblioteca já pronta e somente ver o resultado. No caso do display, não são configurados registradores, mas é
 *  realizada toda a coniguração de ports para que haja a comunicação e transferência de caracteres para o display, assim como
 *  a posição onde se deve escreve-los.
 *      Neste código, não irei reescrever o código da biblioteca pois é um código um pouco grande. Mas, vou renomear as funções
 *  ao meu modo, lê-las e entende-las. Assim, terei a noção do que está sendo configurado. No caso de eu precisar desta biblio-
 *  teca para um projeto prático ou profissional, basta reescreve-lo de acordo com a minha necessidade.
 * 
 *      Na simulação o circuito e o programa funcionaram perfeitamente.  
 * 
 */

// Inclusões 
#include "PICLibs.h"
#include "config.h"
#include <xc.h>

// Protótipo de funções
void setup();

void setup(){
    
    OSCCON = 0b11111110;        // Configura um clock interno de 8MHz e seleciona o oscilador interno
    
    LCD_Init();

} // end void setup

void main(void) {
    
    setup();
    
    int cont = 0;
    
    while(1){
   
        LCD_String_xy(1, 2, "Hello World!");
        LCD_Char_xy(2, 6, cont/100 + 48);
        LCD_Char_xy(2, 7, (cont/10)%10 + 48);
        LCD_Char_xy(2, 8, cont%10 + 48);
    
        cont++;
        delay_ms(1000);
        
    } // end loop infinito 
    
} // end void main

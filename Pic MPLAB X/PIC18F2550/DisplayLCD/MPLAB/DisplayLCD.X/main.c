/* 
 *      Este programa tem o objetivo de demonstrar como utilizar um display lcd de 20x4 ou 16x2. Para isso, ao inv�s de usar
 *  uma biblioteca pronta, o professor demonstrou como criar uma. Isso � muito interessante, visto que no MikroC eu usava a 
 *  biblioteca j� pronta. Aqui tenho a possibilidade de entender como ela funciona e, ainda, entender como funciona a biblioteca
 *  do display 20x4, visto que at� hoje s� utilizei o 16x2, que ser� usado novamente na pr�tica.
 *      A cria��o de bibliotecas para utilizar os perif�ricos � uma forma de se aproximar do hardware do microcontrolador, uma
 *  vez que � necess�rio, em certos casos, configurar um perif�rico diretamente nos registradores, ao inv�s de simplesmente 
 *  utilizar uma biblioteca j� pronta e somente ver o resultado. No caso do display, n�o s�o configurados registradores, mas �
 *  realizada toda a conigura��o de ports para que haja a comunica��o e transfer�ncia de caracteres para o display, assim como
 *  a posi��o onde se deve escreve-los.
 *      Neste c�digo, n�o irei reescrever o c�digo da biblioteca pois � um c�digo um pouco grande. Mas, vou renomear as fun��es
 *  ao meu modo, l�-las e entende-las. Assim, terei a no��o do que est� sendo configurado. No caso de eu precisar desta biblio-
 *  teca para um projeto pr�tico ou profissional, basta reescreve-lo de acordo com a minha necessidade.
 * 
 *      Na simula��o o circuito e o programa funcionaram perfeitamente.  
 * 
 */

// Inclus�es 
#include "PICLibs.h"
#include "config.h"
#include <xc.h>

// Prot�tipo de fun��es
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

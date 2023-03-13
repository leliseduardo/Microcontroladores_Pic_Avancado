/*

        Este programa tem a fun��o de, atrav�s do debug do MikroC, demonstrar o tempo de execu��o de cada instru��o. Nenhuma pr�tica ser� feita.
    O tempo de cada intru��o dever� responder ao ciclo de m�quina do Pic, que usa um cristal de 16MHz. Logo:
    
    ciclo de m�quina = 1 / (16MHz/4) = 250ns
    
    Um c�digo em Assembly ser� utilizado para ver a diferen�a com um c�digo em C
    
        Como previsto e demonstrado na aula, n�o nenhuma diferen�a de tempo de execu��o neste c�digo em C e em Assembly. Por�m, este c�digo � 
    simples. Num c�digo mais complexo a diferen�a do tempo de execu��o aparece, sendo o Assemblymais r�pido, por ser uma linguagem de mais baixo
    n�vel.
        O tempo levado para setar e limpar o pino LATB0 e fazer o loop foi de 4 ciclos de m�quina, ou 1us. Dois ciclos para setar e apagar e 2
    ciclos para a intru��o de loop. Isso d� uma frequ�ncia de oscila��o de:
    
        f = 1 / 1us = 1MHz
        
        Essa frequ�ncia � limitada pelo ciclo de m�quina m�nimo, que depende da frequ�ncia m�xima (no caso 16MHz/4 = 4MHz), e da intru��o de loop,
    que � uma instru��o de desvio incondicional e sempre gasta mais de um ciclo de m�quina.

*/

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     LATB0_bit = 0x00; // Inicia a sa�da LATB0 em Low
     
     /*
     while(1){
     
       LATB0_bit = 0x01;
       LATB0_bit = 0x00;
     
     } // end loop infinito
     */

     loop:
     
       asm bsf LATB,0; // No MikroC, c�digos em Assembly devem ter o "asm" na frente
       asm bcf LATB,0;
       
     goto loop;

}
/* 

        O objetivo deste programa � criar um oscilador de onda quadrada com Duty Cicle em 50%, na maior frequ�ncia poss�vel. Para isso, utiliza-se
    o c�digo do �ltimo projeto, denomina "FreqMaxOperacao". Nele foi visto a frequ�ncia m�xima de oscila��o de um pino do Pic, por�m, com a oscila
    ��o m�xima o sinal de sa�da tem o Duty diferente de 50%. Para fazer o oscilado com esse Duty deve-se compensar o gasto de dois ciclos de
    m�quina pela intru��o de loop, que faz com que o pino fique em Low por mais tempo que em High. Deve-se fazer com que o pino fique em High pelo
    mesmo tempo em que fica em Low.
        A solu��o � simples. utiliza-se duas instru��es que, no total, gastam dois ciclos de m�quina. Assim, compensa-se a demora pela intru��o
    de loop. Assim, demora-se 3 ciclos de m�quina com o pino em High e 3 ciclos de m�quina com o pino em Low.
    
        Como visto pelo debugger do MikroC e como demonstrado e visto na aula, o c�digo funciona como esperado.
        
        A frequ�ncia m�xima, portanto, ficou:
        
        Tempo de oscila��o = 1,5us
        
        f = 1 / 1,5us = 666,67KHz

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
       asm nop; // nop = No Operation. Este comando gasta um ciclo de m�quina e n�o executa nada
       asm nop;
       asm bcf LATB,0;

     goto loop;

}
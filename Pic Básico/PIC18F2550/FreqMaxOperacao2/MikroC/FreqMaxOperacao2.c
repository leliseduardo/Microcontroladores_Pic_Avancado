/* 

        O objetivo deste programa é criar um oscilador de onda quadrada com Duty Cicle em 50%, na maior frequência possível. Para isso, utiliza-se
    o código do último projeto, denomina "FreqMaxOperacao". Nele foi visto a frequência máxima de oscilação de um pino do Pic, porém, com a oscila
    ção máxima o sinal de saída tem o Duty diferente de 50%. Para fazer o oscilado com esse Duty deve-se compensar o gasto de dois ciclos de
    máquina pela intrução de loop, que faz com que o pino fique em Low por mais tempo que em High. Deve-se fazer com que o pino fique em High pelo
    mesmo tempo em que fica em Low.
        A solução é simples. utiliza-se duas instruções que, no total, gastam dois ciclos de máquina. Assim, compensa-se a demora pela intrução
    de loop. Assim, demora-se 3 ciclos de máquina com o pino em High e 3 ciclos de máquina com o pino em Low.
    
        Como visto pelo debugger do MikroC e como demonstrado e visto na aula, o código funciona como esperado.
        
        A frequência máxima, portanto, ficou:
        
        Tempo de oscilação = 1,5us
        
        f = 1 / 1,5us = 666,67KHz

*/

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     LATB0_bit = 0x00; // Inicia a saída LATB0 em Low

     /*
     while(1){

       LATB0_bit = 0x01;
       LATB0_bit = 0x00;

     } // end loop infinito
     */

     loop:

       asm bsf LATB,0; // No MikroC, códigos em Assembly devem ter o "asm" na frente
       asm nop; // nop = No Operation. Este comando gasta um ciclo de máquina e não executa nada
       asm nop;
       asm bcf LATB,0;

     goto loop;

}
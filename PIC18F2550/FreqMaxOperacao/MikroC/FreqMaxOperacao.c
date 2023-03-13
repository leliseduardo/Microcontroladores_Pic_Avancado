/*

        Este programa tem a função de, através do debug do MikroC, demonstrar o tempo de execução de cada instrução. Nenhuma prática será feita.
    O tempo de cada intrução deverá responder ao ciclo de máquina do Pic, que usa um cristal de 16MHz. Logo:
    
    ciclo de máquina = 1 / (16MHz/4) = 250ns
    
    Um código em Assembly será utilizado para ver a diferença com um código em C
    
        Como previsto e demonstrado na aula, não nenhuma diferença de tempo de execução neste código em C e em Assembly. Porém, este código é 
    simples. Num código mais complexo a diferença do tempo de execução aparece, sendo o Assemblymais rápido, por ser uma linguagem de mais baixo
    nível.
        O tempo levado para setar e limpar o pino LATB0 e fazer o loop foi de 4 ciclos de máquina, ou 1us. Dois ciclos para setar e apagar e 2
    ciclos para a intrução de loop. Isso dá uma frequência de oscilação de:
    
        f = 1 / 1us = 1MHz
        
        Essa frequência é limitada pelo ciclo de máquina mínimo, que depende da frequência máxima (no caso 16MHz/4 = 4MHz), e da intrução de loop,
    que é uma instrução de desvio incondicional e sempre gasta mais de um ciclo de máquina.

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
       asm bcf LATB,0;
       
     goto loop;

}
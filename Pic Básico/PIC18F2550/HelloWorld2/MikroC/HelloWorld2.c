/* 

        O fun��o deste programa � simplesmente piscar um led, criando uma fun��o para realizar esta tarefa. Com isso, demonstra-se o que � o real
    objetivo deste projeto, que �, atrav�s do debug do programa e das janelas de debug, visualizar a configura��o dos registrador do Pic a n�vel
    de hardware. Isto �, atrav�s das janelas de mem�ria do Pic, consegue-se enxergar os endere�os de mem�ria sendo preenchidos a medida que os
    registradores v�o sendo configurados.
        Para ser ainda mais claro, cada registrador possu� um endere�o de mem�ria interno dentro do Pic, e este endere�o de mem�ria pode ser
    consultado no datasheet. Quando se configura um registrador, este endere�o de mem�ria armazena o valor configurado para que o registrador possa
    funcionar de acordo como configurado. Atrav�s do debug do programa consegue-se enxergar este preenchimento dos endere�os de mem�ria.

*/

// Fun��es auxiliares
void pisca_Led();

// Fun��o principal
void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todos as entradas digitais em High
     LATB0_bit = 0x00; // Inicia LATB0 em Low
     
     // Loop infinito
     while(1){
     
       pisca_Led();
     
     } // end loop infinito

} // end void main

void pisca_Led(){

     LATB0_bit = 0x01;
     delay_ms(200);
     LATB0_bit = 0x00;
     delay_ms(200);

} // end void pisca_Led















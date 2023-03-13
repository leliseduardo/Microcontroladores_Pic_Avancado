/* 

        O função deste programa é simplesmente piscar um led, criando uma função para realizar esta tarefa. Com isso, demonstra-se o que é o real
    objetivo deste projeto, que é, através do debug do programa e das janelas de debug, visualizar a configuração dos registrador do Pic a nível
    de hardware. Isto é, através das janelas de memória do Pic, consegue-se enxergar os endereços de memória sendo preenchidos a medida que os
    registradores vão sendo configurados.
        Para ser ainda mais claro, cada registrador possuí um endereço de memória interno dentro do Pic, e este endereço de memória pode ser
    consultado no datasheet. Quando se configura um registrador, este endereço de memória armazena o valor configurado para que o registrador possa
    funcionar de acordo como configurado. Através do debug do programa consegue-se enxergar este preenchimento dos endereços de memória.

*/

// Funções auxiliares
void pisca_Led();

// Função principal
void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
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















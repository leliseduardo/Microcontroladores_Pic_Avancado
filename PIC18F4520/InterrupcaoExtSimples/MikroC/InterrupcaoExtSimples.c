/* 

        O objetivo deste programa é introduzir as interrupções da família 18F dos microcontroladores Pic. Para isso, será usada como exemplo
    uma interrupção externa, que irá receber um sinal de 1KHz e a cada interrupção trocará o estado do pino RB7.
        A interrupção externa usada é a INT0, uma das três interrupções externas do PIC18F4520. Nenhuma prioridade será configurada para
    esta interrupção, ou seja, ela funcionará igual funcionaria qualquer interrupção dos microcontroladores das famílias 12F e 16F.
        O sinal de saída, no pino RB7, terá a metade da drequência do sinal de entrada, pois o estado desta saída é trocada a cada inter-
    rupção. Isto é, o sinal de entrada precisa de dois ciclos (que geram duas interrupções) para gerar um ciclo de saída.
        Este programa, ainda, tem a função de mostrar o tempo de latência da interrupção dos MCU's da família 18F, que são menores do que
    o tempo de latência de interrupção das famílias 12F e 16F.
        Tempo de latência da interrupção refere-se ao tempo necessário para o MCU perceber a interrupção, interromper de fato e executar
    a função que está dentro da rotina de interrupção, devido ao salvamento de contexto, termo utilizado em linguagem de baixo nível como
    o Assembly, para se referir às manipulações que o MCU precisa fazer para que os comandos sejam entendidos por ele.
        
        Quando não se configura prioridade de interrupção, a interrupção pode ser dita interrupção com prioridade simples.
        
        O tempo de latência encontrado foi da ordem de us (micro segundos), mais precisamente, como mostrado na aula do WRKits, 8,3us.

*/

#define out LATB7_bit

void interrupt(){

     if(INT0IF_bit){
     
       INT0IF_bit = 0x00;
       
       out = ~out;
     }
}

void main() {

     // Configuração de registradores
     INTCON = 0x90; // Ou 0b10010000, habilita a interrupção global e habilita a interrupção externa INT0
     INTEDG0_bit = 0x00; // Configura a interrupção externa do INT0 por borda de descida
     TRISB = 0x7F; // Ou 0b01111111, que configura apenas RB7 como saída digital
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     
     out = 0x00;
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrupção...
     } // end while
     
} // end void mais
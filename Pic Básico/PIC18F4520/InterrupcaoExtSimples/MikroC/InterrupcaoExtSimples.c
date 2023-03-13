/* 

        O objetivo deste programa � introduzir as interrup��es da fam�lia 18F dos microcontroladores Pic. Para isso, ser� usada como exemplo
    uma interrup��o externa, que ir� receber um sinal de 1KHz e a cada interrup��o trocar� o estado do pino RB7.
        A interrup��o externa usada � a INT0, uma das tr�s interrup��es externas do PIC18F4520. Nenhuma prioridade ser� configurada para
    esta interrup��o, ou seja, ela funcionar� igual funcionaria qualquer interrup��o dos microcontroladores das fam�lias 12F e 16F.
        O sinal de sa�da, no pino RB7, ter� a metade da drequ�ncia do sinal de entrada, pois o estado desta sa�da � trocada a cada inter-
    rup��o. Isto �, o sinal de entrada precisa de dois ciclos (que geram duas interrup��es) para gerar um ciclo de sa�da.
        Este programa, ainda, tem a fun��o de mostrar o tempo de lat�ncia da interrup��o dos MCU's da fam�lia 18F, que s�o menores do que
    o tempo de lat�ncia de interrup��o das fam�lias 12F e 16F.
        Tempo de lat�ncia da interrup��o refere-se ao tempo necess�rio para o MCU perceber a interrup��o, interromper de fato e executar
    a fun��o que est� dentro da rotina de interrup��o, devido ao salvamento de contexto, termo utilizado em linguagem de baixo n�vel como
    o Assembly, para se referir �s manipula��es que o MCU precisa fazer para que os comandos sejam entendidos por ele.
        
        Quando n�o se configura prioridade de interrup��o, a interrup��o pode ser dita interrup��o com prioridade simples.
        
        O tempo de lat�ncia encontrado foi da ordem de us (micro segundos), mais precisamente, como mostrado na aula do WRKits, 8,3us.

*/

#define out LATB7_bit

void interrupt(){

     if(INT0IF_bit){
     
       INT0IF_bit = 0x00;
       
       out = ~out;
     }
}

void main() {

     // Configura��o de registradores
     INTCON = 0x90; // Ou 0b10010000, habilita a interrup��o global e habilita a interrup��o externa INT0
     INTEDG0_bit = 0x00; // Configura a interrup��o externa do INT0 por borda de descida
     TRISB = 0x7F; // Ou 0b01111111, que configura apenas RB7 como sa�da digital
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     
     out = 0x00;
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrup��o...
     } // end while
     
} // end void mais
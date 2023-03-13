/* 

        Programa de introdu��o ao curso avan��do de microcontroladores PIC. Irei testar, neste programa, se meu PIC18F2550 est� funcionando,
     fazendo simplesmente com que ele pisque um Led. Tem muito tempo que tenho este microcontrolador e n�o sei se ele est� queimado. Pode ser que
     n�o funcione.
        No curso avan�ado, o professor demonstra o PIC18F4550, por�m, como est� em falta no mercado e eu n�o tenho, vou utilizar o PIC18F2550, que
     compartilha do mesmo datasheet e, logo, s�o o mesmo microcontrolador, com diferen�a apenas no n�mero de ports e de mem�ria. Outras caracte-
     r�sticas que os diferencam ser�o vistas ao longo do curso, apesar de serem poucas.
        No curso avan�ado, o microcontrolador utilizado diferencia-se do microcontroldor utilizado na fase intermedi�rica do curso, o PIC18F4550,
     em seus recursos, que v�o al�m um pouco. Um exemplo � a capacidade do uso direto do protocolo USB nos microcontroladores que ser�o utilizados,
     o PIC18F4550 e o PIC18F2550. Outras caracter�sicas ser�o exploradas e aprofundadas ao longo do curso, mas nada mais � do que uma continuca��o
     do curso b�sico/Intermedi�rio.
     
        E o PIC18F2550 funcionou perfeitamente na pr�tica. O curso poder� ser feito com ele. A �nica ressalva � que quebrou o pino 14, de
     comunica��o USB. Por�m, neste curso em espec�fico n�o ser�o utilizadas comunica��es USB.
     

*/


void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     
     // Loop infinito
     while(1){
     
       LATB0_bit = 0x01;
       delay_ms(500);
       LATB0_bit = 0x00;
       delay_ms(500);
     
     } // end loop infinito

} // end void main
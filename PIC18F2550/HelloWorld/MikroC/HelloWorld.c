/* 

        Programa de introdução ao curso avançãdo de microcontroladores PIC. Irei testar, neste programa, se meu PIC18F2550 está funcionando,
     fazendo simplesmente com que ele pisque um Led. Tem muito tempo que tenho este microcontrolador e não sei se ele está queimado. Pode ser que
     não funcione.
        No curso avançado, o professor demonstra o PIC18F4550, porém, como está em falta no mercado e eu não tenho, vou utilizar o PIC18F2550, que
     compartilha do mesmo datasheet e, logo, são o mesmo microcontrolador, com diferença apenas no número de ports e de memória. Outras caracte-
     rísticas que os diferencam serão vistas ao longo do curso, apesar de serem poucas.
        No curso avançado, o microcontrolador utilizado diferencia-se do microcontroldor utilizado na fase intermediárica do curso, o PIC18F4550,
     em seus recursos, que vão além um pouco. Um exemplo é a capacidade do uso direto do protocolo USB nos microcontroladores que serão utilizados,
     o PIC18F4550 e o PIC18F2550. Outras caracterísicas serão exploradas e aprofundadas ao longo do curso, mas nada mais é do que uma continucação
     do curso básico/Intermediário.
     
        E o PIC18F2550 funcionou perfeitamente na prática. O curso poderá ser feito com ele. A única ressalva é que quebrou o pino 14, de
     comunicação USB. Porém, neste curso em específico não serão utilizadas comunicações USB.
     

*/


void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digitais em High
     
     // Loop infinito
     while(1){
     
       LATB0_bit = 0x01;
       delay_ms(500);
       LATB0_bit = 0x00;
       delay_ms(500);
     
     } // end loop infinito

} // end void main
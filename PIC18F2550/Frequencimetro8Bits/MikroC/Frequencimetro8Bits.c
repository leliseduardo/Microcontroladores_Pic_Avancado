/* 

        O objetivo deste programa � fazer um detector de frequencias de 8 bits, isto �, at� 255Hz. Para isso, o timer0 � configurado com oscilador
    externo e, a cada pulso que recebe, o seu contador incrementa 1. Para medir a frequ�ncia, basta saber quanto o contador incrementa em 1s. Ou
    seja, a cada 1s, faz-se a leitura do contador do timer0 e, logo depois, zera o contador, para que ele comece a contagem do zero e termine em
    1s. Assim, obt�m-se a frequ�ncia, que � o n�mero de oscila��es por segundo.

        Na simula��o do proteus n�o funcionou, mas na pr�tica funcionou. Sem um frequ�ncimetro e sem um oscilosc�pio fica dif�cil, por�m, s� para
    treino, montei um oscilador com o contador 555 e consegui ver o acender e apagar do led.

*/

// Mapeamento de hardware
#define out LATB0_bit

// Vari�veis auxiliares
unsigned frequencia;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digiais em High
     LATB0_bit = 0x00; // Inicia a sa�da LATB0 em Low
     T0CON = 0xE8; // Habilita o timer0, configura com 8 bits, incrementa pelo clock no pino T0CLK, incrementa na borda de subida, n�o associa
                   // o prescaler, o que equivale a 1:1
     TMR0L = 0x00;

     // Loop infinito
     while(1){

       frequencia = TMR0L;
       
       if(frequencia < 100) out = 0x01;
       else out = 0x00;
       
       TMR0L = 0x00;
       
       delay_ms(1000);

     } // end Looop infinito

} // end void main












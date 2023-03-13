/* 

        O objetivo deste programa é fazer um detector de frequencias de 8 bits, isto é, até 255Hz. Para isso, o timer0 é configurado com oscilador
    externo e, a cada pulso que recebe, o seu contador incrementa 1. Para medir a frequência, basta saber quanto o contador incrementa em 1s. Ou
    seja, a cada 1s, faz-se a leitura do contador do timer0 e, logo depois, zera o contador, para que ele comece a contagem do zero e termine em
    1s. Assim, obtém-se a frequência, que é o número de oscilações por segundo.

        Na simulação do proteus não funcionou, mas na prática funcionou. Sem um frequêncimetro e sem um osciloscópio fica difícil, porém, só para
    treino, montei um oscilador com o contador 555 e consegui ver o acender e apagar do led.

*/

// Mapeamento de hardware
#define out LATB0_bit

// Variáveis auxiliares
unsigned frequencia;

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digiais em High
     LATB0_bit = 0x00; // Inicia a saída LATB0 em Low
     T0CON = 0xE8; // Habilita o timer0, configura com 8 bits, incrementa pelo clock no pino T0CLK, incrementa na borda de subida, não associa
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












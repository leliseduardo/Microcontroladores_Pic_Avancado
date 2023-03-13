/* 

        O objetivo deste programa é utilizar um botão que muda a função do programa através de múltiplos cliques. Para isso, utiliza-se o timer0
     na função de oscilador externo por borda de descida. Isto é, sempre que o botão for clicado, o contador do timero incrementa. A utilização
     do timer0 ainda será sem interrupção, estando sua rotina no loop infinito, na função principal.
        Aqui será feito apenas o protótipo, porém, este programa dá a base para fazer projetos em que um botão apenas realiza várias funções,
     bastando apenas clicar tantas vezes no botão.

*/

// Mapeamento de hardware
#define out LATB0_bit

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia todas as entradas digiais em High
     LATB0_bit = 0x00; // Inicia a saída LATB0 em Low
     T0CON = 0xF8; // Habilita o timer0, configura com 8 bits, incrementa pelo clock no pino T0CLK, incrementa na borda de descida, não associa
                   // o prescaler, o que equivale a 1:1
     TMR0L = 250; // Inicia em 250 para contagem de 6, isto é, 6 cliques do botão. Quando o timer0 está configurado com 8 bits, inicia-se somente
                  // TMRL, e não se usa o TMR0H.
     
     // Loop infinito
     while(1){
     
       if(TMR0IF_bit){
       
         TMR0IF_bit = 0x00;
         TMR0L = 250;
         
         out = ~out;
       
       } // end if TMR0IF_bit
     
     } // end Looop infinito
     
} // end void main



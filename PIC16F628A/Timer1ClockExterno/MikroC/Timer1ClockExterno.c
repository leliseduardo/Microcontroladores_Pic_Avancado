/*

   Neste código, ao invés de usar um osciador externo, usa-se um clock exteno, utilizando um oscilador 555 calculado no caderno para uma
   frequência de 10KHz. Ainda, será configurado um clock sincrono com o clock interno no pic, que quer dizer que o timer1 não incrementa
   com o ciclo de máquina, mas há uma certa sincronia entra o clock externo e o ciclo de maquina e serve para quando se quer ter as duas
   contagens em fase. Porém, quando há esse sincronismo, se o pic entrar em modo sleep, o incremento do timer1 para também.

   ciclo clock externo = 1 / 10KHz = 100us

   Logo, para um overflow de 100ms, o tmr1 deve contar até:

   Overflow = (TMR1H::TMR1L) x prescaler x ciclo clock externo
   Overflow = 410 x 1 x 100us
   Overflow = 41ms

   Para incrementar 410 vezes, (TMR1H::TMR1L) deve começar em:

   inicioTMR1 = (TMR1H::TMR1L) - 410
   inicioTMR1 = 65536 - 410 = 65126
   inicioTMR1 = 65126(decimal) = 0xFE66(hexadecimal)

   Obs: O clock externo com o 555, projetado para uma frequência de 10KHz, funcionou!

*/

#define led RB0_bit

char cont = 0x00;

void interrupt(){

     if(TMR1IF_bit){

       TMR1IF_bit = 0x00;
       TMR1H = 0xFE;
       TMR1L = 0x66;

       cont++;

       if(cont == 0x03){
         
         cont = 0x00;
         led = ~led;
       }
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos

     T1CON = 0x03; // Configura o prescaler em 1:1
                   // Desabilita o oscilador independente (T1OSCEN)
                   // Configura o clock como síncrono e um clock externo no pino RB6
                   // Ativa o timer1
     TMR1H = 0xFE; // Inicializa o TMR1 em 65126(decimal), para incrementar 410 vezes
     TMR1L = 0x66;

     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x01; // Habilita a interrupção por periféricos
     TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1

     TRISB = 0xFE; // Configura apenas RB0 como saída
     led = 0x00; // Inicia led em Low

     while(1){

       //
     }
}
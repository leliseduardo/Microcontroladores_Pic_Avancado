/* 

     Neste código, uma nova forma de usar o timer1 é implementada. Nele, utiliza-se um cristal oscilador externo extra com o intuito de
   incrementar o Timer1 independente do ciclo de máquina. Assim, o incremento do timer1 é configurado como assíncrono, que faz com que
   ele não incremente com o ciclo de máquina, e sim com o período do oscilador externo. Uma vantagem deste tipo de interrupção é que o
   timer1 continuará funcionando caso o pic entre no modo sleep. Ou seja, pode-se manter uma função de interrupção mesmo com o mcu em
   modo sleep. Isso, para aplicações críticas, é de grade valia.
     O cristal oscilador usado para incrementar o timer1 é de 32768 Hz, ou 32,768 KHz, e pode ser usado um cristal de até 200 KHz.
   Assim, o ciclo do cristal do timer1, que irá incrementar TMR1 tem o valor de:
   
   ciclo cristal externo = 1 / 32768 Hz = 30,5176 us
   
   Logo, para um overflow de 100ms, o tmr1 deve contar até:
   
   Overflow = (TMR1H::TMR1L) x prescaler x ciclo cristal externo
   100ms    = (TMR1H::TMR1L) x 8 x 30,5176 us
   (TMR1H::TMR1L) = 100ms / (8 x 30,5176 us)
   (TMR1H::TMR1L) = 409,6 ~= 410
   
   Para incrementar 410 vezes, (TMR1H::TMR1L) deve começar em:
   
   inicioTMR1 = (TMR1H::TMR1L) - 410
   inicioTMR1 = 65536 - 410 = 65126
   inicioTMR1 = 65126(decimal) = 0xFE66(hexadecimal)

*/

#define led RB0_bit

void interrupt(){

     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1H = 0xFE;
       TMR1L = 0x66;
       
       led = ~led;
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos

     T1CON = 0x3F; // Configura o prescaler em 1:8
                   // Ativa o oscilador exclusivo de controle do timer1 (T1OSCEN)
                   // Configura o incremento como assíncrono, isto é, não incrementa com o ciclo de máquina (T1SYNC)
                   // Configura um clock externo nos pinos RB6 e RB7
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
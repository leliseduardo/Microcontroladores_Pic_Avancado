
#define servo1 RC4_bit

unsigned char duty;
int adc = 0x00;

 void interrupt(){

      if(TMR0IF_bit){
      
        TMR0IF_bit = 0x00;
        
        if(servo1){
          TMR0 = duty;
          servo1 = 0x00;
        }
        else{
          TMR0 = 255 - duty;
          servo1 = 0x01;
        }
      }
}

/* 
   Lembrando que o contador do timer0, TMR0, conta do numero iniciado até 255. Logo, para TMR0 conta até 11, deve-se inicializa-lo
   com 255 - 11, por exemplo.

*/

void main() {

     CMCON = 0x07; // Desabilita os comparadores interno
     OPTION_REG = 0x87; //Desabilita os pull-ups internos e configura o prescaler em 1:256 no timer 1
     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x01; // Habilita a interrupção por periféricos
     TMR0IE_bit = 0x01; // Habilita o timer1
     ADON_bit = 0x01; // Habilita o conversor AD
     ADCON1 = 0x0E; // Configura apenas AN0/RA0 como entrada analógica
     TRISA = 0xFF; // Todo porta como entrada
     TRISC = 0xEF; // Apenas RC4 como saída digital
     PORTC = 0xEF; // Inicia RC4 em Low
     
     while(1){
     
     /* 
        Para controlar um servo motor, deve-se ter um sinal com frequencia de 50Hz, que dá um período de 20ms, onde o pulso
        para o deslocamento mínimo (0º) é de 1ms, e o pulso para deslocamento máximo (depende do servo) é de 2ms. Isto é, num sinal
        de frequência de 50Hz (20ms), o sinal deve ter sua parte positiva apenas entre o intervalo de 1ms à 2 ms e a parte negativa, no
        intervalo de 19ms à 18ms.
        
        Deve-se entender que, nesse programa, o pic faz a leitura de um potenciômetro por um conversor ad de 10 bits, e solta um pulso
        variável na frequência de 50Hz pela porta RC4. Logo, o intervalo de 1ms à 2ms deve corresponder a todo o intervalo do potenciômetro,
        isto é, a todo intervalo do conversor AD de 10 bits, ou seja, o intervalo de 0 a 1023.
        
        Como a frequência do sinal do servo motor vai ser definido pela interrupção do timer0, então é necessário fazer com que essa
        interrupção ocorra a cada 20ms. Logo, para um oscilador de 12MHz, preset de 256 e, fazendo o timero contar até 256, tem-se:

        overflow = ciclo de maquina x preset x tmr0
        overflow = 1/(12000000/4) x 256 x 256
        overflow = 22ms, que é uma frequência próxima
        
        Percebe-se que, ao variar a contagem do timer0, isto é, alterar a flag TMR0 (0 a 255), consegue-se variar o tempo de overflow,
        de 0 a 22ms. Logo, será utilizado essa flag para controlar o pulso. Logo, para se ter um pulso de entre 1ms e 2ms, deve-se
        fazer uma regra de três, e descobrir ate que numero o TMR0 deve contar para ter 1ms e 2ms.
        
        22ms ----- 256     22ms ----- 256
        1ms  ----- x       2ms  ----- x
          x = 11             x = 22
          
        Logo, para contar 1ms o TMR0 deve conta até 11, e para contar até 2ms, TMR0 deve contar até 23
        
        Agora, como a variação ocorrerá a partir da leitura do conversor AD, precisa-se fazer com que, ao ler 1024 no conversor, isto é,
        5V (valor máximo), o pulso dado seja de 2ms, isto é, TMR0 = 22. Para isso, precisa-se fazer uma operação em que a variação de
        0 a 1023 seja lida como uma variação de 0 a 11, de forma que, quando o valor no AD for 0, a variável duty seja 11 e quando
        tiver 1024 em AD, a variável duty seja 22, igualando TMR0 a duty. Logo:
        
        1024 / X = 11 <=> X = 93
        
        Assim, dividindo 1024 por 93 e somando 11, teremos que o valor máximo no AD representará 22, ou 2ms, que é o deslocamento máximo
        do Servo. Se no AD tiver 0, ainda sim será somado 11, e o AD representará 11, ou 1ms, que o deslocamento mínimo do motor.
        
        Logo, o loop infinito fica:
     */
     
       adc = (adc_read(0))/85;
       
       duty = adc + 12;
     }
}
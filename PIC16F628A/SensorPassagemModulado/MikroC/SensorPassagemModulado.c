/* 

        Este c�digo � muito interessante, pois faz o uso de duas interrup��es, uma do modulo ccp, no modo captura, e outra do timer0.
   desta forma, � possivel programao o modo cpp como frequencimetro, como j� havia sido feito, e programar o timer0 para gerar uma
   frequencia a partir de suas interru��es. Assim, consegue-se medir, pelo ccp, a frequencia do timer0. Se em algum pino controlado
   pelo timer0 for conectado um led infravermelho, e no pino do modulo ccp for conectado um foto transistor, consegue-se capturar
   a frequencia recebida pelo fototransistor e, se for a frequencia certa programada, realizar alguma fun��o. Assim, temos uma recep��o
   modulada do fototransistor.
        Infelizmente eu n�o tenho o fototransistor para fazer a pr�tica, mas assim que comprar farei. Pela simula��o do proteus, utilizando
   um gerador de frequencias, funcionou perfeitamente.
        Vale salientar que este c�digo � o mesmo utilizado no projeto "frequencimetro", por�m, n�o utiliza o display lcd e, ainda, adiciona
   o uso da interrup��o do timer0
   
        Agora que tenhos o fototransitor consegui testar o circuito e funcionou. Lembrando que a frequ�cia com que o emissor infravermelho
   pisca � dado pelo timer 0 e tem o tempo igual ao tempo de estouro, que �:
   
   ciclo de m�quina = 0,2us
   
   Overflow = ciclo de maquina x prescaler x TMR0
   Overflow = 1us x 2 x 250
   Overflow = 0,5ms

   freq = 1 / (2xOverflow)
   freq = 1 / (2x0,5ms)
   freq = 1000Hz = 1KHz
   
   Logo, o modulo cpp, no modo captura, capta o tempo de 16 per�odos e, atrav�s do c�lculo feito no loop infinito, calcula a frequencia
   do valor recebido pelo receptor infrevermelho

*/

#define ledIR RB2_bit
#define ledBarreira RB1_bit

//variaveis globais
char flag0 = 0x00;
unsigned tempo1, tempo2;
char txt[12];
unsigned long frequencia;
unsigned cont = 0x00;

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       TMR0 = 0x06;

       ledIR = ~ledIR;
     }

     if(CCP1IF_bit){

       CCP1IF_bit = 0x00;

       if(!flag0.B0){

         tempo1 = (CCPR1H << 8) + CCPR1L;

         flag0.B0 = 0x01;
       }
       else{

         tempo2 = (CCPR1H << 8) + CCPR1L;

         flag0.B0 = 0x00;

       }
     }
}

void main() {

      CMCON = 0x07; // Desabilita os comparadores internos
      T1CON = 0x01; // Configura o prescaler para 1:1 e habilita o contador do timer1 (TMR1)
      CCP1CON = 0x07; // Habilita o modo captura com prescaler de 16, isto �, 16 bordas de subida para captura
      GIE_bit = 0x01; // Habilita a interrup��o global
      PEIE_bit = 0x01; // Habilita a interrup��o por perif�ricos
      CCP1IE_bit = 0x01; // Habilita a interrup��o pelo modulo cpp, no caso, no modo captura
      OPTION_REG = 0x80; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:2
      T0IE_bit = 0x01; // Habilita a interrup��o do tmr0
      TMR0 = 0x06; // Inicia a contagem do tmr0 em 6, o que faze ele contar at� 250, pois 256 - 6 = 250
      

      TRISA = 0xFF; // Configura o todo porta como entrada digital
      TRISB = 0xF9; // Configura apenas RB1 e RB2 como sa�das digitais
      PORTA = 0xFF; // Inicia todo porta em High
      PORTB = 0xF0; // Inicia o primeiro neeble em High e o segundo em Low

      while(1){

        tempo2 = abs(tempo2 - tempo1); // Modulo da subtra��o

        tempo2 = (tempo2) >> 4; // Divide por 16

        frequencia = 1 / (tempo2 * 1E-6);

        if(frequencia > 950 && frequencia < 1050)
          ledBarreira = 0x00;
        else
          ledBarreira = 0x01;

        delay_ms(100);
      }
}
/* 

   �ltimo projeto utilizando o modulo ccp no modo de captura e agora entendi o c�digo do primeiro programa utilizando este modo.
   
          O modo cpp, tem como ser configurado com 4 prescalers, que � a captura com 1 borda de descida, com 1 borda de subida, 4 bordas
   de subida ou 16 bordas de subida. Assim, quando configuramos para 1 borda de subida, a captura de tempo ir� ocorrer qunado houver
   a borda de subida do sinal que entra no pino do ccp.
   O ponto chave para entender o funcionamento, � entender que o contador do timer1, o tmr1, n�o come�a a contar quando  a captura
   acontece, e sim, conta continuamente durante todo o programa, sendo incrementado de acordo com seu pr�prio prescaler (prescaler
   do timer1) e do ciclo de m�quina, que aqui est� sendo configurado 1:1 e 4MHz, que d� um ciclo de 1us. Portanto, quando a captura
   acontece, isso quer dizer que os resgistradores de contagem do ccp (CCPR1H::CCPR1L) est�o armazenando a contagem do tmr1 no momento
   em que a captura acontece. Por exemplo, se o programa � iniciado e a captura demora 10s ap�s esse inicio, os registradores do ccp
   irao armazenar estes 10 segundos, pois foi a contagem que o tmr1 fez at� agora.
        Outro ponto importante para se entender � a diferen�a entre a l�gica do programa do projeto "PulsoCapturaCPP" e as l�gicas dos
   projetos "ModoCaptura" e "Frequencimetro" (este programa). No projeto "pulsoCapturaCPP", apenas quando ocorre a captura � que se
   liga o contador do timer, o tmr1. Da�, o tmr1 come�a a contar ap�s a captura, e, para se medir apenas o pulso positivo, inten��o
   do programa, o prescaler do ccp � alterado para borda de descida, e, quando este ocorre, o contador tmr1 � desligado. Da�, o tmr1 s�
   conta enquanto o sinal estiver em high. Isso tudo � feito manualmente pelo software.
   Diferentemente, a l�gica dos programas "ModoCaptura" e "Frequencimetro" (este programa), prop�e usar o modo de captura sem manipular
   a contagem do timer1, e com isso, algumas consequencias ocorrem. Nestes programas, o tmr1 est� sempre ativo e, assim, a contagem ocorre
   sempre, enquanto o programa estiver rodando. Isso quer dizer que o tmr1, de 16 bits, conta de 0 a 2^(16) = 65536, com incremento de 1us,
   que resulta em 65536us = 65ms, e reinicia para 0. Logo, tem-se que levar em considera��o a resolu��o do microcontrolador. Se o ciclo de
   m�quina � de 1us, frequencias acimas de 100KHz podem n�o ser lidas corretamente, pois o pulso pode ler um periodo enquanto na verdade
   houve mais de 1, pela frequencia muito alta. Por exemplo, se a frequencia � de 100KHz, o pe�rodo � de 10us. Se houver mais de 10 ciclos
   de maquina antes da leitura do periodo pelo modulo ccp, j� � perdido a resolu��o do pulso, isto �, houve mais de 1 pulso por contagem. Da
   mesma forma, se a frequencia for muito baixa, pode acontecer do tmr1 estourar sua contagem sem ter lido 1 periodo inteiro. Ainda nesses
   programas, � preciso capturar dois tempos, para que se consiga o intervalo desejado. Por exemplo, se quisermos o tempo de um pico
   positivo, configurar a captura como borda de subida, assim quando ocorrer essa borda, a captura ter� o tempo que demoro at� ocorrer
   esse pulso positivo. Logo em seguida, deve-se alterar o ccp para borda de descida, assim, quando houver esse pulso negativo, a captura
   ir� armazenar o tempo que levou para isso ocorrer. Subtraindo o primeiro tempo do segundo, tem-se o tempo somente do pulso high. Essa �
   a l�gica do progrma "ModoCaptura". J� no "Frequencimeto", como se quer o periodo completo do sinal, n�o � necess�rio trocar a
   configura��o de borda de subida para borda de descida. Quando ocorre a borda de subida, o ccp captura o tempo que demorou para isso
   ocorrer e armazena em uma variavel e, quando ocorre novamente outra borda de subida, o ccp armazena o tempo que demorou numa segunda
   variavel. Subtraindo o tempo da primeira variavel na segunda, temos o tempo do periodo completo. Tamb�m deve-se lembrar que o tmr1 conta
   at� seu limite maximo sem parar e reinicia a contagem. Assim, pode ocorrer da primeira captura ocorrer no final da contagem de tmr1 e
   a segunda captura acontecer no inicio da contagem do tmr1 e, assim, a segunda variavel seria menor do que a primeira e o resultado da
   subtra��o da primeira na segunda seria negativa. Por isso � importante ter o modulo dessa subtra��o.
        Uma maneira de se aumentar a resolu��o do modulo cpp, no modo captura, � colocar o preset da captura em 16 bordas de subida. Assim,
   consegue-se mudar o intervalo de frequ�ncias para frequencias maiores, o que geralmente � masi interessante. Isto �, consegue-se uma
   resolu��o maior para frequencias maiores e uma falta de resolu��o para frequencias pequenas. Isso ocorre pois, com 16 bordas de subida
   para a captura, o periodo pode chegar proximo a 1us, que � o ciclo de maquina, que ainda sim a leitura de conseguira ser feita, pois
   s�o necess�rios 16 bordas de subida. Por exemplo, se o periodo do sinal � de 1us, ele demorara 1us x 16 = 16us para ser capturado. Ainda
   n�o � o ideial, pois 16us s�o 16 ciclos de m�quina e ainda poderia ocorrer falta de resolu��o, por�m, um perido de 1us d� uma frequencia
   de 1MHz. Ou seja, at� uns 200KHz ou, por seguran�a, 100KHz, pode-se medir com tranquilidade.
      Para fazer o gerador de fun�oes que o modulo ccp ir� ler, utilizei um oscilador com CI 555, pois n�o tenho gerador de frequencias.
   O projeto e o calculo dos componentes est� feito no caderno.
*/

// Lcd pinout settings
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

//variaveis globais
char flag0 = 0x00;
unsigned tempo1, tempo2;
char txt[12];
unsigned long frequencia;

void interrupt(){

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
      
      TRISA = 0xFF; // Configura o todo porta como entrada digital
      TRISB = 0x09; // Configura apenas RB0 e RB3 (CCP) como entradas digitais
      PORTA = 0xFF; // Inicia todo porta em High
      PORTB = 0x00; // Inicia todo portb em Low
      
      lcd_init();
      lcd_cmd(_LCD_CURSOR_OFF);
      lcd_cmd(_LCD_CLEAR);
      lcd_out(1,1,"Frequencia");
      lcd_out(2,14,"Hz");
      delay_ms(100);
      
      while(1){
      
        tempo2 = abs(tempo2 - tempo1); // Modulo da subtra��o
        
        tempo2 = (tempo2) >> 4; // Divide por 16
        
        frequencia = 1 / (tempo2 * 1E-6);
        
        LongToSTR(frequencia, txt);
        
        lcd_out(2,2,txt);
        
        delay_ms(100);
      }
}
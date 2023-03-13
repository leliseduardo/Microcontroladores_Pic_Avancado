/*

     Este programa tem a fun��o de simuar um voltimetro que leia tens�es negativas. Como o microcontrolador Pic n�o faz leitura de tens�es
   negativas, eletronicamente foi projetado uma interface que processa a varia��o do sinal de entrada e o faz variar, na sa�da da interface,
   de 0V � 5V. Nesse projeto, a interface recebe um sinal que varia de -2V � 1V e o faz variar de 0V � 5V. Portanto, na entrada anal�gica
   do pic, ser� lida uma tens�o que varia de 0V a 5V e, o valor lido � reconvertido, atrav�s de algumas equa��es, para o valor ao qual o
   sinal realmente de refere, no intervalo de -2V � 1V. Este programa � interessante e muito importante pois, eletronicamente se faz um
   tratamento do sinal de entrada, utilizando uma interface para ajustar o sinal ao valor que o microcontrolador suporta. Ainda, no programa
   o sinal � novamente tratado para desfazer o que a interface eletr�nica fez e, entender o sinal lido de acordo com o sinal original, lido
   na entrada da interface eletr�nica. Logo, h� um processamento de sinal neste projeto, que manipula o sinal recebido para conseguir fazer
   sua leitura e, posteriormente, interpreta-lo.

   Para que se possa fazer a leitura so sinal recebido e interpreta-lo para o sinal original, dois passos s�o necess�rios: Primeiro deve-se
   entender como o conversor AD faz a leitura do sinal com a resolu��o que o MCU t�m para esse conversor (10 bits). Segundo, deve-se
   normalizar o valor lido pelo ADC para que se possa tratar o sinal lido como se fosse o sinal original (lido pela interface eletronica).

   Primeiramente, o valor lido pelo adc � o seguinte:

   5V  ----- 1024
   Vin ----- ADC
   Vin = (ADC x 5) / 1024

   Segundamente, deve-se normalizar o valor lido. Para isso, compara-se a varia��o do sinal original com a varia��o do sinal lido pelo ADC

   Delta-Vadc = 5 - 0 = 5V
   Delta-Vin = 1 - (-2) = 3V

   A rela��o dessas varia��es �:

   Delta-Vin    3V
   --------- =  --  = 0,6
   Delta-Vadc   5V

   Logo, se tem que:

   Vin = Vadc x 0,6V

   Ex: Vin = 5V x 0,6V = 3V

   Agora, deve-se deslocar o sinal ADC lido para o valor m�nimo de Vin

   Vin = (Vadc x 0,6) - 2

   Ex:

   Vin = (5V x 0,6) - 2 = 1V

   Vin = (0V x 0,6) - 2 = -2V

   Que s�o os limites inferior e superior do sinal original, respectivamente.

   Obs: Este processo de normaliza��o j� havia sido feito do projeto "VoltimetroSimples" para ler uma tens�o que variava de 0V a 12V, por�m
   eu n�o sabia que o nome para o c�lculo era esse. Eu temb�m n�o fiz com esses passos e, sim, intuitivamente. Agora entendo como � feito o
   processo de normaliza��o e seus passos.

   Este programa n�o est� compilando pois n�o tenho licen�a do MikroC 4.15 e, como estou usando v�rios floats, o limite m�ximo do tamanho
   programa � ultrapassado. Por isso, instalei o MikroC 7.6.

   Funcionou perfeitamente

   Por�m, tive que voltar para a vers�o 4.15 pois a vers�o mais recente apresenta instabilidades
   
   A fun��o que est� dando problema para compilar � a FloatToString. Quando usa-se soma ou subtra��o no numero no qual essa fun��o deve
   converter, o compilador acusa "demo limit". Provavelmente � algo relacionado a mem�ria que faz com que o programa demo n�o funcione.
   
   Pelo que pesquisei, no programa demo existe um limite de uso para a mem�ria ROM. A fun��o FloatToString consome muita mem�ria e, por
   isso, o programa n�o est� compilando. Quando eu subtraio um valor da vari�vel que a fun��o vai usar, provavelmente h� um almento do
   consumo de mem�ria e por isso n�o compila.
*/

// Fun��o auxiliar

void voltimetro(float range);

// Vari�veis auxiliares

int adc = 0x00;
float tensao = 0.0;
float Vin = 0.0;
char txt[15];


void main() {

     ADCON0 = 0x01; // Habilita AN0 como canal anal�gico e habilita o conversor AD
     ADCON1 = 0x0E; // Habilita o intervalo de tens�o de leitura do ADC como o intervalo da fonte de tens�o (0V � 5V). Ainda, configura
                    // apenas AN0 como porta anal�gica e, o resto das portas que podem ser anal�gicas, como digitais.

     TRISA = 0xFF; // Configura todo porta como entrada digital

     UART1_Init(9600);
     delay_ms(100);

     UART1_Write_Text("Voltimetro PIC18");
     UART1_Write(10);
     UART1_Write(13);

     while(1){

        voltimetro(5.0);
        delay_ms(500);
     }
}

void voltimetro(float range){

     adc = ADC_Read(0);

     tensao = ((adc * range) / 1024.0);

     Vin = (tensao * 0.6) - 2.0;

     FloatToStr(Vin, txt); // Por alguma motivo essa fun��o n�o funciona quando se soma ou subtrai de Vin

     UART1_Write_Text(txt);
     UART1_Write(10);
     UART1_Write(13);
}

/*

     Este programa tem a função de simuar um voltimetro que leia tensões negativas. Como o microcontrolador Pic não faz leitura de tensões
   negativas, eletronicamente foi projetado uma interface que processa a variação do sinal de entrada e o faz variar, na saída da interface,
   de 0V à 5V. Nesse projeto, a interface recebe um sinal que varia de -2V à 1V e o faz variar de 0V à 5V. Portanto, na entrada analógica
   do pic, será lida uma tensão que varia de 0V a 5V e, o valor lido é reconvertido, através de algumas equações, para o valor ao qual o
   sinal realmente de refere, no intervalo de -2V à 1V. Este programa é interessante e muito importante pois, eletronicamente se faz um
   tratamento do sinal de entrada, utilizando uma interface para ajustar o sinal ao valor que o microcontrolador suporta. Ainda, no programa
   o sinal é novamente tratado para desfazer o que a interface eletrônica fez e, entender o sinal lido de acordo com o sinal original, lido
   na entrada da interface eletrônica. Logo, há um processamento de sinal neste projeto, que manipula o sinal recebido para conseguir fazer
   sua leitura e, posteriormente, interpreta-lo.

   Para que se possa fazer a leitura so sinal recebido e interpreta-lo para o sinal original, dois passos são necessários: Primeiro deve-se
   entender como o conversor AD faz a leitura do sinal com a resolução que o MCU têm para esse conversor (10 bits). Segundo, deve-se
   normalizar o valor lido pelo ADC para que se possa tratar o sinal lido como se fosse o sinal original (lido pela interface eletronica).

   Primeiramente, o valor lido pelo adc é o seguinte:

   5V  ----- 1024
   Vin ----- ADC
   Vin = (ADC x 5) / 1024

   Segundamente, deve-se normalizar o valor lido. Para isso, compara-se a variação do sinal original com a variação do sinal lido pelo ADC

   Delta-Vadc = 5 - 0 = 5V
   Delta-Vin = 1 - (-2) = 3V

   A relação dessas variações é:

   Delta-Vin    3V
   --------- =  --  = 0,6
   Delta-Vadc   5V

   Logo, se tem que:

   Vin = Vadc x 0,6V

   Ex: Vin = 5V x 0,6V = 3V

   Agora, deve-se deslocar o sinal ADC lido para o valor mínimo de Vin

   Vin = (Vadc x 0,6) - 2

   Ex:

   Vin = (5V x 0,6) - 2 = 1V

   Vin = (0V x 0,6) - 2 = -2V

   Que são os limites inferior e superior do sinal original, respectivamente.

   Obs: Este processo de normalização já havia sido feito do projeto "VoltimetroSimples" para ler uma tensão que variava de 0V a 12V, porém
   eu não sabia que o nome para o cálculo era esse. Eu tembém não fiz com esses passos e, sim, intuitivamente. Agora entendo como é feito o
   processo de normalização e seus passos.

   Este programa não está compilando pois não tenho licença do MikroC 4.15 e, como estou usando vários floats, o limite máximo do tamanho
   programa é ultrapassado. Por isso, instalei o MikroC 7.6.

   Funcionou perfeitamente

   Porém, tive que voltar para a versão 4.15 pois a versão mais recente apresenta instabilidades
   
   A função que está dando problema para compilar é a FloatToString. Quando usa-se soma ou subtração no numero no qual essa função deve
   converter, o compilador acusa "demo limit". Provavelmente é algo relacionado a memória que faz com que o programa demo não funcione.
   
   Pelo que pesquisei, no programa demo existe um limite de uso para a memória ROM. A função FloatToString consome muita memória e, por
   isso, o programa não está compilando. Quando eu subtraio um valor da variável que a função vai usar, provavelmente há um almento do
   consumo de memória e por isso não compila.
*/

// Função auxiliar

void voltimetro(float range);

// Variáveis auxiliares

int adc = 0x00;
float tensao = 0.0;
float Vin = 0.0;
char txt[15];


void main() {

     ADCON0 = 0x01; // Habilita AN0 como canal analógico e habilita o conversor AD
     ADCON1 = 0x0E; // Habilita o intervalo de tensão de leitura do ADC como o intervalo da fonte de tensão (0V à 5V). Ainda, configura
                    // apenas AN0 como porta analógica e, o resto das portas que podem ser analógicas, como digitais.

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

     FloatToStr(Vin, txt); // Por alguma motivo essa função não funciona quando se soma ou subtrai de Vin

     UART1_Write_Text(txt);
     UART1_Write(10);
     UART1_Write(13);
}

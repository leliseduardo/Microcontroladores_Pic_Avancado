/* 

        Neste programa será implementado um filtro digital denominado filtro de média móvel. A função desse filtro é, a partir de várias
     leituras de um sensor, através do conversor AD, obter uma média de vários valores medidos pelo sensor. Porém, diferentemente de uma
     média comum, onde são feitas várias medidas num mesmo instante, a média móvel faz várias medidas a medida que o tempo passa.
        O funcionamento de um filtro digital de média móvel consiste em alimentar um vetor com várias medidas feitas pelo sensor e, sempre
     que houver uma nova leitura, o vetor apagará o último elemento do vetor, que corresponde a leitura mais antiga, e colocará a leitura
     mais recente no primeiro elemento do vetor. Com isso, a média móvel consiste na média dos valores dentro do vetor. Logo, a média é
     móvel pois estará sempre atualizando no tempo.
        O diferecial desta média consiste no fato de as medidas não serem feitas todas no mesmo intervalo de tempo. As medidas são feitas
     uma por uma de tempos em tempos, que depende do programa mas, ainda sim, um tempo muito rápido. Assim, caso haja uma forte interfe-
     rência no sensor e, assim, haja uma leitura errada, o filtro não deixará esse acontecimento perceptível na leitura do sensor.
        Para demonstrar esse filtro será utilizado o projeto "SensorTemperaturaLCD" que, a princípio, utiliza em suas medidas uma média
     instantânea nas leituras do sensor.
        Como já dito, a média instantânea faz uma média dos valores medidos instantâneamente, isto é, quase ao mesmo tempo, em um intervalo
     de tempo muito pequeno. O filtro de média móvel, faz essas leituras uma por vez e guarda em um vetor. Quando o vetor está cheio, se tem
     uma média de valores que correspondem a leituras feitas num espaço de tempo maior, impedindo que mudanças abruptas de tensão, geradas
     por interferências externas, alterem a medida do sensor. Na média instantânea, uma mudança abrupta de tensão ocorrida no momento da
     leitura do sensor, mesmo fazendo uma média dos valores lidos, pode ocasionar numa média que não corresponde ao valor exato de leitura
     do sensor, isso porque, no pequeno tempo em que as leituras foram feitas, houve a interferência externa.
        Pelo motivo de se ter a média móvel somente quando o vetor está cheio, tempo esse que depende do programa, é característica desse
     filtro demorar uns poucos segundos para estabilizar sua leitura. Porém esse processo é bem rápido.
     
        No proteus é muito interessante ver este programa funcionando, pois dá para notar a media alterando de forma suave até estabilizar
     no valor real da temperatura.
        Isso também ocorre na prática!
        
*/

// Configuração do LCD
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

// Funções auxiliares
void escreveDisplay();
void CustomChar(char linha, char coluna);
void celsius();
long mediaMovel();

// Variáveis auxiliares
#define N 50
const char character[] = {6,9,6,0,0,0,0,0};
long movingAverage;
float temperatura = 0.0;
float ultimaTemperatura = 0.0;
char txt[7];
int media[N];
int adc = 0x00;


void main() {

     // Configuração de registradores
     ADCON0 = 0x01; // Configura AN0 como canal analógico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura o apenas AN0 como porta analógica
     TRISA = 0xFF; // Configura todo porta como entrada digital, exceto AN0 que é entrada analógica
     TRISD = 0x03; // Configura apenas RD0 e RD1 como entradas digitais, pois não serão usadas

     // Inicialização do LCD
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     
     escreveDisplay();
     
     // Loop infinito
     while(1){
     
       celsius();
     }
}

void celsius(){

     movingAverage = mediaMovel();
     
     temperatura = ((movingAverage * 5.0)/1024.0);
     
     temperatura = temperatura * 100.0;
     
     if((temperatura > ultimaTemperatura + 0.8) || temperatura < ultimaTemperatura - 0.8){
     
       ultimaTemperatura = temperatura;
     
       floatToStr(ultimaTemperatura, txt);
     
       lcd_chr(2, 3, txt[0]); // Coluna 3
       lcd_chr_cp(txt[1]); // Coluna 4
       lcd_chr_cp(txt[2]); // Coluna 5
       lcd_chr_cp(txt[3]); // Coluna 6
       lcd_chr_cp(txt[4]); // Coluna 7
       CustomChar(2, 8);
       lcd_chr(2, 9, 'C');
     }
}

long mediaMovel(){

    char i;
    long cont = 0;
    
    adc = adc_read(0);
    
    for(i = N-1; i > 0; i--)
      media[i] = media[i-1];
      
    media[0] = adc;
    
    for(i = 0; i < N; i++)
      cont = cont + media[i];
      
    return (cont/N);
}

void CustomChar(char linha, char coluna) {
    char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(linha, coluna, 0);
}

void escreveDisplay(){

     lcd_chr(1, 3, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('m');
     lcd_chr_cp('o');
     lcd_chr_cp('m');
     lcd_chr_cp('e');
     lcd_chr_cp('t');
     lcd_chr_cp('r');
     lcd_chr_cp('o');
     lcd_chr_cp(' ');
     lcd_chr_cp('P');
     lcd_chr_cp('I');
     lcd_chr_cp('C');
}












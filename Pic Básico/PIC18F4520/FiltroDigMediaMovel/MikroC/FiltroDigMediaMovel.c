/* 

        Neste programa ser� implementado um filtro digital denominado filtro de m�dia m�vel. A fun��o desse filtro �, a partir de v�rias
     leituras de um sensor, atrav�s do conversor AD, obter uma m�dia de v�rios valores medidos pelo sensor. Por�m, diferentemente de uma
     m�dia comum, onde s�o feitas v�rias medidas num mesmo instante, a m�dia m�vel faz v�rias medidas a medida que o tempo passa.
        O funcionamento de um filtro digital de m�dia m�vel consiste em alimentar um vetor com v�rias medidas feitas pelo sensor e, sempre
     que houver uma nova leitura, o vetor apagar� o �ltimo elemento do vetor, que corresponde a leitura mais antiga, e colocar� a leitura
     mais recente no primeiro elemento do vetor. Com isso, a m�dia m�vel consiste na m�dia dos valores dentro do vetor. Logo, a m�dia �
     m�vel pois estar� sempre atualizando no tempo.
        O diferecial desta m�dia consiste no fato de as medidas n�o serem feitas todas no mesmo intervalo de tempo. As medidas s�o feitas
     uma por uma de tempos em tempos, que depende do programa mas, ainda sim, um tempo muito r�pido. Assim, caso haja uma forte interfe-
     r�ncia no sensor e, assim, haja uma leitura errada, o filtro n�o deixar� esse acontecimento percept�vel na leitura do sensor.
        Para demonstrar esse filtro ser� utilizado o projeto "SensorTemperaturaLCD" que, a princ�pio, utiliza em suas medidas uma m�dia
     instant�nea nas leituras do sensor.
        Como j� dito, a m�dia instant�nea faz uma m�dia dos valores medidos instant�neamente, isto �, quase ao mesmo tempo, em um intervalo
     de tempo muito pequeno. O filtro de m�dia m�vel, faz essas leituras uma por vez e guarda em um vetor. Quando o vetor est� cheio, se tem
     uma m�dia de valores que correspondem a leituras feitas num espa�o de tempo maior, impedindo que mudan�as abruptas de tens�o, geradas
     por interfer�ncias externas, alterem a medida do sensor. Na m�dia instant�nea, uma mudan�a abrupta de tens�o ocorrida no momento da
     leitura do sensor, mesmo fazendo uma m�dia dos valores lidos, pode ocasionar numa m�dia que n�o corresponde ao valor exato de leitura
     do sensor, isso porque, no pequeno tempo em que as leituras foram feitas, houve a interfer�ncia externa.
        Pelo motivo de se ter a m�dia m�vel somente quando o vetor est� cheio, tempo esse que depende do programa, � caracter�stica desse
     filtro demorar uns poucos segundos para estabilizar sua leitura. Por�m esse processo � bem r�pido.
     
        No proteus � muito interessante ver este programa funcionando, pois d� para notar a media alterando de forma suave at� estabilizar
     no valor real da temperatura.
        Isso tamb�m ocorre na pr�tica!
        
*/

// Configura��o do LCD
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

// Fun��es auxiliares
void escreveDisplay();
void CustomChar(char linha, char coluna);
void celsius();
long mediaMovel();

// Vari�veis auxiliares
#define N 50
const char character[] = {6,9,6,0,0,0,0,0};
long movingAverage;
float temperatura = 0.0;
float ultimaTemperatura = 0.0;
char txt[7];
int media[N];
int adc = 0x00;


void main() {

     // Configura��o de registradores
     ADCON0 = 0x01; // Configura AN0 como canal anal�gico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de convers�o entre Vss e Vdd e configura o apenas AN0 como porta anal�gica
     TRISA = 0xFF; // Configura todo porta como entrada digital, exceto AN0 que � entrada anal�gica
     TRISD = 0x03; // Configura apenas RD0 e RD1 como entradas digitais, pois n�o ser�o usadas

     // Inicializa��o do LCD
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












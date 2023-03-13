/* 

        Este programa tem a fun��o de medir a temperatura atrav�s de um sensor LM35 e, atrav�s do conversor AD, fazer a leitura do sinal
     do sensor. Atrav�s do c�digo, equacionamos o sinal recebido de forma que o convertemos em temperatura em graus celsius.
        Este c�digo � muito interessante pois nele se utiliza algumas t�cnicas de programa��o que tornam o circuito mais profissional e mais
     preciso. A temperatura lida no display ser� a m�dia de 100 medi��es instant�neas, para o caso de que, se houver algum erro de leitura,
     este erro seja absorvido e filtrado pela m�dia. Ainda, utiliza-se um teste para saber se a temperatura atual � muito pr�xima da �ltima
     medi��o. Caso seja, a temperatura n�o � atualizada no display. Isso ajuda a evitar que os �ltimos n�meros da temperatura fiquem
     cintilando, isto �, alterando muito rapidamente pela atualiza��o instant�nea. Testando se a temperatura alterou com determinada precis�o,
     esvita-se que esse cintilamento ocorra.
        Esse cintilamento ocorre na pr�tica pois, com a atualiza��o instant�nea do display, ele tende a mostrar as pequenas varia��es de
     leitura do sensor, o que � normal quando se tem uma leitura muito precisa.
        Ainda, neste c�digo � utlizada uma ferramenta do MikroC que gera caracteres especiais. Em Tool, na op��o LCD Custom Character con-
     segue-se desenhar um simbolo nos pixel do display. A partir deste desenho essa ferramenta cria uma fun��o que escreve o simbolo
     desenhado no display. Neste c�digo, utiliza-se esta ferramenta para criar o s�mbolo de grau.
     
     Convers�o de ADC para temperatura:
     
     5V      ---------- 1024
     Tensao  ---------- adc
             Tensao = (5 x adc) / 1024
        
     Temperatura = Tensao x 100
     
     Ex:
     adc = 85
     
     Tensao = (5 x 85) / 1024 = 0.42V
     
     Temperatura  = 0.42 x 100 = 42�C, uma vez que o LM35 tem a precis�o de 0.1V / �C
     
*/

// Configura��o display lcd
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
void escreveDisplay(); // Imprime texto do display
void celsius(); // Converte a leitura AD em graus
int mediaADC(); // Calcula a media de 100 medi��es do conversor AD
void CustomChar(char linha, char coluna); // Fun��o de caracter especial, criada pela ferramenta LCD Custom Character e que imprime
                                          // o s�mbolo de grau

// Vari�veis auxiliares
const char character[] = {7,5,7,0,0,0,0,0}; // Vari�vel criada pela ferramenta LCD Custom Character
int mediaTemp = 0x00; // Recebe a media de 100 conversoes AD
float tensao = 0.0; // Calcula tensao medida pelo ADC
float temperatura = 0.0; // Transforma a tensao lida em temperatura em graus celcius
float ultimaTemp = 0.0; // Recebe a ultima temperatura medida
char txt[7];


void main() {

     ADCON0 = 0x01; // Seleciona e habilita o canal AN0 e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de convers�o entre a tens�o da fonte (Vss a Vdd) e configura somente AN0 como porta anal�gica
     TRISA = 0xFF; // Configura todo porta como entrada
     TRISD = 0x03; // Ou 0b00000011, que configura apenas RD0 e RD1 como entrada digitais, pois n�o ser�o utilizados

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     
     escreveDisplay();
     
     while(1){
     
       celsius();
     }
}

void celsius(){

     mediaTemp = mediaADC();
     
     tensao = ((mediaTemp * 5.0) / 1024.0);
     
     temperatura = tensao * 100.0;
     
     if(temperatura > (ultimaTemp + 0.5) || temperatura < (ultimaTemp - 0.5)){
     
        ultimaTemp = temperatura;
        
        FloatToStr(ultimaTemp, txt);
        
        lcd_chr(2, 4, txt[0]); // Imprime na coluna 4 a posi��o 0 da string txt
        lcd_chr_cp(txt[1]); // Imprime na coluna 5 a posi��o 1 da string txt
        lcd_chr_cp(txt[2]); // Imprime na coluna 6 a posi��o 2 da string txt
        lcd_chr_cp(txt[3]); // Imprime na coluna 7 a posi��o 3 da string txt
        lcd_chr_cp(txt[4]); // Imprime na coluna 8 a posi��o 4 da string txt
        CustomChar(2, 9);
        lcd_chr(2, 10, 'C');
     }
}

int mediaADC(){

    int adc = 0x00;
    int i;
    
    for(i = 0x00; i < 0x64; i++) // 0x64 = 100 decimal
          adc += adc_read(0); // Soma 100 vezes a leitura do adc na vari�vel adc
          
    return (adc/0x64); // Divide o somatorio de 100 leituras do adc por 100 = 0x64, resultando na media de leituras
}

void CustomChar(char linha, char coluna) {
    
    char i;
    
    Lcd_Cmd(64);
    
    for (i = 0; i <= 7; i++) Lcd_Chr_CP(character[i]);
    
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(linha, coluna, 0);
}

void escreveDisplay(){

     lcd_chr(1, 2, 'T');
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
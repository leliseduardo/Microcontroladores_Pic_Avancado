/* 

        Este programa tem a função de medir a temperatura através de um sensor LM35 e, através do conversor AD, fazer a leitura do sinal
     do sensor. Através do código, equacionamos o sinal recebido de forma que o convertemos em temperatura em graus celsius.
        Este código é muito interessante pois nele se utiliza algumas técnicas de programação que tornam o circuito mais profissional e mais
     preciso. A temperatura lida no display será a média de 100 medições instantâneas, para o caso de que, se houver algum erro de leitura,
     este erro seja absorvido e filtrado pela média. Ainda, utiliza-se um teste para saber se a temperatura atual é muito próxima da última
     medição. Caso seja, a temperatura não é atualizada no display. Isso ajuda a evitar que os últimos números da temperatura fiquem
     cintilando, isto é, alterando muito rapidamente pela atualização instantânea. Testando se a temperatura alterou com determinada precisão,
     esvita-se que esse cintilamento ocorra.
        Esse cintilamento ocorre na prática pois, com a atualização instantânea do display, ele tende a mostrar as pequenas variações de
     leitura do sensor, o que é normal quando se tem uma leitura muito precisa.
        Ainda, neste código é utlizada uma ferramenta do MikroC que gera caracteres especiais. Em Tool, na opção LCD Custom Character con-
     segue-se desenhar um simbolo nos pixel do display. A partir deste desenho essa ferramenta cria uma função que escreve o simbolo
     desenhado no display. Neste código, utiliza-se esta ferramenta para criar o símbolo de grau.
     
     Conversão de ADC para temperatura:
     
     5V      ---------- 1024
     Tensao  ---------- adc
             Tensao = (5 x adc) / 1024
        
     Temperatura = Tensao x 100
     
     Ex:
     adc = 85
     
     Tensao = (5 x 85) / 1024 = 0.42V
     
     Temperatura  = 0.42 x 100 = 42ºC, uma vez que o LM35 tem a precisão de 0.1V / ºC
     
*/

// Configuração display lcd
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
void escreveDisplay(); // Imprime texto do display
void celsius(); // Converte a leitura AD em graus
int mediaADC(); // Calcula a media de 100 medições do conversor AD
void CustomChar(char linha, char coluna); // Função de caracter especial, criada pela ferramenta LCD Custom Character e que imprime
                                          // o símbolo de grau

// Variáveis auxiliares
const char character[] = {7,5,7,0,0,0,0,0}; // Variável criada pela ferramenta LCD Custom Character
int mediaTemp = 0x00; // Recebe a media de 100 conversoes AD
float tensao = 0.0; // Calcula tensao medida pelo ADC
float temperatura = 0.0; // Transforma a tensao lida em temperatura em graus celcius
float ultimaTemp = 0.0; // Recebe a ultima temperatura medida
char txt[7];


void main() {

     ADCON0 = 0x01; // Seleciona e habilita o canal AN0 e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão entre a tensão da fonte (Vss a Vdd) e configura somente AN0 como porta analógica
     TRISA = 0xFF; // Configura todo porta como entrada
     TRISD = 0x03; // Ou 0b00000011, que configura apenas RD0 e RD1 como entrada digitais, pois não serão utilizados

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
        
        lcd_chr(2, 4, txt[0]); // Imprime na coluna 4 a posição 0 da string txt
        lcd_chr_cp(txt[1]); // Imprime na coluna 5 a posição 1 da string txt
        lcd_chr_cp(txt[2]); // Imprime na coluna 6 a posição 2 da string txt
        lcd_chr_cp(txt[3]); // Imprime na coluna 7 a posição 3 da string txt
        lcd_chr_cp(txt[4]); // Imprime na coluna 8 a posição 4 da string txt
        CustomChar(2, 9);
        lcd_chr(2, 10, 'C');
     }
}

int mediaADC(){

    int adc = 0x00;
    int i;
    
    for(i = 0x00; i < 0x64; i++) // 0x64 = 100 decimal
          adc += adc_read(0); // Soma 100 vezes a leitura do adc na variável adc
          
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
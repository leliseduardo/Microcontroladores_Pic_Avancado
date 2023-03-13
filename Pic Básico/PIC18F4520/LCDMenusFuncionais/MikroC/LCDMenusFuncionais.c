/* 

        O objetivo deste programa é implementar uma função para cada menu desenvolvido no projeto anterior, denominado "LCDMenusSimples". Para isso
    serão usadas várias ferramentas já aprendidas e já usadas anteriormente. Para os termômetros, o conversor AD, para o voltímetro, de novo o
    conversor AD, para o contador de pulsos, a interrupção externa e para o contador de tempo o timer0 e para as entradas do Pic.
        Como só tenho um LM35 a leitura para temperatura interna e externa será a mesma. Mas quando eu obtiver outro, facilente este será implemen-
    tado. Para o contador de pulsos, os pulsos virão de um simples botão, que gera um pulso ao ser pressionado. Isso porque não tenho um gerador de
    funções e montar um circuito oscilador agora fará com que eu perca o foco do programa e circuito.
        Para facilitar o processo de programação, irei copiar o código do projeto "LCDMenusSimples" e implementar as funções de cada menu aqui,
    neste programa. As funções que deverão ser implementadas são:
        - Função de temperatura e função de media de temperaturas
        - Função para o voltímetro
        - Função para o contador de pulsos
        - Função para o contador de tempo
        - Função que verifica o estado do dip Switch

        Depois de alguns problemas com a impressão da temperatura e do voltímetro, que foram resolvidos com sucesso, o circuito tanto no proteus
    quanto na prática funcionaram perfeitamente.
        Agora, depois de terminado, farei umas ressalvas do projeto e também irei especificar quais ferramentas do Pic utilizei para cada função
    associada a um menu.
        Tive alguns problema de impressão com o voltímetro, que ocorreram por algum motivo que desconheço e no processo de leitura e equacionamen-
    to da tensão. Porém, utilizando a função "FloatToStr" e a impressão de cada elementro separado da string de caracteres, foi possível
    imprimir a temperatura. A mudança para o canal analógico 1 (AN1), também evitou algumas instabilidades da impressão.
        Quanto à impressão da temperatura, o problema foi de lógica, que está explicado na própria função. Nesta função, a impressão também foi
    realizada por meio da função "FloatToString" e da impressão de cada elemento da string de caracteres.
    
        Neste programa, para implementar uma função para cada menu, foram utilizadas ferramentas diferentes do Pic, uma vez que cada menu continha
    uma função diferente.
        Para a leitura de temperaturas foi utilizado o conversor AD para leitura de um sensor de temperatura, o LM35. No caso, foi utilizado apenas
    o canal AN0 e um único sensor para simular a temperatura interna e externa de um cômodo. Porém, neste mesmo programa consegue-se adicionar mais
    um sensor e simular com dois sensores. Foi necessário alterar os canais do conversor AD entra 0 e 1 (AN0 eAN1), pois o voltímetro está conecta-
    do no canal 1.
        Para o voltímetro foi utilizado novamente o conversor AD para leitura de um potenciômetro, que altera sua tensão. Para evitar algumas
    instabilidades que foram notadas no programa, foi necessário alterar o canal do conversor AD, inicialmente configurado para o canal 0 (AN0),
    para o canal 1 (AN1), onde o pontenciômetro está conectado.
        Para o contador de pulsos foi utilizado a interrupção externa INT0, configurada como borda de subida. Assim, sempre que um botão tem uma
    borda de subida, ou um pulso externo muda de Low para High, o pulso incrementa e é impresso no display.
        Para a contagem de tempo foi utilizado o timer0 configurado para estourar a cada 50ms. Desta forma, com um contador dentro da função de
    interrupção do timer0, foi possível chegar a 1s. Assim, o contador de tempo incrementa a cada 1s e esse tempo é impresso no display.
        Para o leitor de entradas não foi usado nenhuma ferramenta do Pic específica. Simplesmente foi utilizado a leitura de botões, no caso um
    Dip Switch, na porta onde foram conectados estes botões. Assim, foi impresso se eles estavam pressionados ou não, no caso no Dip Switch, se
    eles estavam setados ou não.
    
    ********** Timer0 **********
    
    Ciclo de maquina = 1/(4MHz/4) = 1us
    <TMR0L::TMR0H> = 2^16 = 65536
    Tempo Overflow = 50ms
    Contagem = 50ms/1us = 50000
    65536 - 50000 = 15536(decimal) = 0x3CB0(hexadecimal)
    
    TMR0L = 0xB0
    TMR0H = 0x3C
    
    Overflow = (65536 - <TMR0L::TMR0H>) * Prescaler * Ciclo de maquina
    Overflow = 15536 * 1 * 1us
    Overflow = 50ms

*/

// Configuração do display LCD
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

// Configuação de hardware
#define voltaMenu RB6_bit
#define avancaMenu RB7_bit
#define numeroMenus 6
#define chave1 RB1_bit
#define chave2 RB2_bit

// Funções auxiliares
void CustomChar(char pos_row, char pos_char);
void leitura_Botoes();
void apaga_Display();

void menu1();
void menu2();
void menu3();
void menu4();
void menu5();
void menu6();

void celsius();
int mediaTemperatura();
void voltimetro();
void conta_Pulsos();
void conta_Tempo();
void dipSwitch();

// Variáveis auxiliares
const char character[] = {6,9,6,0,0,0,0,0};
char flagBotoes = 0x00;
bit apagaDisplay;
char menuControl = 0x01;

float temperatura = 0.0;
float ultimaTemperatura = 0.0;
bit tempControl;
char textoTemp[5];
int media = 0;

float volt = 0.0;
char textoVoltimetro[5];

unsigned long contPulsos = 0;
char textoPulsos[12];

unsigned long contTempo = 0;
char contAux = 0x00;
char textoTempo[12];

// Função de interrupção
void interrupt(){

     if(INT0IF_bit){
     
       INT0IF_bit = 0x00;
       
       contPulsos++;
     
     } // end if INT0IF_bit

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
       TMR0H = 0x3C;
       
       contAux++;
       
       if(contAux == 20){
       
         contAux = 0x00;
         
         contTempo++;
       
       } // end if contAux == 20
     
     } // end if TMR0IF_bit

} // end void interrupt


void main() {

     // Configuração de registradores
     
     // Registradores da interrupção interna INT0 e do TIMER0
     INTCON = 0xF0; // Habilita a interrupção global, a interrupção externa INT0 e a interrupção por overflow do timer0

     // INTCON2
     INTEDG0_bit = 0x01; // Configura a interrupção externa por borda de subida
     
     // T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o incremento do timer0 a partir do ciclo de maquina
     PSA_bit = 0x01; // Não associa o timer0 ao prescaler, o que equivale ao prescaler 1:1
     
     // <TMR0L::TMR0H>>
     TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
     TMR0H = 0x3C;
     
     // Registradores do conversor AD
     ADCON0 = 0x01; // Habilita o conversor AD
     ADCON1 = 0x0D; // Configura apenas AN0 e AN1 como entrada analógicas

     // Registradores de direção dos ports
     TRISA = 0xFF; // Configura todo o porta como entrada digital, exceto RA0/AN0 e RA1/AN1, que são entrada analógicas
     TRISB = 0xFF; // Configura todo o portb como entrada digital
     PORTB = 0xF9; // Apenas RB1 e RB2 iniciam em Low, pois estão ligadas em Pull-Down
     
     tempControl = 0;

     apagaDisplay = 0;

     lcd_init();
     lcd_cmd(_LCD_CLEAR);
     lcd_cmd(_LCD_CURSOR_OFF);

     // Loop infinito
     while(1){

       leitura_Botoes();

       switch(menuControl){

         case 0x01: menu1();
                    break;
         case 0x02: menu2();
                    break;
         case 0x03: menu3();
                    break;
         case 0x04: menu4();
                    break;
         case 0x05: menu5();
                    break;
         case 0x06: menu6();
                    break;

       } // end switch menuControl

     } // end loop infinito

} // end void main

// ======================================================================================================================================

// Funções dos menus

// ======================================================================================================================================

void celsius(){

    ADCON0 = 0x01; // Seleciona o canal 0 do conversor AD

    media = mediaTemperatura();
    
    temperatura = ((media * 5.0)/1024.0);
    temperatura = temperatura * 100.0;
    
    if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5))
      ultimaTemperatura = temperatura;
      
    FloatToStr(ultimaTemperatura, textoTemp);

    if(ultimaTemperatura < 0.05){
      lcd_chr(2, 6, 48);
      lcd_chr_cp(48);
      lcd_chr_cp('.');
      lcd_chr_cp(48);
      lcd_chr_cp(48);
     } // end if ultimaTemperatura < 0.05
     else{
       lcd_chr(2, 6, textoTemp[0]);
       lcd_chr_cp(textoTemp[1]);
       lcd_chr_cp(textoTemp[2]);
       lcd_chr_cp(textoTemp[3]);
       lcd_chr_cp(textoTemp[4]);
     } // end else
    customChar(2, 13);
    lcd_chr(2, 14, 'C');

    /* 
    
          Aqui estava ocorrendo um erro de lógica. Quando eu trocava os menus das temperaturas internas para externas, não imprimia nenhuma tempera-
       tura. Quando eu voltava para a temperatura interna, também não imprimia. Isso ocorria porque as funções de impressão estavam dentro do
       if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5)). Assim, o display só iria imprimir a temperatura se
       houvesse uma alteração de mais de 0.5ºC. Como estou utilizando o mesmo sensor, não havia diferença de temperatura interna e interna e, assim,
       não tinha alteração na temperatura e não imprimia nada. Por isso, ao trocar de displays a temperatura sumia, ela só iria ser impressa nova-
       mente ao haver a alteração da temperatura. Isso também poderia ocorrer caso houvessem dois sensores e eles estivesse marcando a mesma tempe-
       ratura.
          Assim, para resolver este erro de lógica, eu tirei as funções que fazem a impressão da temperatura no display de dentro do "if". Assim,
       a temperatura sempre será impressa. Porém, só irá alterar a temperatura impressa caso houver uma mudança de 0.5ºC. A variável
       ultimaTemperatura, dentro do "if", será atualizada quando a temperatura medida sofrer essa variação, e é esta variável que será tranformada
       em String para ser impressa. Dessa forma, sempre será impressa a última temperatura atualizada, com uma variação mínima de 0.5ºC.
      
    */

} // end void celsius

int mediaTemperatura(){

     char i;
     int adc = 0;
     
     for(i = 0; i < 0x64; i++){

       if(!tempControl) adc += adc_read(0);
       else adc += adc_read(0);

     } // end for

     return (adc/0x64);
} // end void mediaTemperatura
     
void voltimetro(){

     char mil = 0x00, cen = 0x00, dez = 0x00, uni = 0x00;
     int adc = 0;
     
     adc = adc_read(1);
     
     volt = ((adc * 5.0)/1024.0);
     
     FloatToStr(volt, textoVoltimetro);
     
     if(volt < 0.01){
       lcd_chr(2, 8, 48);
       lcd_chr_cp(48);
       lcd_chr_cp('.');
       lcd_chr_cp(48);
       lcd_chr_cp(48);
       lcd_chr_cp(' ');
       lcd_chr_cp(' ');
       lcd_chr_cp(' ');
     }// end if volt < 0.01
     else{
       lcd_chr(2, 8, textoVoltimetro[0]);
       lcd_chr_cp(textoVoltimetro[1]);
       lcd_chr_cp(textoVoltimetro[2]);
       lcd_chr_cp(textoVoltimetro[3]);
       lcd_chr_cp(textoVoltimetro[4]);
       if(volt < 1){
         lcd_chr_cp('E');
         lcd_chr_cp('-');
         lcd_chr_cp(49); // numero "1"
       } // end if volt < 1
       else{
         lcd_chr_cp(' ');
         lcd_chr_cp(' ');
         lcd_chr_cp(' ');
       } // end else
       lcd_chr(2, 16, 'V');
     } // end else

} // end voltimetro

void conta_Pulsos(){

     LongToStr(contPulsos, textoPulsos);
     
     lcd_Out(2, 2, textoPulsos);
                          
} // end void conta_Pulsos

void conta_Tempo(){

     LongToStr(contTempo, textoTempo);
     
     lcd_out(2, 2, textoTempo);

} // end void conta_Tempo

void dipSwitch(){

     if(!chave1) lcd_out(2, 1, "Ch1:Off");
     else lcd_out(2, 1, "Ch1:On ");

     if(!chave2) lcd_out(2, 9, "Ch2:Off");
     else lcd_out(2, 9, "Ch2:On ");

} // end void dipSwitch


// ======================================================================================================================================

// Menus

// ======================================================================================================================================

void leitura_Botoes(){

     if(!voltaMenu) flagBotoes.B0 = 0x01;
     if(!avancaMenu) flagBotoes.B1 = 0x01;

     if(voltaMenu && flagBotoes.B0){

       flagBotoes.B0 = 0x00;
       apagaDisplay = 1;
       menuControl--;

       if(menuControl == 0) menuControl = numeroMenus;

     } // end if voltaMenu && flagBotoes.B0

     if(avancaMenu && flagBotoes.B1){

       flagBotoes.B1 = 0x00;
       apagaDisplay = 1;
       menuControl++;

       if(menuControl == (numeroMenus+1)) menuControl = 0x01;

     } // end if avancaMenu && flagBotoes.B1

} // end void leitura_Botoes

void apaga_Display(){

     if(apagaDisplay){

       apagaDisplay = 0;

       lcd_cmd(_LCD_CLEAR);

     } // end if apagaDisplay

} // end void apaga_Display

void menu1(){

     apaga_Display();

     lcd_chr(1, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('m');
     lcd_chr_cp('p');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('t');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp('a');

     lcd_chr(2, 1, 'I');
     lcd_chr_cp('n');
     lcd_chr_cp('t');
     lcd_chr_cp(':');
     
     tempControl = 0;
     celsius();

} // end void menu1

void menu2(){

     apaga_Display();

     lcd_chr(1, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('m');
     lcd_chr_cp('p');
     lcd_chr_cp('e');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('t');
     lcd_chr_cp('u');
     lcd_chr_cp('r');
     lcd_chr_cp('a');

     lcd_chr(2, 1, 'E');
     lcd_chr_cp('x');
     lcd_chr_cp('t');
     lcd_chr_cp(':');
     
     tempControl = 1;
     celsius();

} // end void menu2


void menu3(){

     apaga_Display();

     lcd_chr(1, 2, 'V');
     lcd_chr_cp('o');
     lcd_chr_cp('l');
     lcd_chr_cp('t');
     lcd_chr_cp('i');
     lcd_chr_cp('m');
     lcd_chr_cp('e');
     lcd_chr_cp('t');
     lcd_chr_cp('r');
     lcd_chr_cp('o');

     lcd_chr(2, 1, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('n');
     lcd_chr_cp('s');
     lcd_chr_cp('a');
     lcd_chr_cp('o');
     lcd_chr_cp(':');
     
     ADCON0 = 0x05; // Seleciona o canal 1 do conversor AD
     voltimetro();

} // end void menu3


void menu4(){

     apaga_Display();

     lcd_chr(1, 2, 'P');
     lcd_chr_cp('u');
     lcd_chr_cp('l');
     lcd_chr_cp('s');
     lcd_chr_cp('o');
     lcd_chr_cp('s');
     lcd_chr_cp(':');
     
     conta_Pulsos();

} // end void menu4


void menu5(){

     apaga_Display();

     lcd_chr(1, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('m');
     lcd_chr_cp('p');
     lcd_chr_cp('o');
     
     conta_Tempo();

} // end void menu5


void menu6(){

     apaga_Display();

     lcd_chr(1, 2, 'E');
     lcd_chr_cp('n');
     lcd_chr_cp('t');
     lcd_chr_cp('r');
     lcd_chr_cp('a');
     lcd_chr_cp('d');
     lcd_chr_cp('a');
     lcd_chr_cp('s');

     dipSwitch();

} // end void menu6


void CustomChar(char pos_row, char pos_char) {
  char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);
}

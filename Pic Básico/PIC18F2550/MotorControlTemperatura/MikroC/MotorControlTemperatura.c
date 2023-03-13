/* 

        O objetivo deste programa é acrescentar ao projeto da última aula, denominado "MotorPartidaSuave", um sensor de temperatura que controle
     a temperatura na carcaça do motor. Se a temperatura na carcaça do motor for maior do que a temperatura programada, a saída "led" é setada e
     o motor diminui sua velocidade até que a temperatura fique abaixo do valor mínimo programado. O led usado para indicar que a temperatura está
     alta pode, em aplicações reais, ser um cooler que resfrie o motor. Daí, o cooler mais a diminuição da velocidade do motor farão com que a
     temperatura abaixe.
        O código usado neste programa será o mesmo do último projeto, acrescentando apenas as configurações para a leitura do sensor de temperatura
     e da saída digital, no caso o led.
     
        Por algum motivo a ferramenta LCD Custom Char gera para mim um código para o simbolo de graus, com a função "Lcd_Cmd(73)". Isto é, com
     o parâmetro 73. Porém, na prática, o simbolo fica com um risco em cima do simbolo. Ao mudar o parâmetro para 72, "Lcd_Cmd(72)", o risco sai.
     O professor não explicou por que isso ocorre, talvez eu tenha que estudar mais a fundo os displays lcd ou esta ferramenta do MikroC, pelo
     Help.
     
        Na prática o circuito funcionou perfeitamente.

*/

// Configuração do display lcd
// Lcd pinout settings
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// Mapeamento de hardware
#define botao RB0_bit
#define backLight LATB1_bit
#define pwm LATC0_bit
#define led LATC1_bit
#define start RC2_bit

// Funções auxiliares
void leitura_Botoes();
void base_Tempo();
void imprime_Display();
void inicia_Motor();
void celsius();
int media_Temperatura();
void CustomChar(char pos_row, char pos_char);


// Variáveis auxiliares
unsigned short valor = 0x80,
         baseTempo = 0x00,
         contBotao = 0x00,
         contTempo = 120,
         controlAdiciona = 0x00,
         duty = 0x00;
         
float temperatura = 0.0,
      ultimaTemperatura = 0.0;
int adc = 0x00;
char txt[7];
const char character[] = {6,9,6,0,0,0,0,0};

bit flagBotao;
bit controlRapido;
bit flagStart;

// Funções de interrupção
void interrupt(){

     if(TMR0IF_bit){

       TMR0IF_bit = 0x00;
       TMR0H = 0x9E;
       TMR0L = 0x58;

       baseTempo++;
       contTempo++;

       if(contTempo > 120){

         backLight = 0x00;
         contTempo = 120;
         controlAdiciona = 0x00;

       } // end if contTempo > 120

       if(flagBotao) contBotao++;

       base_Tempo();

     } // end if TMR0IF_bit

     if(TMR2IF_bit){

       TMR2IF_bit = 0x00;

       if(duty == 0x00) pwm = 0x00;
       else {
         if(pwm){

           TMR2 = duty;
           pwm = 0x00;

         } // end if pwm
         else{

           TMR2 = 255 - duty;
           pwm = 0x01;

         } // end else pwm
       } // end else duty == 0x00;
     } // end TMR2IF_bit

} // end void interrupt

void main() {

     // Configuração de registradores
     ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e ativa o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura AN0 como entrada analógica
     TRISB = 0x01; // Configura apenas RB0 como entrada digital, o resto como saída
     TRISC = 0xFC; // Configura apenas RC0 e RC1 como saídas digitais, o resto como entrada
     LATC = 0xFC; // Inicia todas as saídas digitais em Low

     INTCON = 0xE0; // Habilita a interrupção global, por perfiféricos e a interrupção por overflow do timer 0
     INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb

     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
     TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
     TMR0L = 0x58;

     T2CON = 0x05; // Habilita o timer2, configurao postscale em 1:1 e o prescale em 1:4
     PR2 = 0xFF; // O contador TMR2 conta até 256
     TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2

     flagBotao = 0x00;
     controlRapido = 0x00;
     flagStart = 0x00;

     // Inicialização do display lcd
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_chr(1, 2, 'D');
     lcd_chr_cp('u');
     lcd_chr_cp('t');
     lcd_chr_cp('y');
     lcd_chr_cp(':');
     lcd_chr(2, 2, 'T');
     lcd_chr_cp('e');
     lcd_chr_cp('m');
     lcd_chr_cp('p');
     lcd_chr_cp(':');
     
     
     // Loop infinito
     while(1){

       leitura_Botoes();

       imprime_Display();
       
       celsius();
       
       if(temperatura > 31){
       
         duty = 0x3C; // duty = 60 decimal
         led = 0x01;
       
       } // end if temperatura > 30
       
       if(temperatura < 27 && led){
       
         inicia_Motor();
         led = 0x00;
       
       } // end if temperatura < 27 && led

     } // end loop infinito

} // end void main



void leitura_Botoes(){

     if(!botao){

       flagBotao = 0x01;
       backLight = 0x01;
       contTempo = 0x00;

     } // end if !botao

     if(botao && flagBotao){

       flagBotao = 0x00;
       contBotao = 0x00;
       controlRapido = 0x00;
       controlAdiciona++;

       if(controlAdiciona > 1) valor++;

     } // end if botao && flagBotao

     if(!led) 
       if(!start) flagStart = 0x01;

     if(start && flagStart){

       flagStart = 0x00;

       inicia_Motor();

     } // end if start && flagStart

} // end void leitura_Botoes




void base_Tempo(){

     if(contBotao == 40) controlRapido = 0x01; // Se botao ficar pressionado por 1s, ativa o incremento rapido

     if(baseTempo == 0x04){ // Tempo igual a 100ms

       baseTempo = 0x00;

       if(controlRapido) valor += 1; // Se incremento rapido ligado, incrementa a cada 100ms

     } // end if baseTempo == 0x04

} // end void base_Tempo





void imprime_Display(){

     unsigned char dig3, dig2, dig1;

     dig3 = valor/100;
     dig2 = (valor%100)/10;
     dig1 = valor%10;

     lcd_chr(1, 8, dig3 + 0x30);
     lcd_chr_cp(dig2 + 0x30);
     lcd_chr_cp(dig1 + 0x30);

} // end void imprime_Display



void inicia_Motor(){

     char i;
     duty = 0x00;

     for(i = 0x00; i < valor; i++){

       duty += 0x01;
       delay_ms(10);

     } // end for i = 0x00; i < valor; i++

} // end void inicia_Motor()


void celsius(){

     adc = media_Temperatura();
     
     temperatura = ((adc * 5.0) / 1024.0);
     
     temperatura = temperatura * 100.0;

     if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5)){
     
       ultimaTemperatura = temperatura;
       
       FloatToStr(temperatura, txt);
       
       lcd_chr(2, 8, txt[0]);
       lcd_chr_cp(txt[1]);
       lcd_chr_cp(txt[2]);
       lcd_chr_cp(txt[3]);
       lcd_chr_cp(txt[4]);
       lcd_chr_cp(txt[5]);
       CustomChar(2, 14);
       lcd_chr(2, 15, 'C');
       
     
     } // end if temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5

} // void celsius


int media_Temperatura(){

     char i;
     int media = 0x00;
     
     for(i = 0x00; i < 0x64; i++)
       media += adc_read(0);
       
     return (media/0x64);

} // end int media_Temperatura



void CustomChar(char pos_row, char pos_char) {
     
     char i;
     Lcd_Cmd(72);
     for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
     Lcd_Cmd(_LCD_RETURN_HOME);
     Lcd_Chr(pos_row, pos_char, 1);
     
}









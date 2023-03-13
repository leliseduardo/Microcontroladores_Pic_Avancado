/* 

        O objetivo deste programa é utilizar o PID para a simulação de um controle de temperatura. Para isso será utilizado os programas feitos
    nas últimas aulas, em específico o projeto "PIDSimples".
        O programa irá simular um sensor de temperatura que mede uma temperatura da carcaça de um motor, por exemplo, ou a temperatura de um forno,
    que precisam estar numa temperatura ideal aqui programada. Logo, com a temperatura medida e a temperatura ideal programada, o controle PID
    tentará, através do PWM, chegar à temperatura ideal. Ao PWM pode estar conectado um aquecedor um resfriador, como um cooler.

        O programa funcionou na prática.

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

// Funcções auxiliares
void controle_PID();
void imprime_Display();
void celsius();
int media_Temperatura();
void CustomChar(char pos_row, char pos_char);

// Variáveis auxiliares
double erro,
       PID,
       kp = 9.2,
       ki = 0.0,
       kd = 0.0,
       proporcional,
       integral,
       derivativo,
       valorIdeal = 25.0;

int medidaADC,
    ultimaMedida = 0x00,
    baseTempo = 0x00,
    duty = 128;
    
double temperatura = 0.0,
      ultimaTemperatura = 0.0;
int adc = 0x00;
char txt[7];
const char character[] = {6,9,6,0,0,0,0,0};

// Função de interrupção
void interrupt(){

     if(TMR0IF_bit){

       TMR0IF_bit = 0x00;
       TMR0H = 0x9E;
       TMR0L = 0x58;

       baseTempo += 1;

     } // end TMR0IF_bit

} // end void interrupt

void main() {

     // Registradores
     TRISA = 0xFF; // Cofigura todo porta como entrada

     ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e ativa o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura AN0 como entrada analógica

     INTCON = 0xA0; // Ativa a interrupção global e a interrupção por overflow do timer 0
     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de maquina e prescale de 1:4
     TMR0H = 0x9E; // Inicia em 40536 para uma contagem de 25000
     TMR0L = 0x58;

     // Inicialização do PWM
     PWM1_Init(1000);
     PWM1_Start();
     PWM1_Set_Duty(duty);

     // Inicialização do display lcd
     lcd_Init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1, 2, "Temp: ");
     lcd_out(2, 2, "PWM: ");

     // Loop infinito
     while(1){

       celsius();

       PWM1_Set_Duty(duty);

       if(baseTempo == 4){

         baseTempo = 0x00;

         controle_PID();

         imprime_Display();

       } // end if baseTempo == 4

     } // end Loop infinito

} // end void main

void controle_PID(){

     medidaADC = temperatura;

     erro = valorIdeal - medidaADC;

     proporcional = erro * kp;

     integral += (erro * ki * 100E-3);

     derivativo = (((ultimaMedida - medidaADC) * kd) / 100E-3);

     ultimaMedida = medidaADC;

     PID = proporcional + integral + derivativo;

     PID = PID/4; // Normalização, pois ADC tem 10 bits e o PWM tem 9 bits
     duty = PID + 128;
     if(duty == 256) duty = 255;

     /*

          O PID aqui está programado para ser inversamente proporcional, pois, se a medida for maior que o valor ideal, o erro será negativo. Daí,
       o PID será negativo e o valor de Duty será menor que 128. Logo, quanto maior a medida, menor o valor do Duty. Analogamente, se o valor
       medido for menor que o valor ideal, o PID será positivo e o Duty será maior que 128. Logo, quanto menor o valor medido, maior o PWM.

     */

} // end void controle_PID


void imprime_Display(){

     char cen, dez, uni;

     cen = duty/100;
     dez = (duty%100)/10;
     uni = duty%10;

     lcd_chr(2, 7, cen + 48);
     lcd_chr_cp(dez + 48);
     lcd_chr_cp(uni + 48);

} // end void imprime_Display

void celsius(){

     adc = media_Temperatura();

     temperatura = ((adc * 5.0) / 1024.0);

     temperatura = temperatura * 100.0;

     if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5)){

       ultimaTemperatura = temperatura;

       FloatToStr(temperatura, txt);

       lcd_chr(1, 8, txt[0]);
       lcd_chr_cp(txt[1]);
       lcd_chr_cp(txt[2]);
       lcd_chr_cp(txt[3]);
       lcd_chr_cp(txt[4]);
       lcd_chr_cp(txt[5]);
       CustomChar(1, 14);
       lcd_chr(1, 15, 'C');


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
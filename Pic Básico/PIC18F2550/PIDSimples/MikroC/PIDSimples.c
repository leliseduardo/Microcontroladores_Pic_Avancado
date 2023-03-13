/*

        O objetivo deste programa � criar um PID simples apenas para demonstra��o. Um potenci�metro ir� simular um sensor, enquanto um PWM ir�
    simular o controle de um atuador.
        O controle PID tem a fun��o de tentar aproximar o m�ximo o valor medido pelo sensor, do valor ideal programado. Para isso, calcula o erro
    entre o valor medido e o ideal e, atrav�s das constantes proporcional, integral e derivativo, calcula o melhor PWM para acionar o atuador e
    diminuir o erro.
        O controle PID � o primeiro passo para um controle inteligente de par�metros e, para um programa realmente funcional e um entendimento
    profundo de como este tipo de controle funciona, � necess�rio estudar teoria de controle. Aqui, neste programa, o que � feito � o b�sico de
    PID e apenas um projeto demonstrativo.
    
    ****************** Timer 0 com overflow de 25ms ****************************

    Ciclo de m�quina = 250ns
    Prescale = 4
    Overflow = contagem * prescale * ciclo de maquina
    25ms = contagem * 4 * 250ns
    contagem = 25ms / (4* 250ns)
    contagem = 25000

    <TMR0H::TMR0L> total = 65536
    <TMR0H::TMR0L> inicializa��o = 65536 - 25000 = 40536
    40536 decimal = 0x9E58 hexadecimal

    Logo:

    TMR0H = 0x9E
    TMR0L = 0x58

    ****************************************************************************
    
        Na pr�tica o circuito funcionou perfeitamente, de forma que quanto menor a leitura do ADC, maior o valor do PWM e, quanto maior a leitura
    do ADC, menor o valor do PWM. 
        Logo, este sistema funciona, por exemplo, como se tivesse controlando a temperatura de um aquecedor, onde o PWM controla a pot�ncia de
    um aquecedor e o sensor � de temperatura. Assim, definindo uma temperatura ideal, quanto maior o PWM, isto �, quanto maior a pot�ncia do 
    aquecedor, menor ser� o PWM, a fim de equilibrar a temperatura. Quanto mais baixa a temperatura, maior o valor do PWM, a fim de aquecer o
    aquecedor e chegar na temperatura ideal. O PID sempre tentar� fazer o valor medido ser o mais pr�ximo poss�vel do valor ideal, com o controle
    que tem, no caso, o PWM.


*/

// Configura��o do display lcd
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

// Func��es auxiliares
void controle_PID();
void imprime_Display();

// Vari�veis auxiliares
double erro,
       PID,
       kp = 1.0,
       ki = 0.0,
       kd = 0.0,
       proporcional,
       integral,
       derivativo,
       valorIdeal = 512.0;
       
int medidaADC,
    ultimaMedida = 0x00,
    baseTempo,
    duty = 128;
    
// Fun��o de interrup��o
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
     
     ADCON0 = 0x01; // Seleciona o canal AN0 como anal�gico e ativa o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de convers�o entre Vss e Vdd e configura AN0 como entrada anal�gica
     
     INTCON = 0xA0; // Ativa a interrup��o global e a interrup��o por overflow do timer 0
     T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de maquina e prescale de 1:4
     TMR0H = 0x9E; // Inicia em 40536 para uma contagem de 25000
     TMR0L = 0x58;

     // Inicializa��o do PWM
     PWM1_Init(1000);
     PWM1_Start();
     PWM1_Set_Duty(duty);

     // Inicializa��o do display lcd
     lcd_Init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1, 2, "ADC: ");
     lcd_out(2, 2, "PWM: ");
     
     // Loop infinito
     while(1){
     
       medidaADC = adc_read(0);
       
       PWM1_Set_Duty(duty);
       
       if(baseTempo == 40){
       
         baseTempo = 0x00;
       
         controle_PID();
         
         imprime_Display();
       
       } // end if baseTempo == 40
     
     } // end Loop infinito

} // end void main

void controle_PID(){

     erro = valorIdeal - medidaADC;
     
     proporcional = erro * kp;
     
     integral += (erro * ki * 1);
     
     derivativo = (((ultimaMedida - medidaADC) * kd) / 1);
     
     ultimaMedida = medidaADC;

     PID = proporcional + integral + derivativo;
     
     PID = PID/4; // Normaliza��o, pois ADC tem 10 bits e o PWM tem 9 bits
     duty = PID + 128;
     if(duty == 256) duty = 255;
     
     /*
     
          O PID aqui est� programado para ser inversamente proporcional, pois, se a medida for maior que o valor ideal, o erro ser� negativo. Da�,
       o PID ser� negativo e o valor de Duty ser� menor que 128. Logo, quanto maior a medida, menor o valor do Duty. Analogamente, se o valor
       medido for menor que o valor ideal, o PID ser� positivo e o Duty ser� maior que 128. Logo, quanto menor o valor medido, maior o PWM.
     
     */

} // end void controle_PID


void imprime_Display(){

     char dig1, dig2, dig3, dig4;
     char cen, dez, uni;
     
     dig4 = medidaADC/1000;
     dig3 = (medidaADC%1000)/100;
     dig2 = (medidaADC%100)/10;
     dig1 = medidaADC%10;
     
     lcd_chr(1, 7, dig4 + 48);
     lcd_chr_cp(dig3 + 48);
     lcd_chr_cp(dig2 + 48);
     lcd_chr_cp(dig1 + 48);
     
     cen = duty/100;
     dez = (duty%100)/10;
     uni = duty%10;
     
     lcd_chr(2, 7, cen + 48);
     lcd_chr_cp(dez + 48);
     lcd_chr_cp(uni + 48);

} // end void imprime_Display












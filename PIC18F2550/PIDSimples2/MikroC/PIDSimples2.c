/* 

        O objetivo deste programa é utilizar o código do último projeto, denominado "PIDSimples". Porém, agora o PID será diretamente proporcional
    à saída. Isto é, quanto menor for o valor medido pelo sensor, maior será o valor do PWM na saída, e quanto maior for o valor medido pelo sensor,
    menor será o PWM na saída.
        Para este programa, será utilizado um Led apontando para um LDR. Assim, definindo um valor ideal de luminosidade, o led vai ajustar seu
    brilho. Caso haja alguma barreira atrapalhando a luminosidade do LDR, a tensão no LDR irá subir, a medida ADC irá subir e o brilho do led irá
    aumentar, pois o PWM irá aumentar também.
        Os detalhes do circuito estão no proteus. O resistor que faz o divisor de tensão junto ao LDR é de 3k3 Ohms pois, nas condições de lumi-
    nosidade no momento em que estou testando este código, o LDR aparece com uma resistência próxima a este resistor. Logo, o valor de tensão
    sem a luminosidade do Led se aproxima à Vcc/2.
    
        Na prática o programa funcionou perfeitamente. Como eu já disse antes, é necessário estudar teoria de controle para um entendimento maior
    do controle PID.

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

// Variáveis auxiliares
double erro,
       PID,
       kp = 1.0,
       ki = 0.0,
       kd = 0.0,
       proporcional,
       integral,
       derivativo,
       valorIdeal = 100.0;

int medidaADC,
    ultimaMedida = 0x00,
    baseTempo,
    duty = 128;

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

     PID = PID/4; // Normalização, pois ADC tem 10 bits e o PWM tem 9 bits
     duty = 128 - PID;
     if(duty == 256) duty = 255;

     /*

          Neste programa, o PID é diretamente proporcional ao PWM. Se o valor medido for maior que o valor ideal, o erro é negativo. Logo, o PID
       é negativo e o Duty menor que 128. Se o erro for menor que o valor ideal, o PID é positivo e o Duty maior que 128.
          Esse tipo de controle pode ser usado com coolers de resfriamento. Isto é, quanto maior o sinal so sensor de temperatura, maior a tempera-
       tura e maior tem que ser a potência do cooler, logo o PWM é alto. Quanto mais baixa a temperatura, menor tem que ser a potência do cooler,
       e menor será o PWM.
          Esse controle também serve para o controle luminosidade, que é o exemplo prático deste código. Quanto menor a luminosidade, maior a
       tensão medida no LDR e, assim, maior será o PWM e o brilho de led, a fim de abaixar a tensão do LDR.

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



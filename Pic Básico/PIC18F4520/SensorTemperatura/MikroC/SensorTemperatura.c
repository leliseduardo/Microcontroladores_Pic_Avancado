/*

        Este projeto tem a função de ler um sensor de temperatura, que é o LM35, e mostrar a temperatura num display serial. Para isso utiliza-se
     uma entrada analógica. Ainda, é necessário usar uma equação para que o display demonstre a temperatura correta, uma vez que o sensor tem
     uma resolução de 10mV por 1ºC.
        Este projeto é simples e já foi feito anteriormente com os MCU's da família 16f. Porém, um problema que ainda continua é o uso da comuni-
     cação serial na prática, uma vez que meus cabos conversores USB/Serial parecem não funcionar. Anteriormente eu decidi não perder mais tempo
     tentantado fazer funcionar, pois este tipo de comunicação não é mais tão usado. Assim, o projeto será apenas simulado.
     
     No proteus, o sensor de temperatura não funciona. Usando um potenciômetro o programa funcionou perfeitamente.
*/

// Função auxiliar

void temperatura(float range); // Função auxiliar que recebe como parâmetro um valor Real (float). Este valor tem a função de dizer qual é a faixa de
                          // tensão cujo mcu irá ler. No caso deste programa será 5V.

// Variáveis auxiliares

int adc = 0x00;
float tensao = 0.0;
float temp = 0.0;
char txt[15];

void main() {

     // Registradores de configuração;

     ADCON0 = 0x01; // Habilita o canal 0 (AN0) como porta analógica e habilita o conversor analógico
     ADCON1 = 0x0E; // Configura o intervalo de conversão AD entre os limites da fonte (VSS e VDD) e configura apenas AN0 como porta analógica

     TRISA = 0xFF; // Configura todo porta como entrada

     // Iniciando comunicação serial

     UART1_Init(9600);
     delay_ms(100);
     
     UART1_Write_Text("Temperatura em Celsius");
     UART1_Write(10);
     UART1_Write(13);
     
     
     // Loop infinito
     
     while(1){

        temperatura(5.0);
        delay_ms(500);
     } // end while
} // end void main


void temperatura(float range){

    adc = ADC_Read(0);

    tensao = ((adc * range) / 1024); // Converte a leitura do adc para tensao
    
    temp = tensao * 100; // Converte a tensao lida no adc em temperatura

    FloatToStr(temp, txt);
    UART1_Write_Text(txt);
    UART1_Write(10);
    UART1_Write(13);
}













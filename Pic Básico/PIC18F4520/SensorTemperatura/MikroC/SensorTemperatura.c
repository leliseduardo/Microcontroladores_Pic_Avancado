/*

        Este projeto tem a fun��o de ler um sensor de temperatura, que � o LM35, e mostrar a temperatura num display serial. Para isso utiliza-se
     uma entrada anal�gica. Ainda, � necess�rio usar uma equa��o para que o display demonstre a temperatura correta, uma vez que o sensor tem
     uma resolu��o de 10mV por 1�C.
        Este projeto � simples e j� foi feito anteriormente com os MCU's da fam�lia 16f. Por�m, um problema que ainda continua � o uso da comuni-
     ca��o serial na pr�tica, uma vez que meus cabos conversores USB/Serial parecem n�o funcionar. Anteriormente eu decidi n�o perder mais tempo
     tentantado fazer funcionar, pois este tipo de comunica��o n�o � mais t�o usado. Assim, o projeto ser� apenas simulado.
     
     No proteus, o sensor de temperatura n�o funciona. Usando um potenci�metro o programa funcionou perfeitamente.
*/

// Fun��o auxiliar

void temperatura(float range); // Fun��o auxiliar que recebe como par�metro um valor Real (float). Este valor tem a fun��o de dizer qual � a faixa de
                          // tens�o cujo mcu ir� ler. No caso deste programa ser� 5V.

// Vari�veis auxiliares

int adc = 0x00;
float tensao = 0.0;
float temp = 0.0;
char txt[15];

void main() {

     // Registradores de configura��o;

     ADCON0 = 0x01; // Habilita o canal 0 (AN0) como porta anal�gica e habilita o conversor anal�gico
     ADCON1 = 0x0E; // Configura o intervalo de convers�o AD entre os limites da fonte (VSS e VDD) e configura apenas AN0 como porta anal�gica

     TRISA = 0xFF; // Configura todo porta como entrada

     // Iniciando comunica��o serial

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













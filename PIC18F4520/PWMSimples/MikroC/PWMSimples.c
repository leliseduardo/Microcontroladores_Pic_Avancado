/* 

        Este programa tem como objetivo introduzir o PWM do Pic da familia 18F. Para isso ser� utilizado a bibliteca de PWM do MikroC, que
    utiliza o m�dulo CCP do Pic, que est� relacionado com o timer2. Dessa forma, ser� uma maneira de iniciar o timer2.
        A �nica fun��o deste programa � ter uma sa�da PWM no pino do ccp1 e, atrav�s de bot�es, alterar o duty cicle do PWM.
        
        Os bot�es utilizados neste programa n�o utilizar�o flags para testar se foram clicados e, assim, evitar o bouncing do bot�o. Ser�o
    utilizados delays com um tempo muito pequeno, a fim de evitar esse bouncing e, da mesma forma, permitir que o bot�o, quando pressionado
    por um tempo, fa�a com que o incremento ou decremento do Duty Cicle ocorra mais vezes, at� onde se quer.
    
        Quando se utiliza a biblioteca PWM do MikroC, n�o � necess�rio configurar o pino CCP como sa�da, assim como nenhum outro registra-
    dor deste m�dulo.
    
        No proteus, o oscilosc�pio marcou um per�odo de 400us, que d� uma frequ�ncia de f = 1/400us = 2500 Hz. Que foi exatamente a
    frequ�ncia programada.
        Na pr�tica, utilizando um led na sa�da CCP, o circuito funcionou e a intensidade do brilho do led alterou-se de acordo com o incre-
    mento e decremento do Duty Cicle.
    
        � importante lembrar que a vari�vel duty, declarada como unsigned short, � uma vari�vel de 8 bits. Quando seu valor ultrapassa a
    255, automaticamente ela volta a 0, sem precisar fazer isso no programa. Da mesma forma, quando chega a zero e � incrementada, volta a
    255, num ciclo autom�tico
    
        Na linguagem C ANSI, declarar uma vari�vel como unsigned significa que ela assumir� apenas valores positivo, e nunca negativos.
    Declarar uma vari�vel como short, autom�ticamente � declarar a vari�vel como inteira (int) de 8 bits. Isto �, n�o necessita-se escrever
    "short int". Apenas "short" quer dizer que a vari�vel j� � "int", por�m, com 8 bits, e n�o 16 bits como normalmente � uma vari�vel int.
    Logo: "unsigned short" significa uma vari�vel inteira (int) que assume apenas valores positivos.

*/

// Configura��o de hardware
#define incrementa RB7_bit
#define decrementa RB6_bit

// Vari�veis auxiliares
unsigned short duty = 128; // Duty Cicle de 50%

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos, como digitais
     TRISB = 0xFF; // Configura todo o portb como entrada digital
     
     PWM1_Init(2500);
     PWM1_Start();
     PWM1_Set_Duty(duty);
     
     // loop infinito
     while(1){
     
       if(!incrementa){
       
         duty++;
         delay_ms(30);
       } // end if !incrementa
       else if (!decrementa){
       
         duty--;
         delay_ms(30);
       } // end if !decrementa
       
       PWM1_Set_Duty(duty);
     
     } // end loop infinito
} // end void main










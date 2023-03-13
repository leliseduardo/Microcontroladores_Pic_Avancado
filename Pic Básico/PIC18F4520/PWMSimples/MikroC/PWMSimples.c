/* 

        Este programa tem como objetivo introduzir o PWM do Pic da familia 18F. Para isso será utilizado a bibliteca de PWM do MikroC, que
    utiliza o módulo CCP do Pic, que está relacionado com o timer2. Dessa forma, será uma maneira de iniciar o timer2.
        A única função deste programa é ter uma saída PWM no pino do ccp1 e, através de botões, alterar o duty cicle do PWM.
        
        Os botões utilizados neste programa não utilizarão flags para testar se foram clicados e, assim, evitar o bouncing do botão. Serão
    utilizados delays com um tempo muito pequeno, a fim de evitar esse bouncing e, da mesma forma, permitir que o botão, quando pressionado
    por um tempo, faça com que o incremento ou decremento do Duty Cicle ocorra mais vezes, até onde se quer.
    
        Quando se utiliza a biblioteca PWM do MikroC, não é necessário configurar o pino CCP como saída, assim como nenhum outro registra-
    dor deste módulo.
    
        No proteus, o osciloscópio marcou um período de 400us, que dá uma frequência de f = 1/400us = 2500 Hz. Que foi exatamente a
    frequência programada.
        Na prática, utilizando um led na saída CCP, o circuito funcionou e a intensidade do brilho do led alterou-se de acordo com o incre-
    mento e decremento do Duty Cicle.
    
        É importante lembrar que a variável duty, declarada como unsigned short, é uma variável de 8 bits. Quando seu valor ultrapassa a
    255, automaticamente ela volta a 0, sem precisar fazer isso no programa. Da mesma forma, quando chega a zero e é incrementada, volta a
    255, num ciclo automático
    
        Na linguagem C ANSI, declarar uma variável como unsigned significa que ela assumirá apenas valores positivo, e nunca negativos.
    Declarar uma variável como short, automáticamente é declarar a variável como inteira (int) de 8 bits. Isto é, não necessita-se escrever
    "short int". Apenas "short" quer dizer que a variável já é "int", porém, com 8 bits, e não 16 bits como normalmente é uma variável int.
    Logo: "unsigned short" significa uma variável inteira (int) que assume apenas valores positivos.

*/

// Configuração de hardware
#define incrementa RB7_bit
#define decrementa RB6_bit

// Variáveis auxiliares
unsigned short duty = 128; // Duty Cicle de 50%

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos, como digitais
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










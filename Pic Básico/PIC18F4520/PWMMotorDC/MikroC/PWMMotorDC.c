/* 

        O objetivo deste programa � utilizar o PWM do m�dulo CCP, atrav�s da biblioteca do MikroC, e controlar a velocidade de um motor DC. Para
    isso ser� utilizado um potenci�metro conectado no pino AN0, que vai ler a tens�o no potenci�metro e regular o Duty Cicle do PWM.
        Como o conversor AD � de 10 bits e o m�dulo CCP de 8 bits, haver� a necessidade de fazer uma propor��o para que a leitura do conversor AD
    seja corretamente interpretado.
    
        256 pwm ---------- 1024 adc
        1   pwm ---------- x
            x = 1024 / 256
            x = 4
            
        Ent�o, divide-se a leitura do adc por quatro e obt�m-se o valor do duty. Ex:
        
        adc = 550
        duty = 550 / 4  ~= 138 ~= 50% duty
        
        O circuito na pr�tica funcionou perfeitamente
        
*/

// Vari�veis auxiliares
unsigned short duty = 128;

void main() {

     ADCON0 = 0x01; // Configura AN0 como canal digital e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de convers�o entre Vss e Vdd e configura apenas o pino AN0 como anal�gico
     TRISA = 0xFF; // Configura todo porta como entrada digital, exceto RA0/AN0, que � entrada anal�gica
     
     PWM1_Init(2000); // Inicia o pwm1 com uma frequ�ncia de 2000Hz
     PWM1_Start();
     PWM1_Set_Duty(duty);
     
     // Loop infinito
     while(1){
     
       duty = adc_read(0) >> 2; // >> 2 (shift-right 2) = / 4 (dividir por 4). Ou seja, 1024 do adc = 256 do duty, que d� 100% de duty
                                // Essa divis�o por 4 � o mesmo que fazer: >> 0b1111 1111 = 0b0011 1111, que resulta num n�mero de 8 bits

       PWM1_Set_Duty(duty);
     } // end while

} // end void main












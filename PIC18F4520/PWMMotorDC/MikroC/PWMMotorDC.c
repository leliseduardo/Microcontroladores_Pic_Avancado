/* 

        O objetivo deste programa é utilizar o PWM do módulo CCP, através da biblioteca do MikroC, e controlar a velocidade de um motor DC. Para
    isso será utilizado um potenciômetro conectado no pino AN0, que vai ler a tensão no potenciômetro e regular o Duty Cicle do PWM.
        Como o conversor AD é de 10 bits e o módulo CCP de 8 bits, haverá a necessidade de fazer uma proporção para que a leitura do conversor AD
    seja corretamente interpretado.
    
        256 pwm ---------- 1024 adc
        1   pwm ---------- x
            x = 1024 / 256
            x = 4
            
        Então, divide-se a leitura do adc por quatro e obtém-se o valor do duty. Ex:
        
        adc = 550
        duty = 550 / 4  ~= 138 ~= 50% duty
        
        O circuito na prática funcionou perfeitamente
        
*/

// Variáveis auxiliares
unsigned short duty = 128;

void main() {

     ADCON0 = 0x01; // Configura AN0 como canal digital e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura apenas o pino AN0 como analógico
     TRISA = 0xFF; // Configura todo porta como entrada digital, exceto RA0/AN0, que é entrada analógica
     
     PWM1_Init(2000); // Inicia o pwm1 com uma frequência de 2000Hz
     PWM1_Start();
     PWM1_Set_Duty(duty);
     
     // Loop infinito
     while(1){
     
       duty = adc_read(0) >> 2; // >> 2 (shift-right 2) = / 4 (dividir por 4). Ou seja, 1024 do adc = 256 do duty, que dá 100% de duty
                                // Essa divisão por 4 é o mesmo que fazer: >> 0b1111 1111 = 0b0011 1111, que resulta num número de 8 bits

       PWM1_Set_Duty(duty);
     } // end while

} // end void main












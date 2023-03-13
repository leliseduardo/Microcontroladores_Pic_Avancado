/* 

        O objetivo deste programa é implementar dois PWM's utilizando a biblioteca do MikroC. Assim, serão utilizados os dois módulos CCP,
    CCP1 e CCP2.
        Utilizando o PWM com a biblioteca do MikroC, não é possível utilizar os dois ao mesmo tempo com frequências diferentes, pois ambos
    utilizam o timer2 como base de tempo. Desta forma, na declaração "PWM1_Init(freq)" e "PWM2_Init(freq)", deve-se declarar a mesma
    frequência. Caso seja declarado frequências diferentes, o programa irá levar em consideração apenas a que foi declarada por último,
    uma vez que o processamento do código é sequencial.
        Assim como falado no projeto "PWMSimples", quando se utiliza a biblioteca do PWM do MikroC, não é necessário configurar os pinos
    do módulo CCP, assim como não é necessário fazer nenhuma configuração de registradores deste módulo.
    
       No proteus, o osciloscópio mostrou que a frequência de saída dos PWM's é de 1KHz, como programdo. Na prática, colocando dois leds
    nas duas saídas de PWM, a intesidade dos leds foram alteradas de acordo com o programado, portando o circuito funcionou.
*/

// Configuração de Hardware
#define Inc1Dec2 RB7_bit
#define Inc2Dec1 RB6_bit

// Variáveis auxiliares
unsigned short duty1 = 128;
unsigned short duty2 = 128;

void main() {

     ADCON1 = 0x0F; // Configura todas as portas que poderiam ser analógicas como digitais
     TRISB = 0xFF; // Configura todo o portb como entrada digital
     
     PWM1_Init(1000);
     PWM1_Start();
     PWM1_Set_Duty(duty1);
     
     PWM2_Init(1000);
     PWM2_Start();
     PWM2_Set_Duty(duty2);


     // Loop infinito
     while(1){
     
       if(!Inc1Dec2){
       
         duty1++;
         duty2--;
         delay_ms(30);
       } // end if !Inc1Dec2
       else if(!Inc2Dec1){
       
         duty2++;
         duty1--;
         delay_ms(30);
       } // end if Inc2Dec1
     
     
       PWM1_Set_Duty(duty1);
       PWM2_Set_Duty(duty2);
     } // end while

} // end void main









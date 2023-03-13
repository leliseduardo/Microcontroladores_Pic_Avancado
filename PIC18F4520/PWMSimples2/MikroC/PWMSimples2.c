/* 

        O objetivo deste programa � implementar dois PWM's utilizando a biblioteca do MikroC. Assim, ser�o utilizados os dois m�dulos CCP,
    CCP1 e CCP2.
        Utilizando o PWM com a biblioteca do MikroC, n�o � poss�vel utilizar os dois ao mesmo tempo com frequ�ncias diferentes, pois ambos
    utilizam o timer2 como base de tempo. Desta forma, na declara��o "PWM1_Init(freq)" e "PWM2_Init(freq)", deve-se declarar a mesma
    frequ�ncia. Caso seja declarado frequ�ncias diferentes, o programa ir� levar em considera��o apenas a que foi declarada por �ltimo,
    uma vez que o processamento do c�digo � sequencial.
        Assim como falado no projeto "PWMSimples", quando se utiliza a biblioteca do PWM do MikroC, n�o � necess�rio configurar os pinos
    do m�dulo CCP, assim como n�o � necess�rio fazer nenhuma configura��o de registradores deste m�dulo.
    
       No proteus, o oscilosc�pio mostrou que a frequ�ncia de sa�da dos PWM's � de 1KHz, como programdo. Na pr�tica, colocando dois leds
    nas duas sa�das de PWM, a intesidade dos leds foram alteradas de acordo com o programado, portando o circuito funcionou.
*/

// Configura��o de Hardware
#define Inc1Dec2 RB7_bit
#define Inc2Dec1 RB6_bit

// Vari�veis auxiliares
unsigned short duty1 = 128;
unsigned short duty2 = 128;

void main() {

     ADCON1 = 0x0F; // Configura todas as portas que poderiam ser anal�gicas como digitais
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










unsigned short porcent_duty = 50;
unsigned adc; // Ao declarar apenas unsigned, quer dizer que é unsigned int

void main() {

     // Registadores

     CMCON = 0x07; // Desativa os comparadores internos
     ADCON0 = 0x01; // Liga o conversor AD
     ADCON1 = 0X0E; // Configura apenas o AN0 como entrada analogica, o resto das portas AN, como digital

     
     // PWM
     
     PWM1_Init(1000);
     PWM1_Start();
     PWM1_Set_Duty((porcent_duty*255)/100);
     
     // Loop
     
     while(1){

       adc = ADC_Read(0);
       PWM1_Set_Duty((porcent_duty*255)/100);

       if(adc < 400){
       
         porcent_duty++;
         delay_ms(50);
         
         if(porcent_duty > 90)
           porcent_duty = 90;
       }
       else
         porcent_duty = 80;
     }
}
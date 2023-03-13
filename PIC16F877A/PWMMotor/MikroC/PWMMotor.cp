#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F877A/PWMMotor/MikroC/PWMMotor.c"

unsigned short porcent_duty = 50;
unsigned adc;

void main() {



 CMCON = 0x07;
 ADCON0 = 0x01;
 ADCON1 = 0X0E;




 PWM1_Init(1000);
 PWM1_Start();
 PWM1_Set_Duty((porcent_duty*255)/100);



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

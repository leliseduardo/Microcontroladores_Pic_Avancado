#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMMotorDC/MikroC/PWMMotorDC.c"
#line 23 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMMotorDC/MikroC/PWMMotorDC.c"
unsigned short duty = 128;

void main() {

 ADCON0 = 0x01;
 ADCON1 = 0x0E;
 TRISA = 0xFF;

 PWM1_Init(2000);
 PWM1_Start();
 PWM1_Set_Duty(duty);


 while(1){

 duty = adc_read(0) >> 2;


 PWM1_Set_Duty(duty);
 }

}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMSimples2/MikroC/PWMSimples2.c"
#line 21 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMSimples2/MikroC/PWMSimples2.c"
unsigned short duty1 = 128;
unsigned short duty2 = 128;

void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFF;

 PWM1_Init(1000);
 PWM1_Start();
 PWM1_Set_Duty(duty1);

 PWM2_Init(1000);
 PWM2_Start();
 PWM2_Set_Duty(duty2);



 while(1){

 if(! RB7_bit ){

 duty1++;
 duty2--;
 delay_ms(30);
 }
 else if(! RB6_bit ){

 duty2++;
 duty1--;
 delay_ms(30);
 }


 PWM1_Set_Duty(duty1);
 PWM2_Set_Duty(duty2);
 }

}

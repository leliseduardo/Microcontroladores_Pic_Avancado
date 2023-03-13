#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F877A/PWMSimples/MikroC/PWMSimples.c"





unsigned short duty1, duty2;

void main() {

 CMCON = 0x07;
 TRISB = 0xFF;
 TRISC = 0x00;
 PORTB = 0xFF;
 PORTC = 0x00;

 PWM1_Init(5000);
 PWM2_Init(5000);

 PWM1_Start();
 PWM2_Start();

 duty1 = 127;
 duty2 = 127;

 PWM1_Set_Duty(duty1);
 PWM2_Set_Duty(duty2);


 while(1){

 if(! RB1_bit ){
 delay_ms(40);
 duty1++;
 PWM1_Set_Duty(duty1);
 }
 if(! RB2_bit ){
 delay_ms(40);
 duty1--;
 PWM1_Set_Duty(duty1);
 }
 if(! RB3_bit ){
 delay_ms(40);
 duty2++;
 PWM2_Set_Duty(duty2);
 }
 if(! RB4_bit ){
 delay_ms(40);
 duty2--;
 PWM2_Set_Duty(duty2);
 }
 }
}

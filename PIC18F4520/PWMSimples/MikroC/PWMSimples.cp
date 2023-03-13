#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMSimples/MikroC/PWMSimples.c"
#line 35 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMSimples/MikroC/PWMSimples.c"
unsigned short duty = 128;

void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFF;

 PWM1_Init(2500);
 PWM1_Start();
 PWM1_Set_Duty(duty);


 while(1){

 if(! RB7_bit ){

 duty++;
 delay_ms(30);
 }
 else if (! RB6_bit ){

 duty--;
 delay_ms(30);
 }

 PWM1_Set_Duty(duty);

 }
}

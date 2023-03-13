#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/SireneProgramavel/MikroC/SireneProgramavel.c"
#line 18 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/SireneProgramavel/MikroC/SireneProgramavel.c"
unsigned short duty = 5;
char cont = 0x00;

void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;
  RA2_bit  = ~ RA2_bit ;
 cont++;

 if(cont == 0x32){

 cont = 0x00;
 duty++;
  RA0_bit  = ~ RA0_bit ;
  RA1_bit  = ~ RA1_bit ;
 }
 }
}

void main() {



 CMCON = 0x07;
 OPTION_REG = 0x81;
 INTCON = 0xA0;

 TRISA = 0xF8;
 TRISB = 0xF7;
  RA0_bit  = 0x00;
  RA1_bit  = 0x01;



 PWM1_Init(1500);
 PWM1_Set_Duty(duty);
 PWM1_Start();

 while(1){

 PWM1_Set_Duty(duty);
 }
}

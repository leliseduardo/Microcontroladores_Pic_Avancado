#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ServoMotorTimer0/MikroC/ServoMotorTimer0.c"



unsigned char duty;
int adc = 0x00;

 void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;

 if( RC4_bit ){
 TMR0 = duty;
  RC4_bit  = 0x00;
 }
 else{
 TMR0 = 255 - duty;
  RC4_bit  = 0x01;
 }
 }
}
#line 30 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ServoMotorTimer0/MikroC/ServoMotorTimer0.c"
void main() {

 CMCON = 0x07;
 OPTION_REG = 0x87;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR0IE_bit = 0x01;
 ADON_bit = 0x01;
 ADCON1 = 0x0E;
 TRISA = 0xFF;
 TRISC = 0xEF;
 PORTC = 0xEF;

 while(1){
#line 85 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ServoMotorTimer0/MikroC/ServoMotorTimer0.c"
 adc = (adc_read(0))/85;

 duty = adc + 12;
 }
}

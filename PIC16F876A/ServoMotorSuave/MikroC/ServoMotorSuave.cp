#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ServoMotorSuave/MikroC/ServoMotorSuave.c"



unsigned char duty = 0x00;

void inicialFinal();
void finalInicial();

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

void main() {

 CMCON = 0x07;
 OPTION_REG = 0x87;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR0IE_bit = 0x01;

 TRISC = 0xEF;
 PORTC = 0xEF;

 duty = 7;

 while(1){

 inicialFinal();
 delay_ms(2000);
 finalInicial();
 delay_ms(2000);
 }
}
#line 63 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/ServoMotorSuave/MikroC/ServoMotorSuave.c"
void inicialFinal(){

 int i;

 for(i = 7; i < 30 ; i++){
 duty = i;
 delay_ms(25);
 }
}

void finalInicial(){

 int i;

 for(i = 28; i > 6; i--){
 duty = i;
 delay_ms(25);
 }
}

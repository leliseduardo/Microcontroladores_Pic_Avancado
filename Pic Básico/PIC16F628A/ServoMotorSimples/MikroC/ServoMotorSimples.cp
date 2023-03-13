#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/ServoMotorSimples/MikroC/ServoMotorSimples.c"






void servoCentro(){
  RB0_bit  = 0x00;
 delay_us(18500);
  RB0_bit  = 0x01;
 delay_us(1500);
}

void servoHorario (){
  RB0_bit  = 0x00;
 delay_us(18000);
  RB0_bit  = 0x01;
 delay_us(2000);
}

void servoAntiHorario(){
  RB0_bit  = 0x00;
 delay_us(19000);
  RB0_bit  = 0x01;
 delay_us(1000);
}


void main() {

 CMCON = 0X07;
 TRISA = 0X03;
 PORTA = 0X03;
 TRISB = 0X00;
 PORTB = 0X00;

 while(1){

 if( RA0_bit  == 0 &&  RA1_bit  == 1)
 servoAntiHorario();
 else if( RA1_bit  == 0 &&  RA0_bit  == 1)
 servoHorario();
 else
 servoCentro();

 }

}

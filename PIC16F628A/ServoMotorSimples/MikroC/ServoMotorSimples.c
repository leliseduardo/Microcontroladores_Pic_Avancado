#define s1 RA0_bit
#define s2 RA1_bit
#define led1 RA3_bit
#define led2 RA2_bit
#define servo RB0_bit

void servoCentro(){
     servo = 0x00; // 1 em hexadecimal
     delay_us(18500);
     servo = 0x01;
     delay_us(1500);
}

void servoHorario (){
     servo = 0x00;
     delay_us(18000);
     servo = 0x01;
     delay_us(2000);
}

void servoAntiHorario(){
     servo = 0x00;
     delay_us(19000);
     servo = 0x01;
     delay_us(1000);
}


void main() {

     CMCON = 0X07;
     TRISA = 0X03;
     PORTA = 0X03;
     TRISB = 0X00;
     PORTB = 0X00;
     
     while(1){

       if(s1 == 0 && s2 == 1)
         servoAntiHorario();
       else if(s2 == 0 && s1 == 1)
         servoHorario();
       else
         servoCentro();

     }

}
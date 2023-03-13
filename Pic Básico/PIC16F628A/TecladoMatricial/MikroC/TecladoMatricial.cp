#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/TecladoMatricial/MikroC/TecladoMatricial.c"
#line 18 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/TecladoMatricial/MikroC/TecladoMatricial.c"
void piscaLed(int num);

int control = 0x01;



void interrupt() {

 if(T0IF_bit){
 T0IF_bit = 0x00;
 TMR0 = 0x6C;

 if( RB1_bit  && control == 0x01){
  RB1_bit  = 0x00;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
 control = 0x02;

 if(! RB4_bit )
 piscaLed(1);
 if(! RB5_bit )
 piscaLed(4);
 if(! RB6_bit )
 piscaLed(7);
 if(! RB7_bit )
 piscaLed(11);
 }
 else if( RB2_bit  && control == 0x02){
  RB1_bit  = 0x01;
  RB2_bit  = 0x00;
  RB3_bit  = 0x01;
 control = 0x03;

 if(! RB4_bit )
 piscaLed(2);
 if(! RB5_bit )
 piscaLed(5);
 if(! RB6_bit )
 piscaLed(8);
 if(! RB7_bit )
 piscaLed(10);
 }
 else if( RB3_bit  && control == 0x03){
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x00;
 control = 0x01;

 if(! RB4_bit )
 piscaLed(3);
 if(! RB5_bit )
 piscaLed(6);
 if(! RB6_bit )
 piscaLed(9);
 if(! RB7_bit )
 piscaLed(12);
 }
 }
}



void main() {



 CMCON = 0x07;
 TRISA = 0x03;
 TRISB = 0xF0;
 PORTA = 0x03;
 PORTB = 0xFF;

 OPTION_REG = 0X86;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;

 TMR0 = 0x6C;



 while(1);{

 }
}

void piscaLed(int num){

 int i;

 for(i = 0; i < num; i++){
  RA2_bit  = 0x01;
  RA3_bit  = 0x01;
 delay_ms(200);
  RA2_bit  = 0x00;
  RA3_bit  = 0x00;
 delay_ms(200);
 }
}

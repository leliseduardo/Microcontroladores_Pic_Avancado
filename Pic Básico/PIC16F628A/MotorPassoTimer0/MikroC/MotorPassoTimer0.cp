#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/MotorPassoTimer0/MikroC/MotorPassoTimer0.c"
#line 15 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/MotorPassoTimer0/MikroC/MotorPassoTimer0.c"
void passo1();
void passo2();
void passo3();
void passo4();
void passo5();
void passo6();
void passo7();
void passo8();



unsigned char velocidade = 0x64;


unsigned char cont = 0x01;

void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;
 TMR0 = velocidade;

 switch(cont){

 case 0x01: passo1();
 break;
 case 0x02: passo2();
 break;
 case 0x03: passo3();
 break;
 case 0x04: passo4();
 break;
 case 0x05: passo5();
 break;
 case 0x06: passo6();
 break;
 case 0x07: passo7();
 break;
 case 0x08: passo8();
 break;
 }

 cont++;

 if(cont > 0x08)
 cont = 0x01;
 }
}

void main() {

 CMCON = 0x07;
 OPTION_REG = 0x87;
 INTCON = 0xA0;
 TMR0 = velocidade;

 TRISA = 0xFC;
 TRISB = 0xF0;
 PORTA = 0xFC;
 PORTB = 0xF0;

 while(1){

 if(! RA2_bit  && ! RA0_bit ){

  RA0_bit  = 0x01;
 velocidade++;
 }
 if(! RA3_bit  && ! RA1_bit ){

  RA1_bit  = 0x01;
 velocidade--;
 }

 if( RA2_bit  &&  RA0_bit )
  RA0_bit  = 0x00;

 if( RA3_bit  &&  RA1_bit )
  RA1_bit  = 0x00;
 }
}

void passo1(){

  RB3_bit  = 0x01;
  RB2_bit  = 0x00;
  RB1_bit  = 0x00;
  RB0_bit  = 0x00;
}

void passo2(){

  RB3_bit  = 0x01;
  RB2_bit  = 0x01;
  RB1_bit  = 0x00;
  RB0_bit  = 0x00;
}

void passo3(){

  RB3_bit  = 0x00;
  RB2_bit  = 0x01;
  RB1_bit  = 0x00;
  RB0_bit  = 0x00;
}

void passo4(){

  RB3_bit  = 0x00;
  RB2_bit  = 0x01;
  RB1_bit  = 0x01;
  RB0_bit  = 0x00;
}

void passo5(){

  RB3_bit  = 0x00;
  RB2_bit  = 0x00;
  RB1_bit  = 0x01;
  RB0_bit  = 0x00;
}

void passo6(){

  RB3_bit  = 0x00;
  RB2_bit  = 0x00;
  RB1_bit  = 0x01;
  RB0_bit  = 0x01;
}

void passo7(){

  RB3_bit  = 0x00;
  RB2_bit  = 0x00;
  RB1_bit  = 0x00;
  RB0_bit  = 0x01;
}

void passo8(){

  RB3_bit  = 0x01;
  RB2_bit  = 0x00;
  RB1_bit  = 0x00;
  RB0_bit  = 0x01;
}

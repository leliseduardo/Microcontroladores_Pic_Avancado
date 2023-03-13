#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/PrioridadeInterrupcao/MikroC/PrioridadeInterrupcao.c"
#line 41 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/PrioridadeInterrupcao/MikroC/PrioridadeInterrupcao.c"
void interrupt(){

 if(INTF_bit){

 INTF_bit = 0x00;

  RB1_bit  = ~ RB1_bit ;
 }

 if(T0IF_bit){

 T0IF_bit = 0x00;

  RB2_bit  = ~ RB2_bit ;
 }

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1H = 0xFF;

  RB3_bit  = ~ RB3_bit ;
 }

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

  RB4_bit  = ~ RB4_bit ;
 }
}

void main() {

 CMCON = 0x07;
 OPTION_REG = 0x08;



 INTCON = 0xF0;

 T1CON = 0x01;
 TMR1IE_bit = 0x01;
 TMR1H = 0xFF;


 T2CON = 0x04;
 TMR2IE_bit = 0x01;
 PR2 = 0xFF;


 TRISA = 0xFF;
 TRISB = 0xE1;
 PORTA = 0xFF;
 PORTB = 0xE1;

}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/PWMTimer2/MikroC/PWMTimer2.c"









void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0;
 TMR0 = 0x6C;

 if(! RA0_bit )
 CCPR1L++;

 if(! RA1_bit )
 CCPR1L--;
 }

}

void main() {




 CMCON = 0x07;
 TRISA = 0x03;
 PORTA = 0x03;
 TRISB = 0x00;
 PORTB = 0x00;


 OPTION_REG = 0x86;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;
 TMR0 = 0x6C;

 T2CON = 0x06;
 PR2 = 0xFF;







 CCPR1L = 0x00;
 CCP1CON = 0x0C;







 while(1){



 }

}

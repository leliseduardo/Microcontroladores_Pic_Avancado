#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Timer2Ex/MikroC/Timer2Ex.c"



void interrupt(){
 if(TMR2IF_bit){
 TMR2IF_bit = 0x00;

 PORTB = ~PORTB;
 }
}

void main() {



 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR2IE_bit = 0x01;
 T2CON = 0b00011101;

 PR2 = 100;

 TRISB = 0x00;
 PORTB = 0x00;



 while(1){



 }
}

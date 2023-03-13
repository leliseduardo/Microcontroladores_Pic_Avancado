#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/InterrupçãoExternaSimples/MikroC/InterrupçãoExternaSimples.c"







bit control;



void interrupt(){

 if(INTF_bit){

 INTF_bit = 0x00;

 control = ~control;

  RA1_bit  = control;
 delay_ms(100);
 }
}

void main() {



 CMCON = 0x07;

 GIE_bit = 0x01;
 PEIE_bit = 0x00;
 INTE_bit = 0x01;
 INTEDG_bit = 0x00;

 TRISA = 0xFC;
 TRISB = 0xFF;
 PORTA = 0xFC;
 PORTB = 0xFF;



 control = 0x00;



 while(1){

  RA0_bit  = 0x01;
 delay_ms(1000);
  RA0_bit  = 0x00;
 delay_ms(1000);
 }
}

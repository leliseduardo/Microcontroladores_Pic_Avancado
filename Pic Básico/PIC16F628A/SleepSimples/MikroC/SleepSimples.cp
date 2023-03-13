#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/SleepSimples/MikroC/SleepSimples.c"



bit control;

void interrupt(){

 if(INTF_bit){

 INTF_bit = 0x00;
 control = ~control;

  RA3_bit  = ~ RA3_bit ;

 if(control)
 asm sleep;
 }

 delay_ms(200);
}

void main() {

 CMCON = 0x07;
 OPTION_REG = 0x80;
 GIE_bit = 0x01;
 PEIE_bit = 0x00;
 INTE_bit = 0x01;

 TRISA = 0xF3;
 TRISB = 0xFF;

 RA2_bit = 0x00;
 RA3_bit = 0x00;

 control = 0x00;

 while(1){

  RA2_bit  = 0x01;
 delay_ms(500);
  RA2_bit  = 0x00;
 delay_ms(500);
 }
}

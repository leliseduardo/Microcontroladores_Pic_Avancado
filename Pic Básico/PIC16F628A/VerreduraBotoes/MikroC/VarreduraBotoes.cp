#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/VerreduraBotoes/MikroC/VarreduraBotoes.c"





void interrupt(){
 if(T0IF){

 T0IF_bit = 0x00;

 TMR0 = 0x6C;

 if( RA0_bit  == 0)
  RA2_bit  = 0x01;

 if( RA1_bit  == 0)
  RA2_bit  = 0x00;
 }
}

void main() {

 OPTION_REG = 0X86;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;

 TMR0 = 0x6C;

 CMCON = 0x07;
 TRISA = 0x03;
 PORTA = 0x03;

 while(1){

  RA3_bit  = 0x01;
 delay_ms(500);
  RA3_bit  = 0x00;
 delay_ms(500);
 }
}

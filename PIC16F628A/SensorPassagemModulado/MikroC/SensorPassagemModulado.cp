#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/SensorPassagemModulado/MikroC/SensorPassagemModulado.c"
#line 36 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/SensorPassagemModulado/MikroC/SensorPassagemModulado.c"
char flag0 = 0x00;
unsigned tempo1, tempo2;
char txt[12];
unsigned long frequencia;
unsigned cont = 0x00;

void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;
 TMR0 = 0x06;

  RB2_bit  = ~ RB2_bit ;
 }

 if(CCP1IF_bit){

 CCP1IF_bit = 0x00;

 if(!flag0.B0){

 tempo1 = (CCPR1H << 8) + CCPR1L;

 flag0.B0 = 0x01;
 }
 else{

 tempo2 = (CCPR1H << 8) + CCPR1L;

 flag0.B0 = 0x00;

 }
 }
}

void main() {

 CMCON = 0x07;
 T1CON = 0x01;
 CCP1CON = 0x07;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 CCP1IE_bit = 0x01;
 OPTION_REG = 0x80;
 T0IE_bit = 0x01;
 TMR0 = 0x06;


 TRISA = 0xFF;
 TRISB = 0xF9;
 PORTA = 0xFF;
 PORTB = 0xF0;

 while(1){

 tempo2 = abs(tempo2 - tempo1);

 tempo2 = (tempo2) >> 4;

 frequencia = 1 / (tempo2 * 1E-6);

 if(frequencia > 950 && frequencia < 1050)
  RB1_bit  = 0x00;
 else
  RB1_bit  = 0x01;

 delay_ms(100);
 }
}

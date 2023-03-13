#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/TecladoAnalogico/MikroC/TecladoAnalogico.c"
#line 67 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/TecladoAnalogico/MikroC/TecladoAnalogico.c"
void leBotao();



unsigned char flag0 = 0x00;
unsigned char flag1 = 0x00;
unsigned char flag2 = 0x00;
unsigned char flag3 = 0x00;

int adc = 0x00;
char pisca = 0x00;
char i = 0x00;
#line 115 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/TecladoAnalogico/MikroC/TecladoAnalogico.c"
void main() {

 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA = 0xFF;
 TRISB = 0xFE;
  LATB0_bit  = 0x00;

 while(1){

 leBotao();

 if( flag1.B7 ){

 for(i = 0x00; i < pisca; i++){

  LATB0_bit  = 0x01;
 delay_ms(200);
  LATB0_bit  = 0x00;
 delay_ms(200);
 }

 flag0 = 0x00;
 flag1 = 0x00;
 flag2 = 0x00;
 flag3 = 0x00;
 }
 }
}

void leBotao(){

 adc = ADC_Read(0);

 if(adc > 94 && adc < 108 )  flag0.B0  = 0x01;
 else if(adc > 108 && adc < 132 )  flag0.B1  = 0x01;
 else if(adc > 132 && adc < 162 )  flag0.B2  = 0x01;
 else if(adc > 162 && adc < 208 )  flag0.B3  = 0x01;
 else if(adc > 244 && adc < 284 )  flag0.B4  = 0x01;
 else if(adc > 328 && adc < 368 )  flag0.B5  = 0x01;
 else if(adc > 389 && adc < 429 )  flag0.B6  = 0x01;
 else if(adc > 494 && adc < 534 )  flag0.B7  = 0x01;
 else if(adc > 568 && adc < 608 )  flag1.B0  = 0x01;
 else if(adc > 678 && adc < 718 )  flag1.B1  = 0x01;
 else if(adc > 768 && adc < 808 )  flag1.B2  = 0x01;
 else if(adc > 820 && adc < 860 )  flag1.B3  = 0x01;
 else if(adc > 871 && adc < 911 )  flag1.B4  = 0x01;
 else if(adc > 912 && adc < 952 )  flag1.B5  = 0x01;
 else if(adc > 959 && adc < 999 )  flag1.B6  = 0x01;

 if(adc < 94 &&  flag0.B0 ){

  flag1.B7  = 0x01;
 pisca = 0x01;
  flag2.B0  = 0x01;
  flag0.B0  = 0x00;
 }
 if(adc < 108 &&  flag0.B1 ){

  flag1.B7  = 0x01;
 pisca = 0x02;
  flag2.B1  = 0x01;
  flag0.B1  = 0x00;
 }
 if(adc < 132 &&  flag0.B2 ){

  flag1.B7  = 0x01;
 pisca = 0x03;
  flag2.B2  = 0x01;
  flag0.B2  = 0x00;
 }
 if(adc < 162 &&  flag0.B3 ){

  flag1.B7  = 0x01;
 pisca = 0x04;
  flag2.B3  = 0x01;
  flag0.B3  = 0x00;
 }
 if(adc < 244 &&  flag0.B4 ){

  flag1.B7  = 0x01;
 pisca = 0x05;
  flag2.B4  = 0x01;
  flag0.B4  = 0x00;
 }
 if(adc < 328 &&  flag0.B5 ){

  flag1.B7  = 0x01;
 pisca = 0x06;
  flag2.B5  = 0x01;
  flag0.B5  = 0x00;
 }
 if(adc < 389 &&  flag0.B6 ){

  flag1.B7  = 0x01;
 pisca = 0x07;
  flag2.B6  = 0x01;
  flag0.B6  = 0x00;
 }
 if(adc < 494 &&  flag0.B7 ){

  flag1.B7  = 0x01;
 pisca = 0x08;
  flag2.B7  = 0x01;
  flag0.B7  = 0x00;
 }
 if(adc < 568 &&  flag1.B0 ){

  flag1.B7  = 0x01;
 pisca = 0x09;
  flag3.B0  = 0x01;
  flag1.B0  = 0x00;
 }
 if(adc < 678 &&  flag1.B1 ){

  flag1.B7  = 0x01;
 pisca = 0x0A;
  flag3.B1  = 0x01;
  flag1.B1  = 0x00;
 }
 if(adc < 768 &&  flag1.B2 ){

  flag1.B7  = 0x01;
 pisca = 0x0B;
  flag3.B2  = 0x01;
  flag1.B2  = 0x00;
 }
 if(adc < 820 &&  flag1.B3 ){

  flag1.B7  = 0x01;
 pisca = 0x0C;
  flag3.B3  = 0x01;
  flag1.B3  = 0x00;
 }
 if(adc < 871 &&  flag1.B4 ){

  flag1.B7  = 0x01;
 pisca = 0x0D;
  flag3.B4  = 0x01;
  flag1.B4  = 0x00;
 }
 if(adc < 912 &&  flag1.B5 ){

  flag1.B7  = 0x01;
 pisca = 0x0E;
  flag3.B5  = 0x01;
  flag1.B5  = 0x00;
 }
 if(adc < 959 &&  flag1.B6 ){

  flag1.B7  = 0x01;
 pisca = 0x0F;
  flag3.B6  = 0x01;
  flag1.B6  = 0x00;
 }
}

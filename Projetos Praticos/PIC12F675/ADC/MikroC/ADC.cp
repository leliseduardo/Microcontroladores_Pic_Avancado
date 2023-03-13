#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Projetos Praticos/PIC12F675/ADC/MikroC/ADC.c"

int leituraADC = 0;
bit control;

void main() {

 ANSEL = 1;
 ADCON0 = 1;
 CMCON = 7;
 TRISIO4_bit = 0;
 TRISIO5_bit = 0;
 GPIO = 0;
 control = 0x00;

 while(1){

 leituraADC = adc_read(0);

 if(leituraADC < 700){

 control = ~control;


 delay_ms(1000);

 }

 if(control){

 GPIO.F4 = ~GPIO.F4;
 GPIO.F5 = ~GPIO.F5;

 }
 else
 GPIO = 0x00;

 }

}

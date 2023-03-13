#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC12F675/ADCSimples/MikroC/ADCSimples.c"





int leituraADC = 0;

void main() {

 ANSEL = 1;
 ADCON0 = 1;
 CMCON = 7;

 TRISIO = 1;
 GPIO = 0;

 while(1){
 leituraADC = ADC_Read(0);

 if(leituraADC > 0){
  GPIO.F5  = 0;
  GPIO.F4  = 0;
  GPIO.F2  = 0;
  GPIO.F1  = 0;
 }

 if(leituraADC > 204){
  GPIO.F5  = 1;
  GPIO.F4  = 0;
  GPIO.F2  = 0;
  GPIO.F1  = 0;
 }

 if(leituraADC > 408){
  GPIO.F5  = 1;
  GPIO.F4  = 1;
  GPIO.F2  = 0;
  GPIO.F1  = 0;
 }

 if(leituraADC > 612){
  GPIO.F5  = 1;
  GPIO.F4  = 1;
  GPIO.F2  = 1;
  GPIO.F1  = 0;
 }

 if(leituraADC > 816){
  GPIO.F5  = 1;
  GPIO.F4  = 1;
  GPIO.F2  = 1;
  GPIO.F1  = 1;
 }

 delay_ms(100);
 }


}

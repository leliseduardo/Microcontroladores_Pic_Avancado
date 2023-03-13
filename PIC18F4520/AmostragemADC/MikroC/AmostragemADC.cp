#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/AmostragemADC/MikroC/AmostragemADC.c"
#line 37 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/AmostragemADC/MikroC/AmostragemADC.c"
int adc = 0x00;

void main() {



 ADCON0 = 0x01;
 ADCON1 = 0x0E;
 ADCON2 = 0b000000110;



 TRISA = 0xFF;
 TRISB = 0xFE;
 LATB = 0x00;



 while(1){

 adc = adc_Read(0);

 if(adc > 512)  LATB0_bit  = 0x01;

 else  LATB0_bit  = 0x00;
 }
}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/ADCSimples/MikroC/ADCSimples.c"
#line 10 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/ADCSimples/MikroC/ADCSimples.c"
void main() {

 INTCON2 = 0x7F;
 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA = 0xFF;
 TRISB = 0x00;
 LATB = 0x00;

 while(1){

 LATB = ADC_Read(0);
 }
}

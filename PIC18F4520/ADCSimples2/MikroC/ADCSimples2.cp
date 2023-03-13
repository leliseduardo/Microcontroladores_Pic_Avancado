#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/ADCSimples2/MikroC/ADCSimples2.c"
#line 9 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/ADCSimples2/MikroC/ADCSimples2.c"
void main() {

 ADCON0 = 0x01;
 ADCON1 = 0x0E;


 TRISA = 0xFF;
 TRISB = 0x00;
 TRISC = 0xFC;
 LATB = 0x00;
 LATC = 0x00;

 while(1){

 switch(ADC_Read(0)){

 case 0: LATB = 0b00000000; LATC = 0x00; break;
 case 100: LATB = 0b00000001; LATC = 0x00; break;
 case 200: LATB = 0b00000011; LATC = 0x00; break;
 case 300: LATB = 0b00000111; LATC = 0x00; break;
 case 400: LATB = 0b00001111; LATC = 0x00; break;
 case 500: LATB = 0b00011111; LATC = 0x00; break;
 case 600: LATB = 0b00111111; LATC = 0x00; break;
 case 700: LATB = 0b01111111; LATC = 0x00; break;
 case 800: LATB = 0b11111111; LATC = 0x00; break;
 case 900: LATB = 0b11111111; LATC = 0x01; break;
 case 1000: LATB = 0b11111111; LATC = 0x03; break;
 }
 }
}

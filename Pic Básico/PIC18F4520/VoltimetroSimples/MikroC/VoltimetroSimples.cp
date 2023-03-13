#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/VoltimetroSimples/MikroC/VoltimetroSimples.c"
#line 78 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/VoltimetroSimples/MikroC/VoltimetroSimples.c"
int adc;
unsigned tensao;
unsigned aux;
char flag = 0x00;



void volts(unsigned volt);

void main() {

 INTCON2 = 0x7F;
 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA = 0xFF;
 TRISB = 0xFE;
 LATB = 0x00;

 while(1){

 volts(12);
 }
}

void volts(unsigned volt){

 unsigned i;

 if(! RB1_bit ) flag.B0 = 0x01;

 if( RB1_bit  && flag.B0){

 flag.B0 = 0x00;

 aux = 1024/volt;

 adc = ADC_Read(0);

 tensao = adc / aux;

 for(i = 0x00; i <= tensao; i++){

  LATB0_bit  = 0x01;
 delay_ms(300);
  LATB0_bit  = 0x00;
 delay_ms(300);
 }
 }
}

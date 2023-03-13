#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/LeitorPulsos/SensorPic/MikroC/SensorPic.c"
#line 31 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/LeitorPulsos/SensorPic/MikroC/SensorPic.c"
void pulso_Saida(int n);


char baseTempo = 0x00;

int adc = 0x00;


void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;

 baseTempo++;

 if(baseTempo == 0x04){

 baseTempo = 0x00;
 adc = adc_read(0);

 }

 }

}

void main() {


 CMCON = 0x07;
 ANSEL = 0x11;
 ADCON0 = 0x01;

 INTCON = 0xA0;
 OPTION_REG = 0x07;
 TRISIO = 0x1F;

  GP5_bit  = 0x00;


 while(1){

 if(! GP1_bit ) pulso_Saida(0x01);
 if(! GP2_bit ) pulso_Saida(0x02);
 if(! GP3_bit ) pulso_Saida(0x03);
 if(! GP4_bit ) pulso_Saida(0x04);

 switch(adc){

 case 0:
 case 512: pulso_Saida(5);
 break;
 case 877:
 case 955:
 case 1023: pulso_Saida(6);
 break;

 }

 }

}


void pulso_Saida(int n){

 char i;

 for(i = 0x00; i < n; i++){

  GP5_bit  = 0x01;
 delay_ms(30);
  GP5_bit  = 0x00;
 delay_ms(30);

 }

 delay_ms(250);

}

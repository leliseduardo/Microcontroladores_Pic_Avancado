#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SensorTemperatura/MikroC/SensorTemperatura.c"
#line 15 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SensorTemperatura/MikroC/SensorTemperatura.c"
void temperatura(float range);




int adc = 0x00;
float tensao = 0.0;
float temp = 0.0;
char txt[15];

void main() {



 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA = 0xFF;



 UART1_Init(9600);
 delay_ms(100);

 UART1_Write_Text("Temperatura em Celsius");
 UART1_Write(10);
 UART1_Write(13);




 while(1){

 temperatura(5.0);
 delay_ms(500);
 }
}


void temperatura(float range){

 adc = ADC_Read(0);

 tensao = ((adc * range) / 1024);

 temp = tensao * 100;

 FloatToStr(temp, txt);
 UART1_Write_Text(txt);
 UART1_Write(10);
 UART1_Write(13);
}

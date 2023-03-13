#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/VoltTensaoNegativa/MikroC/VoltTensãoNegativa.c"
#line 73 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/VoltTensaoNegativa/MikroC/VoltTensãoNegativa.c"
void voltimetro(float range);



int adc = 0x00;
float tensao = 0.0;
float Vin = 0.0;
char txt[15];


void main() {

 ADCON0 = 0x01;
 ADCON1 = 0x0E;


 TRISA = 0xFF;

 UART1_Init(9600);
 delay_ms(100);

 UART1_Write_Text("Voltimetro PIC18");
 UART1_Write(10);
 UART1_Write(13);

 while(1){

 voltimetro(5.0);
 delay_ms(500);
 }
}

void voltimetro(float range){

 adc = ADC_Read(0);

 tensao = ((adc * range) / 1024.0);

 Vin = (tensao * 0.6) - 2.0;

 FloatToStr(Vin, txt);

 UART1_Write_Text(txt);
 UART1_Write(10);
 UART1_Write(13);
}

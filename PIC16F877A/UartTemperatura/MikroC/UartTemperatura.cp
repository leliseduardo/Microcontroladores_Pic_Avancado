#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F877A/UartTemperatura/MikroC/UartTemperatura.c"





char uart_rd;
char txt[7];
long int valorAD = 0;
long int temperatura = 0;

void main() {

 CMCON = 0x07;
 ADCON0 = 0x01;
 ADCON1 = 0x0E;


 TRISB = 0x80;
 PORTB = 0x00;

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

 while (1) {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);
 }

 switch(uart_rd){
 case 'b':  RB0_bit  = 0x01;
 break;
 case 'v':  RB0_bit  = 0x00;
 break;
 case 'y':  RB1_bit  = 0x01;
 break;
 case 't':  RB1_bit  = 0x00;
 break;
 case 'g':  RB2_bit  = 0x01;
 break;
 case 'f':  RB2_bit  = 0x00;
 break;
 }

 if( RB7_bit ){
 valorAD = ADC_Read(0);

 temperatura = valorAD/2;

 IntToStr(temperatura, txt);

 UART1_Write_Text(txt);
 UART1_Write_Text(" Celsius");
 UART1_Write(10);
 UART1_Write(13);
 delay_ms(200);
 }
 }
}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F877A/UartSimples/MikroC/UartSimples.c"





char uart_rd;

void main() {

 CMCON = 0x07;
 ADCON0 = 0x00;
 ADCON1 = 0x06;

 TRISB = 0x80;
 PORTB = 0x00;


 UART1_Init(9600);
 delay_ms(150);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

 while (1) {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);


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
 }

 if( RB7_bit ){
 UART1_Write_Text("Alerta!");
 UART1_Write(10);
 UART1_Write(13);
 }
 }
}

#define azul RB0_bit
#define amarelo RB1_bit
#define verde RB2_bit
#define botao RB7_bit

char uart_rd;
char txt[7]; // variavel char vetor, que na verdade é uma String de caracters
long int valorAD = 0;
long int temperatura = 0;

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     ADCON0 = 0x01; // Ou 0b00000001 habilita o adc do pic
     ADCON1 = 0x0E; // Ou 0b00001110 seleciona apena AN0 como entrada analogica, o resto como porta digital. 1110(binario) = E(Hex)
                    // 0x0E pois cada casa representa um neable. 0b 0000(1o neable) 1110(20 neable), 0x 0(1o neable) E(2o neable)
     
     TRISB = 0x80; // Ou 0b10000000 Seleciona apenas RB7 como entrada digital
     PORTB = 0x00; // Inicia todo o portb com nível baixo

     UART1_Init(9600);               // Initialize UART module at 9600 bps
     Delay_ms(100);                  // Wait for UART module to stabilize

     UART1_Write_Text("Start");
     UART1_Write(10);
     UART1_Write(13);

     while (1) {                     // Endless loop
       if (UART1_Data_Ready()) {     // If data is received,
         uart_rd = UART1_Read();     // read the received data,
         UART1_Write(uart_rd);       // and send data via UART
       }
       
       switch(uart_rd){
         case 'b': azul = 0x01;
         break;
         case 'v': azul = 0x00;
         break;
         case 'y': amarelo = 0x01;
         break;
         case 't': amarelo = 0x00;
         break;
         case 'g': verde = 0x01;
         break;
         case 'f': verde = 0x00;
         break;
       }
       
       if(botao){
         valorAD = ADC_Read(0);
         
         temperatura = valorAD/2;
         
         IntToStr(temperatura, txt);
         
         UART1_Write_Text(txt);
         UART1_Write_Text(" Celsius");
         UART1_Write(10); // Realimenta a linha
         UART1_Write(13); // Quebra linha
         delay_ms(200);
       }
     }
}


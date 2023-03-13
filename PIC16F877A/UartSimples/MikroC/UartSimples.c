#define azul RB0_bit
#define amarelo RB1_bit
#define verde RB2_bit
#define botao RB7_bit

char uart_rd;

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     ADCON0 = 0x00; // Desabilita os conversores AD internos
     ADCON1 = 0x06; // Torna todo o ADC digital

     TRISB = 0x80; // Ou 0b10000000 Torna RB7 uma entrada digital
     PORTB = 0x00; // Inicia todo o portb em nível baixo


     UART1_Init(9600);               // Initialize UART module at 9600 bps
     delay_ms(150);                  // Wait for UART module to stabilize

     UART1_Write_Text("Start"); // Escreve o texto start
     UART1_Write(10); // O 10, na tabela ASCII, representa realimentação de linha, isto é, permite que se escreva mais
     UART1_Write(13); // O 13, na tabela ASCII, representa a quebra de linha, ou o enter. Assim, este comando quebra a linha

     while (1) {                    // Endless loop
       if (UART1_Data_Ready()) {     // If data is received,
         uart_rd = UART1_Read();     // read the received data,
         UART1_Write(uart_rd);       // and send data via UART

       
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
       }
       
       if(botao){
         UART1_Write_Text("Alerta!"); // Escreve o texto Alerta!
         UART1_Write(10); // Realimentação da linha
         UART1_Write(13); // Quebra da linha
       }
     }
}
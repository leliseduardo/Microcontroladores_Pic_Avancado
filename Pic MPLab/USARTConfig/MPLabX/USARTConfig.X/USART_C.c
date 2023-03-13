#include "USART_H.h"

short UART_Init(const long int baudrate){

    unsigned int x = 0;
    
    x = (_MCU_FREQ - baudrate*64)/(baudrate*64);
    
    if(x > 255){
        
        x = (_MCU_FREQ - baudrate*16)/(baudrate*16);
        BRGH = 1;
    }
    
    if(x < 255){
        
        SPBRG = x;
        TXSTAbits.SYNC = 0;     // Configura modo assíncrono
        TXSTAbits.TXEN = 1;     // Ativa envio de dados
        RCSTAbits.SPEN = 1;     // Ativar a porta serial
        RCSTAbits.CREN = 1;     // Ativa o recebimento de dados
        TRISCbits.RC6 = 1;      // Deve estar em 1 conforme datasheet
        TRISCbits.RC7 = 1;      // Deve estar em 1 conforme datasheer
        
        return 1;
    }
    else
        return 0;
}
void UART_Write(const char data){
    
    while(!TRMT);
    TXREG = data;
}
    
void UART_Write_ln(const char data){
    
    UART_Write(data);
    UART_Write('\r');
    UART_Write('\n');
}
    
    
void UART_Write_Text(const char text[]){

    int i;
    for(i = 0; text[i] != '\0'; i++)
        UART_Write(text[i]);
}


void  UART_Write_Text_ln(const char text[]){

    UART_Write_Text(text);
    UART_Write('\r');
    UART_Write('\n');
}

char UART_Read(){
    
    while(!RCIF);
    return RCREG;
}
        
void UART_Read_Text(char *Output, const unsigned int length){

    for(unsigned int i = 0; i < length; i++)
        Output[i] = UART_Read();
    
    Output[length] = '\0';
}

void UART_Interrupt(){
    
    if(RCIF){
        
        char temp = RCREG;
        for(unsigned int i = 0; i < UARTBUFFLENGTH - 2; i++)
            UARTBUFF[i] = UARTBUFF[i+1];

        UARTBUFF[UARTBUFFLENGTH - 2] = temp;
        UARTBUFF[UARTBUFFLENGTH - 1] = '\0';
        RCIF = 0;
    }
}

__bit UART_FindOnBuffer(const char compare[], unsigned int *addr){

    unsigned int i = 0, z = 0, datasize = 0;
    short located = 0;
    
    datasize = strlen(compare);
    
    for(i = 0; i < (UARTBUFFLENGTH - datasize); i++){
        located = 1;
        
        for(z = 0; z < datasize; z++){
        
            if(UARTBUFF[z+i] != compare[z]){
            
                located = 0;
                break;
            }
        }
        
        if(located == 1){
            
            *addr = i;
            break;
        }
    }
    
    if(located == 1)
        return 1;
    else
        return 0;
}


void UART_ClearOnBuffer(const char compare[], unsigned int addr){
    
    unsigned int finalADDR = addr + strlen(compare) - 1;
    
    for(unsigned int i = 0; i < finalADDR; i++)
        UARTBUFF[i] = ' ';
}
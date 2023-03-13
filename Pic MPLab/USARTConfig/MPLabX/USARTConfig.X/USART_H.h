#ifndef __USART

    #define __USART

    #include <xc.h>
    #include "MCU_H.h"
    #include <string.h>

    #define UARTBUFFLENGTH 65
    char UARTBUFF[UARTBUFFLENGTH] = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
                                     ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
                                     ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
                                     ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 
                                     '\0'};
    short UART_Init(const long int baudrate);
    void UART_Write(const char data);
    void UART_Write_ln(const char data);
    void UART_Write_Text(const char text[]);
    void  UART_Write_Text_ln(const char text[]);
    char UART_Read();
    void UART_Read_Text(char *Output, const unsigned int length);
    void UART_Interrupt();
    __bit UART_FindOnBuffer(const char compare[], unsigned int *addr);
    void UART_ClearOnBuffer(const char compare[], unsigned int addr);
    
#endif 

_main:

;UartSimples.c,8 :: 		void main() {
;UartSimples.c,10 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;UartSimples.c,11 :: 		ADCON0 = 0x00; // Desabilita os comparador AD internos
	CLRF       ADCON0+0
;UartSimples.c,12 :: 		ADCON1 = 0x06; // Torna todo o ADC digital
	MOVLW      6
	MOVWF      ADCON1+0
;UartSimples.c,14 :: 		TRISB = 0x80; // Ou 0b10000000 Torna RB7 uma entrada digital
	MOVLW      128
	MOVWF      TRISB+0
;UartSimples.c,15 :: 		PORTB = 0x00; // Inicia todo o portb em nível baixo
	CLRF       PORTB+0
;UartSimples.c,18 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;UartSimples.c,19 :: 		delay_ms(150);                  // Wait for UART module to stabilize
	MOVLW      4
	MOVWF      R11+0
	MOVLW      207
	MOVWF      R12+0
	MOVLW      1
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;UartSimples.c,21 :: 		UART1_Write_Text("Start"); // Escreve o texto start
	MOVLW      ?lstr1_UartSimples+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UartSimples.c,22 :: 		UART1_Write(10); // O 10, na tabela ASCII, representa realimentação de linha, isto é, permite que se escreva mais
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartSimples.c,23 :: 		UART1_Write(13); // O 13, na tabela ASCII, representa a quebra de linha, ou o enter. Assim, este comando quebra a linha
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartSimples.c,25 :: 		while (1) {                    // Endless loop
L_main1:
;UartSimples.c,26 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;UartSimples.c,27 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;UartSimples.c,28 :: 		UART1_Write(uart_rd);       // and send data via UART
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartSimples.c,31 :: 		switch(uart_rd){
	GOTO       L_main4
;UartSimples.c,32 :: 		case 'b': azul = 0x01;
L_main6:
	BSF        RB0_bit+0, 0
;UartSimples.c,33 :: 		break;
	GOTO       L_main5
;UartSimples.c,34 :: 		case 'v': azul = 0x00;
L_main7:
	BCF        RB0_bit+0, 0
;UartSimples.c,35 :: 		break;
	GOTO       L_main5
;UartSimples.c,36 :: 		case 'y': amarelo = 0x01;
L_main8:
	BSF        RB1_bit+0, 1
;UartSimples.c,37 :: 		break;
	GOTO       L_main5
;UartSimples.c,38 :: 		case 't': amarelo = 0x00;
L_main9:
	BCF        RB1_bit+0, 1
;UartSimples.c,39 :: 		break;
	GOTO       L_main5
;UartSimples.c,40 :: 		case 'g': verde = 0x01;
L_main10:
	BSF        RB2_bit+0, 2
;UartSimples.c,41 :: 		break;
	GOTO       L_main5
;UartSimples.c,42 :: 		case 'f': verde = 0x00;
L_main11:
	BCF        RB2_bit+0, 2
;UartSimples.c,43 :: 		break;
	GOTO       L_main5
;UartSimples.c,44 :: 		}
L_main4:
	MOVF       _uart_rd+0, 0
	XORLW      98
	BTFSC      STATUS+0, 2
	GOTO       L_main6
	MOVF       _uart_rd+0, 0
	XORLW      118
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVF       _uart_rd+0, 0
	XORLW      121
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _uart_rd+0, 0
	XORLW      116
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _uart_rd+0, 0
	XORLW      103
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _uart_rd+0, 0
	XORLW      102
	BTFSC      STATUS+0, 2
	GOTO       L_main11
L_main5:
;UartSimples.c,45 :: 		}
L_main3:
;UartSimples.c,47 :: 		if(botao){
	BTFSS      RB7_bit+0, 7
	GOTO       L_main12
;UartSimples.c,48 :: 		UART1_Write_Text("Alerta!"); // Escreve o texto Alerta!
	MOVLW      ?lstr2_UartSimples+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UartSimples.c,49 :: 		UART1_Write(10); // Realimentação da linha
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartSimples.c,50 :: 		UART1_Write(13); // Quebra da linha
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartSimples.c,51 :: 		}
L_main12:
;UartSimples.c,52 :: 		}
	GOTO       L_main1
;UartSimples.c,53 :: 		}
	GOTO       $+0
; end of _main


_main:

;UartTemperatura.c,11 :: 		void main() {
;UartTemperatura.c,13 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;UartTemperatura.c,14 :: 		ADCON0 = 0x01; // Ou 0b00000001 habilita o adc do pic
	MOVLW      1
	MOVWF      ADCON0+0
;UartTemperatura.c,15 :: 		ADCON1 = 0x0E; // Ou 0b00001110 seleciona apena AN0 como entrada analogica, o resto como porta digital. 1110(binario) = E(Hex)
	MOVLW      14
	MOVWF      ADCON1+0
;UartTemperatura.c,18 :: 		TRISB = 0x80; // Ou 0b10000000 Seleciona apenas RB7 como entrada digital
	MOVLW      128
	MOVWF      TRISB+0
;UartTemperatura.c,19 :: 		PORTB = 0x00; // Inicia todo o portb com nível baixo
	CLRF       PORTB+0
;UartTemperatura.c,21 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;UartTemperatura.c,22 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
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
;UartTemperatura.c,24 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_UartTemperatura+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UartTemperatura.c,25 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartTemperatura.c,26 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartTemperatura.c,28 :: 		while (1) {                     // Endless loop
L_main1:
;UartTemperatura.c,29 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;UartTemperatura.c,30 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;UartTemperatura.c,31 :: 		UART1_Write(uart_rd);       // and send data via UART
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartTemperatura.c,32 :: 		}
L_main3:
;UartTemperatura.c,34 :: 		switch(uart_rd){
	GOTO       L_main4
;UartTemperatura.c,35 :: 		case 'b': azul = 0x01;
L_main6:
	BSF        RB0_bit+0, 0
;UartTemperatura.c,36 :: 		break;
	GOTO       L_main5
;UartTemperatura.c,37 :: 		case 'v': azul = 0x00;
L_main7:
	BCF        RB0_bit+0, 0
;UartTemperatura.c,38 :: 		break;
	GOTO       L_main5
;UartTemperatura.c,39 :: 		case 'y': amarelo = 0x01;
L_main8:
	BSF        RB1_bit+0, 1
;UartTemperatura.c,40 :: 		break;
	GOTO       L_main5
;UartTemperatura.c,41 :: 		case 't': amarelo = 0x00;
L_main9:
	BCF        RB1_bit+0, 1
;UartTemperatura.c,42 :: 		break;
	GOTO       L_main5
;UartTemperatura.c,43 :: 		case 'g': verde = 0x01;
L_main10:
	BSF        RB2_bit+0, 2
;UartTemperatura.c,44 :: 		break;
	GOTO       L_main5
;UartTemperatura.c,45 :: 		case 'f': verde = 0x00;
L_main11:
	BCF        RB2_bit+0, 2
;UartTemperatura.c,46 :: 		break;
	GOTO       L_main5
;UartTemperatura.c,47 :: 		}
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
;UartTemperatura.c,49 :: 		if(botao){
	BTFSS      RB7_bit+0, 7
	GOTO       L_main12
;UartTemperatura.c,50 :: 		valorAD = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _valorAD+0
	MOVF       R0+1, 0
	MOVWF      _valorAD+1
	CLRF       _valorAD+2
	CLRF       _valorAD+3
;UartTemperatura.c,52 :: 		temperatura = valorAD/2;
	MOVF       _valorAD+0, 0
	MOVWF      R0+0
	MOVF       _valorAD+1, 0
	MOVWF      R0+1
	MOVF       _valorAD+2, 0
	MOVWF      R0+2
	MOVF       _valorAD+3, 0
	MOVWF      R0+3
	RRF        R0+3, 1
	RRF        R0+2, 1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+3, 7
	BTFSC      R0+3, 6
	BSF        R0+3, 7
	MOVF       R0+0, 0
	MOVWF      _temperatura+0
	MOVF       R0+1, 0
	MOVWF      _temperatura+1
	MOVF       R0+2, 0
	MOVWF      _temperatura+2
	MOVF       R0+3, 0
	MOVWF      _temperatura+3
;UartTemperatura.c,54 :: 		IntToStr(temperatura, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;UartTemperatura.c,56 :: 		UART1_Write_Text(txt);
	MOVLW      _txt+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UartTemperatura.c,57 :: 		UART1_Write_Text(" Celsius");
	MOVLW      ?lstr2_UartTemperatura+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;UartTemperatura.c,58 :: 		UART1_Write(10); // Realimenta a linha
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartTemperatura.c,59 :: 		UART1_Write(13); // Quebra linha
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;UartTemperatura.c,60 :: 		delay_ms(200);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;UartTemperatura.c,61 :: 		}
L_main12:
;UartTemperatura.c,62 :: 		}
	GOTO       L_main1
;UartTemperatura.c,63 :: 		}
	GOTO       $+0
; end of _main

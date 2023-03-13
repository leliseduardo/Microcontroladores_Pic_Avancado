
_main:

;VoltTens�oNegativa.c,83 :: 		void main() {
;VoltTens�oNegativa.c,85 :: 		ADCON0 = 0x01; // Habilita AN0 como canal anal�gico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;VoltTens�oNegativa.c,86 :: 		ADCON1 = 0x0E; // Habilita o intervalo de tens�o de leitura do ADC como o intervalo da fonte de tens�o (0V � 5V). Ainda, configura
	MOVLW       14
	MOVWF       ADCON1+0 
;VoltTens�oNegativa.c,89 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital
	MOVLW       255
	MOVWF       TRISA+0 
;VoltTens�oNegativa.c,91 :: 		UART1_Init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;VoltTens�oNegativa.c,92 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	NOP
	NOP
;VoltTens�oNegativa.c,94 :: 		UART1_Write_Text("Voltimetro PIC18");
	MOVLW       ?lstr1_VoltTens�oNegativa+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_VoltTens�oNegativa+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;VoltTens�oNegativa.c,95 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;VoltTens�oNegativa.c,96 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;VoltTens�oNegativa.c,98 :: 		while(1){
L_main1:
;VoltTens�oNegativa.c,100 :: 		voltimetro(5.0);
	MOVLW       0
	MOVWF       FARG_voltimetro_range+0 
	MOVLW       0
	MOVWF       FARG_voltimetro_range+1 
	MOVLW       32
	MOVWF       FARG_voltimetro_range+2 
	MOVLW       129
	MOVWF       FARG_voltimetro_range+3 
	CALL        _voltimetro+0, 0
;VoltTens�oNegativa.c,101 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;VoltTens�oNegativa.c,102 :: 		}
	GOTO        L_main1
;VoltTens�oNegativa.c,103 :: 		}
	GOTO        $+0
; end of _main

_voltimetro:

;VoltTens�oNegativa.c,105 :: 		void voltimetro(float range){
;VoltTens�oNegativa.c,107 :: 		adc = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;VoltTens�oNegativa.c,109 :: 		tensao = ((adc * range) / 1024.0);
	CALL        _Int2Double+0, 0
	MOVF        FARG_voltimetro_range+0, 0 
	MOVWF       R4 
	MOVF        FARG_voltimetro_range+1, 0 
	MOVWF       R5 
	MOVF        FARG_voltimetro_range+2, 0 
	MOVWF       R6 
	MOVF        FARG_voltimetro_range+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _tensao+0 
	MOVF        R1, 0 
	MOVWF       _tensao+1 
	MOVF        R2, 0 
	MOVWF       _tensao+2 
	MOVF        R3, 0 
	MOVWF       _tensao+3 
;VoltTens�oNegativa.c,111 :: 		Vin = (tensao * 0.6) - 2.0;
	MOVLW       154
	MOVWF       R4 
	MOVLW       153
	MOVWF       R5 
	MOVLW       25
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _Vin+0 
	MOVF        R1, 0 
	MOVWF       _Vin+1 
	MOVF        R2, 0 
	MOVWF       _Vin+2 
	MOVF        R3, 0 
	MOVWF       _Vin+3 
;VoltTens�oNegativa.c,113 :: 		FloatToStr(Vin, txt); // Por alguma motivo essa fun��o n�o funciona quando se soma ou subtrai de Vin
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;VoltTens�oNegativa.c,115 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;VoltTens�oNegativa.c,116 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;VoltTens�oNegativa.c,117 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;VoltTens�oNegativa.c,118 :: 		}
	RETURN      0
; end of _voltimetro

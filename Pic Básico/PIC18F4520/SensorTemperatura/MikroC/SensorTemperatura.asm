
_main:

;SensorTemperatura.c,25 :: 		void main() {
;SensorTemperatura.c,29 :: 		ADCON0 = 0x01; // Habilita o canal 0 (AN0) como porta analógica e habilita o conversor analógico
	MOVLW       1
	MOVWF       ADCON0+0 
;SensorTemperatura.c,30 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão AD entre os limites da fonte (VSS e VDD) e configura apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;SensorTemperatura.c,32 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;SensorTemperatura.c,36 :: 		UART1_Init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SensorTemperatura.c,37 :: 		delay_ms(100);
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
;SensorTemperatura.c,39 :: 		UART1_Write_Text("Temperatura em Celsius");
	MOVLW       ?lstr1_SensorTemperatura+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_SensorTemperatura+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SensorTemperatura.c,40 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SensorTemperatura.c,41 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SensorTemperatura.c,46 :: 		while(1){
L_main1:
;SensorTemperatura.c,48 :: 		temperatura(5.0);
	MOVLW       0
	MOVWF       FARG_temperatura_range+0 
	MOVLW       0
	MOVWF       FARG_temperatura_range+1 
	MOVLW       32
	MOVWF       FARG_temperatura_range+2 
	MOVLW       129
	MOVWF       FARG_temperatura_range+3 
	CALL        _temperatura+0, 0
;SensorTemperatura.c,49 :: 		delay_ms(500);
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
;SensorTemperatura.c,50 :: 		} // end while
	GOTO        L_main1
;SensorTemperatura.c,51 :: 		} // end void main
	GOTO        $+0
; end of _main

_temperatura:

;SensorTemperatura.c,54 :: 		void temperatura(float range){
;SensorTemperatura.c,56 :: 		adc = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;SensorTemperatura.c,58 :: 		tensao = ((adc * range) / 1024); // Converte a leitura do adc para tensao
	CALL        _Int2Double+0, 0
	MOVF        FARG_temperatura_range+0, 0 
	MOVWF       R4 
	MOVF        FARG_temperatura_range+1, 0 
	MOVWF       R5 
	MOVF        FARG_temperatura_range+2, 0 
	MOVWF       R6 
	MOVF        FARG_temperatura_range+3, 0 
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
;SensorTemperatura.c,60 :: 		temp = tensao * 100; // Converte a tensao lida no adc em temperatura
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;SensorTemperatura.c,62 :: 		FloatToStr(temp, txt);
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
;SensorTemperatura.c,63 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SensorTemperatura.c,64 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SensorTemperatura.c,65 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;SensorTemperatura.c,66 :: 		}
	RETURN      0
; end of _temperatura

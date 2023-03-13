
_main:

;SensorTemperaturaLCD.c,67 :: 		void main() {
;SensorTemperaturaLCD.c,69 :: 		ADCON0 = 0x01; // Seleciona e habilita o canal AN0 e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;SensorTemperaturaLCD.c,70 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre a tensão da fonte (Vss a Vdd) e configura somente AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;SensorTemperaturaLCD.c,71 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;SensorTemperaturaLCD.c,72 :: 		TRISD = 0x03; // Ou 0b00000011, que configura apenas RD0 e RD1 como entrada digitais, pois não serão utilizados
	MOVLW       3
	MOVWF       TRISD+0 
;SensorTemperaturaLCD.c,74 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;SensorTemperaturaLCD.c,75 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SensorTemperaturaLCD.c,76 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SensorTemperaturaLCD.c,78 :: 		escreveDisplay();
	CALL        _escreveDisplay+0, 0
;SensorTemperaturaLCD.c,80 :: 		while(1){
L_main0:
;SensorTemperaturaLCD.c,82 :: 		celsius();
	CALL        _celsius+0, 0
;SensorTemperaturaLCD.c,83 :: 		}
	GOTO        L_main0
;SensorTemperaturaLCD.c,84 :: 		}
	GOTO        $+0
; end of _main

_celsius:

;SensorTemperaturaLCD.c,86 :: 		void celsius(){
;SensorTemperaturaLCD.c,88 :: 		mediaTemp = mediaADC();
	CALL        _mediaADC+0, 0
	MOVF        R0, 0 
	MOVWF       _mediaTemp+0 
	MOVF        R1, 0 
	MOVWF       _mediaTemp+1 
;SensorTemperaturaLCD.c,90 :: 		tensao = ((mediaTemp * 5.0) / 1024.0);
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
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
;SensorTemperaturaLCD.c,92 :: 		temperatura = tensao * 100.0;
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
	MOVWF       FLOC__celsius+0 
	MOVF        R1, 0 
	MOVWF       FLOC__celsius+1 
	MOVF        R2, 0 
	MOVWF       FLOC__celsius+2 
	MOVF        R3, 0 
	MOVWF       FLOC__celsius+3 
	MOVF        FLOC__celsius+0, 0 
	MOVWF       _temperatura+0 
	MOVF        FLOC__celsius+1, 0 
	MOVWF       _temperatura+1 
	MOVF        FLOC__celsius+2, 0 
	MOVWF       _temperatura+2 
	MOVF        FLOC__celsius+3, 0 
	MOVWF       _temperatura+3 
;SensorTemperaturaLCD.c,94 :: 		if(temperatura > (ultimaTemp + 0.5) || temperatura < (ultimaTemp - 0.5)){
	MOVF        _ultimaTemp+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemp+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemp+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemp+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        FLOC__celsius+0, 0 
	MOVWF       R4 
	MOVF        FLOC__celsius+1, 0 
	MOVWF       R5 
	MOVF        FLOC__celsius+2, 0 
	MOVWF       R6 
	MOVF        FLOC__celsius+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__celsius11
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	MOVF        _ultimaTemp+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemp+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemp+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemp+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _temperatura+0, 0 
	MOVWF       R0 
	MOVF        _temperatura+1, 0 
	MOVWF       R1 
	MOVF        _temperatura+2, 0 
	MOVWF       R2 
	MOVF        _temperatura+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__celsius11
	GOTO        L_celsius4
L__celsius11:
;SensorTemperaturaLCD.c,96 :: 		ultimaTemp = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemp+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemp+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemp+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemp+3 
;SensorTemperaturaLCD.c,98 :: 		FloatToStr(ultimaTemp, txt);
	MOVF        _temperatura+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _temperatura+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _temperatura+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _temperatura+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;SensorTemperaturaLCD.c,100 :: 		lcd_chr(2, 4, txt[0]); // Imprime na coluna 4 a posição 0 da string txt
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;SensorTemperaturaLCD.c,101 :: 		lcd_chr_cp(txt[1]); // Imprime na coluna 5 a posição 1 da string txt
	MOVF        _txt+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,102 :: 		lcd_chr_cp(txt[2]); // Imprime na coluna 6 a posição 2 da string txt
	MOVF        _txt+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,103 :: 		lcd_chr_cp(txt[3]); // Imprime na coluna 7 a posição 3 da string txt
	MOVF        _txt+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,104 :: 		lcd_chr_cp(txt[4]); // Imprime na coluna 8 a posição 4 da string txt
	MOVF        _txt+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,105 :: 		CustomChar(2, 9);
	MOVLW       2
	MOVWF       FARG_CustomChar_linha+0 
	MOVLW       9
	MOVWF       FARG_CustomChar_coluna+0 
	CALL        _CustomChar+0, 0
;SensorTemperaturaLCD.c,106 :: 		lcd_chr(2, 10, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;SensorTemperaturaLCD.c,107 :: 		}
L_celsius4:
;SensorTemperaturaLCD.c,108 :: 		}
	RETURN      0
; end of _celsius

_mediaADC:

;SensorTemperaturaLCD.c,110 :: 		int mediaADC(){
;SensorTemperaturaLCD.c,112 :: 		int adc = 0x00;
	CLRF        mediaADC_adc_L0+0 
	CLRF        mediaADC_adc_L0+1 
;SensorTemperaturaLCD.c,115 :: 		for(i = 0x00; i < 0x64; i++) // 0x64 = 100 decimal
	CLRF        mediaADC_i_L0+0 
	CLRF        mediaADC_i_L0+1 
L_mediaADC5:
	MOVLW       128
	XORWF       mediaADC_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mediaADC12
	MOVLW       100
	SUBWF       mediaADC_i_L0+0, 0 
L__mediaADC12:
	BTFSC       STATUS+0, 0 
	GOTO        L_mediaADC6
;SensorTemperaturaLCD.c,116 :: 		adc += adc_read(0); // Soma 100 vezes a leitura do adc na variável adc
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       mediaADC_adc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mediaADC_adc_L0+1, 1 
;SensorTemperaturaLCD.c,115 :: 		for(i = 0x00; i < 0x64; i++) // 0x64 = 100 decimal
	INFSNZ      mediaADC_i_L0+0, 1 
	INCF        mediaADC_i_L0+1, 1 
;SensorTemperaturaLCD.c,116 :: 		adc += adc_read(0); // Soma 100 vezes a leitura do adc na variável adc
	GOTO        L_mediaADC5
L_mediaADC6:
;SensorTemperaturaLCD.c,118 :: 		return (adc/0x64); // Divide o somatorio de 100 leituras do adc por 100 = 0x64, resultando na media de leituras
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        mediaADC_adc_L0+0, 0 
	MOVWF       R0 
	MOVF        mediaADC_adc_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
;SensorTemperaturaLCD.c,119 :: 		}
	RETURN      0
; end of _mediaADC

_CustomChar:

;SensorTemperaturaLCD.c,121 :: 		void CustomChar(char linha, char coluna) {
;SensorTemperaturaLCD.c,125 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SensorTemperaturaLCD.c,127 :: 		for (i = 0; i <= 7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar8:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar9
	MOVLW       _character+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar8
L_CustomChar9:
;SensorTemperaturaLCD.c,129 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SensorTemperaturaLCD.c,130 :: 		Lcd_Chr(linha, coluna, 0);
	MOVF        FARG_CustomChar_linha+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_coluna+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;SensorTemperaturaLCD.c,131 :: 		}
	RETURN      0
; end of _CustomChar

_escreveDisplay:

;SensorTemperaturaLCD.c,133 :: 		void escreveDisplay(){
;SensorTemperaturaLCD.c,135 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;SensorTemperaturaLCD.c,136 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,137 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,138 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,139 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,140 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,141 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,142 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,143 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,144 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,145 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,146 :: 		lcd_chr_cp('P');
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,147 :: 		lcd_chr_cp('I');
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,148 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SensorTemperaturaLCD.c,149 :: 		}
	RETURN      0
; end of _escreveDisplay

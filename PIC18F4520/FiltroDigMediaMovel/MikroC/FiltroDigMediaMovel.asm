
_main:

;FiltroDigMediaMovel.c,63 :: 		void main() {
;FiltroDigMediaMovel.c,66 :: 		ADCON0 = 0x01; // Configura AN0 como canal analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;FiltroDigMediaMovel.c,67 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura o apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;FiltroDigMediaMovel.c,68 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital, exceto AN0 que é entrada analógica
	MOVLW       255
	MOVWF       TRISA+0 
;FiltroDigMediaMovel.c,69 :: 		TRISD = 0x03; // Configura apenas RD0 e RD1 como entradas digitais, pois não serão usadas
	MOVLW       3
	MOVWF       TRISD+0 
;FiltroDigMediaMovel.c,72 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;FiltroDigMediaMovel.c,73 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;FiltroDigMediaMovel.c,74 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;FiltroDigMediaMovel.c,76 :: 		escreveDisplay();
	CALL        _escreveDisplay+0, 0
;FiltroDigMediaMovel.c,79 :: 		while(1){
L_main0:
;FiltroDigMediaMovel.c,81 :: 		celsius();
	CALL        _celsius+0, 0
;FiltroDigMediaMovel.c,82 :: 		}
	GOTO        L_main0
;FiltroDigMediaMovel.c,83 :: 		}
	GOTO        $+0
; end of _main

_celsius:

;FiltroDigMediaMovel.c,85 :: 		void celsius(){
;FiltroDigMediaMovel.c,87 :: 		movingAverage = mediaMovel();
	CALL        _mediaMovel+0, 0
	MOVF        R0, 0 
	MOVWF       _movingAverage+0 
	MOVF        R1, 0 
	MOVWF       _movingAverage+1 
	MOVF        R2, 0 
	MOVWF       _movingAverage+2 
	MOVF        R3, 0 
	MOVWF       _movingAverage+3 
;FiltroDigMediaMovel.c,89 :: 		temperatura = ((movingAverage * 5.0)/1024.0);
	CALL        _Longint2Double+0, 0
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
	MOVWF       _temperatura+0 
	MOVF        R1, 0 
	MOVWF       _temperatura+1 
	MOVF        R2, 0 
	MOVWF       _temperatura+2 
	MOVF        R3, 0 
	MOVWF       _temperatura+3 
;FiltroDigMediaMovel.c,91 :: 		temperatura = temperatura * 100.0;
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
;FiltroDigMediaMovel.c,93 :: 		if((temperatura > ultimaTemperatura + 0.8) || temperatura < ultimaTemperatura - 0.8){
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R3 
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
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
	GOTO        L__celsius14
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
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
	GOTO        L__celsius14
	GOTO        L_celsius4
L__celsius14:
;FiltroDigMediaMovel.c,95 :: 		ultimaTemperatura = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemperatura+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemperatura+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemperatura+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemperatura+3 
;FiltroDigMediaMovel.c,97 :: 		floatToStr(ultimaTemperatura, txt);
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
;FiltroDigMediaMovel.c,99 :: 		lcd_chr(2, 3, txt[0]); // Coluna 3
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;FiltroDigMediaMovel.c,100 :: 		lcd_chr_cp(txt[1]); // Coluna 4
	MOVF        _txt+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,101 :: 		lcd_chr_cp(txt[2]); // Coluna 5
	MOVF        _txt+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,102 :: 		lcd_chr_cp(txt[3]); // Coluna 6
	MOVF        _txt+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,103 :: 		lcd_chr_cp(txt[4]); // Coluna 7
	MOVF        _txt+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,104 :: 		CustomChar(2, 8);
	MOVLW       2
	MOVWF       FARG_CustomChar_linha+0 
	MOVLW       8
	MOVWF       FARG_CustomChar_coluna+0 
	CALL        _CustomChar+0, 0
;FiltroDigMediaMovel.c,105 :: 		lcd_chr(2, 9, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;FiltroDigMediaMovel.c,106 :: 		}
L_celsius4:
;FiltroDigMediaMovel.c,107 :: 		}
	RETURN      0
; end of _celsius

_mediaMovel:

;FiltroDigMediaMovel.c,109 :: 		long mediaMovel(){
;FiltroDigMediaMovel.c,112 :: 		long cont = 0;
	CLRF        mediaMovel_cont_L0+0 
	CLRF        mediaMovel_cont_L0+1 
	CLRF        mediaMovel_cont_L0+2 
	CLRF        mediaMovel_cont_L0+3 
;FiltroDigMediaMovel.c,114 :: 		adc = adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;FiltroDigMediaMovel.c,116 :: 		for(i = N-1; i > 0; i--)
	MOVLW       49
	MOVWF       mediaMovel_i_L0+0 
L_mediaMovel5:
	MOVF        mediaMovel_i_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_mediaMovel6
;FiltroDigMediaMovel.c,117 :: 		media[i] = media[i-1];
	MOVF        mediaMovel_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _media+0
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_media+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	DECF        mediaMovel_i_L0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	SUBWFB      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _media+0
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_media+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;FiltroDigMediaMovel.c,116 :: 		for(i = N-1; i > 0; i--)
	DECF        mediaMovel_i_L0+0, 1 
;FiltroDigMediaMovel.c,117 :: 		media[i] = media[i-1];
	GOTO        L_mediaMovel5
L_mediaMovel6:
;FiltroDigMediaMovel.c,119 :: 		media[0] = adc;
	MOVF        _adc+0, 0 
	MOVWF       _media+0 
	MOVF        _adc+1, 0 
	MOVWF       _media+1 
;FiltroDigMediaMovel.c,121 :: 		for(i = 0; i < N; i++)
	CLRF        mediaMovel_i_L0+0 
L_mediaMovel8:
	MOVLW       50
	SUBWF       mediaMovel_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mediaMovel9
;FiltroDigMediaMovel.c,122 :: 		cont = cont + media[i];
	MOVF        mediaMovel_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _media+0
	ADDWF       R0, 0 
	MOVWF       FSR2L 
	MOVLW       hi_addr(_media+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       mediaMovel_cont_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mediaMovel_cont_L0+1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      mediaMovel_cont_L0+2, 1 
	ADDWFC      mediaMovel_cont_L0+3, 1 
;FiltroDigMediaMovel.c,121 :: 		for(i = 0; i < N; i++)
	INCF        mediaMovel_i_L0+0, 1 
;FiltroDigMediaMovel.c,122 :: 		cont = cont + media[i];
	GOTO        L_mediaMovel8
L_mediaMovel9:
;FiltroDigMediaMovel.c,124 :: 		return (cont/N);
	MOVLW       50
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        mediaMovel_cont_L0+0, 0 
	MOVWF       R0 
	MOVF        mediaMovel_cont_L0+1, 0 
	MOVWF       R1 
	MOVF        mediaMovel_cont_L0+2, 0 
	MOVWF       R2 
	MOVF        mediaMovel_cont_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
;FiltroDigMediaMovel.c,125 :: 		}
	RETURN      0
; end of _mediaMovel

_CustomChar:

;FiltroDigMediaMovel.c,127 :: 		void CustomChar(char linha, char coluna) {
;FiltroDigMediaMovel.c,129 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;FiltroDigMediaMovel.c,130 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar11:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar12
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
	GOTO        L_CustomChar11
L_CustomChar12:
;FiltroDigMediaMovel.c,131 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;FiltroDigMediaMovel.c,132 :: 		Lcd_Chr(linha, coluna, 0);
	MOVF        FARG_CustomChar_linha+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_coluna+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;FiltroDigMediaMovel.c,133 :: 		}
	RETURN      0
; end of _CustomChar

_escreveDisplay:

;FiltroDigMediaMovel.c,135 :: 		void escreveDisplay(){
;FiltroDigMediaMovel.c,137 :: 		lcd_chr(1, 3, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;FiltroDigMediaMovel.c,138 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,139 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,140 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,141 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,142 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,143 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,144 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,145 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,146 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,147 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,148 :: 		lcd_chr_cp('P');
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,149 :: 		lcd_chr_cp('I');
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,150 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;FiltroDigMediaMovel.c,151 :: 		}
	RETURN      0
; end of _escreveDisplay

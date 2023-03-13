
_main:

;CartaoSDSimples.c,45 :: 		void main() {
;CartaoSDSimples.c,47 :: 		ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;CartaoSDSimples.c,48 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;CartaoSDSimples.c,50 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;CartaoSDSimples.c,51 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;CartaoSDSimples.c,52 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;CartaoSDSimples.c,53 :: 		start_SD();
	CALL        _start_SD+0, 0
;CartaoSDSimples.c,54 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;CartaoSDSimples.c,57 :: 		while(1){
L_main0:
;CartaoSDSimples.c,59 :: 		adc = adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;CartaoSDSimples.c,61 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;CartaoSDSimples.c,63 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;CartaoSDSimples.c,65 :: 		} // end Loop infinito
	GOTO        L_main0
;CartaoSDSimples.c,67 :: 		} // end void main
	GOTO        $+0
; end of _main

_imprime_Display:

;CartaoSDSimples.c,70 :: 		void imprime_Display(){
;CartaoSDSimples.c,74 :: 		valor = calcula_Tensao(adc);
	MOVF        _adc+0, 0 
	MOVWF       FARG_calcula_Tensao_n+0 
	MOVF        _adc+1, 0 
	MOVWF       FARG_calcula_Tensao_n+1 
	CALL        _calcula_Tensao+0, 0
	MOVF        R0, 0 
	MOVWF       _valor+0 
	MOVF        R1, 0 
	MOVWF       _valor+1 
;CartaoSDSimples.c,76 :: 		if(valor > valorMaximo){
	MOVF        R1, 0 
	SUBWF       _valorMaximo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__imprime_Display5
	MOVF        R0, 0 
	SUBWF       _valorMaximo+0, 0 
L__imprime_Display5:
	BTFSC       STATUS+0, 0 
	GOTO        L_imprime_Display3
;CartaoSDSimples.c,78 :: 		valorMaximo = valor;
	MOVF        _valor+0, 0 
	MOVWF       _valorMaximo+0 
	MOVF        _valor+1, 0 
	MOVWF       _valorMaximo+1 
;CartaoSDSimples.c,80 :: 		} // end if valor > valorMaximo
L_imprime_Display3:
;CartaoSDSimples.c,82 :: 		if(valor < valorMinimo){
	MOVF        _valorMinimo+1, 0 
	SUBWF       _valor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__imprime_Display6
	MOVF        _valorMinimo+0, 0 
	SUBWF       _valor+0, 0 
L__imprime_Display6:
	BTFSC       STATUS+0, 0 
	GOTO        L_imprime_Display4
;CartaoSDSimples.c,84 :: 		valorMinimo = valor;
	MOVF        _valor+0, 0 
	MOVWF       _valorMinimo+0 
	MOVF        _valor+1, 0 
	MOVWF       _valorMinimo+1 
;CartaoSDSimples.c,86 :: 		} // end if valor > valorMinimo
L_imprime_Display4:
;CartaoSDSimples.c,88 :: 		lcd_out(1, 2, "Voltimetro");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_CartaoSDSimples+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_CartaoSDSimples+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;CartaoSDSimples.c,90 :: 		mil = valor/1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_mil_L0+0 
;CartaoSDSimples.c,91 :: 		cen = (valor%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen_L0+0 
;CartaoSDSimples.c,92 :: 		dez = (valor%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez_L0+0 
;CartaoSDSimples.c,93 :: 		uni = valor%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni_L0+0 
;CartaoSDSimples.c,95 :: 		lcd_chr(2, 6, mil + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_mil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;CartaoSDSimples.c,96 :: 		lcd_chr_cp(cen + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;CartaoSDSimples.c,97 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;CartaoSDSimples.c,98 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;CartaoSDSimples.c,99 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;CartaoSDSimples.c,101 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_calcula_Tensao:

;CartaoSDSimples.c,104 :: 		unsigned calcula_Tensao(int n){
;CartaoSDSimples.c,108 :: 		tensao = ((n * 500.0) / 1023.0);
	MOVF        FARG_calcula_Tensao_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_calcula_Tensao_n+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;CartaoSDSimples.c,110 :: 		return (unsigned)tensao;
	CALL        _Double2Word+0, 0
;CartaoSDSimples.c,112 :: 		} // end unsigned calcula_Tensao
	RETURN      0
; end of _calcula_Tensao

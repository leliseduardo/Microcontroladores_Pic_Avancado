
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Frequencimetro.c,71 :: 		void interrupt(){
;Frequencimetro.c,73 :: 		if(CCP1IF_bit){
	BTFSS      CCP1IF_bit+0, 2
	GOTO       L_interrupt0
;Frequencimetro.c,75 :: 		CCP1IF_bit = 0x00;
	BCF        CCP1IF_bit+0, 2
;Frequencimetro.c,77 :: 		if(!flag0.B0){
	BTFSC      _flag0+0, 0
	GOTO       L_interrupt1
;Frequencimetro.c,79 :: 		tempo1 = (CCPR1H << 8) + CCPR1L;
	MOVF       CCPR1H+0, 0
	MOVWF      _tempo1+1
	CLRF       _tempo1+0
	MOVF       CCPR1L+0, 0
	ADDWF      _tempo1+0, 1
	BTFSC      STATUS+0, 0
	INCF       _tempo1+1, 1
;Frequencimetro.c,81 :: 		flag0.B0 = 0x01;
	BSF        _flag0+0, 0
;Frequencimetro.c,82 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;Frequencimetro.c,85 :: 		tempo2 = (CCPR1H << 8) + CCPR1L;
	MOVF       CCPR1H+0, 0
	MOVWF      _tempo2+1
	CLRF       _tempo2+0
	MOVF       CCPR1L+0, 0
	ADDWF      _tempo2+0, 1
	BTFSC      STATUS+0, 0
	INCF       _tempo2+1, 1
;Frequencimetro.c,87 :: 		flag0.B0 = 0x00;
	BCF        _flag0+0, 0
;Frequencimetro.c,89 :: 		}
L_interrupt2:
;Frequencimetro.c,90 :: 		}
L_interrupt0:
;Frequencimetro.c,91 :: 		}
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Frequencimetro.c,93 :: 		void main() {
;Frequencimetro.c,95 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;Frequencimetro.c,96 :: 		T1CON = 0x01; // Configura o prescaler para 1:1 e habilita o contador do timer1 (TMR1)
	MOVLW      1
	MOVWF      T1CON+0
;Frequencimetro.c,97 :: 		CCP1CON = 0x07; // Habilita o modo captura com prescaler de 16, isto é, 16 bordas de subida para captura
	MOVLW      7
	MOVWF      CCP1CON+0
;Frequencimetro.c,98 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;Frequencimetro.c,99 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;Frequencimetro.c,100 :: 		CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo cpp, no caso, no modo captura
	BSF        CCP1IE_bit+0, 2
;Frequencimetro.c,102 :: 		TRISA = 0xFF; // Configura o todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;Frequencimetro.c,103 :: 		TRISB = 0x09; // Configura apenas RB0 e RB3 (CCP) como entradas digitais
	MOVLW      9
	MOVWF      TRISB+0
;Frequencimetro.c,104 :: 		PORTA = 0xFF; // Inicia todo porta em High
	MOVLW      255
	MOVWF      PORTA+0
;Frequencimetro.c,105 :: 		PORTB = 0x00; // Inicia todo portb em Low
	CLRF       PORTB+0
;Frequencimetro.c,107 :: 		lcd_init();
	CALL       _Lcd_Init+0
;Frequencimetro.c,108 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Frequencimetro.c,109 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Frequencimetro.c,110 :: 		lcd_out(1,1,"Frequencia");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Frequencimetro+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Frequencimetro.c,111 :: 		lcd_out(2,14,"Hz");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Frequencimetro+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Frequencimetro.c,112 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;Frequencimetro.c,114 :: 		while(1){
L_main4:
;Frequencimetro.c,116 :: 		tempo2 = abs(tempo2 - tempo1); // Modulo da subtração
	MOVF       _tempo1+0, 0
	SUBWF      _tempo2+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       _tempo1+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _tempo2+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	MOVWF      _tempo2+0
	MOVF       R0+1, 0
	MOVWF      _tempo2+1
;Frequencimetro.c,118 :: 		tempo2 = (tempo2) >> 4; // Divide por 16
	MOVLW      4
	MOVWF      R2+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R2+0, 0
L__main8:
	BTFSC      STATUS+0, 2
	GOTO       L__main9
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	ADDLW      255
	GOTO       L__main8
L__main9:
	MOVF       R4+0, 0
	MOVWF      _tempo2+0
	MOVF       R4+1, 0
	MOVWF      _tempo2+1
;Frequencimetro.c,120 :: 		frequencia = 1 / (tempo2 * 1E-6);
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
	CALL       _Word2Double+0
	MOVLW      189
	MOVWF      R4+0
	MOVLW      55
	MOVWF      R4+1
	MOVLW      6
	MOVWF      R4+2
	MOVLW      107
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      0
	MOVWF      R0+2
	MOVLW      127
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	CALL       _Double2Longword+0
	MOVF       R0+0, 0
	MOVWF      _frequencia+0
	MOVF       R0+1, 0
	MOVWF      _frequencia+1
	MOVF       R0+2, 0
	MOVWF      _frequencia+2
	MOVF       R0+3, 0
	MOVWF      _frequencia+3
;Frequencimetro.c,122 :: 		LongToSTR(frequencia, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_LongToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_LongToStr_input+1
	MOVF       R0+2, 0
	MOVWF      FARG_LongToStr_input+2
	MOVF       R0+3, 0
	MOVWF      FARG_LongToStr_input+3
	MOVLW      _txt+0
	MOVWF      FARG_LongToStr_output+0
	CALL       _LongToStr+0
;Frequencimetro.c,124 :: 		lcd_out(2,2,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Frequencimetro.c,126 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
	NOP
;Frequencimetro.c,127 :: 		}
	GOTO       L_main4
;Frequencimetro.c,128 :: 		}
	GOTO       $+0
; end of _main

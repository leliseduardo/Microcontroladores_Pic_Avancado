
_main:

;LCDSimples.c,19 :: 		void main() {
;LCDSimples.c,21 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;LCDSimples.c,22 :: 		TRISA = 0X00;
	CLRF       TRISA+0
;LCDSimples.c,23 :: 		TRISB = 0X00;
	CLRF       TRISB+0
;LCDSimples.c,24 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;LCDSimples.c,25 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;LCDSimples.c,27 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;LCDSimples.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCDSimples.c,29 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCDSimples.c,31 :: 		Lcd_Out(1, 1, "Inicializando...");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_LCDSimples+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCDSimples.c,32 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;LCDSimples.c,33 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;LCDSimples.c,34 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;LCDSimples.c,36 :: 		while(1){
L_main2:
;LCDSimples.c,38 :: 		Lcd_Out(1,1,"Hello World!");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_LCDSimples+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;LCDSimples.c,39 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;LCDSimples.c,40 :: 		}
	GOTO       L_main2
;LCDSimples.c,42 :: 		}
	GOTO       $+0
; end of _main


_main:

;ContadorPulsosTimer1.c,21 :: 		void main() {
;ContadorPulsosTimer1.c,23 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;ContadorPulsosTimer1.c,24 :: 		T1CON = 0x03; // Ou 0b00000011, que configura o prescaler como 1:1, habilita o timer1 e habilita a contagem do timer1
	MOVLW      3
	MOVWF      T1CON+0
;ContadorPulsosTimer1.c,27 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;ContadorPulsosTimer1.c,28 :: 		TMR1H = 0x00;
	CLRF       TMR1H+0
;ContadorPulsosTimer1.c,30 :: 		TRISB = 0x03; // Ou 0b00000011, que configura apenas RB0 e RB1 como entradas digitais
	MOVLW      3
	MOVWF      TRISB+0
;ContadorPulsosTimer1.c,31 :: 		TRISC = 0xEF; // Ou 0b11101111, que configura apenas RC4 como saída digital
	MOVLW      239
	MOVWF      TRISC+0
;ContadorPulsosTimer1.c,33 :: 		PORTB = 0x00; // Inicia todo o portb em low;
	CLRF       PORTB+0
;ContadorPulsosTimer1.c,34 :: 		PORTC = 0xEF; // Inicia apenas RC4 em low
	MOVLW      239
	MOVWF      PORTC+0
;ContadorPulsosTimer1.c,51 :: 		lcd_init();
	CALL       _Lcd_Init+0
;ContadorPulsosTimer1.c,52 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ContadorPulsosTimer1.c,53 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ContadorPulsosTimer1.c,55 :: 		while(1){
L_main0:
;ContadorPulsosTimer1.c,57 :: 		lcd_out(1,1,"Pulse: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_ContadorPulsosTimer1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ContadorPulsosTimer1.c,59 :: 		pulse = (TMR1H << 8) + TMR1L; // Desloca o TMR1H 8 bits para esquerda e soma TMR1L, logo, pulse = 0b TMR1H TMR1L
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _pulse+0
	MOVF       R0+1, 0
	MOVWF      _pulse+1
;ContadorPulsosTimer1.c,61 :: 		IntToStr(pulse, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;ContadorPulsosTimer1.c,63 :: 		lcd_out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ContadorPulsosTimer1.c,65 :: 		if(pulse > 20)
	MOVF       _pulse+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main3
	MOVF       _pulse+0, 0
	SUBLW      20
L__main3:
	BTFSC      STATUS+0, 0
	GOTO       L_main2
;ContadorPulsosTimer1.c,66 :: 		RC4_bit = 0x01;
	BSF        RC4_bit+0, 4
L_main2:
;ContadorPulsosTimer1.c,67 :: 		}
	GOTO       L_main0
;ContadorPulsosTimer1.c,69 :: 		}
	GOTO       $+0
; end of _main

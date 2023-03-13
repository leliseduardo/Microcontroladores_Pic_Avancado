
_main:

;ShiftLeftLeds.c,4 :: 		void main() {
;ShiftLeftLeds.c,6 :: 		TRISB = 0;
	CLRF       TRISB+0
;ShiftLeftLeds.c,7 :: 		PORTB = 0b11111111; // ou 0xFF ou 255
	MOVLW      255
	MOVWF      PORTB+0
;ShiftLeftLeds.c,9 :: 		while(1){
L_main0:
;ShiftLeftLeds.c,11 :: 		PORTB = control;
	MOVF       _control+0, 0
	MOVWF      PORTB+0
;ShiftLeftLeds.c,13 :: 		control = control << 1;
	RLF        _control+0, 1
	RLF        _control+1, 1
	BCF        _control+0, 0
;ShiftLeftLeds.c,14 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;ShiftLeftLeds.c,16 :: 		if(control == 0)
	MOVLW      0
	XORWF      _control+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main4
	MOVLW      0
	XORWF      _control+0, 0
L__main4:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;ShiftLeftLeds.c,17 :: 		control = 0b11111111; // ou 0xFF ou 255
	MOVLW      255
	MOVWF      _control+0
	CLRF       _control+1
L_main3:
;ShiftLeftLeds.c,19 :: 		}
	GOTO       L_main0
;ShiftLeftLeds.c,21 :: 		}
	GOTO       $+0
; end of _main

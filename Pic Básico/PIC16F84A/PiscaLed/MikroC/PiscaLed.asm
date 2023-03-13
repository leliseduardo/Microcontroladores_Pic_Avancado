
_main:

;PiscaLed.c,1 :: 		void main() {
;PiscaLed.c,3 :: 		TRISB = 0b00000000;
	CLRF       TRISB+0
;PiscaLed.c,4 :: 		PORTB = 0b00000000;
	CLRF       PORTB+0
;PiscaLed.c,6 :: 		while(1){
L_main0:
;PiscaLed.c,8 :: 		RB1_bit = 1;
	BSF        RB1_bit+0, 1
;PiscaLed.c,9 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;PiscaLed.c,10 :: 		RB1_bit = 0;
	BCF        RB1_bit+0, 1
;PiscaLed.c,11 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;PiscaLed.c,13 :: 		}
	GOTO       L_main0
;PiscaLed.c,15 :: 		}
	GOTO       $+0
; end of _main

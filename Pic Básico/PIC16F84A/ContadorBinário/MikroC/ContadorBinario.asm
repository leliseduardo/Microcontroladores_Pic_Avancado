
_main:

;ContadorBinario.c,1 :: 		void main() {
;ContadorBinario.c,3 :: 		TRISB = 0b00000000;
	CLRF       TRISB+0
;ContadorBinario.c,4 :: 		PORTB = 0b00000000;
	CLRF       PORTB+0
;ContadorBinario.c,6 :: 		while(1){
L_main0:
;ContadorBinario.c,8 :: 		PORTB++;
	INCF       PORTB+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;ContadorBinario.c,9 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;ContadorBinario.c,11 :: 		}
	GOTO       L_main0
;ContadorBinario.c,13 :: 		}
	GOTO       $+0
; end of _main

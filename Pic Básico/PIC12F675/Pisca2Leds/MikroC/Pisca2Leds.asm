
_main:

;Pisca2Leds.c,1 :: 		void main() {
;Pisca2Leds.c,3 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Pisca2Leds.c,4 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;Pisca2Leds.c,5 :: 		TRISIO0_bit = 0;
	BCF        TRISIO0_bit+0, 0
;Pisca2Leds.c,6 :: 		TRISIO1_bit = 0;
	BCF        TRISIO1_bit+0, 1
;Pisca2Leds.c,7 :: 		GPIO = 0;
	CLRF       GPIO+0
;Pisca2Leds.c,9 :: 		while(1){
L_main0:
;Pisca2Leds.c,11 :: 		GPIO.F0 = 0;
	BCF        GPIO+0, 0
;Pisca2Leds.c,12 :: 		GPIO.F1 = 1;
	BSF        GPIO+0, 1
;Pisca2Leds.c,13 :: 		delay_ms(100);
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
;Pisca2Leds.c,14 :: 		GPIO.F0 = 1;
	BSF        GPIO+0, 0
;Pisca2Leds.c,15 :: 		GPIO.F1 = 0;
	BCF        GPIO+0, 1
;Pisca2Leds.c,16 :: 		delay_ms(100);
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
;Pisca2Leds.c,18 :: 		}
	GOTO       L_main0
;Pisca2Leds.c,19 :: 		}
	GOTO       $+0
; end of _main


_main:

;OsciladorExterno.c,1 :: 		void main() {
;OsciladorExterno.c,3 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;OsciladorExterno.c,4 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;OsciladorExterno.c,6 :: 		TRISIO0_bit = 0;
	BCF        TRISIO0_bit+0, 0
;OsciladorExterno.c,7 :: 		TRISIO1_bit = 0;
	BCF        TRISIO1_bit+0, 1
;OsciladorExterno.c,9 :: 		GPIO = 0;
	CLRF       GPIO+0
;OsciladorExterno.c,11 :: 		while(1){
L_main0:
;OsciladorExterno.c,13 :: 		GPIO.F0 = 1;
	BSF        GPIO+0, 0
;OsciladorExterno.c,14 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
;OsciladorExterno.c,15 :: 		GPIO.F0 = 0;
	BCF        GPIO+0, 0
;OsciladorExterno.c,16 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
;OsciladorExterno.c,18 :: 		GPIO.F1 = 1;
	BSF        GPIO+0, 1
;OsciladorExterno.c,19 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
;OsciladorExterno.c,20 :: 		GPIO.F1 = 0;
	BCF        GPIO+0, 1
;OsciladorExterno.c,21 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
;OsciladorExterno.c,23 :: 		}
	GOTO       L_main0
;OsciladorExterno.c,25 :: 		}
	GOTO       $+0
; end of _main

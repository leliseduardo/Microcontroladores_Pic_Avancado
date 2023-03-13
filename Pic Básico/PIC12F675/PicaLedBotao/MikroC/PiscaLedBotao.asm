
_main:

;PiscaLedBotao.c,1 :: 		void main() {
;PiscaLedBotao.c,3 :: 		ANSEL = 0x00;
	CLRF       ANSEL+0
;PiscaLedBotao.c,4 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;PiscaLedBotao.c,6 :: 		TRISIO4_bit = 1;
	BSF        TRISIO4_bit+0, 4
;PiscaLedBotao.c,7 :: 		TRISIO5_bit = 0;
	BCF        TRISIO5_bit+0, 5
;PiscaLedBotao.c,9 :: 		GPIO = 0;
	CLRF       GPIO+0
;PiscaLedBotao.c,11 :: 		while(1){
L_main0:
;PiscaLedBotao.c,13 :: 		if(GPIO.F4){
	BTFSS      GPIO+0, 4
	GOTO       L_main2
;PiscaLedBotao.c,14 :: 		GPIO.F5 = 1;
	BSF        GPIO+0, 5
;PiscaLedBotao.c,15 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
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
;PiscaLedBotao.c,16 :: 		}
	GOTO       L_main4
L_main2:
;PiscaLedBotao.c,18 :: 		GPIO.F5 = 0;
	BCF        GPIO+0, 5
L_main4:
;PiscaLedBotao.c,20 :: 		}
	GOTO       L_main0
;PiscaLedBotao.c,22 :: 		}
	GOTO       $+0
; end of _main

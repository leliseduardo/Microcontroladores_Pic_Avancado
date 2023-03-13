
_main:

;DoisLedsDoisBotoes.c,6 :: 		void main() {
;DoisLedsDoisBotoes.c,8 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;DoisLedsDoisBotoes.c,9 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;DoisLedsDoisBotoes.c,11 :: 		TRISIO0_bit = 1;
	BSF        TRISIO0_bit+0, 0
;DoisLedsDoisBotoes.c,12 :: 		TRISIO1_bit = 1;
	BSF        TRISIO1_bit+0, 1
;DoisLedsDoisBotoes.c,13 :: 		TRISIO4_bit = 0;
	BCF        TRISIO4_bit+0, 4
;DoisLedsDoisBotoes.c,14 :: 		TRISIO5_bit = 0;
	BCF        TRISIO5_bit+0, 5
;DoisLedsDoisBotoes.c,16 :: 		S1 = 1;
	BSF        GPIO+0, 0
;DoisLedsDoisBotoes.c,17 :: 		S2 = 1;
	BSF        GPIO+0, 1
;DoisLedsDoisBotoes.c,18 :: 		D1 = 0;
	BCF        GPIO+0, 4
;DoisLedsDoisBotoes.c,19 :: 		D2 = 0;
	BCF        GPIO+0, 5
;DoisLedsDoisBotoes.c,21 :: 		while(1){
L_main0:
;DoisLedsDoisBotoes.c,23 :: 		if(S1 == 0){
	BTFSC      GPIO+0, 0
	GOTO       L_main2
;DoisLedsDoisBotoes.c,24 :: 		D1 = ~D1;
	MOVLW      16
	XORWF      GPIO+0, 1
;DoisLedsDoisBotoes.c,25 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
;DoisLedsDoisBotoes.c,26 :: 		}
L_main2:
;DoisLedsDoisBotoes.c,28 :: 		if(S2 == 0){
	BTFSC      GPIO+0, 1
	GOTO       L_main4
;DoisLedsDoisBotoes.c,29 :: 		D2 = ~D2;
	MOVLW      32
	XORWF      GPIO+0, 1
;DoisLedsDoisBotoes.c,30 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
;DoisLedsDoisBotoes.c,31 :: 		}
L_main4:
;DoisLedsDoisBotoes.c,33 :: 		}
	GOTO       L_main0
;DoisLedsDoisBotoes.c,34 :: 		}
	GOTO       $+0
; end of _main


_main:

;RandomLeds.c,8 :: 		void main() {
;RandomLeds.c,10 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;RandomLeds.c,11 :: 		TRISA = 3; // ou 0b00000011, pois s1 e s2 são inputs
	MOVLW      3
	MOVWF      TRISA+0
;RandomLeds.c,12 :: 		PORTA = 3; // ou 0b00000011, pois s1 e s2 são ativadas com nível 0
	MOVLW      3
	MOVWF      PORTA+0
;RandomLeds.c,14 :: 		while(1){
L_main0:
;RandomLeds.c,16 :: 		numbers = rand();
	CALL       _rand+0
	MOVF       R0+0, 0
	MOVWF      _numbers+0
	MOVF       R0+1, 0
	MOVWF      _numbers+1
;RandomLeds.c,18 :: 		led1 = numbers;
	BTFSC      R0+0, 0
	GOTO       L__main11
	BCF        RA3_bit+0, 3
	GOTO       L__main12
L__main11:
	BSF        RA3_bit+0, 3
L__main12:
;RandomLeds.c,19 :: 		led2 = ~led1;
	BTFSC      RA3_bit+0, 3
	GOTO       L__main13
	BSF        RA2_bit+0, 2
	GOTO       L__main14
L__main13:
	BCF        RA2_bit+0, 2
L__main14:
;RandomLeds.c,21 :: 		while(led1 == 1){
L_main2:
	BTFSS      RA3_bit+0, 3
	GOTO       L_main3
;RandomLeds.c,22 :: 		if(s1 == 0)
	BTFSC      RA0_bit+0, 0
	GOTO       L_main4
;RandomLeds.c,23 :: 		led1 = 0;
	BCF        RA3_bit+0, 3
L_main4:
;RandomLeds.c,25 :: 		delay_ms(70);
	MOVLW      91
	MOVWF      R12+0
	MOVLW      231
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
	NOP
;RandomLeds.c,26 :: 		}
	GOTO       L_main2
L_main3:
;RandomLeds.c,28 :: 		while(led2 == 1){
L_main6:
	BTFSS      RA2_bit+0, 2
	GOTO       L_main7
;RandomLeds.c,29 :: 		if(s2 == 0)
	BTFSC      RA1_bit+0, 1
	GOTO       L_main8
;RandomLeds.c,30 :: 		led2 = 0;
	BCF        RA2_bit+0, 2
L_main8:
;RandomLeds.c,32 :: 		delay_ms(70);
	MOVLW      91
	MOVWF      R12+0
	MOVLW      231
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	NOP
	NOP
;RandomLeds.c,33 :: 		}
	GOTO       L_main6
L_main7:
;RandomLeds.c,35 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;RandomLeds.c,37 :: 		}
	GOTO       L_main0
;RandomLeds.c,39 :: 		}
	GOTO       $+0
; end of _main

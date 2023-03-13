
_main:

;DoisProgramas.c,7 :: 		void main() {
;DoisProgramas.c,9 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;DoisProgramas.c,10 :: 		TRISA = 3; // ou 0b00000011, número 3 em binário. Bits menos significativos iguais a 1 pois S1 e S2 são inputs
	MOVLW      3
	MOVWF      TRISA+0
;DoisProgramas.c,11 :: 		PORTA = 3; // Pois S1 e S2 são ativados quando se joga nível 0 neles
	MOVLW      3
	MOVWF      PORTA+0
;DoisProgramas.c,13 :: 		while(1){
L_main0:
;DoisProgramas.c,14 :: 		if(S1 == 0){
	BTFSC      RA0_bit+0, 0
	GOTO       L_main2
;DoisProgramas.c,15 :: 		while(1){
L_main3:
;DoisProgramas.c,16 :: 		Led1 = 0;
	BCF        RA3_bit+0, 3
;DoisProgramas.c,17 :: 		Led2 = 1;
	BSF        RA2_bit+0, 2
;DoisProgramas.c,18 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;DoisProgramas.c,19 :: 		Led1 = 1;
	BSF        RA3_bit+0, 3
;DoisProgramas.c,20 :: 		Led2 = 0;
	BCF        RA2_bit+0, 2
;DoisProgramas.c,21 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
;DoisProgramas.c,22 :: 		}
	GOTO       L_main3
;DoisProgramas.c,23 :: 		}
L_main2:
;DoisProgramas.c,25 :: 		if(S2 == 0){
	BTFSC      RA1_bit+0, 1
	GOTO       L_main7
;DoisProgramas.c,26 :: 		while(1){
L_main8:
;DoisProgramas.c,27 :: 		Led1 = 1;
	BSF        RA3_bit+0, 3
;DoisProgramas.c,28 :: 		Led2 = 1;
	BSF        RA2_bit+0, 2
;DoisProgramas.c,29 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
;DoisProgramas.c,30 :: 		Led1 = 0;
	BCF        RA3_bit+0, 3
;DoisProgramas.c,31 :: 		Led2 = 0;
	BCF        RA2_bit+0, 2
;DoisProgramas.c,32 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
;DoisProgramas.c,33 :: 		}
	GOTO       L_main8
;DoisProgramas.c,34 :: 		}
L_main7:
;DoisProgramas.c,35 :: 		}
	GOTO       L_main0
;DoisProgramas.c,39 :: 		}
	GOTO       $+0
; end of _main

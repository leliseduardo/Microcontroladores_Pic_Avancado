
_main:

;WatchDogSimples.c,3 :: 		void main() {
;WatchDogSimples.c,6 :: 		OPTION_REG = 0x8E; // Ou 0b10001110, desabilita os pull-ups internos e habilita o watchDog timer com prescaler 1:128
	MOVLW      142
	MOVWF      OPTION_REG+0
;WatchDogSimples.c,8 :: 		TRISB = 0x7E; // Ou 0b01111110, configura RB0 e RB7 como saídas digitais
	MOVLW      126
	MOVWF      TRISB+0
;WatchDogSimples.c,9 :: 		PORTB = 0x8E; // Ou 0b10001110, Inicia RB0 em Low e RB7 em High
	MOVLW      142
	MOVWF      PORTB+0
;WatchDogSimples.c,11 :: 		asm clrwdt;
	CLRWDT
;WatchDogSimples.c,13 :: 		while(1){
L_main0:
;WatchDogSimples.c,15 :: 		asm clrwdt;
	CLRWDT
;WatchDogSimples.c,17 :: 		led = 0x01;
	BSF        RB0_bit+0, 0
;WatchDogSimples.c,18 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
;WatchDogSimples.c,19 :: 		led = 0x00;
	BCF        RB0_bit+0, 0
;WatchDogSimples.c,20 :: 		delay_ms(300);
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
;WatchDogSimples.c,21 :: 		}
	GOTO       L_main0
;WatchDogSimples.c,23 :: 		}
	GOTO       $+0
; end of _main

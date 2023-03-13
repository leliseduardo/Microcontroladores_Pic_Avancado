
_main:

;HelloWorld.c,8 :: 		void main() {
;HelloWorld.c,10 :: 		ADCON1 = 0x0F; // Configura todas as portas analógicar do portb como portas digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;HelloWorld.c,12 :: 		TRISB = 0xFE; // Configura apenas RB0_bit como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;HelloWorld.c,14 :: 		while(1){
L_main0:
;HelloWorld.c,16 :: 		LATB0_bit = 0x01; // É a mesma coisa que RB0_bit
	BSF         LATB0_bit+0, 0 
;HelloWorld.c,17 :: 		delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;HelloWorld.c,18 :: 		LATB0_bit = 0x00;
	BCF         LATB0_bit+0, 0 
;HelloWorld.c,19 :: 		delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;HelloWorld.c,20 :: 		}
	GOTO        L_main0
;HelloWorld.c,21 :: 		}
	GOTO        $+0
; end of _main

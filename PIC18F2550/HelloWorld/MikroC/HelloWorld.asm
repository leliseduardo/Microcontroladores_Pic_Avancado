
_main:

;HelloWorld.c,21 :: 		void main() {
;HelloWorld.c,23 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;HelloWorld.c,24 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;HelloWorld.c,25 :: 		PORTB = 0xFE; // Inicia todas as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;HelloWorld.c,28 :: 		while(1){
L_main0:
;HelloWorld.c,30 :: 		LATB0_bit = 0x01;
	BSF         LATB0_bit+0, 0 
;HelloWorld.c,31 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;HelloWorld.c,32 :: 		LATB0_bit = 0x00;
	BCF         LATB0_bit+0, 0 
;HelloWorld.c,33 :: 		delay_ms(500);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;HelloWorld.c,35 :: 		} // end loop infinito
	GOTO        L_main0
;HelloWorld.c,37 :: 		} // end void main
	GOTO        $+0
; end of _main

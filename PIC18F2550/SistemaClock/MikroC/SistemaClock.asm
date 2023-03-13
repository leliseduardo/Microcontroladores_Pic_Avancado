
_main:

;SistemaClock.c,21 :: 		void main() {
;SistemaClock.c,23 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;SistemaClock.c,24 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;SistemaClock.c,25 :: 		PORTB = 0xFE; // Inicia todos as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;SistemaClock.c,26 :: 		LATB0_bit = 0x00; // Inicia LATB0 em Low
	BCF         LATB0_bit+0, 0 
;SistemaClock.c,29 :: 		while(1){
L_main0:
;SistemaClock.c,31 :: 		pisca_Led();
	CALL        _pisca_Led+0, 0
;SistemaClock.c,33 :: 		} // end loop infinito
	GOTO        L_main0
;SistemaClock.c,35 :: 		} // end void main
	GOTO        $+0
; end of _main

_pisca_Led:

;SistemaClock.c,37 :: 		void pisca_Led(){
;SistemaClock.c,39 :: 		LATB0_bit = 0x01;
	BSF         LATB0_bit+0, 0 
;SistemaClock.c,40 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_pisca_Led2:
	DECFSZ      R13, 1, 1
	BRA         L_pisca_Led2
	DECFSZ      R12, 1, 1
	BRA         L_pisca_Led2
	DECFSZ      R11, 1, 1
	BRA         L_pisca_Led2
;SistemaClock.c,41 :: 		LATB0_bit = 0x00;
	BCF         LATB0_bit+0, 0 
;SistemaClock.c,42 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_pisca_Led3:
	DECFSZ      R13, 1, 1
	BRA         L_pisca_Led3
	DECFSZ      R12, 1, 1
	BRA         L_pisca_Led3
	DECFSZ      R11, 1, 1
	BRA         L_pisca_Led3
;SistemaClock.c,44 :: 		} // end void pisca_Led
	RETURN      0
; end of _pisca_Led


_main:

;HelloWorld2.c,17 :: 		void main() {
;HelloWorld2.c,19 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;HelloWorld2.c,20 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;HelloWorld2.c,21 :: 		PORTB = 0xFE; // Inicia todos as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;HelloWorld2.c,22 :: 		LATB0_bit = 0x00; // Inicia LATB0 em Low
	BCF         LATB0_bit+0, 0 
;HelloWorld2.c,25 :: 		while(1){
L_main0:
;HelloWorld2.c,27 :: 		pisca_Led();
	CALL        _pisca_Led+0, 0
;HelloWorld2.c,29 :: 		} // end loop infinito
	GOTO        L_main0
;HelloWorld2.c,31 :: 		} // end void main
	GOTO        $+0
; end of _main

_pisca_Led:

;HelloWorld2.c,33 :: 		void pisca_Led(){
;HelloWorld2.c,35 :: 		LATB0_bit = 0x01;
	BSF         LATB0_bit+0, 0 
;HelloWorld2.c,36 :: 		delay_ms(200);
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
;HelloWorld2.c,37 :: 		LATB0_bit = 0x00;
	BCF         LATB0_bit+0, 0 
;HelloWorld2.c,38 :: 		delay_ms(200);
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
;HelloWorld2.c,40 :: 		} // end void pisca_Led
	RETURN      0
; end of _pisca_Led

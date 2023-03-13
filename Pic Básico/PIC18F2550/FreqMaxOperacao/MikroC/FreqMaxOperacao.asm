
_main:

;FreqMaxOperacao.c,23 :: 		void main() {
;FreqMaxOperacao.c,25 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;FreqMaxOperacao.c,26 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;FreqMaxOperacao.c,27 :: 		PORTB = 0xFE; // Inicia todas as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;FreqMaxOperacao.c,28 :: 		LATB0_bit = 0x00; // Inicia a saída LATB0 em Low
	BCF         LATB0_bit+0, 0 
;FreqMaxOperacao.c,39 :: 		loop:
___main_loop:
;FreqMaxOperacao.c,41 :: 		asm bsf LATB,0; // No MikroC, códigos em Assembly devem ter o "asm" na frente
	BSF         LATB+0, 0, 1
;FreqMaxOperacao.c,42 :: 		asm bcf LATB,0;
	BCF         LATB+0, 0, 1
;FreqMaxOperacao.c,44 :: 		goto loop;
	GOTO        ___main_loop
;FreqMaxOperacao.c,46 :: 		}
	GOTO        $+0
; end of _main

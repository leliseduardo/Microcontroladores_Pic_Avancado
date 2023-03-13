
_main:

;FreqMaxOperacao2.c,21 :: 		void main() {
;FreqMaxOperacao2.c,23 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;FreqMaxOperacao2.c,24 :: 		TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;FreqMaxOperacao2.c,25 :: 		PORTB = 0xFE; // Inicia todas as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;FreqMaxOperacao2.c,26 :: 		LATB0_bit = 0x00; // Inicia a sa�da LATB0 em Low
	BCF         LATB0_bit+0, 0 
;FreqMaxOperacao2.c,37 :: 		loop:
___main_loop:
;FreqMaxOperacao2.c,39 :: 		asm bsf LATB,0; // No MikroC, c�digos em Assembly devem ter o "asm" na frente
	BSF         LATB+0, 0, 1
;FreqMaxOperacao2.c,40 :: 		asm nop; // nop = No Operation. Este comando gasta um ciclo de m�quina e n�o executa nada
	NOP
;FreqMaxOperacao2.c,41 :: 		asm nop;
	NOP
;FreqMaxOperacao2.c,42 :: 		asm bcf LATB,0;
	BCF         LATB+0, 0, 1
;FreqMaxOperacao2.c,44 :: 		goto loop;
	GOTO        ___main_loop
;FreqMaxOperacao2.c,46 :: 		}
	GOTO        $+0
; end of _main

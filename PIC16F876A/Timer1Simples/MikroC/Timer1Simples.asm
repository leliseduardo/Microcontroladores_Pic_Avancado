
_main:

;Timer1Simples.c,12 :: 		void main() {
;Timer1Simples.c,14 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;Timer1Simples.c,15 :: 		T1CON = 0x01; // Ativa o timer 1 e configura o prescaler como 1:1
	MOVLW      1
	MOVWF      T1CON+0
;Timer1Simples.c,16 :: 		TMR1L = 0x00; // Inicia a contagem do timer 1 em 0
	CLRF       TMR1L+0
;Timer1Simples.c,17 :: 		TMR1H = 0x00;
	CLRF       TMR1H+0
;Timer1Simples.c,19 :: 		TRISC = 0xEF; // Ou 0b11101111, que configura apensa RC4 como saída digital
	MOVLW      239
	MOVWF      TRISC+0
;Timer1Simples.c,20 :: 		RC4_bit = 0x00;
	BCF        RC4_bit+0, 4
;Timer1Simples.c,22 :: 		while(1){
L_main0:
;Timer1Simples.c,24 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_main2
;Timer1Simples.c,26 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;Timer1Simples.c,28 :: 		RC4_bit = ~RC4_bit;
	MOVLW      16
	XORWF      RC4_bit+0, 1
;Timer1Simples.c,29 :: 		}
L_main2:
;Timer1Simples.c,30 :: 		}
	GOTO       L_main0
;Timer1Simples.c,31 :: 		}
	GOTO       $+0
; end of _main

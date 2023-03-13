
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;saidaInterna.c,3 :: 		void interrupt(){
;saidaInterna.c,5 :: 		if(CMIF_bit){
	BTFSS      CMIF_bit+0, 6
	GOTO       L_interrupt0
;saidaInterna.c,7 :: 		CMIF_bit = 0x00;
	BCF        CMIF_bit+0, 6
;saidaInterna.c,9 :: 		if(C1OUT_bit)
	BTFSS      C1OUT_bit+0, 6
	GOTO       L_interrupt1
;saidaInterna.c,10 :: 		led = 0x01;
	BSF        RB0_bit+0, 0
	GOTO       L_interrupt2
L_interrupt1:
;saidaInterna.c,12 :: 		led = 0x00;
	BCF        RB0_bit+0, 0
L_interrupt2:
;saidaInterna.c,13 :: 		}
L_interrupt0:
;saidaInterna.c,14 :: 		}
L__interrupt3:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;saidaInterna.c,16 :: 		void main() {
;saidaInterna.c,18 :: 		GIE_bit = 0x01; // Ativa a interrupção global
	BSF        GIE_bit+0, 7
;saidaInterna.c,19 :: 		PEIE_bit = 0x01; // Ativa a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;saidaInterna.c,20 :: 		CMIE_bit = 0x01; // Ativa os comparadores internos
	BSF        CMIE_bit+0, 6
;saidaInterna.c,21 :: 		CMCON = 0x02; // Ativa os dois comparadores internos sem saída externa, apenas a mudança da flag C1OUT
	MOVLW      2
	MOVWF      CMCON+0
;saidaInterna.c,23 :: 		TRISA = 0x0F; // Configura o primeiro nibble como entrada digital, isto é, RA0, RA1, RA2 e RA3
	MOVLW      15
	MOVWF      TRISA+0
;saidaInterna.c,24 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW      254
	MOVWF      TRISB+0
;saidaInterna.c,25 :: 		}
	GOTO       $+0
; end of _main


_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SaidaPino.c,2 :: 		void interrupt(){
;SaidaPino.c,4 :: 		if(CMIF_bit){
	BTFSS      CMIF_bit+0, 6
	GOTO       L_interrupt0
;SaidaPino.c,6 :: 		CMIF_bit = 0x00;
	BCF        CMIF_bit+0, 6
;SaidaPino.c,7 :: 		}
L_interrupt0:
;SaidaPino.c,8 :: 		}
L__interrupt1:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SaidaPino.c,10 :: 		void main() {
;SaidaPino.c,12 :: 		GIE_bit = 0x01; // Ativa a interrupção global
	BSF        GIE_bit+0, 7
;SaidaPino.c,13 :: 		PEIE_bit = 0x01; // Ativa a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;SaidaPino.c,14 :: 		CMIE_bit = 0x01; // Ativa os comparadores internos
	BSF        CMIE_bit+0, 6
;SaidaPino.c,15 :: 		CMCON = 0x03; // Ativa os dois comparadores internos e configura suas saídas nos pinos RA4 e RA5
	MOVLW      3
	MOVWF      CMCON+0
;SaidaPino.c,17 :: 		TRISA = 0x0F; // Configura RA0, RA1, RA2 e RA3 como entradas digitais
	MOVLW      15
	MOVWF      TRISA+0
;SaidaPino.c,18 :: 		}
	GOTO       $+0
; end of _main

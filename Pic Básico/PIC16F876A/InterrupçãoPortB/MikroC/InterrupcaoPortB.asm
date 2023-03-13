
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;InterrupcaoPortB.c,2 :: 		void interrupt(){
;InterrupcaoPortB.c,4 :: 		if(RBIF_bit){
	BTFSS      RBIF_bit+0, 0
	GOTO       L_interrupt0
;InterrupcaoPortB.c,6 :: 		RBIF_bit = 0x00;
	BCF        RBIF_bit+0, 0
;InterrupcaoPortB.c,8 :: 		RC4_bit = ~RC4_bit;
	MOVLW      16
	XORWF      RC4_bit+0, 1
;InterrupcaoPortB.c,9 :: 		}
L_interrupt0:
;InterrupcaoPortB.c,10 :: 		}
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

;InterrupcaoPortB.c,12 :: 		void main() {
;InterrupcaoPortB.c,14 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;InterrupcaoPortB.c,15 :: 		RBIE_bit = 0x01; // Habilita a interrupção por mudança de estado do portb que, no caso, é apenas para o nibble mais significativo
	BSF        RBIE_bit+0, 3
;InterrupcaoPortB.c,16 :: 		RBIF_bit = 0x00; // Força a flag de interrupção para 0, isto é, a flag que monitora a mudança de estado do portb é 0
	BCF        RBIF_bit+0, 0
;InterrupcaoPortB.c,17 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;InterrupcaoPortB.c,19 :: 		TRISB = 0xFF; // Todo portb como entrada
	MOVLW      255
	MOVWF      TRISB+0
;InterrupcaoPortB.c,20 :: 		TRISC = 0xEF; // Apenas RC4 como saída
	MOVLW      239
	MOVWF      TRISC+0
;InterrupcaoPortB.c,22 :: 		while(1){
L_main1:
;InterrupcaoPortB.c,25 :: 		}
	GOTO       L_main1
;InterrupcaoPortB.c,26 :: 		}
	GOTO       $+0
; end of _main

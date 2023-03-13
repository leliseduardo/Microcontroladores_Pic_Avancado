
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TensaoRefInterna.c,3 :: 		void interrupt(){
;TensaoRefInterna.c,5 :: 		if(CMIF_bit){
	BTFSS      CMIF_bit+0, 6
	GOTO       L_interrupt0
;TensaoRefInterna.c,7 :: 		CMIF_bit = 0;
	BCF        CMIF_bit+0, 6
;TensaoRefInterna.c,9 :: 		if(!C1OUT_bit)
	BTFSC      C1OUT_bit+0, 6
	GOTO       L_interrupt1
;TensaoRefInterna.c,10 :: 		rele = 0x01;
	BSF        RB0_bit+0, 0
	GOTO       L_interrupt2
L_interrupt1:
;TensaoRefInterna.c,12 :: 		rele = 0x00;
	BCF        RB0_bit+0, 0
L_interrupt2:
;TensaoRefInterna.c,13 :: 		}
L_interrupt0:
;TensaoRefInterna.c,14 :: 		}
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TensaoRefInterna.c,16 :: 		void main() {
;TensaoRefInterna.c,18 :: 		CMCON = 0x02; // Habilita os comparadores internos com tensão de referencia internas e tensao de saída interna
	MOVLW      2
	MOVWF      CMCON+0
;TensaoRefInterna.c,19 :: 		VRCON = 0xBC; // Habilita referencia interna e configura a tensao interna para 2,5V
	MOVLW      188
	MOVWF      VRCON+0
;TensaoRefInterna.c,20 :: 		INTCON = 0xC0; // Habilita a interrupção global e a interrupção por periféricos
	MOVLW      192
	MOVWF      INTCON+0
;TensaoRefInterna.c,21 :: 		CMIE_bit = 0x01; // Flag do registrador PIE1, habilita a interrupção pelo comparador
	BSF        CMIE_bit+0, 6
;TensaoRefInterna.c,23 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;TensaoRefInterna.c,24 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW      254
	MOVWF      TRISB+0
;TensaoRefInterna.c,25 :: 		rele = 0x00;
	BCF        RB0_bit+0, 0
;TensaoRefInterna.c,27 :: 		while(1){
L_main3:
;TensaoRefInterna.c,30 :: 		}
	GOTO       L_main3
;TensaoRefInterna.c,31 :: 		}
	GOTO       $+0
; end of _main


_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;IncrementoExtTimer0.c,3 :: 		void interrupt(){
;IncrementoExtTimer0.c,5 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;IncrementoExtTimer0.c,7 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;IncrementoExtTimer0.c,8 :: 		TMR0 = 250;
	MOVLW      250
	MOVWF      TMR0+0
;IncrementoExtTimer0.c,10 :: 		led1 = ~led1;
	MOVLW      1
	XORWF      RA0_bit+0, 1
;IncrementoExtTimer0.c,11 :: 		}
L_interrupt0:
;IncrementoExtTimer0.c,12 :: 		}
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

;IncrementoExtTimer0.c,14 :: 		void main() {
;IncrementoExtTimer0.c,16 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;IncrementoExtTimer0.c,17 :: 		OPTION_REG = 0xB8; // Desabilita os pull-up internos, configura o incremento do tmr0 pelo pino RA4, quando houver uma transição
	MOVLW      184
	MOVWF      OPTION_REG+0
;IncrementoExtTimer0.c,19 :: 		INTCON = 0xA0;  // Habilita a interrupção global, desabilita a interrupção por perifericos e ativa a interrupção do timer0
	MOVLW      160
	MOVWF      INTCON+0
;IncrementoExtTimer0.c,20 :: 		TMR0 = 250; // tmr0 começa a contagem em 250, logo, só conta até 6, pois 256 - 250 = 6
	MOVLW      250
	MOVWF      TMR0+0
;IncrementoExtTimer0.c,22 :: 		TRISA = 0xFE; // Ou 0b11111110, que configura apenas RA0 como saída digital
	MOVLW      254
	MOVWF      TRISA+0
;IncrementoExtTimer0.c,23 :: 		led1 = 0x00; // Inicia led1, que é RA0, em Low
	BCF        RA0_bit+0, 0
;IncrementoExtTimer0.c,25 :: 		while(1){
L_main1:
;IncrementoExtTimer0.c,28 :: 		}
	GOTO       L_main1
;IncrementoExtTimer0.c,29 :: 		}
	GOTO       $+0
; end of _main


_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;InterrupcaoSimples.c,3 :: 		void interrupt(){
;InterrupcaoSimples.c,4 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;InterrupcaoSimples.c,5 :: 		cont++;
	INCF       _cont+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cont+1, 1
;InterrupcaoSimples.c,6 :: 		TMR0 = 0x06;
	MOVLW      6
	MOVWF      TMR0+0
;InterrupcaoSimples.c,8 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;InterrupcaoSimples.c,9 :: 		}
L_interrupt0:
;InterrupcaoSimples.c,10 :: 		}
L__interrupt4:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;InterrupcaoSimples.c,12 :: 		void main() {
;InterrupcaoSimples.c,14 :: 		OPTION_REG = 0x81; // Ou 0b10000001, configura o prescaler para 1:4 associado ao TMR0 e desabilita os resistores de pull-up internos
	MOVLW      129
	MOVWF      OPTION_REG+0
;InterrupcaoSimples.c,15 :: 		GIE_bit = 0x01; // Habilita a interrução global do Pic
	BSF        GIE_bit+0, 7
;InterrupcaoSimples.c,16 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;InterrupcaoSimples.c,17 :: 		T0IE_bit = 0x01; // Habilita a interrupção por estouro do TMR0
	BSF        T0IE_bit+0, 5
;InterrupcaoSimples.c,19 :: 		TMR0 = 0x06; // Inicia a contagem do timer 0 em 0
	MOVLW      6
	MOVWF      TMR0+0
;InterrupcaoSimples.c,21 :: 		TRISB.RB4 = 0x00; // Seleciona RB4 como saída digital
	BCF        TRISB+0, 4
;InterrupcaoSimples.c,22 :: 		RB4_bit = 0x00; // Inicia RB4 em nível baixo (low)
	BCF        RB4_bit+0, 4
;InterrupcaoSimples.c,24 :: 		while(1){
L_main1:
;InterrupcaoSimples.c,25 :: 		if(cont == 500){
	MOVF       _cont+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main5
	MOVLW      244
	XORWF      _cont+0, 0
L__main5:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;InterrupcaoSimples.c,26 :: 		RB4_bit = ~RB4_bit; // Alterna RB4 entre HIGH e LOW
	MOVLW      16
	XORWF      RB4_bit+0, 1
;InterrupcaoSimples.c,27 :: 		cont = 0x00;
	CLRF       _cont+0
	CLRF       _cont+1
;InterrupcaoSimples.c,28 :: 		}
L_main3:
;InterrupcaoSimples.c,29 :: 		}
	GOTO       L_main1
;InterrupcaoSimples.c,31 :: 		}
	GOTO       $+0
; end of _main

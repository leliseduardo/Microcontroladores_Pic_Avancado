
_main:

;PicDuino.c,15 :: 		void main() {
;PicDuino.c,17 :: 		CMCON = 0x07;                  // Desliga os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;PicDuino.c,18 :: 		TRISA = 0xF3;                  // Ou 0b11110011, configura apenas RA2 e RA3 como saídas digitais
	MOVLW      243
	MOVWF      TRISA+0
;PicDuino.c,19 :: 		TRISB = 0xFF;                  // Configura todo portb como entrada digital
	MOVLW      255
	MOVWF      TRISB+0
;PicDuino.c,20 :: 		led1  = 0x00;                  // Inicia led1 em Low
	BCF        RA2_bit+0, 2
;PicDuino.c,21 :: 		led2  = 0x00;                  // Inicia led2 em Low
	BCF        RA3_bit+0, 3
;PicDuino.c,24 :: 		while(1){
L_main0:
;PicDuino.c,26 :: 		if(!botao1)                  // Testa se botao1 está pressionado
	BTFSC      RA0_bit+0, 0
	GOTO       L_main2
;PicDuino.c,27 :: 		led1 = 0x01;               // Se estiver, acende led1
	BSF        RA2_bit+0, 2
	GOTO       L_main3
L_main2:
;PicDuino.c,29 :: 		led1 = 0x00;               // Se não estiver, apaga led1
	BCF        RA2_bit+0, 2
L_main3:
;PicDuino.c,31 :: 		if(!botao2)                  // Testa se botao2 está pressionado
	BTFSC      RA1_bit+0, 1
	GOTO       L_main4
;PicDuino.c,32 :: 		led2 = 0x01;               // Se estiver, acende led2
	BSF        RA3_bit+0, 3
	GOTO       L_main5
L_main4:
;PicDuino.c,34 :: 		led2 = 0x00;               // Se não estiver, apaga led2
	BCF        RA3_bit+0, 3
L_main5:
;PicDuino.c,36 :: 		} // end Loop infinito
	GOTO       L_main0
;PicDuino.c,38 :: 		} // end void main
	GOTO       $+0
; end of _main

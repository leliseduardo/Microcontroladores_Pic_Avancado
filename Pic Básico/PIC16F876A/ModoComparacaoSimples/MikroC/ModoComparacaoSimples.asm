
_main:

;ModoComparacaoSimples.c,3 :: 		void main() {
;ModoComparacaoSimples.c,5 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;ModoComparacaoSimples.c,6 :: 		T1CON = 0x31; // Ou 0b00110001, que configura o prescaler em 1:8 e ativa o timer1
	MOVLW      49
	MOVWF      T1CON+0
;ModoComparacaoSimples.c,7 :: 		TMR1L = 0x00; // Inicia o contador do timer1 em 0
	CLRF       TMR1L+0
;ModoComparacaoSimples.c,8 :: 		TMR1H = 0x00;
	CLRF       TMR1H+0
;ModoComparacaoSimples.c,11 :: 		CCP1CON = 0x0B; // Ou 0b00001011, que configura o modo comparador como gatilho especial, reiniciando o contador do timer1
	MOVLW      11
	MOVWF      CCP1CON+0
;ModoComparacaoSimples.c,12 :: 		CCPR1L = 0xFF;  // Inicia o registrador do modo comparador em 0xFFFF;
	MOVLW      255
	MOVWF      CCPR1L+0
;ModoComparacaoSimples.c,13 :: 		CCPR1H = 0xFF;
	MOVLW      255
	MOVWF      CCPR1H+0
;ModoComparacaoSimples.c,15 :: 		TRISC = 0xFA; // Ou 0x11111010, que configura apenas RC0 e RC2 como saída digital
	MOVLW      250
	MOVWF      TRISC+0
;ModoComparacaoSimples.c,16 :: 		RC2_bit = 0x00; // Inicia RC2 em Low
	BCF        RC2_bit+0, 2
;ModoComparacaoSimples.c,17 :: 		RC0_bit = 0x00; // Inicia RC0 em Low
	BCF        RC0_bit+0, 0
;ModoComparacaoSimples.c,30 :: 		while(1){
L_main0:
;ModoComparacaoSimples.c,32 :: 		if(CCP1IF_bit){
	BTFSS      CCP1IF_bit+0, 2
	GOTO       L_main2
;ModoComparacaoSimples.c,34 :: 		CCP1IF_bit = 0x00;
	BCF        CCP1IF_bit+0, 2
;ModoComparacaoSimples.c,36 :: 		RC0_bit = ~RC0_bit;
	MOVLW      1
	XORWF      RC0_bit+0, 1
;ModoComparacaoSimples.c,37 :: 		}
L_main2:
;ModoComparacaoSimples.c,38 :: 		}
	GOTO       L_main0
;ModoComparacaoSimples.c,40 :: 		}
	GOTO       $+0
; end of _main


_main:

;ProtecaoCodigo.c,4 :: 		void main() {
;ProtecaoCodigo.c,6 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;ProtecaoCodigo.c,8 :: 		TRISB = 0xFC; // Configura apenas RB0 e RB1 como saídas digitais
	MOVLW      252
	MOVWF      TRISB+0
;ProtecaoCodigo.c,9 :: 		PORTB = 0xFC; // Inicia RB0 e RB1 em Low
	MOVLW      252
	MOVWF      PORTB+0
;ProtecaoCodigo.c,11 :: 		while(1){
L_main0:
;ProtecaoCodigo.c,13 :: 		led1 = 0x01;
	BSF        RB0_bit+0, 0
;ProtecaoCodigo.c,14 :: 		led2 = 0x00;
	BCF        RB1_bit+0, 1
;ProtecaoCodigo.c,15 :: 		delay_ms(600);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;ProtecaoCodigo.c,16 :: 		led1 = 0x00;
	BCF        RB0_bit+0, 0
;ProtecaoCodigo.c,17 :: 		led2 = 0x01;
	BSF        RB1_bit+0, 1
;ProtecaoCodigo.c,18 :: 		delay_ms(600);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
	NOP
;ProtecaoCodigo.c,19 :: 		}
	GOTO       L_main0
;ProtecaoCodigo.c,20 :: 		}
	GOTO       $+0
; end of _main


_main:

;MultiplexacaoLeds.c,6 :: 		void main() {
;MultiplexacaoLeds.c,8 :: 		CMCON = 0X07;
	MOVLW      7
	MOVWF      CMCON+0
;MultiplexacaoLeds.c,9 :: 		TRISA = 0X03; // Ou 0b00000011, seleciona os pinos 0 e 1 como entradas digitais
	MOVLW      3
	MOVWF      TRISA+0
;MultiplexacaoLeds.c,10 :: 		PORTA = 0x03; // Ou 0b00000011, inicia os pinos 0 e 1 em nivel logico alto
	MOVLW      3
	MOVWF      PORTA+0
;MultiplexacaoLeds.c,12 :: 		while(1){
L_main0:
;MultiplexacaoLeds.c,14 :: 		led1 = 0x01;
	BSF        RA2_bit+0, 2
;MultiplexacaoLeds.c,15 :: 		led2 = 0x00;
	BCF        RA3_bit+0, 3
;MultiplexacaoLeds.c,16 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
;MultiplexacaoLeds.c,17 :: 		led1 = 0x00;
	BCF        RA2_bit+0, 2
;MultiplexacaoLeds.c,18 :: 		led2 = 0x01;
	BSF        RA3_bit+0, 3
;MultiplexacaoLeds.c,19 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
;MultiplexacaoLeds.c,21 :: 		}
	GOTO       L_main0
;MultiplexacaoLeds.c,22 :: 		}
	GOTO       $+0
; end of _main

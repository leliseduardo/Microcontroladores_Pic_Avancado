
_main:

;ConversorDASimples.c,3 :: 		void main() {
;ConversorDASimples.c,5 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;ConversorDASimples.c,6 :: 		TRISA = 0xFF; // Todo porta como entrada digital, mesmo sendo um conversor DA RA2 é configurado como entrada
	MOVLW      255
	MOVWF      TRISA+0
;ConversorDASimples.c,8 :: 		VRCON = 0xE7; // O valor máximo para o conversor DA é de 3,1V, mas nesse prog não vai ser utilizada essa tensão
	MOVLW      231
	MOVWF      VRCON+0
;ConversorDASimples.c,11 :: 		while(1){
L_main0:
;ConversorDASimples.c,13 :: 		VRCON = 0xE7;
	MOVLW      231
	MOVWF      VRCON+0
;ConversorDASimples.c,14 :: 		delay_ms(50);
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
;ConversorDASimples.c,15 :: 		VRCON = 0xE6;
	MOVLW      230
	MOVWF      VRCON+0
;ConversorDASimples.c,16 :: 		delay_ms(50);
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
;ConversorDASimples.c,17 :: 		VRCON = 0xE5;
	MOVLW      229
	MOVWF      VRCON+0
;ConversorDASimples.c,18 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
;ConversorDASimples.c,19 :: 		VRCON = 0xE4;
	MOVLW      228
	MOVWF      VRCON+0
;ConversorDASimples.c,20 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
;ConversorDASimples.c,21 :: 		VRCON = 0xE3;
	MOVLW      227
	MOVWF      VRCON+0
;ConversorDASimples.c,22 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
;ConversorDASimples.c,23 :: 		VRCON = 0xE2;
	MOVLW      226
	MOVWF      VRCON+0
;ConversorDASimples.c,24 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
;ConversorDASimples.c,25 :: 		VRCON = 0xE1;
	MOVLW      225
	MOVWF      VRCON+0
;ConversorDASimples.c,26 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	NOP
;ConversorDASimples.c,27 :: 		}
	GOTO       L_main0
;ConversorDASimples.c,28 :: 		}
	GOTO       $+0
; end of _main

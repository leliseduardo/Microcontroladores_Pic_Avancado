
_main:

;Display7Seg.c,1 :: 		void main() {
;Display7Seg.c,4 :: 		unsigned char anodo, cont = 0x00; // numero 0 em hexa
	CLRF       main_cont_L0+0
	MOVLW      63
	MOVWF      main_numero_L0+0
	MOVLW      6
	MOVWF      main_numero_L0+1
	MOVLW      91
	MOVWF      main_numero_L0+2
	MOVLW      79
	MOVWF      main_numero_L0+3
	MOVLW      102
	MOVWF      main_numero_L0+4
	MOVLW      109
	MOVWF      main_numero_L0+5
	MOVLW      125
	MOVWF      main_numero_L0+6
	MOVLW      7
	MOVWF      main_numero_L0+7
	MOVLW      255
	MOVWF      main_numero_L0+8
	MOVLW      111
	MOVWF      main_numero_L0+9
;Display7Seg.c,7 :: 		CMCON = 0x07; // ou 0b00000111
	MOVLW      7
	MOVWF      CMCON+0
;Display7Seg.c,8 :: 		TRISB = 0X00; // ou 0b00000000, seleciona o portb todo como saída
	CLRF       TRISB+0
;Display7Seg.c,9 :: 		PORTB = 0X00; // inicia todo o portb com nível baixo
	CLRF       PORTB+0
;Display7Seg.c,11 :: 		while(1){
L_main0:
;Display7Seg.c,13 :: 		anodo = numero[cont];
	MOVF       main_cont_L0+0, 0
	ADDLW      main_numero_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;Display7Seg.c,15 :: 		PORTB = anodo;
;Display7Seg.c,17 :: 		cont++;
	INCF       main_cont_L0+0, 1
;Display7Seg.c,18 :: 		if(cont == 10)
	MOVF       main_cont_L0+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;Display7Seg.c,19 :: 		cont = 0;
	CLRF       main_cont_L0+0
L_main2:
;Display7Seg.c,21 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;Display7Seg.c,23 :: 		} //end while
	GOTO       L_main0
;Display7Seg.c,25 :: 		}
	GOTO       $+0
; end of _main

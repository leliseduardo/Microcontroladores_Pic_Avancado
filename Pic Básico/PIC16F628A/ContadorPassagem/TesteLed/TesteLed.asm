
_main:

;TesteLed.c,3 :: 		void main() {
;TesteLed.c,5 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;TesteLed.c,6 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;TesteLed.c,7 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;TesteLed.c,8 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;TesteLed.c,9 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;TesteLed.c,11 :: 		while(1){
L_main0:
;TesteLed.c,13 :: 		unsigned long int i = 0;
	CLRF       main_i_L1+0
	CLRF       main_i_L1+1
	CLRF       main_i_L1+2
	CLRF       main_i_L1+3
;TesteLed.c,15 :: 		while(i < 7000){
L_main2:
	MOVLW      0
	SUBWF      main_i_L1+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVLW      0
	SUBWF      main_i_L1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVLW      27
	SUBWF      main_i_L1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main7
	MOVLW      88
	SUBWF      main_i_L1+0, 0
L__main7:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;TesteLed.c,16 :: 		led = 0x01;
	BSF        RA1_bit+0, 1
;TesteLed.c,17 :: 		delay_us(14);
	MOVLW      4
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	NOP
;TesteLed.c,18 :: 		led = 0x00;
	BCF        RA1_bit+0, 1
;TesteLed.c,19 :: 		delay_us(14);
	MOVLW      4
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	NOP
;TesteLed.c,20 :: 		i++;
	MOVF       main_i_L1+0, 0
	MOVWF      R0+0
	MOVF       main_i_L1+1, 0
	MOVWF      R0+1
	MOVF       main_i_L1+2, 0
	MOVWF      R0+2
	MOVF       main_i_L1+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      main_i_L1+0
	MOVF       R0+1, 0
	MOVWF      main_i_L1+1
	MOVF       R0+2, 0
	MOVWF      main_i_L1+2
	MOVF       R0+3, 0
	MOVWF      main_i_L1+3
;TesteLed.c,21 :: 		}
	GOTO       L_main2
L_main3:
;TesteLed.c,23 :: 		i = 0;
	CLRF       main_i_L1+0
	CLRF       main_i_L1+1
	CLRF       main_i_L1+2
	CLRF       main_i_L1+3
;TesteLed.c,25 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
;TesteLed.c,26 :: 		}
	GOTO       L_main0
;TesteLed.c,28 :: 		}
	GOTO       $+0
; end of _main


_main:

;ADC.c,5 :: 		void main() {
;ADC.c,7 :: 		ANSEL = 1; // Ou 0b00000001 Seleciona AN0 como entrada analógica
	MOVLW      1
	MOVWF      ANSEL+0
;ADC.c,8 :: 		ADCON0 = 1; // Ou 0b00000001 Habilita a entrada AN0
	MOVLW      1
	MOVWF      ADCON0+0
;ADC.c,9 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;ADC.c,10 :: 		TRISIO4_bit = 0;
	BCF        TRISIO4_bit+0, 4
;ADC.c,11 :: 		TRISIO5_bit = 0;
	BCF        TRISIO5_bit+0, 5
;ADC.c,12 :: 		GPIO = 0;
	CLRF       GPIO+0
;ADC.c,13 :: 		control = 0x00;
	BCF        _control+0, BitPos(_control+0)
;ADC.c,15 :: 		while(1){
L_main0:
;ADC.c,17 :: 		leituraADC = adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _leituraADC+0
	MOVF       R0+1, 0
	MOVWF      _leituraADC+1
;ADC.c,19 :: 		if(leituraADC < 700){
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORLW      2
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main6
	MOVLW      188
	SUBWF      R0+0, 0
L__main6:
	BTFSC      STATUS+0, 0
	GOTO       L_main2
;ADC.c,21 :: 		control = ~control;
	MOVLW
	XORWF      _control+0, 1
;ADC.c,24 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
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
;ADC.c,26 :: 		}
L_main2:
;ADC.c,28 :: 		if(control){
	BTFSS      _control+0, BitPos(_control+0)
	GOTO       L_main4
;ADC.c,30 :: 		GPIO.F4 = ~GPIO.F4;
	MOVLW      16
	XORWF      GPIO+0, 1
;ADC.c,31 :: 		GPIO.F5 = ~GPIO.F5;
	MOVLW      32
	XORWF      GPIO+0, 1
;ADC.c,33 :: 		}
	GOTO       L_main5
L_main4:
;ADC.c,35 :: 		GPIO = 0x00;
	CLRF       GPIO+0
L_main5:
;ADC.c,37 :: 		}
	GOTO       L_main0
;ADC.c,39 :: 		}
	GOTO       $+0
; end of _main

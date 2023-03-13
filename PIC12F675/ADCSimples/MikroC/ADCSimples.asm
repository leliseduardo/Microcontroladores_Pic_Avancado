
_main:

;ADCSimples.c,8 :: 		void main() {
;ADCSimples.c,10 :: 		ANSEL = 1; // OU 0b00000001 Seleciona AN0 como entrada analógica
	MOVLW      1
	MOVWF      ANSEL+0
;ADCSimples.c,11 :: 		ADCON0 = 1; // Seleciona a entrada AN0
	MOVLW      1
	MOVWF      ADCON0+0
;ADCSimples.c,12 :: 		CMCON = 7;
	MOVLW      7
	MOVWF      CMCON+0
;ADCSimples.c,14 :: 		TRISIO = 1; // Ou 0b00000001 Habilita GP0 como entrada
	MOVLW      1
	MOVWF      TRISIO+0
;ADCSimples.c,15 :: 		GPIO = 0; // Ou 0x00000000 Inicia todos em low
	CLRF       GPIO+0
;ADCSimples.c,17 :: 		while(1){
L_main0:
;ADCSimples.c,18 :: 		leituraADC = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _leituraADC+0
	MOVF       R0+1, 0
	MOVWF      _leituraADC+1
;ADCSimples.c,20 :: 		if(leituraADC > 0){
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main8
	MOVF       R0+0, 0
	SUBLW      0
L__main8:
	BTFSC      STATUS+0, 0
	GOTO       L_main2
;ADCSimples.c,21 :: 		led1 = 0;
	BCF        GPIO+0, 5
;ADCSimples.c,22 :: 		led2 = 0;
	BCF        GPIO+0, 4
;ADCSimples.c,23 :: 		led3 = 0;
	BCF        GPIO+0, 2
;ADCSimples.c,24 :: 		led4 = 0;
	BCF        GPIO+0, 1
;ADCSimples.c,25 :: 		}
L_main2:
;ADCSimples.c,27 :: 		if(leituraADC > 204){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _leituraADC+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main9
	MOVF       _leituraADC+0, 0
	SUBLW      204
L__main9:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;ADCSimples.c,28 :: 		led1 = 1;
	BSF        GPIO+0, 5
;ADCSimples.c,29 :: 		led2 = 0;
	BCF        GPIO+0, 4
;ADCSimples.c,30 :: 		led3 = 0;
	BCF        GPIO+0, 2
;ADCSimples.c,31 :: 		led4 = 0;
	BCF        GPIO+0, 1
;ADCSimples.c,32 :: 		}
L_main3:
;ADCSimples.c,34 :: 		if(leituraADC > 408){
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      _leituraADC+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVF       _leituraADC+0, 0
	SUBLW      152
L__main10:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;ADCSimples.c,35 :: 		led1 = 1;
	BSF        GPIO+0, 5
;ADCSimples.c,36 :: 		led2 = 1;
	BSF        GPIO+0, 4
;ADCSimples.c,37 :: 		led3 = 0;
	BCF        GPIO+0, 2
;ADCSimples.c,38 :: 		led4 = 0;
	BCF        GPIO+0, 1
;ADCSimples.c,39 :: 		}
L_main4:
;ADCSimples.c,41 :: 		if(leituraADC > 612){
	MOVLW      128
	XORLW      2
	MOVWF      R0+0
	MOVLW      128
	XORWF      _leituraADC+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVF       _leituraADC+0, 0
	SUBLW      100
L__main11:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;ADCSimples.c,42 :: 		led1 = 1;
	BSF        GPIO+0, 5
;ADCSimples.c,43 :: 		led2 = 1;
	BSF        GPIO+0, 4
;ADCSimples.c,44 :: 		led3 = 1;
	BSF        GPIO+0, 2
;ADCSimples.c,45 :: 		led4 = 0;
	BCF        GPIO+0, 1
;ADCSimples.c,46 :: 		}
L_main5:
;ADCSimples.c,48 :: 		if(leituraADC > 816){
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _leituraADC+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVF       _leituraADC+0, 0
	SUBLW      48
L__main12:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;ADCSimples.c,49 :: 		led1 = 1;
	BSF        GPIO+0, 5
;ADCSimples.c,50 :: 		led2 = 1;
	BSF        GPIO+0, 4
;ADCSimples.c,51 :: 		led3 = 1;
	BSF        GPIO+0, 2
;ADCSimples.c,52 :: 		led4 = 1;
	BSF        GPIO+0, 1
;ADCSimples.c,53 :: 		}
L_main6:
;ADCSimples.c,55 :: 		delay_ms(100); // Taxa de atualização do ADC
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
	NOP
;ADCSimples.c,56 :: 		}
	GOTO       L_main0
;ADCSimples.c,59 :: 		}
	GOTO       $+0
; end of _main

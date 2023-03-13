
_main:

;PWMMotor.c,5 :: 		void main() {
;PWMMotor.c,9 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;PWMMotor.c,10 :: 		ADCON0 = 0x01; // Liga o conversor AD
	MOVLW      1
	MOVWF      ADCON0+0
;PWMMotor.c,11 :: 		ADCON1 = 0X0E; // Configura apenas o AN0 como entrada analogica, o resto das portas AN, como digital
	MOVLW      14
	MOVWF      ADCON1+0
;PWMMotor.c,16 :: 		PWM1_Init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      187
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;PWMMotor.c,17 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;PWMMotor.c,18 :: 		PWM1_Set_Duty((porcent_duty*255)/100);
	MOVF       _porcent_duty+0, 0
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWMMotor.c,22 :: 		while(1){
L_main0:
;PWMMotor.c,24 :: 		adc = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc+0
	MOVF       R0+1, 0
	MOVWF      _adc+1
;PWMMotor.c,25 :: 		PWM1_Set_Duty((porcent_duty*255)/100);
	MOVF       _porcent_duty+0, 0
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWMMotor.c,27 :: 		if(adc < 400){
	MOVLW      1
	SUBWF      _adc+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main6
	MOVLW      144
	SUBWF      _adc+0, 0
L__main6:
	BTFSC      STATUS+0, 0
	GOTO       L_main2
;PWMMotor.c,29 :: 		porcent_duty++;
	INCF       _porcent_duty+0, 1
;PWMMotor.c,30 :: 		delay_ms(50);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
;PWMMotor.c,32 :: 		if(porcent_duty > 90)
	MOVF       _porcent_duty+0, 0
	SUBLW      90
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;PWMMotor.c,33 :: 		porcent_duty = 90;
	MOVLW      90
	MOVWF      _porcent_duty+0
L_main4:
;PWMMotor.c,34 :: 		}
	GOTO       L_main5
L_main2:
;PWMMotor.c,36 :: 		porcent_duty = 80;
	MOVLW      80
	MOVWF      _porcent_duty+0
L_main5:
;PWMMotor.c,37 :: 		}
	GOTO       L_main0
;PWMMotor.c,38 :: 		}
	GOTO       $+0
; end of _main

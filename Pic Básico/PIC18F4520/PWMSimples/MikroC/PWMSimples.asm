
_main:

;PWMSimples.c,37 :: 		void main() {
;PWMSimples.c,39 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos, como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;PWMSimples.c,40 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;PWMSimples.c,42 :: 		PWM1_Init(2500);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       99
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;PWMSimples.c,43 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;PWMSimples.c,44 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMSimples.c,47 :: 		while(1){
L_main0:
;PWMSimples.c,49 :: 		if(!incrementa){
	BTFSC       RB7_bit+0, 7 
	GOTO        L_main2
;PWMSimples.c,51 :: 		duty++;
	INCF        _duty+0, 1 
;PWMSimples.c,52 :: 		delay_ms(30);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
;PWMSimples.c,53 :: 		} // end if !incrementa
	GOTO        L_main4
L_main2:
;PWMSimples.c,54 :: 		else if (!decrementa){
	BTFSC       RB6_bit+0, 6 
	GOTO        L_main5
;PWMSimples.c,56 :: 		duty--;
	DECF        _duty+0, 1 
;PWMSimples.c,57 :: 		delay_ms(30);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
;PWMSimples.c,58 :: 		} // end if !decrementa
L_main5:
L_main4:
;PWMSimples.c,60 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMSimples.c,62 :: 		} // end loop infinito
	GOTO        L_main0
;PWMSimples.c,63 :: 		} // end void main
	GOTO        $+0
; end of _main

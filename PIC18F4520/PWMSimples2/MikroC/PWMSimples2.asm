
_main:

;PWMSimples2.c,24 :: 		void main() {
;PWMSimples2.c,26 :: 		ADCON1 = 0x0F; // Configura todas as portas que poderiam ser analógicas como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;PWMSimples2.c,27 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;PWMSimples2.c,29 :: 		PWM1_Init(1000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;PWMSimples2.c,30 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;PWMSimples2.c,31 :: 		PWM1_Set_Duty(duty1);
	MOVF        _duty1+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMSimples2.c,33 :: 		PWM2_Init(1000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM2_Init+0, 0
;PWMSimples2.c,34 :: 		PWM2_Start();
	CALL        _PWM2_Start+0, 0
;PWMSimples2.c,35 :: 		PWM2_Set_Duty(duty2);
	MOVF        _duty2+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;PWMSimples2.c,39 :: 		while(1){
L_main0:
;PWMSimples2.c,41 :: 		if(!Inc1Dec2){
	BTFSC       RB7_bit+0, 7 
	GOTO        L_main2
;PWMSimples2.c,43 :: 		duty1++;
	INCF        _duty1+0, 1 
;PWMSimples2.c,44 :: 		duty2--;
	DECF        _duty2+0, 1 
;PWMSimples2.c,45 :: 		delay_ms(30);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
;PWMSimples2.c,46 :: 		} // end if !Inc1Dec2
	GOTO        L_main4
L_main2:
;PWMSimples2.c,47 :: 		else if(!Inc2Dec1){
	BTFSC       RB6_bit+0, 6 
	GOTO        L_main5
;PWMSimples2.c,49 :: 		duty2++;
	INCF        _duty2+0, 1 
;PWMSimples2.c,50 :: 		duty1--;
	DECF        _duty1+0, 1 
;PWMSimples2.c,51 :: 		delay_ms(30);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
;PWMSimples2.c,52 :: 		} // end if Inc2Dec1
L_main5:
L_main4:
;PWMSimples2.c,55 :: 		PWM1_Set_Duty(duty1);
	MOVF        _duty1+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMSimples2.c,56 :: 		PWM2_Set_Duty(duty2);
	MOVF        _duty2+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;PWMSimples2.c,57 :: 		} // end while
	GOTO        L_main0
;PWMSimples2.c,59 :: 		} // end void main
	GOTO        $+0
; end of _main

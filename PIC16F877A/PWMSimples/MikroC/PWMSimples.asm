
_main:

;PWMSimples.c,8 :: 		void main() {
;PWMSimples.c,10 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;PWMSimples.c,11 :: 		TRISB = 0xFF; // Configura todo o porta como entrada digital
	MOVLW      255
	MOVWF      TRISB+0
;PWMSimples.c,12 :: 		TRISC = 0x00; // Configura todo portc como saída digital
	CLRF       TRISC+0
;PWMSimples.c,13 :: 		PORTB = 0xFF; // Inicia todo porta em HIGH
	MOVLW      255
	MOVWF      PORTB+0
;PWMSimples.c,14 :: 		PORTC = 0x00; // Inicia todo portc em LOW
	CLRF       PORTC+0
;PWMSimples.c,16 :: 		PWM1_Init(5000); // Inicia o pwm na porta RC2/CCP1
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;PWMSimples.c,17 :: 		PWM2_Init(5000); // Inicia o pwm na porta RC1/CCP2
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;PWMSimples.c,19 :: 		PWM1_Start(); // Ativa os PWMs
	CALL       _PWM1_Start+0
;PWMSimples.c,20 :: 		PWM2_Start();
	CALL       _PWM2_Start+0
;PWMSimples.c,22 :: 		duty1 = 127; // Faz as variáveis equivalerem a 50% de duty cicle
	MOVLW      127
	MOVWF      _duty1+0
;PWMSimples.c,23 :: 		duty2 = 127;
	MOVLW      127
	MOVWF      _duty2+0
;PWMSimples.c,25 :: 		PWM1_Set_Duty(duty1); // Configura os dutys dos pwms em 127, ou seja, 50%
	MOVLW      127
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWMSimples.c,26 :: 		PWM2_Set_Duty(duty2);
	MOVF       _duty2+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;PWMSimples.c,29 :: 		while(1){
L_main0:
;PWMSimples.c,31 :: 		if(!bot1){
	BTFSC      RB1_bit+0, 1
	GOTO       L_main2
;PWMSimples.c,32 :: 		delay_ms(40);
	MOVLW      208
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;PWMSimples.c,33 :: 		duty1++;
	INCF       _duty1+0, 1
;PWMSimples.c,34 :: 		PWM1_Set_Duty(duty1);
	MOVF       _duty1+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWMSimples.c,35 :: 		}
L_main2:
;PWMSimples.c,36 :: 		if(!bot2){
	BTFSC      RB2_bit+0, 2
	GOTO       L_main4
;PWMSimples.c,37 :: 		delay_ms(40);
	MOVLW      208
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
	NOP
;PWMSimples.c,38 :: 		duty1--;
	DECF       _duty1+0, 1
;PWMSimples.c,39 :: 		PWM1_Set_Duty(duty1);
	MOVF       _duty1+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWMSimples.c,40 :: 		}
L_main4:
;PWMSimples.c,41 :: 		if(!bot3){
	BTFSC      RB3_bit+0, 3
	GOTO       L_main6
;PWMSimples.c,42 :: 		delay_ms(40);
	MOVLW      208
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
	NOP
;PWMSimples.c,43 :: 		duty2++;
	INCF       _duty2+0, 1
;PWMSimples.c,44 :: 		PWM2_Set_Duty(duty2);
	MOVF       _duty2+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;PWMSimples.c,45 :: 		}
L_main6:
;PWMSimples.c,46 :: 		if(!bot4){
	BTFSC      RB4_bit+0, 4
	GOTO       L_main8
;PWMSimples.c,47 :: 		delay_ms(40);
	MOVLW      208
	MOVWF      R12+0
	MOVLW      201
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	NOP
	NOP
;PWMSimples.c,48 :: 		duty2--;
	DECF       _duty2+0, 1
;PWMSimples.c,49 :: 		PWM2_Set_Duty(duty2);
	MOVF       _duty2+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;PWMSimples.c,50 :: 		}
L_main8:
;PWMSimples.c,51 :: 		}
	GOTO       L_main0
;PWMSimples.c,52 :: 		}
	GOTO       $+0
; end of _main

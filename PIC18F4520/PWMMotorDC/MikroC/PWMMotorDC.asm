
_main:

;PWMMotorDC.c,25 :: 		void main() {
;PWMMotorDC.c,27 :: 		ADCON0 = 0x01; // Configura AN0 como canal digital e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;PWMMotorDC.c,28 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura apenas o pino AN0 como analógico
	MOVLW       14
	MOVWF       ADCON1+0 
;PWMMotorDC.c,29 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital, exceto RA0/AN0, que é entrada analógica
	MOVLW       255
	MOVWF       TRISA+0 
;PWMMotorDC.c,31 :: 		PWM1_Init(2000); // Inicia o pwm1 com uma frequência de 2000Hz
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       124
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;PWMMotorDC.c,32 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;PWMMotorDC.c,33 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMMotorDC.c,36 :: 		while(1){
L_main0:
;PWMMotorDC.c,38 :: 		duty = adc_read(0) >> 2; // >> 2 (shift-right 2) = / 4 (dividir por 4). Ou seja, 1024 do adc = 256 do duty, que dá 100% de duty
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       _duty+0 
;PWMMotorDC.c,41 :: 		PWM1_Set_Duty(duty);
	MOVF        R2, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMMotorDC.c,42 :: 		} // end while
	GOTO        L_main0
;PWMMotorDC.c,44 :: 		} // end void main
	GOTO        $+0
; end of _main

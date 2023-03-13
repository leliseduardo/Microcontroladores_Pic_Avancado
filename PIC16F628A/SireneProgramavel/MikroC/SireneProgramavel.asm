
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SireneProgramavel.c,21 :: 		void interrupt(){
;SireneProgramavel.c,23 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;SireneProgramavel.c,25 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;SireneProgramavel.c,26 :: 		speaker = ~speaker; // Se Overflow = 1ms, então speaker irá alternar a cada 1us, tendo um periodo T de 2ms e f = 1/T = 500Hz
	MOVLW      4
	XORWF      RA2_bit+0, 1
;SireneProgramavel.c,27 :: 		cont++;
	INCF       _cont+0, 1
;SireneProgramavel.c,29 :: 		if(cont == 0x32){ // Se cont = 0x32(hexadecimal) = 50(decimal)
	MOVF       _cont+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;SireneProgramavel.c,31 :: 		cont = 0x00;
	CLRF       _cont+0
;SireneProgramavel.c,32 :: 		duty++;
	INCF       _duty+0, 1
;SireneProgramavel.c,33 :: 		led1 = ~led1;
	MOVLW      1
	XORWF      RA0_bit+0, 1
;SireneProgramavel.c,34 :: 		led2 = ~led2;
	MOVLW      2
	XORWF      RA1_bit+0, 1
;SireneProgramavel.c,35 :: 		}
L_interrupt1:
;SireneProgramavel.c,36 :: 		}
L_interrupt0:
;SireneProgramavel.c,37 :: 		}
L__interrupt4:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SireneProgramavel.c,39 :: 		void main() {
;SireneProgramavel.c,43 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;SireneProgramavel.c,44 :: 		OPTION_REG = 0x81; // Desabilita os pull-ups internos e configura o prescaler para 1:4, associado ao timer0
	MOVLW      129
	MOVWF      OPTION_REG+0
;SireneProgramavel.c,45 :: 		INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção pelo timer0
	MOVLW      160
	MOVWF      INTCON+0
;SireneProgramavel.c,47 :: 		TRISA = 0xF8; // Configura apenas RA0, RA1 e RA2 como saídas digitais
	MOVLW      248
	MOVWF      TRISA+0
;SireneProgramavel.c,48 :: 		TRISB = 0xF7; // Configura apenas RB3 como saída digital
	MOVLW      247
	MOVWF      TRISB+0
;SireneProgramavel.c,49 :: 		led1 = 0x00;
	BCF        RA0_bit+0, 0
;SireneProgramavel.c,50 :: 		led2 = 0x01;
	BSF        RA1_bit+0, 1
;SireneProgramavel.c,54 :: 		PWM1_Init(1500);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      166
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;SireneProgramavel.c,55 :: 		PWM1_Set_Duty(duty);
	MOVF       _duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;SireneProgramavel.c,56 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;SireneProgramavel.c,58 :: 		while(1){
L_main2:
;SireneProgramavel.c,60 :: 		PWM1_Set_Duty(duty);
	MOVF       _duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;SireneProgramavel.c,61 :: 		}
	GOTO       L_main2
;SireneProgramavel.c,62 :: 		}
	GOTO       $+0
; end of _main

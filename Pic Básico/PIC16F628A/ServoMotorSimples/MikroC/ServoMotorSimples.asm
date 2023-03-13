
_servoCentro:

;ServoMotorSimples.c,7 :: 		void servoCentro(){
;ServoMotorSimples.c,8 :: 		servo = 0x00; // 1 em hexadecimal
	BCF        RB0_bit+0, 0
;ServoMotorSimples.c,9 :: 		delay_us(18500);
	MOVLW      121
	MOVWF      R12+0
	MOVLW      31
	MOVWF      R13+0
L_servoCentro0:
	DECFSZ     R13+0, 1
	GOTO       L_servoCentro0
	DECFSZ     R12+0, 1
	GOTO       L_servoCentro0
	NOP
	NOP
;ServoMotorSimples.c,10 :: 		servo = 0x01;
	BSF        RB0_bit+0, 0
;ServoMotorSimples.c,11 :: 		delay_us(1500);
	MOVLW      10
	MOVWF      R12+0
	MOVLW      188
	MOVWF      R13+0
L_servoCentro1:
	DECFSZ     R13+0, 1
	GOTO       L_servoCentro1
	DECFSZ     R12+0, 1
	GOTO       L_servoCentro1
	NOP
;ServoMotorSimples.c,12 :: 		}
	RETURN
; end of _servoCentro

_servoHorario:

;ServoMotorSimples.c,14 :: 		void servoHorario (){
;ServoMotorSimples.c,15 :: 		servo = 0x00;
	BCF        RB0_bit+0, 0
;ServoMotorSimples.c,16 :: 		delay_us(18000);
	MOVLW      117
	MOVWF      R12+0
	MOVLW      225
	MOVWF      R13+0
L_servoHorario2:
	DECFSZ     R13+0, 1
	GOTO       L_servoHorario2
	DECFSZ     R12+0, 1
	GOTO       L_servoHorario2
;ServoMotorSimples.c,17 :: 		servo = 0x01;
	BSF        RB0_bit+0, 0
;ServoMotorSimples.c,18 :: 		delay_us(2000);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_servoHorario3:
	DECFSZ     R13+0, 1
	GOTO       L_servoHorario3
	DECFSZ     R12+0, 1
	GOTO       L_servoHorario3
	NOP
	NOP
;ServoMotorSimples.c,19 :: 		}
	RETURN
; end of _servoHorario

_servoAntiHorario:

;ServoMotorSimples.c,21 :: 		void servoAntiHorario(){
;ServoMotorSimples.c,22 :: 		servo = 0x00;
	BCF        RB0_bit+0, 0
;ServoMotorSimples.c,23 :: 		delay_us(19000);
	MOVLW      124
	MOVWF      R12+0
	MOVLW      95
	MOVWF      R13+0
L_servoAntiHorario4:
	DECFSZ     R13+0, 1
	GOTO       L_servoAntiHorario4
	DECFSZ     R12+0, 1
	GOTO       L_servoAntiHorario4
;ServoMotorSimples.c,24 :: 		servo = 0x01;
	BSF        RB0_bit+0, 0
;ServoMotorSimples.c,25 :: 		delay_us(1000);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_servoAntiHorario5:
	DECFSZ     R13+0, 1
	GOTO       L_servoAntiHorario5
	DECFSZ     R12+0, 1
	GOTO       L_servoAntiHorario5
;ServoMotorSimples.c,26 :: 		}
	RETURN
; end of _servoAntiHorario

_main:

;ServoMotorSimples.c,29 :: 		void main() {
;ServoMotorSimples.c,31 :: 		CMCON = 0X07;
	MOVLW      7
	MOVWF      CMCON+0
;ServoMotorSimples.c,32 :: 		TRISA = 0X03;
	MOVLW      3
	MOVWF      TRISA+0
;ServoMotorSimples.c,33 :: 		PORTA = 0X03;
	MOVLW      3
	MOVWF      PORTA+0
;ServoMotorSimples.c,34 :: 		TRISB = 0X00;
	CLRF       TRISB+0
;ServoMotorSimples.c,35 :: 		PORTB = 0X00;
	CLRF       PORTB+0
;ServoMotorSimples.c,37 :: 		while(1){
L_main6:
;ServoMotorSimples.c,39 :: 		if(s1 == 0 && s2 == 1)
	BTFSC      RA0_bit+0, 0
	GOTO       L_main10
	BTFSS      RA1_bit+0, 1
	GOTO       L_main10
L__main17:
;ServoMotorSimples.c,40 :: 		servoAntiHorario();
	CALL       _servoAntiHorario+0
	GOTO       L_main11
L_main10:
;ServoMotorSimples.c,41 :: 		else if(s2 == 0 && s1 == 1)
	BTFSC      RA1_bit+0, 1
	GOTO       L_main14
	BTFSS      RA0_bit+0, 0
	GOTO       L_main14
L__main16:
;ServoMotorSimples.c,42 :: 		servoHorario();
	CALL       _servoHorario+0
	GOTO       L_main15
L_main14:
;ServoMotorSimples.c,44 :: 		servoCentro();
	CALL       _servoCentro+0
L_main15:
L_main11:
;ServoMotorSimples.c,46 :: 		}
	GOTO       L_main6
;ServoMotorSimples.c,48 :: 		}
	GOTO       $+0
; end of _main

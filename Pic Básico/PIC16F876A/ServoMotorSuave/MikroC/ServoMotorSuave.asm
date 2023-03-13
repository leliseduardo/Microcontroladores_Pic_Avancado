
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;ServoMotorSuave.c,9 :: 		void interrupt(){
;ServoMotorSuave.c,11 :: 		if(TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;ServoMotorSuave.c,13 :: 		TMR0IF_bit = 0x00;
	BCF        TMR0IF_bit+0, 2
;ServoMotorSuave.c,15 :: 		if(servo1){
	BTFSS      RC4_bit+0, 4
	GOTO       L_interrupt1
;ServoMotorSuave.c,16 :: 		TMR0 = duty;
	MOVF       _duty+0, 0
	MOVWF      TMR0+0
;ServoMotorSuave.c,17 :: 		servo1 = 0x00;
	BCF        RC4_bit+0, 4
;ServoMotorSuave.c,18 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;ServoMotorSuave.c,20 :: 		TMR0 = 255 - duty;
	MOVF       _duty+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;ServoMotorSuave.c,21 :: 		servo1 = 0x01;
	BSF        RC4_bit+0, 4
;ServoMotorSuave.c,22 :: 		}
L_interrupt2:
;ServoMotorSuave.c,23 :: 		}
L_interrupt0:
;ServoMotorSuave.c,24 :: 		}
L__interrupt15:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;ServoMotorSuave.c,26 :: 		void main() {
;ServoMotorSuave.c,28 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;ServoMotorSuave.c,29 :: 		OPTION_REG = 0x87; // Desabilita os pull-ups internos, ativa o timer0 e configura o prescaler em 1:255
	MOVLW      135
	MOVWF      OPTION_REG+0
;ServoMotorSuave.c,30 :: 		GIE_bit = 0x01; // Ativa a interrupção global
	BSF        GIE_bit+0, 7
;ServoMotorSuave.c,31 :: 		PEIE_bit = 0x01; // Ativa a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;ServoMotorSuave.c,32 :: 		TMR0IE_bit = 0x01; // Ativa o timer0
	BSF        TMR0IE_bit+0, 5
;ServoMotorSuave.c,34 :: 		TRISC = 0xEF; // Configura apenas RC4 como saída digital
	MOVLW      239
	MOVWF      TRISC+0
;ServoMotorSuave.c,35 :: 		PORTC = 0xEF; // Inicia RC4 em Low
	MOVLW      239
	MOVWF      PORTC+0
;ServoMotorSuave.c,37 :: 		duty = 7; // Inicia o servo na posição inicial
	MOVLW      7
	MOVWF      _duty+0
;ServoMotorSuave.c,39 :: 		while(1){
L_main3:
;ServoMotorSuave.c,41 :: 		inicialFinal();
	CALL       _inicialFinal+0
;ServoMotorSuave.c,42 :: 		delay_ms(2000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;ServoMotorSuave.c,43 :: 		finalInicial();
	CALL       _finalInicial+0
;ServoMotorSuave.c,44 :: 		delay_ms(2000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
;ServoMotorSuave.c,45 :: 		}
	GOTO       L_main3
;ServoMotorSuave.c,46 :: 		}
	GOTO       $+0
; end of _main

_inicialFinal:

;ServoMotorSuave.c,63 :: 		void inicialFinal(){
;ServoMotorSuave.c,67 :: 		for(i = 7; i < 30 ; i++){  // Coloquei para ir até 29 (< 30) pois, na prática, é o valor que faz o servo ir até o ponto final realmente
	MOVLW      7
	MOVWF      R1+0
	MOVLW      0
	MOVWF      R1+1
L_inicialFinal7:
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__inicialFinal16
	MOVLW      30
	SUBWF      R1+0, 0
L__inicialFinal16:
	BTFSC      STATUS+0, 0
	GOTO       L_inicialFinal8
;ServoMotorSuave.c,68 :: 		duty = i;
	MOVF       R1+0, 0
	MOVWF      _duty+0
;ServoMotorSuave.c,69 :: 		delay_ms(25);
	MOVLW      98
	MOVWF      R12+0
	MOVLW      101
	MOVWF      R13+0
L_inicialFinal10:
	DECFSZ     R13+0, 1
	GOTO       L_inicialFinal10
	DECFSZ     R12+0, 1
	GOTO       L_inicialFinal10
	NOP
	NOP
;ServoMotorSuave.c,67 :: 		for(i = 7; i < 30 ; i++){  // Coloquei para ir até 29 (< 30) pois, na prática, é o valor que faz o servo ir até o ponto final realmente
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;ServoMotorSuave.c,70 :: 		}
	GOTO       L_inicialFinal7
L_inicialFinal8:
;ServoMotorSuave.c,71 :: 		}
	RETURN
; end of _inicialFinal

_finalInicial:

;ServoMotorSuave.c,73 :: 		void finalInicial(){
;ServoMotorSuave.c,77 :: 		for(i = 28; i > 6; i--){
	MOVLW      28
	MOVWF      R1+0
	MOVLW      0
	MOVWF      R1+1
L_finalInicial11:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__finalInicial17
	MOVF       R1+0, 0
	SUBLW      6
L__finalInicial17:
	BTFSC      STATUS+0, 0
	GOTO       L_finalInicial12
;ServoMotorSuave.c,78 :: 		duty = i;
	MOVF       R1+0, 0
	MOVWF      _duty+0
;ServoMotorSuave.c,79 :: 		delay_ms(25);
	MOVLW      98
	MOVWF      R12+0
	MOVLW      101
	MOVWF      R13+0
L_finalInicial14:
	DECFSZ     R13+0, 1
	GOTO       L_finalInicial14
	DECFSZ     R12+0, 1
	GOTO       L_finalInicial14
	NOP
	NOP
;ServoMotorSuave.c,77 :: 		for(i = 28; i > 6; i--){
	MOVLW      1
	SUBWF      R1+0, 1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
;ServoMotorSuave.c,80 :: 		}
	GOTO       L_finalInicial11
L_finalInicial12:
;ServoMotorSuave.c,81 :: 		}
	RETURN
; end of _finalInicial

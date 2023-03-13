
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SleepSimples.c,6 :: 		void interrupt(){
;SleepSimples.c,8 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;SleepSimples.c,10 :: 		INTF_bit = 0x00;
	BCF        INTF_bit+0, 1
;SleepSimples.c,11 :: 		control = ~control;
	MOVLW
	XORWF      _control+0, 1
;SleepSimples.c,13 :: 		led2 = ~led2;
	MOVLW      8
	XORWF      RA3_bit+0, 1
;SleepSimples.c,15 :: 		if(control)
	BTFSS      _control+0, BitPos(_control+0)
	GOTO       L_interrupt1
;SleepSimples.c,16 :: 		asm sleep;
	SLEEP
L_interrupt1:
;SleepSimples.c,17 :: 		}
L_interrupt0:
;SleepSimples.c,19 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_interrupt2:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt2
	DECFSZ     R12+0, 1
	GOTO       L_interrupt2
	DECFSZ     R11+0, 1
	GOTO       L_interrupt2
	NOP
;SleepSimples.c,20 :: 		}
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SleepSimples.c,22 :: 		void main() {
;SleepSimples.c,24 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;SleepSimples.c,25 :: 		OPTION_REG = 0x80; // Desativa os pull-ups internos e configura a interrupção externa por borda de descida
	MOVLW      128
	MOVWF      OPTION_REG+0
;SleepSimples.c,26 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;SleepSimples.c,27 :: 		PEIE_bit = 0x00; // Desabilita a interrupção por periféricos
	BCF        PEIE_bit+0, 6
;SleepSimples.c,28 :: 		INTE_bit = 0x01; // Habilita a interrupção externa no pino RB0/INT
	BSF        INTE_bit+0, 4
;SleepSimples.c,30 :: 		TRISA = 0xF3; // Configura apensa RA2 e RA3 como saídas digitais
	MOVLW      243
	MOVWF      TRISA+0
;SleepSimples.c,31 :: 		TRISB = 0xFF; // Configura todo portb como entrada digital
	MOVLW      255
	MOVWF      TRISB+0
;SleepSimples.c,33 :: 		RA2_bit = 0x00; // Inicia RA2 e RA3 em Low
	BCF        RA2_bit+0, 2
;SleepSimples.c,34 :: 		RA3_bit = 0x00;
	BCF        RA3_bit+0, 3
;SleepSimples.c,36 :: 		control = 0x00; // Inicializa a variável control em 0, ou nível lógico Low
	BCF        _control+0, BitPos(_control+0)
;SleepSimples.c,38 :: 		while(1){
L_main3:
;SleepSimples.c,40 :: 		led1 = 0x01;
	BSF        RA2_bit+0, 2
;SleepSimples.c,41 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;SleepSimples.c,42 :: 		led1 = 0x00;
	BCF        RA2_bit+0, 2
;SleepSimples.c,43 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;SleepSimples.c,44 :: 		}
	GOTO       L_main3
;SleepSimples.c,45 :: 		}
	GOTO       $+0
; end of _main


_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;PWMTimer2.c,10 :: 		void interrupt(){
;PWMTimer2.c,12 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;PWMTimer2.c,14 :: 		T0IF_bit = 0;
	BCF        T0IF_bit+0, 2
;PWMTimer2.c,15 :: 		TMR0 = 0x6C;
	MOVLW      108
	MOVWF      TMR0+0
;PWMTimer2.c,17 :: 		if(!s1)
	BTFSC      RA0_bit+0, 0
	GOTO       L_interrupt1
;PWMTimer2.c,18 :: 		CCPR1L++;
	INCF       CCPR1L+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      CCPR1L+0
L_interrupt1:
;PWMTimer2.c,20 :: 		if(!s2)
	BTFSC      RA1_bit+0, 1
	GOTO       L_interrupt2
;PWMTimer2.c,21 :: 		CCPR1L--;
	DECF       CCPR1L+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      CCPR1L+0
L_interrupt2:
;PWMTimer2.c,22 :: 		}
L_interrupt0:
;PWMTimer2.c,24 :: 		}
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;PWMTimer2.c,26 :: 		void main() {
;PWMTimer2.c,31 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;PWMTimer2.c,32 :: 		TRISA = 0x03; // Configura RA0 e RA1 como entradas digitais
	MOVLW      3
	MOVWF      TRISA+0
;PWMTimer2.c,33 :: 		PORTA = 0x03; // Inicia RA0 e RA1 em nível lógico alto
	MOVLW      3
	MOVWF      PORTA+0
;PWMTimer2.c,34 :: 		TRISB = 0x00; // Configura todo o portb como saída digital
	CLRF       TRISB+0
;PWMTimer2.c,35 :: 		PORTB = 0x00; // Inicia todo o portb em nível lógico baixo
	CLRF       PORTB+0
;PWMTimer2.c,38 :: 		OPTION_REG = 0x86; // Desliga pull-up interno e configura o prescaler em 1:128
	MOVLW      134
	MOVWF      OPTION_REG+0
;PWMTimer2.c,39 :: 		GIE_bit = 0x01;  //  Ativa a interrupção global
	BSF        GIE_bit+0, 7
;PWMTimer2.c,40 :: 		PEIE_bit = 0x01; // Ativa a interrupção por periferico externo
	BSF        PEIE_bit+0, 6
;PWMTimer2.c,41 :: 		T0IE_bit = 0x01; // Ativa o timer0
	BSF        T0IE_bit+0, 5
;PWMTimer2.c,42 :: 		TMR0 = 0x6C; // Inicia a contagem do timer0 em 0x6C
	MOVLW      108
	MOVWF      TMR0+0
;PWMTimer2.c,44 :: 		T2CON = 0x06; // Ativa o timer2 e configura o postscaler para 1:1 e o prescaler para 1:16
	MOVLW      6
	MOVWF      T2CON+0
;PWMTimer2.c,45 :: 		PR2 = 0xFF; // Faz o TMR2 contar até 0xFF
	MOVLW      255
	MOVWF      PR2+0
;PWMTimer2.c,53 :: 		CCPR1L = 0x00; // Inicia esse registrador, de 8 bits, em 0x00. Ele é responsável por 8 dos 10 bits do PWM. Ou seja, o led inicia apagado
	CLRF       CCPR1L+0
;PWMTimer2.c,54 :: 		CCP1CON = 0x0C; // Ativa o modo PWM
	MOVLW      12
	MOVWF      CCP1CON+0
;PWMTimer2.c,62 :: 		while(1){
L_main3:
;PWMTimer2.c,66 :: 		}
	GOTO       L_main3
;PWMTimer2.c,68 :: 		}
	GOTO       $+0
; end of _main

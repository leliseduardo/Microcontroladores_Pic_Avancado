
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;PrioridadeInterrupcao.c,41 :: 		void interrupt(){
;PrioridadeInterrupcao.c,43 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;PrioridadeInterrupcao.c,45 :: 		INTF_bit = 0x00;
	BCF        INTF_bit+0, 1
;PrioridadeInterrupcao.c,47 :: 		out1 = ~out1;
	MOVLW      2
	XORWF      RB1_bit+0, 1
;PrioridadeInterrupcao.c,48 :: 		}
L_interrupt0:
;PrioridadeInterrupcao.c,50 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt1
;PrioridadeInterrupcao.c,52 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;PrioridadeInterrupcao.c,54 :: 		out2 = ~out2;
	MOVLW      4
	XORWF      RB2_bit+0, 1
;PrioridadeInterrupcao.c,55 :: 		}
L_interrupt1:
;PrioridadeInterrupcao.c,57 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt2
;PrioridadeInterrupcao.c,59 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;PrioridadeInterrupcao.c,60 :: 		TMR1H = 0xFF;
	MOVLW      255
	MOVWF      TMR1H+0
;PrioridadeInterrupcao.c,62 :: 		out3 = ~out3;
	MOVLW      8
	XORWF      RB3_bit+0, 1
;PrioridadeInterrupcao.c,63 :: 		}
L_interrupt2:
;PrioridadeInterrupcao.c,65 :: 		if(TMR2IF_bit){
	BTFSS      TMR2IF_bit+0, 1
	GOTO       L_interrupt3
;PrioridadeInterrupcao.c,67 :: 		TMR2IF_bit = 0x00;
	BCF        TMR2IF_bit+0, 1
;PrioridadeInterrupcao.c,69 :: 		out4 = ~out4;
	MOVLW      16
	XORWF      RB4_bit+0, 1
;PrioridadeInterrupcao.c,70 :: 		}
L_interrupt3:
;PrioridadeInterrupcao.c,71 :: 		}
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

;PrioridadeInterrupcao.c,73 :: 		void main() {
;PrioridadeInterrupcao.c,75 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;PrioridadeInterrupcao.c,76 :: 		OPTION_REG = 0x08; // Ativa os pull-ups internos
	MOVLW      8
	MOVWF      OPTION_REG+0
;PrioridadeInterrupcao.c,80 :: 		INTCON = 0xF0; // Ativa a interrupção global, por periféricos, do timer0 e externa
	MOVLW      240
	MOVWF      INTCON+0
;PrioridadeInterrupcao.c,82 :: 		T1CON = 0x01; // Ativa o TMR1 e configura o prescaler para 1:1
	MOVLW      1
	MOVWF      T1CON+0
;PrioridadeInterrupcao.c,83 :: 		TMR1IE_bit = 0x01; // Ativa a interrupção do timer1 (flag do registrador PIE1) PIE = peripheral interrupt enable
	BSF        TMR1IE_bit+0, 0
;PrioridadeInterrupcao.c,84 :: 		TMR1H = 0xFF; // Como o timer1 é de 16 bits, configura-se o neeble mais significativo para começar a contagem já em 256,
	MOVLW      255
	MOVWF      TMR1H+0
;PrioridadeInterrupcao.c,87 :: 		T2CON = 0x04; // Ativa o timer2 e configura o prescaler como 1:1 e o postscaler como 1:1
	MOVLW      4
	MOVWF      T2CON+0
;PrioridadeInterrupcao.c,88 :: 		TMR2IE_bit = 0x01; // Ativa a interrupção do timer2 (flag do registrador PIE1)
	BSF        TMR2IE_bit+0, 1
;PrioridadeInterrupcao.c,89 :: 		PR2 = 0xFF; // Faz o contador do timer2, TMR2, contar de 0 a 255(valor de PR2). O timer2, internamente, compara o valor de TMR2
	MOVLW      255
	MOVWF      PR2+0
;PrioridadeInterrupcao.c,92 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital, pois não serão usadas
	MOVLW      255
	MOVWF      TRISA+0
;PrioridadeInterrupcao.c,93 :: 		TRISB = 0xE1; // Configura RB4, RB3, RB2 e RB1 como saídas digitais e o resto como entrada digital
	MOVLW      225
	MOVWF      TRISB+0
;PrioridadeInterrupcao.c,94 :: 		PORTA = 0xFF; // Inicia todo porta em High
	MOVLW      255
	MOVWF      PORTA+0
;PrioridadeInterrupcao.c,95 :: 		PORTB = 0xE1; // Inicia RB4, RB3, RB2 e RB1 em Low e o resto em High
	MOVLW      225
	MOVWF      PORTB+0
;PrioridadeInterrupcao.c,97 :: 		}
	GOTO       $+0
; end of _main

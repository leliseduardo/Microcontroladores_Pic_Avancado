
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Timer2Ex.c,4 :: 		void interrupt(){
;Timer2Ex.c,5 :: 		if(TMR2IF_bit){ // Verifica se houve o overflow no timer2
	BTFSS      TMR2IF_bit+0, 1
	GOTO       L_interrupt0
;Timer2Ex.c,6 :: 		TMR2IF_bit = 0x00;
	BCF        TMR2IF_bit+0, 1
;Timer2Ex.c,8 :: 		PORTB = ~PORTB;
	COMF       PORTB+0, 1
;Timer2Ex.c,9 :: 		}
L_interrupt0:
;Timer2Ex.c,10 :: 		}
L__interrupt3:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Timer2Ex.c,12 :: 		void main() {
;Timer2Ex.c,16 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;Timer2Ex.c,17 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos externos
	BSF        PEIE_bit+0, 6
;Timer2Ex.c,18 :: 		TMR2IE_bit = 0x01; // Habilita a interrupção do timer2 com PR2, número máximo que o contador do timer2 irá contar
	BSF        TMR2IE_bit+0, 1
;Timer2Ex.c,19 :: 		T2CON = 0b00011101; // Habilita o timer2, configura o postscaler como 1:4 e o prescaler como 1:4
	MOVLW      29
	MOVWF      T2CON+0
;Timer2Ex.c,21 :: 		PR2 = 100; // Faz PR2 = 100, isto é, faz o contador do timer2 contar até 100
	MOVLW      100
	MOVWF      PR2+0
;Timer2Ex.c,23 :: 		TRISB = 0x00; // Todo portb como saída digital
	CLRF       TRISB+0
;Timer2Ex.c,24 :: 		PORTB = 0x00; // Todo portb inicia com nivel logico 0
	CLRF       PORTB+0
;Timer2Ex.c,28 :: 		while(1){
L_main1:
;Timer2Ex.c,32 :: 		}
	GOTO       L_main1
;Timer2Ex.c,33 :: 		}
	GOTO       $+0
; end of _main

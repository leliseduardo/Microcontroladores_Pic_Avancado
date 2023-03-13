
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;VarreduraBotoes.c,6 :: 		void interrupt(){ // timer com tempo de estouro = (1 / (4MHz/4))*(256 - 108)*128 = 18,9ms, sendo f = 4MHz, TMR0 = 0x6C = 108 e prescaler = 1:128
;VarreduraBotoes.c,9 :: 		T0IF_bit = 0x00; // Faz a variavel de estouro ser igual a zero, isto é, diz que ainda não houve estouro
	BCF        T0IF_bit+0, 2
;VarreduraBotoes.c,11 :: 		TMR0 = 0x6C; // Inicia novamente o contador timer0 em 0x6C
	MOVLW      108
	MOVWF      TMR0+0
;VarreduraBotoes.c,13 :: 		if(s1 == 0)
	BTFSC      RA0_bit+0, 0
	GOTO       L_interrupt1
;VarreduraBotoes.c,14 :: 		led1 = 0x01;
	BSF        RA2_bit+0, 2
L_interrupt1:
;VarreduraBotoes.c,16 :: 		if(s2 == 0)
	BTFSC      RA1_bit+0, 1
	GOTO       L_interrupt2
;VarreduraBotoes.c,17 :: 		led1 = 0x00;
	BCF        RA2_bit+0, 2
L_interrupt2:
;VarreduraBotoes.c,19 :: 		}
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

;VarreduraBotoes.c,21 :: 		void main() {
;VarreduraBotoes.c,23 :: 		OPTION_REG = 0X86; // Desabilita os pull-ups internos do PORTB e seleciona o prescaler em 1:128
	MOVLW      134
	MOVWF      OPTION_REG+0
;VarreduraBotoes.c,24 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;VarreduraBotoes.c,25 :: 		PEIE_bit = 0x01; // Habilita a interrupção por perifericos
	BSF        PEIE_bit+0, 6
;VarreduraBotoes.c,26 :: 		T0IE_bit = 0x01; // Habilita a interrupção por estouro do timer0
	BSF        T0IE_bit+0, 5
;VarreduraBotoes.c,28 :: 		TMR0 = 0x6C; // Inicia a contagem do timer0 em 0x6C = 0b0110 1100 = 108(decimal)
	MOVLW      108
	MOVWF      TMR0+0
;VarreduraBotoes.c,30 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;VarreduraBotoes.c,31 :: 		TRISA = 0x03;
	MOVLW      3
	MOVWF      TRISA+0
;VarreduraBotoes.c,32 :: 		PORTA = 0x03;
	MOVLW      3
	MOVWF      PORTA+0
;VarreduraBotoes.c,34 :: 		while(1){
L_main3:
;VarreduraBotoes.c,36 :: 		led2 = 0x01;
	BSF        RA3_bit+0, 3
;VarreduraBotoes.c,37 :: 		delay_ms(500);
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
;VarreduraBotoes.c,38 :: 		led2 = 0x00;
	BCF        RA3_bit+0, 3
;VarreduraBotoes.c,39 :: 		delay_ms(500);
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
;VarreduraBotoes.c,40 :: 		}
	GOTO       L_main3
;VarreduraBotoes.c,41 :: 		}
	GOTO       $+0
; end of _main

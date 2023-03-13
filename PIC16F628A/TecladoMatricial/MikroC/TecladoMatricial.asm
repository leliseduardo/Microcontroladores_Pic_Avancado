
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TecladoMatricial.c,24 :: 		void interrupt() {
;TecladoMatricial.c,26 :: 		if(T0IF_bit){  // Testa se o timer0 estourou
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;TecladoMatricial.c,27 :: 		T0IF_bit = 0x00; // Zera a variável de estouro
	BCF        T0IF_bit+0, 2
;TecladoMatricial.c,28 :: 		TMR0 = 0x6C; // Inicia o contador do timer0
	MOVLW      108
	MOVWF      TMR0+0
;TecladoMatricial.c,30 :: 		if(col1 && control == 0x01){
	BTFSS      RB1_bit+0, 1
	GOTO       L_interrupt3
	MOVLW      0
	XORWF      _control+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt35
	MOVLW      1
	XORWF      _control+0, 0
L__interrupt35:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
L__interrupt33:
;TecladoMatricial.c,31 :: 		col1 = 0x00;
	BCF        RB1_bit+0, 1
;TecladoMatricial.c,32 :: 		col2 = 0x01;
	BSF        RB2_bit+0, 2
;TecladoMatricial.c,33 :: 		col3 = 0x01;
	BSF        RB3_bit+0, 3
;TecladoMatricial.c,34 :: 		control = 0x02;
	MOVLW      2
	MOVWF      _control+0
	MOVLW      0
	MOVWF      _control+1
;TecladoMatricial.c,36 :: 		if(!lina)
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt4
;TecladoMatricial.c,37 :: 		piscaLed(1);
	MOVLW      1
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt4:
;TecladoMatricial.c,38 :: 		if(!linb)
	BTFSC      RB5_bit+0, 5
	GOTO       L_interrupt5
;TecladoMatricial.c,39 :: 		piscaLed(4);
	MOVLW      4
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt5:
;TecladoMatricial.c,40 :: 		if(!linc)
	BTFSC      RB6_bit+0, 6
	GOTO       L_interrupt6
;TecladoMatricial.c,41 :: 		piscaLed(7);
	MOVLW      7
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt6:
;TecladoMatricial.c,42 :: 		if(!lind)
	BTFSC      RB7_bit+0, 7
	GOTO       L_interrupt7
;TecladoMatricial.c,43 :: 		piscaLed(11);
	MOVLW      11
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt7:
;TecladoMatricial.c,44 :: 		}
	GOTO       L_interrupt8
L_interrupt3:
;TecladoMatricial.c,45 :: 		else if(col2 && control == 0x02){
	BTFSS      RB2_bit+0, 2
	GOTO       L_interrupt11
	MOVLW      0
	XORWF      _control+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt36
	MOVLW      2
	XORWF      _control+0, 0
L__interrupt36:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
L__interrupt32:
;TecladoMatricial.c,46 :: 		col1 = 0x01;
	BSF        RB1_bit+0, 1
;TecladoMatricial.c,47 :: 		col2 = 0x00;
	BCF        RB2_bit+0, 2
;TecladoMatricial.c,48 :: 		col3 = 0x01;
	BSF        RB3_bit+0, 3
;TecladoMatricial.c,49 :: 		control = 0x03;
	MOVLW      3
	MOVWF      _control+0
	MOVLW      0
	MOVWF      _control+1
;TecladoMatricial.c,51 :: 		if(!lina)
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt12
;TecladoMatricial.c,52 :: 		piscaLed(2);
	MOVLW      2
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt12:
;TecladoMatricial.c,53 :: 		if(!linb)
	BTFSC      RB5_bit+0, 5
	GOTO       L_interrupt13
;TecladoMatricial.c,54 :: 		piscaLed(5);
	MOVLW      5
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt13:
;TecladoMatricial.c,55 :: 		if(!linc)
	BTFSC      RB6_bit+0, 6
	GOTO       L_interrupt14
;TecladoMatricial.c,56 :: 		piscaLed(8);
	MOVLW      8
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt14:
;TecladoMatricial.c,57 :: 		if(!lind)
	BTFSC      RB7_bit+0, 7
	GOTO       L_interrupt15
;TecladoMatricial.c,58 :: 		piscaLed(10);
	MOVLW      10
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt15:
;TecladoMatricial.c,59 :: 		}
	GOTO       L_interrupt16
L_interrupt11:
;TecladoMatricial.c,60 :: 		else if(col3 && control == 0x03){
	BTFSS      RB3_bit+0, 3
	GOTO       L_interrupt19
	MOVLW      0
	XORWF      _control+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt37
	MOVLW      3
	XORWF      _control+0, 0
L__interrupt37:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt19
L__interrupt31:
;TecladoMatricial.c,61 :: 		col1 = 0x01;
	BSF        RB1_bit+0, 1
;TecladoMatricial.c,62 :: 		col2 = 0x01;
	BSF        RB2_bit+0, 2
;TecladoMatricial.c,63 :: 		col3 = 0x00;
	BCF        RB3_bit+0, 3
;TecladoMatricial.c,64 :: 		control = 0x01;
	MOVLW      1
	MOVWF      _control+0
	MOVLW      0
	MOVWF      _control+1
;TecladoMatricial.c,66 :: 		if(!lina)
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt20
;TecladoMatricial.c,67 :: 		piscaLed(3);
	MOVLW      3
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt20:
;TecladoMatricial.c,68 :: 		if(!linb)
	BTFSC      RB5_bit+0, 5
	GOTO       L_interrupt21
;TecladoMatricial.c,69 :: 		piscaLed(6);
	MOVLW      6
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt21:
;TecladoMatricial.c,70 :: 		if(!linc)
	BTFSC      RB6_bit+0, 6
	GOTO       L_interrupt22
;TecladoMatricial.c,71 :: 		piscaLed(9);
	MOVLW      9
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt22:
;TecladoMatricial.c,72 :: 		if(!lind)
	BTFSC      RB7_bit+0, 7
	GOTO       L_interrupt23
;TecladoMatricial.c,73 :: 		piscaLed(12);
	MOVLW      12
	MOVWF      FARG_piscaLed_num+0
	MOVLW      0
	MOVWF      FARG_piscaLed_num+1
	CALL       _piscaLed+0
L_interrupt23:
;TecladoMatricial.c,74 :: 		}
L_interrupt19:
L_interrupt16:
L_interrupt8:
;TecladoMatricial.c,75 :: 		}
L_interrupt0:
;TecladoMatricial.c,76 :: 		}
L__interrupt34:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TecladoMatricial.c,80 :: 		void main() {
;TecladoMatricial.c,84 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;TecladoMatricial.c,85 :: 		TRISA = 0x03; // Seleciona apenas RA0 e RA1 como entradas digitais
	MOVLW      3
	MOVWF      TRISA+0
;TecladoMatricial.c,86 :: 		TRISB = 0xF0; // Seleciona o primeiro nibble como entrada digital
	MOVLW      240
	MOVWF      TRISB+0
;TecladoMatricial.c,87 :: 		PORTA = 0x03; // Inicia apenas RA0 e RA1 em nível logico alto
	MOVLW      3
	MOVWF      PORTA+0
;TecladoMatricial.c,88 :: 		PORTB = 0xFF; // Inicia todo o portb em nível logico alto
	MOVLW      255
	MOVWF      PORTB+0
;TecladoMatricial.c,90 :: 		OPTION_REG = 0X86; // Debabilita o pull-up interno do portb e seleciona o prescaler em 1:128
	MOVLW      134
	MOVWF      OPTION_REG+0
;TecladoMatricial.c,91 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;TecladoMatricial.c,92 :: 		PEIE_bit = 0x01; // Habilita a interrupção por perifericos externos
	BSF        PEIE_bit+0, 6
;TecladoMatricial.c,93 :: 		T0IE_bit = 0x01; // Habilita a interrupção por estouro do timer0
	BSF        T0IE_bit+0, 5
;TecladoMatricial.c,95 :: 		TMR0 = 0x6C; // Inicia o timer0 em 0x6C = 108 (decimal)
	MOVLW      108
	MOVWF      TMR0+0
;TecladoMatricial.c,99 :: 		while(1);{
L_main24:
	GOTO       L_main24
;TecladoMatricial.c,102 :: 		}
	GOTO       $+0
; end of _main

_piscaLed:

;TecladoMatricial.c,104 :: 		void piscaLed(int num){
;TecladoMatricial.c,108 :: 		for(i = 0; i < num; i++){
	CLRF       R1+0
	CLRF       R1+1
L_piscaLed26:
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_piscaLed_num+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__piscaLed38
	MOVF       FARG_piscaLed_num+0, 0
	SUBWF      R1+0, 0
L__piscaLed38:
	BTFSC      STATUS+0, 0
	GOTO       L_piscaLed27
;TecladoMatricial.c,109 :: 		led1 = 0x01;
	BSF        RA2_bit+0, 2
;TecladoMatricial.c,110 :: 		led2 = 0x01;
	BSF        RA3_bit+0, 3
;TecladoMatricial.c,111 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_piscaLed29:
	DECFSZ     R13+0, 1
	GOTO       L_piscaLed29
	DECFSZ     R12+0, 1
	GOTO       L_piscaLed29
	DECFSZ     R11+0, 1
	GOTO       L_piscaLed29
	NOP
;TecladoMatricial.c,112 :: 		led1 = 0x00;
	BCF        RA2_bit+0, 2
;TecladoMatricial.c,113 :: 		led2 = 0x00;
	BCF        RA3_bit+0, 3
;TecladoMatricial.c,114 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_piscaLed30:
	DECFSZ     R13+0, 1
	GOTO       L_piscaLed30
	DECFSZ     R12+0, 1
	GOTO       L_piscaLed30
	DECFSZ     R11+0, 1
	GOTO       L_piscaLed30
	NOP
;TecladoMatricial.c,108 :: 		for(i = 0; i < num; i++){
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;TecladoMatricial.c,115 :: 		}
	GOTO       L_piscaLed26
L_piscaLed27:
;TecladoMatricial.c,116 :: 		}
	RETURN
; end of _piscaLed

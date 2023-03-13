
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MultiplexacaoDispInterrup.c,30 :: 		void interrupt(){
;MultiplexacaoDispInterrup.c,32 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;MultiplexacaoDispInterrup.c,34 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;MultiplexacaoDispInterrup.c,35 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;MultiplexacaoDispInterrup.c,37 :: 		if(!milOut && control == 0x01){
	BTFSC      RB0_bit+0, 0
	GOTO       L_interrupt3
	MOVF       _control+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
L__interrupt27:
;MultiplexacaoDispInterrup.c,39 :: 		control = 0x02;
	MOVLW      2
	MOVWF      _control+0
;MultiplexacaoDispInterrup.c,40 :: 		cenOut = 0x00;
	BCF        RB1_bit+0, 1
;MultiplexacaoDispInterrup.c,41 :: 		dezOut = 0x00;
	BCF        RB2_bit+0, 2
;MultiplexacaoDispInterrup.c,42 :: 		uniOut = 0x00;
	BCF        RB3_bit+0, 3
;MultiplexacaoDispInterrup.c,43 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MultiplexacaoDispInterrup.c,44 :: 		mil = cont / 1000;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _mil+0
	MOVF       R0+1, 0
	MOVWF      _mil+1
;MultiplexacaoDispInterrup.c,45 :: 		milOut = 0x01;
	BSF        RB0_bit+0, 0
;MultiplexacaoDispInterrup.c,46 :: 		PORTC = display(mil);
	MOVF       R0+0, 0
	MOVWF      FARG_display_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;MultiplexacaoDispInterrup.c,47 :: 		}
	GOTO       L_interrupt4
L_interrupt3:
;MultiplexacaoDispInterrup.c,48 :: 		else if(!cenOut && control == 0x02){
	BTFSC      RB1_bit+0, 1
	GOTO       L_interrupt7
	MOVF       _control+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
L__interrupt26:
;MultiplexacaoDispInterrup.c,50 :: 		control = 0x03;
	MOVLW      3
	MOVWF      _control+0
;MultiplexacaoDispInterrup.c,51 :: 		milOut = 0x00;
	BCF        RB0_bit+0, 0
;MultiplexacaoDispInterrup.c,52 :: 		dezOut = 0x00;
	BCF        RB2_bit+0, 2
;MultiplexacaoDispInterrup.c,53 :: 		uniOut = 0x00;
	BCF        RB3_bit+0, 3
;MultiplexacaoDispInterrup.c,54 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MultiplexacaoDispInterrup.c,55 :: 		cen = (cont%1000) / 100;
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _cen+0
	MOVF       R0+1, 0
	MOVWF      _cen+1
;MultiplexacaoDispInterrup.c,56 :: 		cenOut = 0x01;
	BSF        RB1_bit+0, 1
;MultiplexacaoDispInterrup.c,57 :: 		PORTC = display(cen);
	MOVF       R0+0, 0
	MOVWF      FARG_display_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;MultiplexacaoDispInterrup.c,58 :: 		}
	GOTO       L_interrupt8
L_interrupt7:
;MultiplexacaoDispInterrup.c,59 :: 		else if(!dezOut && control == 0x03){
	BTFSC      RB2_bit+0, 2
	GOTO       L_interrupt11
	MOVF       _control+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
L__interrupt25:
;MultiplexacaoDispInterrup.c,61 :: 		control = 0x04;
	MOVLW      4
	MOVWF      _control+0
;MultiplexacaoDispInterrup.c,62 :: 		milOut = 0x00;
	BCF        RB0_bit+0, 0
;MultiplexacaoDispInterrup.c,63 :: 		cenOut = 0x00;
	BCF        RB1_bit+0, 1
;MultiplexacaoDispInterrup.c,64 :: 		uniOut = 0x00;
	BCF        RB3_bit+0, 3
;MultiplexacaoDispInterrup.c,65 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MultiplexacaoDispInterrup.c,66 :: 		dez = (cont % 100) / 10;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _dez+0
	MOVF       R0+1, 0
	MOVWF      _dez+1
;MultiplexacaoDispInterrup.c,67 :: 		dezOut = 0x01;
	BSF        RB2_bit+0, 2
;MultiplexacaoDispInterrup.c,68 :: 		PORTC = display(dez);
	MOVF       R0+0, 0
	MOVWF      FARG_display_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;MultiplexacaoDispInterrup.c,69 :: 		}
	GOTO       L_interrupt12
L_interrupt11:
;MultiplexacaoDispInterrup.c,70 :: 		else if(!uniOut && control == 0x04){
	BTFSC      RB3_bit+0, 3
	GOTO       L_interrupt15
	MOVF       _control+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt15
L__interrupt24:
;MultiplexacaoDispInterrup.c,72 :: 		control = 0x01;
	MOVLW      1
	MOVWF      _control+0
;MultiplexacaoDispInterrup.c,73 :: 		milOut = 0x00;
	BCF        RB0_bit+0, 0
;MultiplexacaoDispInterrup.c,74 :: 		cenOut = 0x00;
	BCF        RB1_bit+0, 1
;MultiplexacaoDispInterrup.c,75 :: 		dezOut = 0x00;
	BCF        RB2_bit+0, 2
;MultiplexacaoDispInterrup.c,76 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MultiplexacaoDispInterrup.c,77 :: 		uni = cont%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _uni+0
	MOVF       R0+1, 0
	MOVWF      _uni+1
;MultiplexacaoDispInterrup.c,78 :: 		uniOut = 0x01;
	BSF        RB3_bit+0, 3
;MultiplexacaoDispInterrup.c,79 :: 		PORTC = display(uni);
	MOVF       R0+0, 0
	MOVWF      FARG_display_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;MultiplexacaoDispInterrup.c,80 :: 		}
L_interrupt15:
L_interrupt12:
L_interrupt8:
L_interrupt4:
;MultiplexacaoDispInterrup.c,81 :: 		}
L_interrupt0:
;MultiplexacaoDispInterrup.c,82 :: 		}
L__interrupt28:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MultiplexacaoDispInterrup.c,84 :: 		void main() {
;MultiplexacaoDispInterrup.c,85 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;MultiplexacaoDispInterrup.c,86 :: 		OPTION_REG = 0x83; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:1
	MOVLW      131
	MOVWF      OPTION_REG+0
;MultiplexacaoDispInterrup.c,87 :: 		INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção do timer0
	MOVLW      160
	MOVWF      INTCON+0
;MultiplexacaoDispInterrup.c,88 :: 		TMR0 = 0x00; // Começa a contagem do timer0 em 0x00
	CLRF       TMR0+0
;MultiplexacaoDispInterrup.c,90 :: 		TRISB = 0xF0; // Configura primeiro neeble como entrada digital e o segundo neeble como saída digital
	MOVLW      240
	MOVWF      TRISB+0
;MultiplexacaoDispInterrup.c,91 :: 		TRISC = 0x80; // Confgirua apenas RB7 como entrada digital
	MOVLW      128
	MOVWF      TRISC+0
;MultiplexacaoDispInterrup.c,92 :: 		PORTB = 0xF0; // Inicia o primeiro neeble em High e o segundo neeble em Low
	MOVLW      240
	MOVWF      PORTB+0
;MultiplexacaoDispInterrup.c,93 :: 		PORTC = 0x80; // Inicia apenas RB7 em High
	MOVLW      128
	MOVWF      PORTC+0
;MultiplexacaoDispInterrup.c,95 :: 		while(1){
L_main16:
;MultiplexacaoDispInterrup.c,97 :: 		contador();
	CALL       _contador+0
;MultiplexacaoDispInterrup.c,98 :: 		}
	GOTO       L_main16
;MultiplexacaoDispInterrup.c,99 :: 		}
	GOTO       $+0
; end of _main

_contador:

;MultiplexacaoDispInterrup.c,101 :: 		void contador(){
;MultiplexacaoDispInterrup.c,103 :: 		if(incDec){
	BTFSS      RB4_bit+0, 4
	GOTO       L_contador18
;MultiplexacaoDispInterrup.c,105 :: 		cont++;
	INCF       _cont+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cont+1, 1
;MultiplexacaoDispInterrup.c,106 :: 		if(cont > 9999) cont = 0;
	MOVF       _cont+1, 0
	SUBLW      39
	BTFSS      STATUS+0, 2
	GOTO       L__contador29
	MOVF       _cont+0, 0
	SUBLW      15
L__contador29:
	BTFSC      STATUS+0, 0
	GOTO       L_contador19
	CLRF       _cont+0
	CLRF       _cont+1
L_contador19:
;MultiplexacaoDispInterrup.c,107 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_contador20:
	DECFSZ     R13+0, 1
	GOTO       L_contador20
	DECFSZ     R12+0, 1
	GOTO       L_contador20
	NOP
	NOP
;MultiplexacaoDispInterrup.c,108 :: 		}
	GOTO       L_contador21
L_contador18:
;MultiplexacaoDispInterrup.c,111 :: 		cont--;
	MOVLW      1
	SUBWF      _cont+0, 1
	BTFSS      STATUS+0, 0
	DECF       _cont+1, 1
;MultiplexacaoDispInterrup.c,112 :: 		if(cont < 0) cont = 9999;
	MOVLW      0
	SUBWF      _cont+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__contador30
	MOVLW      0
	SUBWF      _cont+0, 0
L__contador30:
	BTFSC      STATUS+0, 0
	GOTO       L_contador22
	MOVLW      15
	MOVWF      _cont+0
	MOVLW      39
	MOVWF      _cont+1
L_contador22:
;MultiplexacaoDispInterrup.c,113 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_contador23:
	DECFSZ     R13+0, 1
	GOTO       L_contador23
	DECFSZ     R12+0, 1
	GOTO       L_contador23
	NOP
	NOP
;MultiplexacaoDispInterrup.c,114 :: 		}
L_contador21:
;MultiplexacaoDispInterrup.c,115 :: 		}
	RETURN
; end of _contador

_display:

;MultiplexacaoDispInterrup.c,117 :: 		int display(int num){
;MultiplexacaoDispInterrup.c,119 :: 		int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
	MOVLW      63
	MOVWF      display_vetorDisplay_L0+0
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+1
	MOVLW      6
	MOVWF      display_vetorDisplay_L0+2
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+3
	MOVLW      91
	MOVWF      display_vetorDisplay_L0+4
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+5
	MOVLW      79
	MOVWF      display_vetorDisplay_L0+6
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+7
	MOVLW      102
	MOVWF      display_vetorDisplay_L0+8
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+9
	MOVLW      109
	MOVWF      display_vetorDisplay_L0+10
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+11
	MOVLW      125
	MOVWF      display_vetorDisplay_L0+12
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+13
	MOVLW      7
	MOVWF      display_vetorDisplay_L0+14
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+15
	MOVLW      127
	MOVWF      display_vetorDisplay_L0+16
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+17
	MOVLW      103
	MOVWF      display_vetorDisplay_L0+18
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+19
;MultiplexacaoDispInterrup.c,122 :: 		aux = vetorDisplay[num];
	MOVF       FARG_display_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_display_num+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      display_vetorDisplay_L0+0
	MOVWF      FSR
;MultiplexacaoDispInterrup.c,124 :: 		return aux;
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
;MultiplexacaoDispInterrup.c,125 :: 		}
	RETURN
; end of _display


_main:

;RodaFonica2.c,84 :: 		void main() {
;RodaFonica2.c,86 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;RodaFonica2.c,87 :: 		INTCON2.F7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;RodaFonica2.c,88 :: 		TRISB = 0xC0; // Configura apenas RB6 e RB7 como entrada digital, o resto como saída
	MOVLW       192
	MOVWF       TRISB+0 
;RodaFonica2.c,89 :: 		LATB = 0xC0; // Inicia todas as saídas em Low
	MOVLW       192
	MOVWF       LATB+0 
;RodaFonica2.c,91 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;RodaFonica2.c,92 :: 		TMR0H = 0x9E; // Inicia o contador do timer0 em 40536, para uma contagem de 25000
	MOVLW       158
	MOVWF       TMR0H+0 
;RodaFonica2.c,93 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;RodaFonica2.c,95 :: 		T1CON = 0xB1; // Configura com 16 bits, Pic com outra fonte de clock, prescaler 1:8 e habilita o timer1
	MOVLW       177
	MOVWF       T1CON+0 
;RodaFonica2.c,96 :: 		TMR0H = 0x3C; // Inicia o contador do timer1 em 15536, para uma contagem de 50000
	MOVLW       60
	MOVWF       TMR0H+0 
;RodaFonica2.c,97 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;RodaFonica2.c,99 :: 		T2CON = 0x7C; // Configura o postscale em 1:16, habilita o timer2, configura o prescaler em 1:1
	MOVLW       124
	MOVWF       T2CON+0 
;RodaFonica2.c,100 :: 		PR2 = 0xAA; // O contador do timer2 conta até 170
	MOVLW       170
	MOVWF       PR2+0 
;RodaFonica2.c,102 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;RodaFonica2.c,105 :: 		while(1){
L_main0:
;RodaFonica2.c,107 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_main2
;RodaFonica2.c,109 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;RodaFonica2.c,110 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;RodaFonica2.c,111 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;RodaFonica2.c,113 :: 		baseTempo1 += 1;
	INFSNZ      _baseTempo1+0, 1 
	INCF        _baseTempo1+1, 1 
;RodaFonica2.c,114 :: 		baseTempo2 += 1;
	INFSNZ      _baseTempo2+0, 1 
	INCF        _baseTempo2+1, 1 
;RodaFonica2.c,116 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;RodaFonica2.c,118 :: 		} // end if TMR0IF_bit
L_main2:
;RodaFonica2.c,120 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_main3
;RodaFonica2.c,122 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;RodaFonica2.c,123 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;RodaFonica2.c,124 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;RodaFonica2.c,126 :: 		contTMR1 += 1;
	INFSNZ      _contTMR1+0, 1 
	INCF        _contTMR1+1, 1 
;RodaFonica2.c,128 :: 		if(contTMR1 == 0x0A){
	MOVLW       0
	XORWF       _contTMR1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVLW       10
	XORWF       _contTMR1+0, 0 
L__main23:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;RodaFonica2.c,130 :: 		contTMR1 = 0x00;
	CLRF        _contTMR1+0 
	CLRF        _contTMR1+1 
;RodaFonica2.c,131 :: 		contMotor += 1;
	INFSNZ      _contMotor+0, 1 
	INCF        _contMotor+1, 1 
;RodaFonica2.c,133 :: 		if(contMotor == 0x05){
	MOVLW       0
	XORWF       _contMotor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main24
	MOVLW       5
	XORWF       _contMotor+0, 0 
L__main24:
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;RodaFonica2.c,135 :: 		contMotor = 0x06;
	MOVLW       6
	MOVWF       _contMotor+0 
	MOVLW       0
	MOVWF       _contMotor+1 
;RodaFonica2.c,136 :: 		motor = 0x00;
	BCF         LATB2_bit+0, 2 
;RodaFonica2.c,138 :: 		} // end if contMotor = 0x05
L_main5:
;RodaFonica2.c,140 :: 		} // end if contTMR1 = 0x0A
L_main4:
;RodaFonica2.c,142 :: 		leitura_Botao();
	CALL        _leitura_Botao+0, 0
;RodaFonica2.c,144 :: 		} // end if TMR1IF_bit
L_main3:
;RodaFonica2.c,146 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_main6
;RodaFonica2.c,148 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;RodaFonica2.c,150 :: 		rpmEncoder += 1;
	INCF        _rpmEncoder+0, 1 
;RodaFonica2.c,151 :: 		rpmEncoder2 += 1;
	INCF        _rpmEncoder2+0, 1 
;RodaFonica2.c,152 :: 		rpmEncoder3 += 1;
	INCF        _rpmEncoder3+0, 1 
;RodaFonica2.c,155 :: 		if(rpmEncoder < 116) rpm = ~rpm;
	MOVLW       116
	SUBWF       _rpmEncoder+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
	BTG         LATB3_bit+0, 3 
	GOTO        L_main8
L_main7:
;RodaFonica2.c,156 :: 		else rpm = 0x00;
	BCF         LATB3_bit+0, 3 
L_main8:
;RodaFonica2.c,158 :: 		if(rpmEncoder == 120) rpmEncoder = 0x00;
	MOVF        _rpmEncoder+0, 0 
	XORLW       120
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	CLRF        _rpmEncoder+0 
L_main9:
;RodaFonica2.c,161 :: 		if(rpmEncoder2 < 14) rpm2 = ~rpm2;
	MOVLW       14
	SUBWF       _rpmEncoder2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main10
	BTG         LATB4_bit+0, 4 
	GOTO        L_main11
L_main10:
;RodaFonica2.c,162 :: 		else rpm2 = 0x00;
	BCF         LATB4_bit+0, 4 
L_main11:
;RodaFonica2.c,164 :: 		if(rpmEncoder2 == 16) rpmEncoder2 = 0x00;
	MOVF        _rpmEncoder2+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
	CLRF        _rpmEncoder2+0 
L_main12:
;RodaFonica2.c,167 :: 		if(rpmEncoder3 < 70) rpm3 = ~rpm3;
	MOVLW       70
	SUBWF       _rpmEncoder3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
	BTG         LATB5_bit+0, 5 
	GOTO        L_main14
L_main13:
;RodaFonica2.c,168 :: 		else rpm3 = 0x00;
	BCF         LATB5_bit+0, 5 
L_main14:
;RodaFonica2.c,170 :: 		if(rpmEncoder3 == 72) rpmEncoder3 = 0x00;
	MOVF        _rpmEncoder3+0, 0 
	XORLW       72
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	CLRF        _rpmEncoder3+0 
L_main15:
;RodaFonica2.c,181 :: 		} // end if TMR2IF_bit
L_main6:
;RodaFonica2.c,183 :: 		} // end Loop infinito
	GOTO        L_main0
;RodaFonica2.c,185 :: 		} // end void main
	GOTO        $+0
; end of _main

_base_Tempo:

;RodaFonica2.c,189 :: 		void base_Tempo(){
;RodaFonica2.c,191 :: 		if(baseTempo1 == 0x0A){ // a cada 250ms
	MOVLW       0
	XORWF       _baseTempo1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo25
	MOVLW       10
	XORWF       _baseTempo1+0, 0 
L__base_Tempo25:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo16
;RodaFonica2.c,193 :: 		baseTempo1 = 0x00;
	CLRF        _baseTempo1+0 
	CLRF        _baseTempo1+1 
;RodaFonica2.c,195 :: 		led1 = ~led1;
	BTG         LATB0_bit+0, 0 
;RodaFonica2.c,197 :: 		} // end if baseTempo1 == 0x02
L_base_Tempo16:
;RodaFonica2.c,201 :: 		if(baseTempo2 == 0x014){ // a cada 500ms
	MOVLW       0
	XORWF       _baseTempo2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo26
	MOVLW       20
	XORWF       _baseTempo2+0, 0 
L__base_Tempo26:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo17
;RodaFonica2.c,203 :: 		baseTempo2 = 0x00;
	CLRF        _baseTempo2+0 
	CLRF        _baseTempo2+1 
;RodaFonica2.c,205 :: 		led2 = ~led2;
	BTG         LATB1_bit+0, 1 
;RodaFonica2.c,207 :: 		} // end if baseTempo2 == 0x0A
L_base_Tempo17:
;RodaFonica2.c,210 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_leitura_Botao:

;RodaFonica2.c,214 :: 		void leitura_Botao(){
;RodaFonica2.c,216 :: 		if(!botao) flagBotao = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botao18
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
L_leitura_Botao18:
;RodaFonica2.c,218 :: 		if(botao && flagBotao){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botao21
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botao21
L__leitura_Botao22:
;RodaFonica2.c,220 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;RodaFonica2.c,221 :: 		motor = 0x01;
	BSF         LATB2_bit+0, 2 
;RodaFonica2.c,222 :: 		contMotor = 0x00;
	CLRF        _contMotor+0 
	CLRF        _contMotor+1 
;RodaFonica2.c,224 :: 		} // end botao && flagBotao
L_leitura_Botao21:
;RodaFonica2.c,226 :: 		} // end void leitura_Botao
	RETURN      0
; end of _leitura_Botao


_main:

;RodaFonica.c,90 :: 		void main() {
;RodaFonica.c,92 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;RodaFonica.c,93 :: 		INTCON2.F7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;RodaFonica.c,94 :: 		TRISB = 0xF0; // Configura o primeiro nible como saída digital, o segundo como entrada
	MOVLW       240
	MOVWF       TRISB+0 
;RodaFonica.c,95 :: 		LATB = 0xF0; // Inicia todas as saídas em Low
	MOVLW       240
	MOVWF       LATB+0 
;RodaFonica.c,97 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;RodaFonica.c,98 :: 		TMR0H = 0x9E; // Inicia o contador do timer0 em 40536, para uma contagem de 25000
	MOVLW       158
	MOVWF       TMR0H+0 
;RodaFonica.c,99 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;RodaFonica.c,101 :: 		T1CON = 0xB1; // Configura com 16 bits, Pic com outra fonte de clock, prescaler 1:8 e habilita o timer1
	MOVLW       177
	MOVWF       T1CON+0 
;RodaFonica.c,102 :: 		TMR0H = 0x3C; // Inicia o contador do timer1 em 15536, para uma contagem de 50000
	MOVLW       60
	MOVWF       TMR0H+0 
;RodaFonica.c,103 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;RodaFonica.c,105 :: 		T2CON = 0x7C; // Configura o postscale em 1:16, habilita o timer2, configura o prescaler em 1:1
	MOVLW       124
	MOVWF       T2CON+0 
;RodaFonica.c,106 :: 		PR2 = 0xAA; // O contador do timer2 conta até 170
	MOVLW       170
	MOVWF       PR2+0 
;RodaFonica.c,108 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;RodaFonica.c,111 :: 		while(1){
L_main0:
;RodaFonica.c,113 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_main2
;RodaFonica.c,115 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;RodaFonica.c,116 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;RodaFonica.c,117 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;RodaFonica.c,119 :: 		baseTempo1 += 1;
	INFSNZ      _baseTempo1+0, 1 
	INCF        _baseTempo1+1, 1 
;RodaFonica.c,120 :: 		baseTempo2 += 1;
	INFSNZ      _baseTempo2+0, 1 
	INCF        _baseTempo2+1, 1 
;RodaFonica.c,122 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;RodaFonica.c,124 :: 		} // end if TMR0IF_bit
L_main2:
;RodaFonica.c,126 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_main3
;RodaFonica.c,128 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;RodaFonica.c,129 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;RodaFonica.c,130 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;RodaFonica.c,132 :: 		contTMR1 += 1;
	INFSNZ      _contTMR1+0, 1 
	INCF        _contTMR1+1, 1 
;RodaFonica.c,134 :: 		if(contTMR1 == 0x0A){
	MOVLW       0
	XORWF       _contTMR1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVLW       10
	XORWF       _contTMR1+0, 0 
L__main17:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;RodaFonica.c,136 :: 		contTMR1 = 0x00;
	CLRF        _contTMR1+0 
	CLRF        _contTMR1+1 
;RodaFonica.c,137 :: 		contMotor += 1;
	INFSNZ      _contMotor+0, 1 
	INCF        _contMotor+1, 1 
;RodaFonica.c,139 :: 		if(contMotor == 0x05){
	MOVLW       0
	XORWF       _contMotor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVLW       5
	XORWF       _contMotor+0, 0 
L__main18:
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;RodaFonica.c,141 :: 		contMotor = 0x06;
	MOVLW       6
	MOVWF       _contMotor+0 
	MOVLW       0
	MOVWF       _contMotor+1 
;RodaFonica.c,142 :: 		motor = 0x00;
	BCF         LATB2_bit+0, 2 
;RodaFonica.c,144 :: 		} // end if contMotor = 0x05
L_main5:
;RodaFonica.c,146 :: 		} // end if contTMR1 = 0x0A
L_main4:
;RodaFonica.c,148 :: 		leitura_Botao();
	CALL        _leitura_Botao+0, 0
;RodaFonica.c,150 :: 		} // end if TMR1IF_bit
L_main3:
;RodaFonica.c,152 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_main6
;RodaFonica.c,154 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;RodaFonica.c,156 :: 		rpmEncoder++;
	INCF        _rpmEncoder+0, 1 
;RodaFonica.c,158 :: 		if(rpmEncoder < 116) rpm = ~rpm;
	MOVLW       116
	SUBWF       _rpmEncoder+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
	BTG         LATB3_bit+0, 3 
	GOTO        L_main8
L_main7:
;RodaFonica.c,159 :: 		else rpm = 0x00;
	BCF         LATB3_bit+0, 3 
L_main8:
;RodaFonica.c,161 :: 		if(rpmEncoder == 120) rpmEncoder = 0x00;
	MOVF        _rpmEncoder+0, 0 
	XORLW       120
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	CLRF        _rpmEncoder+0 
L_main9:
;RodaFonica.c,172 :: 		} // end if TMR2IF_bit
L_main6:
;RodaFonica.c,174 :: 		} // end Loop infinito
	GOTO        L_main0
;RodaFonica.c,176 :: 		} // end void main
	GOTO        $+0
; end of _main

_base_Tempo:

;RodaFonica.c,180 :: 		void base_Tempo(){
;RodaFonica.c,182 :: 		if(baseTempo1 == 0x0A){ // a cada 250ms
	MOVLW       0
	XORWF       _baseTempo1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo19
	MOVLW       10
	XORWF       _baseTempo1+0, 0 
L__base_Tempo19:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo10
;RodaFonica.c,184 :: 		baseTempo1 = 0x00;
	CLRF        _baseTempo1+0 
	CLRF        _baseTempo1+1 
;RodaFonica.c,186 :: 		led1 = ~led1;
	BTG         LATB0_bit+0, 0 
;RodaFonica.c,188 :: 		} // end if baseTempo1 == 0x02
L_base_Tempo10:
;RodaFonica.c,192 :: 		if(baseTempo2 == 0x014){ // a cada 500ms
	MOVLW       0
	XORWF       _baseTempo2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo20
	MOVLW       20
	XORWF       _baseTempo2+0, 0 
L__base_Tempo20:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo11
;RodaFonica.c,194 :: 		baseTempo2 = 0x00;
	CLRF        _baseTempo2+0 
	CLRF        _baseTempo2+1 
;RodaFonica.c,196 :: 		led2 = ~led2;
	BTG         LATB1_bit+0, 1 
;RodaFonica.c,198 :: 		} // end if baseTempo2 == 0x0A
L_base_Tempo11:
;RodaFonica.c,201 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_leitura_Botao:

;RodaFonica.c,205 :: 		void leitura_Botao(){
;RodaFonica.c,207 :: 		if(!botao) flagBotao = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botao12
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
L_leitura_Botao12:
;RodaFonica.c,209 :: 		if(botao && flagBotao){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botao15
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botao15
L__leitura_Botao16:
;RodaFonica.c,211 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;RodaFonica.c,212 :: 		motor = 0x01;
	BSF         LATB2_bit+0, 2 
;RodaFonica.c,213 :: 		contMotor = 0x00;
	CLRF        _contMotor+0 
	CLRF        _contMotor+1 
;RodaFonica.c,215 :: 		} // end botao && flagBotao
L_leitura_Botao15:
;RodaFonica.c,217 :: 		} // end void leitura_Botao
	RETURN      0
; end of _leitura_Botao

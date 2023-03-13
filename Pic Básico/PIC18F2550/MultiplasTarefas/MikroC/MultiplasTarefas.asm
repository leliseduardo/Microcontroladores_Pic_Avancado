
_main:

;MultiplasTarefas.c,70 :: 		void main() {
;MultiplasTarefas.c,72 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;MultiplasTarefas.c,73 :: 		INTCON2.F7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;MultiplasTarefas.c,74 :: 		TRISB = 0xF8; // Configura RB0, RB1 e RB2 como saídas digitais, o resto como entrada
	MOVLW       248
	MOVWF       TRISB+0 
;MultiplasTarefas.c,75 :: 		LATB = 0xF8; // Inicia todas as saídas em Low
	MOVLW       248
	MOVWF       LATB+0 
;MultiplasTarefas.c,77 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;MultiplasTarefas.c,78 :: 		TMR0H = 0x9E; // Inicia o contador do timer0 em 40536, para uma contagem de 25000
	MOVLW       158
	MOVWF       TMR0H+0 
;MultiplasTarefas.c,79 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;MultiplasTarefas.c,81 :: 		T1CON = 0xB1; // Configura com 16 bits, Pic com outra fonte de clock, prescaler 1:8 e habilita o timer1
	MOVLW       177
	MOVWF       T1CON+0 
;MultiplasTarefas.c,82 :: 		TMR0H = 0x3C; // Inicia o contador do timer1 em 15536, para uma contagem de 50000
	MOVLW       60
	MOVWF       TMR0H+0 
;MultiplasTarefas.c,83 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;MultiplasTarefas.c,85 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;MultiplasTarefas.c,88 :: 		while(1){
L_main0:
;MultiplasTarefas.c,90 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_main2
;MultiplasTarefas.c,92 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;MultiplasTarefas.c,93 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;MultiplasTarefas.c,94 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;MultiplasTarefas.c,96 :: 		baseTempo1 += 1;
	INFSNZ      _baseTempo1+0, 1 
	INCF        _baseTempo1+1, 1 
;MultiplasTarefas.c,97 :: 		baseTempo2 += 1;
	INFSNZ      _baseTempo2+0, 1 
	INCF        _baseTempo2+1, 1 
;MultiplasTarefas.c,99 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;MultiplasTarefas.c,101 :: 		} // end if TMR0IF_bit
L_main2:
;MultiplasTarefas.c,103 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_main3
;MultiplasTarefas.c,105 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;MultiplasTarefas.c,106 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;MultiplasTarefas.c,107 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;MultiplasTarefas.c,109 :: 		contTMR1 += 1;
	INFSNZ      _contTMR1+0, 1 
	INCF        _contTMR1+1, 1 
;MultiplasTarefas.c,111 :: 		if(contTMR1 == 0x0A){
	MOVLW       0
	XORWF       _contTMR1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVLW       10
	XORWF       _contTMR1+0, 0 
L__main13:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;MultiplasTarefas.c,113 :: 		contTMR1 = 0x00;
	CLRF        _contTMR1+0 
	CLRF        _contTMR1+1 
;MultiplasTarefas.c,114 :: 		contMotor += 1;
	INFSNZ      _contMotor+0, 1 
	INCF        _contMotor+1, 1 
;MultiplasTarefas.c,116 :: 		if(contMotor == 0x05){
	MOVLW       0
	XORWF       _contMotor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main14
	MOVLW       5
	XORWF       _contMotor+0, 0 
L__main14:
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;MultiplasTarefas.c,118 :: 		contMotor = 0x06;
	MOVLW       6
	MOVWF       _contMotor+0 
	MOVLW       0
	MOVWF       _contMotor+1 
;MultiplasTarefas.c,119 :: 		motor = 0x00;
	BCF         LATB2_bit+0, 2 
;MultiplasTarefas.c,121 :: 		} // end if contMotor = 0x05
L_main5:
;MultiplasTarefas.c,123 :: 		} // end if contTMR1 = 0x0A
L_main4:
;MultiplasTarefas.c,125 :: 		leitura_Botao();
	CALL        _leitura_Botao+0, 0
;MultiplasTarefas.c,127 :: 		} // end if TMR1IF_bit
L_main3:
;MultiplasTarefas.c,129 :: 		} // end Loop infinito
	GOTO        L_main0
;MultiplasTarefas.c,131 :: 		} // end void main
	GOTO        $+0
; end of _main

_base_Tempo:

;MultiplasTarefas.c,135 :: 		void base_Tempo(){
;MultiplasTarefas.c,137 :: 		if(baseTempo1 == 0x0A){ // a cada 250ms
	MOVLW       0
	XORWF       _baseTempo1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo15
	MOVLW       10
	XORWF       _baseTempo1+0, 0 
L__base_Tempo15:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo6
;MultiplasTarefas.c,139 :: 		baseTempo1 = 0x00;
	CLRF        _baseTempo1+0 
	CLRF        _baseTempo1+1 
;MultiplasTarefas.c,141 :: 		led1 = ~led1;
	BTG         LATB0_bit+0, 0 
;MultiplasTarefas.c,143 :: 		} // end if baseTempo1 == 0x02
L_base_Tempo6:
;MultiplasTarefas.c,147 :: 		if(baseTempo2 == 0x014){ // a cada 500ms
	MOVLW       0
	XORWF       _baseTempo2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo16
	MOVLW       20
	XORWF       _baseTempo2+0, 0 
L__base_Tempo16:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo7
;MultiplasTarefas.c,149 :: 		baseTempo2 = 0x00;
	CLRF        _baseTempo2+0 
	CLRF        _baseTempo2+1 
;MultiplasTarefas.c,151 :: 		led2 = ~led2;
	BTG         LATB1_bit+0, 1 
;MultiplasTarefas.c,153 :: 		} // end if baseTempo2 == 0x0A
L_base_Tempo7:
;MultiplasTarefas.c,156 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_leitura_Botao:

;MultiplasTarefas.c,160 :: 		void leitura_Botao(){
;MultiplasTarefas.c,162 :: 		if(!botao) flagBotao = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botao8
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
L_leitura_Botao8:
;MultiplasTarefas.c,164 :: 		if(botao && flagBotao){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botao11
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botao11
L__leitura_Botao12:
;MultiplasTarefas.c,166 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;MultiplasTarefas.c,167 :: 		motor = 0x01;
	BSF         LATB2_bit+0, 2 
;MultiplasTarefas.c,168 :: 		contMotor = 0x00;
	CLRF        _contMotor+0 
	CLRF        _contMotor+1 
;MultiplasTarefas.c,170 :: 		} // end botao && flagBotao
L_leitura_Botao11:
;MultiplasTarefas.c,172 :: 		} // end void leitura_Botao
	RETURN      0
; end of _leitura_Botao


_main:

;TMR0MultiBasesTemp.c,54 :: 		void main() {
;TMR0MultiBasesTemp.c,56 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;TMR0MultiBasesTemp.c,57 :: 		TRISB = 0xF0; // Configura o primeiro nible como saída digital e o segundo como entrada
	MOVLW       240
	MOVWF       TRISB+0 
;TMR0MultiBasesTemp.c,58 :: 		LATB = 0xF0; // Inicia todas as saídas em Low
	MOVLW       240
	MOVWF       LATB+0 
;TMR0MultiBasesTemp.c,60 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;TMR0MultiBasesTemp.c,61 :: 		TMR0H = 0x9E; // Inicia o contador do tiemr0 em 40536, para uma contagem de 25000
	MOVLW       158
	MOVWF       TMR0H+0 
;TMR0MultiBasesTemp.c,62 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;TMR0MultiBasesTemp.c,65 :: 		while(1){
L_main0:
;TMR0MultiBasesTemp.c,67 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_main2
;TMR0MultiBasesTemp.c,69 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;TMR0MultiBasesTemp.c,70 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;TMR0MultiBasesTemp.c,71 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;TMR0MultiBasesTemp.c,73 :: 		baseTempo1 += 1;
	INFSNZ      _baseTempo1+0, 1 
	INCF        _baseTempo1+1, 1 
;TMR0MultiBasesTemp.c,74 :: 		baseTempo2 += 1;
	INFSNZ      _baseTempo2+0, 1 
	INCF        _baseTempo2+1, 1 
;TMR0MultiBasesTemp.c,75 :: 		baseTempo3 += 1;
	INFSNZ      _baseTempo3+0, 1 
	INCF        _baseTempo3+1, 1 
;TMR0MultiBasesTemp.c,76 :: 		baseTempo4 += 1;
	INFSNZ      _baseTempo4+0, 1 
	INCF        _baseTempo4+1, 1 
;TMR0MultiBasesTemp.c,78 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;TMR0MultiBasesTemp.c,80 :: 		} // end if TMR0IF_bit
L_main2:
;TMR0MultiBasesTemp.c,82 :: 		} // end Loop infinito
	GOTO        L_main0
;TMR0MultiBasesTemp.c,84 :: 		} // end void main
	GOTO        $+0
; end of _main

_base_Tempo:

;TMR0MultiBasesTemp.c,88 :: 		void base_Tempo(){
;TMR0MultiBasesTemp.c,90 :: 		if(baseTempo1 == 0x02){ // a cada 50ms
	MOVLW       0
	XORWF       _baseTempo1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo7
	MOVLW       2
	XORWF       _baseTempo1+0, 0 
L__base_Tempo7:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo3
;TMR0MultiBasesTemp.c,92 :: 		baseTempo1 = 0x00;
	CLRF        _baseTempo1+0 
	CLRF        _baseTempo1+1 
;TMR0MultiBasesTemp.c,94 :: 		led1 = ~led1;
	BTG         LATB0_bit+0, 0 
;TMR0MultiBasesTemp.c,96 :: 		} // end if baseTempo1 == 0x02
L_base_Tempo3:
;TMR0MultiBasesTemp.c,100 :: 		if(baseTempo2 == 0x0A){ // a cada 250ms
	MOVLW       0
	XORWF       _baseTempo2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo8
	MOVLW       10
	XORWF       _baseTempo2+0, 0 
L__base_Tempo8:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo4
;TMR0MultiBasesTemp.c,102 :: 		baseTempo2 = 0x00;
	CLRF        _baseTempo2+0 
	CLRF        _baseTempo2+1 
;TMR0MultiBasesTemp.c,104 :: 		led2 = ~led2;
	BTG         LATB1_bit+0, 1 
;TMR0MultiBasesTemp.c,106 :: 		} // end if baseTempo2 == 0x0A
L_base_Tempo4:
;TMR0MultiBasesTemp.c,110 :: 		if(baseTempo3 == 0x14){ // a cada 500ms
	MOVLW       0
	XORWF       _baseTempo3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo9
	MOVLW       20
	XORWF       _baseTempo3+0, 0 
L__base_Tempo9:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo5
;TMR0MultiBasesTemp.c,112 :: 		baseTempo3 = 0x00;
	CLRF        _baseTempo3+0 
	CLRF        _baseTempo3+1 
;TMR0MultiBasesTemp.c,114 :: 		led3 = ~led3;
	BTG         LATB2_bit+0, 2 
;TMR0MultiBasesTemp.c,116 :: 		} // end if baseTempo1 == 0x14
L_base_Tempo5:
;TMR0MultiBasesTemp.c,120 :: 		if(baseTempo4 == 0x28){ // a cada 1s
	MOVLW       0
	XORWF       _baseTempo4+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo10
	MOVLW       40
	XORWF       _baseTempo4+0, 0 
L__base_Tempo10:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo6
;TMR0MultiBasesTemp.c,122 :: 		baseTempo4 = 0x00;
	CLRF        _baseTempo4+0 
	CLRF        _baseTempo4+1 
;TMR0MultiBasesTemp.c,124 :: 		led4 = ~led4;
	BTG         LATB3_bit+0, 3 
;TMR0MultiBasesTemp.c,126 :: 		} // end if baseTempo1 == 0x28
L_base_Tempo6:
;TMR0MultiBasesTemp.c,128 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

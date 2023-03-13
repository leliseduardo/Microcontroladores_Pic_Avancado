
_interrupt:

;IncInteligenteBackLight.c,47 :: 		void interrupt(){
;IncInteligenteBackLight.c,49 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;IncInteligenteBackLight.c,51 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;IncInteligenteBackLight.c,52 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;IncInteligenteBackLight.c,53 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;IncInteligenteBackLight.c,55 :: 		baseTempo++;
	INFSNZ      _baseTempo+0, 1 
	INCF        _baseTempo+1, 1 
;IncInteligenteBackLight.c,56 :: 		contTempo++;
	INFSNZ      _contTempo+0, 1 
	INCF        _contTempo+1, 1 
;IncInteligenteBackLight.c,58 :: 		if(contTempo > 120){
	MOVLW       0
	MOVWF       R0 
	MOVF        _contTempo+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt15
	MOVF        _contTempo+0, 0 
	SUBLW       120
L__interrupt15:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;IncInteligenteBackLight.c,60 :: 		backLight = 0x00;
	BCF         LATB1_bit+0, 1 
;IncInteligenteBackLight.c,61 :: 		contTempo = 120;
	MOVLW       120
	MOVWF       _contTempo+0 
	MOVLW       0
	MOVWF       _contTempo+1 
;IncInteligenteBackLight.c,62 :: 		controlAdiciona = 0x00;
	CLRF        _controlAdiciona+0 
	CLRF        _controlAdiciona+1 
;IncInteligenteBackLight.c,64 :: 		} // end if contTempo > 120
L_interrupt1:
;IncInteligenteBackLight.c,66 :: 		if(flagBotao) contBotao++;
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_interrupt2
	INFSNZ      _contBotao+0, 1 
	INCF        _contBotao+1, 1 
L_interrupt2:
;IncInteligenteBackLight.c,68 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;IncInteligenteBackLight.c,70 :: 		} // end if TMR0IF_bit
L_interrupt0:
;IncInteligenteBackLight.c,72 :: 		} // end void interrupt
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;IncInteligenteBackLight.c,74 :: 		void main() {
;IncInteligenteBackLight.c,77 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;IncInteligenteBackLight.c,78 :: 		TRISB = 0x01; // Configura apenas RB0 como entrada digital, o resto como saída
	MOVLW       1
	MOVWF       TRISB+0 
;IncInteligenteBackLight.c,80 :: 		INTCON = 0xA0; // Habilita a interrupção global e a interrupção por overflow do timer 0
	MOVLW       160
	MOVWF       INTCON+0 
;IncInteligenteBackLight.c,81 :: 		INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;IncInteligenteBackLight.c,83 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;IncInteligenteBackLight.c,84 :: 		TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
	MOVLW       158
	MOVWF       TMR0H+0 
;IncInteligenteBackLight.c,85 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;IncInteligenteBackLight.c,87 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;IncInteligenteBackLight.c,88 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;IncInteligenteBackLight.c,91 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;IncInteligenteBackLight.c,92 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;IncInteligenteBackLight.c,93 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;IncInteligenteBackLight.c,94 :: 		lcd_chr(1, 2, 'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;IncInteligenteBackLight.c,95 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncInteligenteBackLight.c,96 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncInteligenteBackLight.c,97 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncInteligenteBackLight.c,100 :: 		while(1){
L_main3:
;IncInteligenteBackLight.c,102 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;IncInteligenteBackLight.c,104 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;IncInteligenteBackLight.c,106 :: 		} // end loop infinito
	GOTO        L_main3
;IncInteligenteBackLight.c,108 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;IncInteligenteBackLight.c,112 :: 		void leitura_Botoes(){
;IncInteligenteBackLight.c,114 :: 		if(!botao){
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes5
;IncInteligenteBackLight.c,116 :: 		flagBotao = 0x01;
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
;IncInteligenteBackLight.c,117 :: 		backLight = 0x01;
	BSF         LATB1_bit+0, 1 
;IncInteligenteBackLight.c,118 :: 		contTempo = 0x00;
	CLRF        _contTempo+0 
	CLRF        _contTempo+1 
;IncInteligenteBackLight.c,120 :: 		} // end if !botao
L_leitura_Botoes5:
;IncInteligenteBackLight.c,122 :: 		if(botao && flagBotao){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes8
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botoes8
L__leitura_Botoes13:
;IncInteligenteBackLight.c,124 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;IncInteligenteBackLight.c,125 :: 		contBotao = 0x00;
	CLRF        _contBotao+0 
	CLRF        _contBotao+1 
;IncInteligenteBackLight.c,126 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;IncInteligenteBackLight.c,127 :: 		controlAdiciona++;
	INFSNZ      _controlAdiciona+0, 1 
	INCF        _controlAdiciona+1, 1 
;IncInteligenteBackLight.c,129 :: 		if(controlAdiciona > 1) valor++;
	MOVLW       0
	MOVWF       R0 
	MOVF        _controlAdiciona+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leitura_Botoes16
	MOVF        _controlAdiciona+0, 0 
	SUBLW       1
L__leitura_Botoes16:
	BTFSC       STATUS+0, 0 
	GOTO        L_leitura_Botoes9
	INFSNZ      _valor+0, 1 
	INCF        _valor+1, 1 
L_leitura_Botoes9:
;IncInteligenteBackLight.c,131 :: 		} // end if botao && flagBotao
L_leitura_Botoes8:
;IncInteligenteBackLight.c,133 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_base_Tempo:

;IncInteligenteBackLight.c,138 :: 		void base_Tempo(){
;IncInteligenteBackLight.c,140 :: 		if(contBotao == 40) controlRapido = 0x01; // Se botao ficar pressionado por 1s, ativa o incremento rapido
	MOVLW       0
	XORWF       _contBotao+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo17
	MOVLW       40
	XORWF       _contBotao+0, 0 
L__base_Tempo17:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo10
	BSF         _controlRapido+0, BitPos(_controlRapido+0) 
L_base_Tempo10:
;IncInteligenteBackLight.c,142 :: 		if(baseTempo == 0x04){ // Tempo igual a 100ms
	MOVLW       0
	XORWF       _baseTempo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo18
	MOVLW       4
	XORWF       _baseTempo+0, 0 
L__base_Tempo18:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo11
;IncInteligenteBackLight.c,144 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
	CLRF        _baseTempo+1 
;IncInteligenteBackLight.c,146 :: 		if(controlRapido) valor += 1; // Se incremento rapido ligado, incrementa a cada 100ms
	BTFSS       _controlRapido+0, BitPos(_controlRapido+0) 
	GOTO        L_base_Tempo12
	INFSNZ      _valor+0, 1 
	INCF        _valor+1, 1 
L_base_Tempo12:
;IncInteligenteBackLight.c,148 :: 		} // end if baseTempo == 0x04
L_base_Tempo11:
;IncInteligenteBackLight.c,150 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_imprime_Display:

;IncInteligenteBackLight.c,156 :: 		void imprime_Display(){
;IncInteligenteBackLight.c,160 :: 		dig5 = valor/10000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig5_L0+0 
;IncInteligenteBackLight.c,161 :: 		dig4 = (valor%10000)/1000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig4_L0+0 
;IncInteligenteBackLight.c,162 :: 		dig3 = (valor%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig3_L0+0 
;IncInteligenteBackLight.c,163 :: 		dig2 = (valor%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig2_L0+0 
;IncInteligenteBackLight.c,164 :: 		dig1 = valor%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig1_L0+0 
;IncInteligenteBackLight.c,166 :: 		lcd_chr(1, 7, dig5 + 0x30);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_dig5_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;IncInteligenteBackLight.c,167 :: 		lcd_chr_cp(dig4 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig4_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncInteligenteBackLight.c,168 :: 		lcd_chr_cp(dig3 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncInteligenteBackLight.c,169 :: 		lcd_chr_cp(dig2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncInteligenteBackLight.c,170 :: 		lcd_chr_cp(dig1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncInteligenteBackLight.c,172 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

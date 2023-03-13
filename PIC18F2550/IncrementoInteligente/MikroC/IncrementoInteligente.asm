
_interrupt:

;IncrementoInteligente.c,71 :: 		void interrupt(){
;IncrementoInteligente.c,73 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;IncrementoInteligente.c,75 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;IncrementoInteligente.c,76 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;IncrementoInteligente.c,77 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;IncrementoInteligente.c,79 :: 		baseTempo++;
	INFSNZ      _baseTempo+0, 1 
	INCF        _baseTempo+1, 1 
;IncrementoInteligente.c,81 :: 		if(flagBotao) contBotao++;
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_interrupt1
	INFSNZ      _contBotao+0, 1 
	INCF        _contBotao+1, 1 
L_interrupt1:
;IncrementoInteligente.c,83 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;IncrementoInteligente.c,85 :: 		} // end if TMR0IF_bit
L_interrupt0:
;IncrementoInteligente.c,87 :: 		} // end void interrupt
L__interrupt12:
	RETFIE      1
; end of _interrupt

_main:

;IncrementoInteligente.c,89 :: 		void main() {
;IncrementoInteligente.c,92 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;IncrementoInteligente.c,93 :: 		TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como saída
	MOVLW       3
	MOVWF       TRISB+0 
;IncrementoInteligente.c,95 :: 		INTCON = 0xA0; // Habilita a interrupção global e a interrupção por overflow do timer 0
	MOVLW       160
	MOVWF       INTCON+0 
;IncrementoInteligente.c,96 :: 		INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;IncrementoInteligente.c,98 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;IncrementoInteligente.c,99 :: 		TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
	MOVLW       158
	MOVWF       TMR0H+0 
;IncrementoInteligente.c,100 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;IncrementoInteligente.c,102 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;IncrementoInteligente.c,103 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;IncrementoInteligente.c,106 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;IncrementoInteligente.c,107 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;IncrementoInteligente.c,108 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;IncrementoInteligente.c,109 :: 		lcd_chr(1, 2, 'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;IncrementoInteligente.c,110 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncrementoInteligente.c,111 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncrementoInteligente.c,112 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncrementoInteligente.c,115 :: 		while(1){
L_main2:
;IncrementoInteligente.c,117 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;IncrementoInteligente.c,119 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;IncrementoInteligente.c,121 :: 		} // end loop infinito
	GOTO        L_main2
;IncrementoInteligente.c,123 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;IncrementoInteligente.c,127 :: 		void leitura_Botoes(){
;IncrementoInteligente.c,129 :: 		if(!botao) flagBotao = 0x01;
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes4
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
L_leitura_Botoes4:
;IncrementoInteligente.c,131 :: 		if(botao && flagBotao){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes7
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botoes7
L__leitura_Botoes11:
;IncrementoInteligente.c,133 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;IncrementoInteligente.c,134 :: 		valor += 1;
	INFSNZ      _valor+0, 1 
	INCF        _valor+1, 1 
;IncrementoInteligente.c,135 :: 		contBotao = 0x00;
	CLRF        _contBotao+0 
	CLRF        _contBotao+1 
;IncrementoInteligente.c,136 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;IncrementoInteligente.c,138 :: 		} // end if botao && flagBotao
L_leitura_Botoes7:
;IncrementoInteligente.c,140 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_base_Tempo:

;IncrementoInteligente.c,145 :: 		void base_Tempo(){
;IncrementoInteligente.c,147 :: 		if(contBotao == 40) controlRapido = 0x01; // Se botao ficar pressionado por 1s, ativa o incremento rapido
	MOVLW       0
	XORWF       _contBotao+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo13
	MOVLW       40
	XORWF       _contBotao+0, 0 
L__base_Tempo13:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo8
	BSF         _controlRapido+0, BitPos(_controlRapido+0) 
L_base_Tempo8:
;IncrementoInteligente.c,149 :: 		if(baseTempo == 0x04){ // Tempo igual a 100ms
	MOVLW       0
	XORWF       _baseTempo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__base_Tempo14
	MOVLW       4
	XORWF       _baseTempo+0, 0 
L__base_Tempo14:
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo9
;IncrementoInteligente.c,151 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
	CLRF        _baseTempo+1 
;IncrementoInteligente.c,153 :: 		if(controlRapido) valor += 1; // Se incremento rapido ligado, incrementa a cada 100ms
	BTFSS       _controlRapido+0, BitPos(_controlRapido+0) 
	GOTO        L_base_Tempo10
	INFSNZ      _valor+0, 1 
	INCF        _valor+1, 1 
L_base_Tempo10:
;IncrementoInteligente.c,155 :: 		} // end if baseTempo == 0x04
L_base_Tempo9:
;IncrementoInteligente.c,157 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_imprime_Display:

;IncrementoInteligente.c,163 :: 		void imprime_Display(){
;IncrementoInteligente.c,167 :: 		dig5 = valor/10000;
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
;IncrementoInteligente.c,168 :: 		dig4 = (valor%10000)/1000;
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
;IncrementoInteligente.c,169 :: 		dig3 = (valor%1000)/100;
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
;IncrementoInteligente.c,170 :: 		dig2 = (valor%100)/10;
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
;IncrementoInteligente.c,171 :: 		dig1 = valor%10;
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
;IncrementoInteligente.c,173 :: 		lcd_chr(1, 7, dig5 + 0x30);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_dig5_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;IncrementoInteligente.c,174 :: 		lcd_chr_cp(dig4 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig4_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncrementoInteligente.c,175 :: 		lcd_chr_cp(dig3 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncrementoInteligente.c,176 :: 		lcd_chr_cp(dig2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncrementoInteligente.c,177 :: 		lcd_chr_cp(dig1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;IncrementoInteligente.c,179 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

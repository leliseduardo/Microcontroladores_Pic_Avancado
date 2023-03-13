
_interrupt:

;PWMAjusteDigital.c,54 :: 		void interrupt(){
;PWMAjusteDigital.c,56 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;PWMAjusteDigital.c,58 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;PWMAjusteDigital.c,59 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;PWMAjusteDigital.c,60 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;PWMAjusteDigital.c,62 :: 		baseTempo++;
	INCF        _baseTempo+0, 1 
;PWMAjusteDigital.c,63 :: 		contTempo++;
	INCF        _contTempo+0, 1 
;PWMAjusteDigital.c,65 :: 		if(contTempo > 120){
	MOVF        _contTempo+0, 0 
	SUBLW       120
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;PWMAjusteDigital.c,67 :: 		backLight = 0x00;
	BCF         LATB1_bit+0, 1 
;PWMAjusteDigital.c,68 :: 		contTempo = 120;
	MOVLW       120
	MOVWF       _contTempo+0 
;PWMAjusteDigital.c,69 :: 		controlAdiciona = 0x00;
	CLRF        _controlAdiciona+0 
;PWMAjusteDigital.c,71 :: 		} // end if contTempo > 120
L_interrupt1:
;PWMAjusteDigital.c,73 :: 		if(flagBotao) contBotao++;
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_interrupt2
	INCF        _contBotao+0, 1 
L_interrupt2:
;PWMAjusteDigital.c,75 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;PWMAjusteDigital.c,77 :: 		} // end if TMR0IF_bit
L_interrupt0:
;PWMAjusteDigital.c,79 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt3
;PWMAjusteDigital.c,81 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;PWMAjusteDigital.c,83 :: 		if(pwm){
	BTFSS       LATC0_bit+0, 0 
	GOTO        L_interrupt4
;PWMAjusteDigital.c,85 :: 		TMR2 = duty;
	MOVF        _duty+0, 0 
	MOVWF       TMR2+0 
;PWMAjusteDigital.c,86 :: 		pwm = 0x00;
	BCF         LATC0_bit+0, 0 
;PWMAjusteDigital.c,88 :: 		} // end if pwm
	GOTO        L_interrupt5
L_interrupt4:
;PWMAjusteDigital.c,91 :: 		TMR2 = 255 - duty;
	MOVF        _duty+0, 0 
	SUBLW       255
	MOVWF       TMR2+0 
;PWMAjusteDigital.c,92 :: 		pwm = 0x01;
	BSF         LATC0_bit+0, 0 
;PWMAjusteDigital.c,94 :: 		} // end else pwm
L_interrupt5:
;PWMAjusteDigital.c,96 :: 		} // end TMR2IF_bit
L_interrupt3:
;PWMAjusteDigital.c,98 :: 		} // end void interrupt
L__interrupt19:
	RETFIE      1
; end of _interrupt

_main:

;PWMAjusteDigital.c,100 :: 		void main() {
;PWMAjusteDigital.c,103 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;PWMAjusteDigital.c,104 :: 		TRISB = 0x01; // Configura apenas RB0 como entrada digital, o resto como saída
	MOVLW       1
	MOVWF       TRISB+0 
;PWMAjusteDigital.c,105 :: 		TRISC = 0xFE; // Configura apenas RC0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISC+0 
;PWMAjusteDigital.c,107 :: 		INTCON = 0xE0; // Habilita a interrupção global, por perfiféricos e a interrupção por overflow do timer 0
	MOVLW       224
	MOVWF       INTCON+0 
;PWMAjusteDigital.c,108 :: 		INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;PWMAjusteDigital.c,110 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;PWMAjusteDigital.c,111 :: 		TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
	MOVLW       158
	MOVWF       TMR0H+0 
;PWMAjusteDigital.c,112 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;PWMAjusteDigital.c,114 :: 		T2CON = 0x05; // Habilita o timer2, configurao postscale em 1:1 e o prescale em 1:4
	MOVLW       5
	MOVWF       T2CON+0 
;PWMAjusteDigital.c,115 :: 		PR2 = 0xFF; // O contador TMR2 conta até 256
	MOVLW       255
	MOVWF       PR2+0 
;PWMAjusteDigital.c,116 :: 		TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2
	BSF         TMR2IE_bit+0, 1 
;PWMAjusteDigital.c,118 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;PWMAjusteDigital.c,119 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;PWMAjusteDigital.c,122 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;PWMAjusteDigital.c,123 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWMAjusteDigital.c,124 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWMAjusteDigital.c,125 :: 		lcd_chr(1, 2, 'D');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMAjusteDigital.c,126 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMAjusteDigital.c,127 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMAjusteDigital.c,128 :: 		lcd_chr_cp('y');
	MOVLW       121
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMAjusteDigital.c,129 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMAjusteDigital.c,132 :: 		while(1){
L_main6:
;PWMAjusteDigital.c,134 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;PWMAjusteDigital.c,136 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;PWMAjusteDigital.c,138 :: 		} // end loop infinito
	GOTO        L_main6
;PWMAjusteDigital.c,140 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;PWMAjusteDigital.c,144 :: 		void leitura_Botoes(){
;PWMAjusteDigital.c,146 :: 		if(!botao){
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes8
;PWMAjusteDigital.c,148 :: 		flagBotao = 0x01;
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
;PWMAjusteDigital.c,149 :: 		backLight = 0x01;
	BSF         LATB1_bit+0, 1 
;PWMAjusteDigital.c,150 :: 		contTempo = 0x00;
	CLRF        _contTempo+0 
;PWMAjusteDigital.c,152 :: 		} // end if !botao
L_leitura_Botoes8:
;PWMAjusteDigital.c,154 :: 		if(botao && flagBotao){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes11
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botoes11
L__leitura_Botoes18:
;PWMAjusteDigital.c,156 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;PWMAjusteDigital.c,157 :: 		contBotao = 0x00;
	CLRF        _contBotao+0 
;PWMAjusteDigital.c,158 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;PWMAjusteDigital.c,159 :: 		controlAdiciona++;
	INCF        _controlAdiciona+0, 1 
;PWMAjusteDigital.c,161 :: 		if(controlAdiciona > 1) valor++;
	MOVF        _controlAdiciona+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_leitura_Botoes12
	INCF        _valor+0, 1 
L_leitura_Botoes12:
;PWMAjusteDigital.c,163 :: 		} // end if botao && flagBotao
L_leitura_Botoes11:
;PWMAjusteDigital.c,165 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_base_Tempo:

;PWMAjusteDigital.c,170 :: 		void base_Tempo(){
;PWMAjusteDigital.c,172 :: 		if(contBotao == 40) controlRapido = 0x01; // Se botao ficar pressionado por 1s, ativa o incremento rapido
	MOVF        _contBotao+0, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo13
	BSF         _controlRapido+0, BitPos(_controlRapido+0) 
L_base_Tempo13:
;PWMAjusteDigital.c,174 :: 		if(baseTempo == 0x04){ // Tempo igual a 100ms
	MOVF        _baseTempo+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo14
;PWMAjusteDigital.c,176 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
;PWMAjusteDigital.c,178 :: 		if(controlRapido) valor += 1; // Se incremento rapido ligado, incrementa a cada 100ms
	BTFSS       _controlRapido+0, BitPos(_controlRapido+0) 
	GOTO        L_base_Tempo15
	INCF        _valor+0, 1 
L_base_Tempo15:
;PWMAjusteDigital.c,180 :: 		} // end if baseTempo == 0x04
L_base_Tempo14:
;PWMAjusteDigital.c,182 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_imprime_Display:

;PWMAjusteDigital.c,188 :: 		void imprime_Display(){
;PWMAjusteDigital.c,192 :: 		dig3 = valor/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig3_L0+0 
;PWMAjusteDigital.c,193 :: 		dig2 = (valor%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig2_L0+0 
;PWMAjusteDigital.c,194 :: 		dig1 = valor%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig1_L0+0 
;PWMAjusteDigital.c,196 :: 		lcd_chr(1, 8, dig3 + 0x30);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMAjusteDigital.c,197 :: 		lcd_chr_cp(dig2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMAjusteDigital.c,198 :: 		lcd_chr_cp(dig1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMAjusteDigital.c,200 :: 		duty = valor;
	MOVF        _valor+0, 0 
	MOVWF       _duty+0 
;PWMAjusteDigital.c,202 :: 		if(duty == 0x00){
	MOVF        _valor+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_imprime_Display16
;PWMAjusteDigital.c,204 :: 		TMR2ON_bit = 0x00;
	BCF         TMR2ON_bit+0, 2 
;PWMAjusteDigital.c,206 :: 		pwm = 0x00;
	BCF         LATC0_bit+0, 0 
;PWMAjusteDigital.c,208 :: 		} // end if duty == 0x00
	GOTO        L_imprime_Display17
L_imprime_Display16:
;PWMAjusteDigital.c,209 :: 		else  TMR2ON_bit = 0x01;
	BSF         TMR2ON_bit+0, 2 
L_imprime_Display17:
;PWMAjusteDigital.c,211 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

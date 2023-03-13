
_interrupt:

;MotorPartidaSuave.c,62 :: 		void interrupt(){
;MotorPartidaSuave.c,64 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;MotorPartidaSuave.c,66 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;MotorPartidaSuave.c,67 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;MotorPartidaSuave.c,68 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;MotorPartidaSuave.c,70 :: 		baseTempo++;
	INCF        _baseTempo+0, 1 
;MotorPartidaSuave.c,71 :: 		contTempo++;
	INCF        _contTempo+0, 1 
;MotorPartidaSuave.c,73 :: 		if(contTempo > 120){
	MOVF        _contTempo+0, 0 
	SUBLW       120
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;MotorPartidaSuave.c,75 :: 		backLight = 0x00;
	BCF         LATB1_bit+0, 1 
;MotorPartidaSuave.c,76 :: 		contTempo = 120;
	MOVLW       120
	MOVWF       _contTempo+0 
;MotorPartidaSuave.c,77 :: 		controlAdiciona = 0x00;
	CLRF        _controlAdiciona+0 
;MotorPartidaSuave.c,79 :: 		} // end if contTempo > 120
L_interrupt1:
;MotorPartidaSuave.c,81 :: 		if(flagBotao) contBotao++;
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_interrupt2
	INCF        _contBotao+0, 1 
L_interrupt2:
;MotorPartidaSuave.c,83 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;MotorPartidaSuave.c,85 :: 		} // end if TMR0IF_bit
L_interrupt0:
;MotorPartidaSuave.c,87 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt3
;MotorPartidaSuave.c,89 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;MotorPartidaSuave.c,91 :: 		if(duty == 0x00) pwm = 0x00;
	MOVF        _duty+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
	BCF         LATC0_bit+0, 0 
	GOTO        L_interrupt5
L_interrupt4:
;MotorPartidaSuave.c,93 :: 		if(pwm){
	BTFSS       LATC0_bit+0, 0 
	GOTO        L_interrupt6
;MotorPartidaSuave.c,95 :: 		TMR2 = duty;
	MOVF        _duty+0, 0 
	MOVWF       TMR2+0 
;MotorPartidaSuave.c,96 :: 		pwm = 0x00;
	BCF         LATC0_bit+0, 0 
;MotorPartidaSuave.c,98 :: 		} // end if pwm
	GOTO        L_interrupt7
L_interrupt6:
;MotorPartidaSuave.c,101 :: 		TMR2 = 255 - duty;
	MOVF        _duty+0, 0 
	SUBLW       255
	MOVWF       TMR2+0 
;MotorPartidaSuave.c,102 :: 		pwm = 0x01;
	BSF         LATC0_bit+0, 0 
;MotorPartidaSuave.c,104 :: 		} // end else pwm
L_interrupt7:
;MotorPartidaSuave.c,105 :: 		} // end else duty == 0x00;
L_interrupt5:
;MotorPartidaSuave.c,106 :: 		} // end TMR2IF_bit
L_interrupt3:
;MotorPartidaSuave.c,108 :: 		} // end void interrupt
L__interrupt28:
	RETFIE      1
; end of _interrupt

_main:

;MotorPartidaSuave.c,110 :: 		void main() {
;MotorPartidaSuave.c,113 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;MotorPartidaSuave.c,114 :: 		TRISB = 0x01; // Configura apenas RB0 como entrada digital, o resto como saída
	MOVLW       1
	MOVWF       TRISB+0 
;MotorPartidaSuave.c,115 :: 		TRISC = 0xFE; // Configura apenas RC0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISC+0 
;MotorPartidaSuave.c,117 :: 		INTCON = 0xE0; // Habilita a interrupção global, por perfiféricos e a interrupção por overflow do timer 0
	MOVLW       224
	MOVWF       INTCON+0 
;MotorPartidaSuave.c,118 :: 		INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;MotorPartidaSuave.c,120 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;MotorPartidaSuave.c,121 :: 		TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
	MOVLW       158
	MOVWF       TMR0H+0 
;MotorPartidaSuave.c,122 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;MotorPartidaSuave.c,124 :: 		T2CON = 0x05; // Habilita o timer2, configurao postscale em 1:1 e o prescale em 1:4
	MOVLW       5
	MOVWF       T2CON+0 
;MotorPartidaSuave.c,125 :: 		PR2 = 0xFF; // O contador TMR2 conta até 256
	MOVLW       255
	MOVWF       PR2+0 
;MotorPartidaSuave.c,126 :: 		TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2
	BSF         TMR2IE_bit+0, 1 
;MotorPartidaSuave.c,128 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;MotorPartidaSuave.c,129 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;MotorPartidaSuave.c,130 :: 		flagStart = 0x00;
	BCF         _flagStart+0, BitPos(_flagStart+0) 
;MotorPartidaSuave.c,133 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;MotorPartidaSuave.c,134 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorPartidaSuave.c,135 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorPartidaSuave.c,136 :: 		lcd_chr(1, 2, 'D');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorPartidaSuave.c,137 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorPartidaSuave.c,138 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorPartidaSuave.c,139 :: 		lcd_chr_cp('y');
	MOVLW       121
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorPartidaSuave.c,140 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorPartidaSuave.c,143 :: 		while(1){
L_main8:
;MotorPartidaSuave.c,145 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;MotorPartidaSuave.c,147 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;MotorPartidaSuave.c,149 :: 		} // end loop infinito
	GOTO        L_main8
;MotorPartidaSuave.c,151 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;MotorPartidaSuave.c,155 :: 		void leitura_Botoes(){
;MotorPartidaSuave.c,157 :: 		if(!botao){
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes10
;MotorPartidaSuave.c,159 :: 		flagBotao = 0x01;
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
;MotorPartidaSuave.c,160 :: 		backLight = 0x01;
	BSF         LATB1_bit+0, 1 
;MotorPartidaSuave.c,161 :: 		contTempo = 0x00;
	CLRF        _contTempo+0 
;MotorPartidaSuave.c,163 :: 		} // end if !botao
L_leitura_Botoes10:
;MotorPartidaSuave.c,165 :: 		if(botao && flagBotao){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes13
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botoes13
L__leitura_Botoes27:
;MotorPartidaSuave.c,167 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;MotorPartidaSuave.c,168 :: 		contBotao = 0x00;
	CLRF        _contBotao+0 
;MotorPartidaSuave.c,169 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;MotorPartidaSuave.c,170 :: 		controlAdiciona++;
	INCF        _controlAdiciona+0, 1 
;MotorPartidaSuave.c,172 :: 		if(controlAdiciona > 1) valor++;
	MOVF        _controlAdiciona+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_leitura_Botoes14
	INCF        _valor+0, 1 
L_leitura_Botoes14:
;MotorPartidaSuave.c,174 :: 		} // end if botao && flagBotao
L_leitura_Botoes13:
;MotorPartidaSuave.c,176 :: 		if(!start) flagStart = 0x01;
	BTFSC       RC1_bit+0, 1 
	GOTO        L_leitura_Botoes15
	BSF         _flagStart+0, BitPos(_flagStart+0) 
L_leitura_Botoes15:
;MotorPartidaSuave.c,178 :: 		if(start && flagStart){
	BTFSS       RC1_bit+0, 1 
	GOTO        L_leitura_Botoes18
	BTFSS       _flagStart+0, BitPos(_flagStart+0) 
	GOTO        L_leitura_Botoes18
L__leitura_Botoes26:
;MotorPartidaSuave.c,180 :: 		flagStart = 0x00;
	BCF         _flagStart+0, BitPos(_flagStart+0) 
;MotorPartidaSuave.c,182 :: 		inicia_Motor();
	CALL        _inicia_Motor+0, 0
;MotorPartidaSuave.c,184 :: 		} // end if start && flagStart
L_leitura_Botoes18:
;MotorPartidaSuave.c,186 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_base_Tempo:

;MotorPartidaSuave.c,191 :: 		void base_Tempo(){
;MotorPartidaSuave.c,193 :: 		if(contBotao == 40) controlRapido = 0x01; // Se botao ficar pressionado por 1s, ativa o incremento rapido
	MOVF        _contBotao+0, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo19
	BSF         _controlRapido+0, BitPos(_controlRapido+0) 
L_base_Tempo19:
;MotorPartidaSuave.c,195 :: 		if(baseTempo == 0x04){ // Tempo igual a 100ms
	MOVF        _baseTempo+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo20
;MotorPartidaSuave.c,197 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
;MotorPartidaSuave.c,199 :: 		if(controlRapido) valor += 1; // Se incremento rapido ligado, incrementa a cada 100ms
	BTFSS       _controlRapido+0, BitPos(_controlRapido+0) 
	GOTO        L_base_Tempo21
	INCF        _valor+0, 1 
L_base_Tempo21:
;MotorPartidaSuave.c,201 :: 		} // end if baseTempo == 0x04
L_base_Tempo20:
;MotorPartidaSuave.c,203 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_imprime_Display:

;MotorPartidaSuave.c,209 :: 		void imprime_Display(){
;MotorPartidaSuave.c,213 :: 		dig3 = valor/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig3_L0+0 
;MotorPartidaSuave.c,214 :: 		dig2 = (valor%100)/10;
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
;MotorPartidaSuave.c,215 :: 		dig1 = valor%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig1_L0+0 
;MotorPartidaSuave.c,217 :: 		lcd_chr(1, 8, dig3 + 0x30);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorPartidaSuave.c,218 :: 		lcd_chr_cp(dig2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorPartidaSuave.c,219 :: 		lcd_chr_cp(dig1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorPartidaSuave.c,221 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_inicia_Motor:

;MotorPartidaSuave.c,225 :: 		void inicia_Motor(){
;MotorPartidaSuave.c,228 :: 		duty = 0x00;
	CLRF        _duty+0 
;MotorPartidaSuave.c,230 :: 		for(i = 0x00; i < valor; i++){
	CLRF        R1 
L_inicia_Motor22:
	MOVF        _valor+0, 0 
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inicia_Motor23
;MotorPartidaSuave.c,232 :: 		duty += 0x01;
	INCF        _duty+0, 1 
;MotorPartidaSuave.c,233 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_inicia_Motor25:
	DECFSZ      R13, 1, 1
	BRA         L_inicia_Motor25
	DECFSZ      R12, 1, 1
	BRA         L_inicia_Motor25
	NOP
	NOP
;MotorPartidaSuave.c,230 :: 		for(i = 0x00; i < valor; i++){
	INCF        R1, 1 
;MotorPartidaSuave.c,235 :: 		} // end for i = 0x00; i < valor; i++
	GOTO        L_inicia_Motor22
L_inicia_Motor23:
;MotorPartidaSuave.c,237 :: 		} // end void inicia_Motor()
	RETURN      0
; end of _inicia_Motor

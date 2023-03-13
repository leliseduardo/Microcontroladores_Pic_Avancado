
_interrupt:

;MotorControlTemperatura.c,73 :: 		void interrupt(){
;MotorControlTemperatura.c,75 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;MotorControlTemperatura.c,77 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;MotorControlTemperatura.c,78 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;MotorControlTemperatura.c,79 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;MotorControlTemperatura.c,81 :: 		baseTempo++;
	INCF        _baseTempo+0, 1 
;MotorControlTemperatura.c,82 :: 		contTempo++;
	INCF        _contTempo+0, 1 
;MotorControlTemperatura.c,84 :: 		if(contTempo > 120){
	MOVF        _contTempo+0, 0 
	SUBLW       120
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;MotorControlTemperatura.c,86 :: 		backLight = 0x00;
	BCF         LATB1_bit+0, 1 
;MotorControlTemperatura.c,87 :: 		contTempo = 120;
	MOVLW       120
	MOVWF       _contTempo+0 
;MotorControlTemperatura.c,88 :: 		controlAdiciona = 0x00;
	CLRF        _controlAdiciona+0 
;MotorControlTemperatura.c,90 :: 		} // end if contTempo > 120
L_interrupt1:
;MotorControlTemperatura.c,92 :: 		if(flagBotao) contBotao++;
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_interrupt2
	INCF        _contBotao+0, 1 
L_interrupt2:
;MotorControlTemperatura.c,94 :: 		base_Tempo();
	CALL        _base_Tempo+0, 0
;MotorControlTemperatura.c,96 :: 		} // end if TMR0IF_bit
L_interrupt0:
;MotorControlTemperatura.c,98 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt3
;MotorControlTemperatura.c,100 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;MotorControlTemperatura.c,102 :: 		if(duty == 0x00) pwm = 0x00;
	MOVF        _duty+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
	BCF         LATC0_bit+0, 0 
	GOTO        L_interrupt5
L_interrupt4:
;MotorControlTemperatura.c,104 :: 		if(pwm){
	BTFSS       LATC0_bit+0, 0 
	GOTO        L_interrupt6
;MotorControlTemperatura.c,106 :: 		TMR2 = duty;
	MOVF        _duty+0, 0 
	MOVWF       TMR2+0 
;MotorControlTemperatura.c,107 :: 		pwm = 0x00;
	BCF         LATC0_bit+0, 0 
;MotorControlTemperatura.c,109 :: 		} // end if pwm
	GOTO        L_interrupt7
L_interrupt6:
;MotorControlTemperatura.c,112 :: 		TMR2 = 255 - duty;
	MOVF        _duty+0, 0 
	SUBLW       255
	MOVWF       TMR2+0 
;MotorControlTemperatura.c,113 :: 		pwm = 0x01;
	BSF         LATC0_bit+0, 0 
;MotorControlTemperatura.c,115 :: 		} // end else pwm
L_interrupt7:
;MotorControlTemperatura.c,116 :: 		} // end else duty == 0x00;
L_interrupt5:
;MotorControlTemperatura.c,117 :: 		} // end TMR2IF_bit
L_interrupt3:
;MotorControlTemperatura.c,119 :: 		} // end void interrupt
L__interrupt44:
	RETFIE      1
; end of _interrupt

_main:

;MotorControlTemperatura.c,121 :: 		void main() {
;MotorControlTemperatura.c,124 :: 		ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e ativa o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;MotorControlTemperatura.c,125 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura AN0 como entrada analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;MotorControlTemperatura.c,126 :: 		TRISB = 0x01; // Configura apenas RB0 como entrada digital, o resto como saída
	MOVLW       1
	MOVWF       TRISB+0 
;MotorControlTemperatura.c,127 :: 		TRISC = 0xFC; // Configura apenas RC0 e RC1 como saídas digitais, o resto como entrada
	MOVLW       252
	MOVWF       TRISC+0 
;MotorControlTemperatura.c,128 :: 		LATC = 0xFC; // Inicia todas as saídas digitais em Low
	MOVLW       252
	MOVWF       LATC+0 
;MotorControlTemperatura.c,130 :: 		INTCON = 0xE0; // Habilita a interrupção global, por perfiféricos e a interrupção por overflow do timer 0
	MOVLW       224
	MOVWF       INTCON+0 
;MotorControlTemperatura.c,131 :: 		INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entrada do portb
	BCF         INTCON2+0, 7 
;MotorControlTemperatura.c,133 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento com ciclo de maquina, prescale de 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;MotorControlTemperatura.c,134 :: 		TMR0H = 0x9E; // Inicializa em 40536 para uma contagem de 25000 e overflow em 25ms
	MOVLW       158
	MOVWF       TMR0H+0 
;MotorControlTemperatura.c,135 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;MotorControlTemperatura.c,137 :: 		T2CON = 0x05; // Habilita o timer2, configurao postscale em 1:1 e o prescale em 1:4
	MOVLW       5
	MOVWF       T2CON+0 
;MotorControlTemperatura.c,138 :: 		PR2 = 0xFF; // O contador TMR2 conta até 256
	MOVLW       255
	MOVWF       PR2+0 
;MotorControlTemperatura.c,139 :: 		TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2
	BSF         TMR2IE_bit+0, 1 
;MotorControlTemperatura.c,141 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;MotorControlTemperatura.c,142 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;MotorControlTemperatura.c,143 :: 		flagStart = 0x00;
	BCF         _flagStart+0, BitPos(_flagStart+0) 
;MotorControlTemperatura.c,146 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;MotorControlTemperatura.c,147 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorControlTemperatura.c,148 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorControlTemperatura.c,149 :: 		lcd_chr(1, 2, 'D');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorControlTemperatura.c,150 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,151 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,152 :: 		lcd_chr_cp('y');
	MOVLW       121
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,153 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,154 :: 		lcd_chr(2, 2, 'T');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorControlTemperatura.c,155 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,156 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,157 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,158 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,162 :: 		while(1){
L_main8:
;MotorControlTemperatura.c,164 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;MotorControlTemperatura.c,166 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;MotorControlTemperatura.c,168 :: 		celsius();
	CALL        _celsius+0, 0
;MotorControlTemperatura.c,170 :: 		if(temperatura > 31){
	MOVF        _temperatura+0, 0 
	MOVWF       R4 
	MOVF        _temperatura+1, 0 
	MOVWF       R5 
	MOVF        _temperatura+2, 0 
	MOVWF       R6 
	MOVF        _temperatura+3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       120
	MOVWF       R2 
	MOVLW       131
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
;MotorControlTemperatura.c,172 :: 		duty = 0x3C; // duty = 60 decimal
	MOVLW       60
	MOVWF       _duty+0 
;MotorControlTemperatura.c,173 :: 		led = 0x01;
	BSF         LATC1_bit+0, 1 
;MotorControlTemperatura.c,175 :: 		} // end if temperatura > 30
L_main10:
;MotorControlTemperatura.c,177 :: 		if(temperatura < 27 && led){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       88
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _temperatura+0, 0 
	MOVWF       R0 
	MOVF        _temperatura+1, 0 
	MOVWF       R1 
	MOVF        _temperatura+2, 0 
	MOVWF       R2 
	MOVF        _temperatura+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	BTFSS       LATC1_bit+0, 1 
	GOTO        L_main13
L__main40:
;MotorControlTemperatura.c,179 :: 		inicia_Motor();
	CALL        _inicia_Motor+0, 0
;MotorControlTemperatura.c,180 :: 		led = 0x00;
	BCF         LATC1_bit+0, 1 
;MotorControlTemperatura.c,182 :: 		} // end if temperatura < 27 && led
L_main13:
;MotorControlTemperatura.c,184 :: 		} // end loop infinito
	GOTO        L_main8
;MotorControlTemperatura.c,186 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;MotorControlTemperatura.c,190 :: 		void leitura_Botoes(){
;MotorControlTemperatura.c,192 :: 		if(!botao){
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes14
;MotorControlTemperatura.c,194 :: 		flagBotao = 0x01;
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
;MotorControlTemperatura.c,195 :: 		backLight = 0x01;
	BSF         LATB1_bit+0, 1 
;MotorControlTemperatura.c,196 :: 		contTempo = 0x00;
	CLRF        _contTempo+0 
;MotorControlTemperatura.c,198 :: 		} // end if !botao
L_leitura_Botoes14:
;MotorControlTemperatura.c,200 :: 		if(botao && flagBotao){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Botoes17
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botoes17
L__leitura_Botoes42:
;MotorControlTemperatura.c,202 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;MotorControlTemperatura.c,203 :: 		contBotao = 0x00;
	CLRF        _contBotao+0 
;MotorControlTemperatura.c,204 :: 		controlRapido = 0x00;
	BCF         _controlRapido+0, BitPos(_controlRapido+0) 
;MotorControlTemperatura.c,205 :: 		controlAdiciona++;
	INCF        _controlAdiciona+0, 1 
;MotorControlTemperatura.c,207 :: 		if(controlAdiciona > 1) valor++;
	MOVF        _controlAdiciona+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_leitura_Botoes18
	INCF        _valor+0, 1 
L_leitura_Botoes18:
;MotorControlTemperatura.c,209 :: 		} // end if botao && flagBotao
L_leitura_Botoes17:
;MotorControlTemperatura.c,211 :: 		if(!led)
	BTFSC       LATC1_bit+0, 1 
	GOTO        L_leitura_Botoes19
;MotorControlTemperatura.c,212 :: 		if(!start) flagStart = 0x01;
	BTFSC       RC2_bit+0, 2 
	GOTO        L_leitura_Botoes20
	BSF         _flagStart+0, BitPos(_flagStart+0) 
L_leitura_Botoes20:
L_leitura_Botoes19:
;MotorControlTemperatura.c,214 :: 		if(start && flagStart){
	BTFSS       RC2_bit+0, 2 
	GOTO        L_leitura_Botoes23
	BTFSS       _flagStart+0, BitPos(_flagStart+0) 
	GOTO        L_leitura_Botoes23
L__leitura_Botoes41:
;MotorControlTemperatura.c,216 :: 		flagStart = 0x00;
	BCF         _flagStart+0, BitPos(_flagStart+0) 
;MotorControlTemperatura.c,218 :: 		inicia_Motor();
	CALL        _inicia_Motor+0, 0
;MotorControlTemperatura.c,220 :: 		} // end if start && flagStart
L_leitura_Botoes23:
;MotorControlTemperatura.c,222 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_base_Tempo:

;MotorControlTemperatura.c,227 :: 		void base_Tempo(){
;MotorControlTemperatura.c,229 :: 		if(contBotao == 40) controlRapido = 0x01; // Se botao ficar pressionado por 1s, ativa o incremento rapido
	MOVF        _contBotao+0, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo24
	BSF         _controlRapido+0, BitPos(_controlRapido+0) 
L_base_Tempo24:
;MotorControlTemperatura.c,231 :: 		if(baseTempo == 0x04){ // Tempo igual a 100ms
	MOVF        _baseTempo+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_base_Tempo25
;MotorControlTemperatura.c,233 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
;MotorControlTemperatura.c,235 :: 		if(controlRapido) valor += 1; // Se incremento rapido ligado, incrementa a cada 100ms
	BTFSS       _controlRapido+0, BitPos(_controlRapido+0) 
	GOTO        L_base_Tempo26
	INCF        _valor+0, 1 
L_base_Tempo26:
;MotorControlTemperatura.c,237 :: 		} // end if baseTempo == 0x04
L_base_Tempo25:
;MotorControlTemperatura.c,239 :: 		} // end void base_Tempo
	RETURN      0
; end of _base_Tempo

_imprime_Display:

;MotorControlTemperatura.c,245 :: 		void imprime_Display(){
;MotorControlTemperatura.c,249 :: 		dig3 = valor/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig3_L0+0 
;MotorControlTemperatura.c,250 :: 		dig2 = (valor%100)/10;
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
;MotorControlTemperatura.c,251 :: 		dig1 = valor%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig1_L0+0 
;MotorControlTemperatura.c,253 :: 		lcd_chr(1, 8, dig3 + 0x30);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorControlTemperatura.c,254 :: 		lcd_chr_cp(dig2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,255 :: 		lcd_chr_cp(dig1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dig1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,257 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_inicia_Motor:

;MotorControlTemperatura.c,261 :: 		void inicia_Motor(){
;MotorControlTemperatura.c,264 :: 		duty = 0x00;
	CLRF        _duty+0 
;MotorControlTemperatura.c,266 :: 		for(i = 0x00; i < valor; i++){
	CLRF        R1 
L_inicia_Motor27:
	MOVF        _valor+0, 0 
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_inicia_Motor28
;MotorControlTemperatura.c,268 :: 		duty += 0x01;
	INCF        _duty+0, 1 
;MotorControlTemperatura.c,269 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_inicia_Motor30:
	DECFSZ      R13, 1, 1
	BRA         L_inicia_Motor30
	DECFSZ      R12, 1, 1
	BRA         L_inicia_Motor30
	NOP
	NOP
;MotorControlTemperatura.c,266 :: 		for(i = 0x00; i < valor; i++){
	INCF        R1, 1 
;MotorControlTemperatura.c,271 :: 		} // end for i = 0x00; i < valor; i++
	GOTO        L_inicia_Motor27
L_inicia_Motor28:
;MotorControlTemperatura.c,273 :: 		} // end void inicia_Motor()
	RETURN      0
; end of _inicia_Motor

_celsius:

;MotorControlTemperatura.c,276 :: 		void celsius(){
;MotorControlTemperatura.c,278 :: 		adc = media_Temperatura();
	CALL        _media_Temperatura+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;MotorControlTemperatura.c,280 :: 		temperatura = ((adc * 5.0) / 1024.0);
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _temperatura+0 
	MOVF        R1, 0 
	MOVWF       _temperatura+1 
	MOVF        R2, 0 
	MOVWF       _temperatura+2 
	MOVF        R3, 0 
	MOVWF       _temperatura+3 
;MotorControlTemperatura.c,282 :: 		temperatura = temperatura * 100.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__celsius+0 
	MOVF        R1, 0 
	MOVWF       FLOC__celsius+1 
	MOVF        R2, 0 
	MOVWF       FLOC__celsius+2 
	MOVF        R3, 0 
	MOVWF       FLOC__celsius+3 
	MOVF        FLOC__celsius+0, 0 
	MOVWF       _temperatura+0 
	MOVF        FLOC__celsius+1, 0 
	MOVWF       _temperatura+1 
	MOVF        FLOC__celsius+2, 0 
	MOVWF       _temperatura+2 
	MOVF        FLOC__celsius+3, 0 
	MOVWF       _temperatura+3 
;MotorControlTemperatura.c,284 :: 		if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5)){
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        FLOC__celsius+0, 0 
	MOVWF       R4 
	MOVF        FLOC__celsius+1, 0 
	MOVWF       R5 
	MOVF        FLOC__celsius+2, 0 
	MOVWF       R6 
	MOVF        FLOC__celsius+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__celsius43
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _temperatura+0, 0 
	MOVWF       R0 
	MOVF        _temperatura+1, 0 
	MOVWF       R1 
	MOVF        _temperatura+2, 0 
	MOVWF       R2 
	MOVF        _temperatura+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__celsius43
	GOTO        L_celsius33
L__celsius43:
;MotorControlTemperatura.c,286 :: 		ultimaTemperatura = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemperatura+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemperatura+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemperatura+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemperatura+3 
;MotorControlTemperatura.c,288 :: 		FloatToStr(temperatura, txt);
	MOVF        _temperatura+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _temperatura+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _temperatura+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _temperatura+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;MotorControlTemperatura.c,290 :: 		lcd_chr(2, 8, txt[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorControlTemperatura.c,291 :: 		lcd_chr_cp(txt[1]);
	MOVF        _txt+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,292 :: 		lcd_chr_cp(txt[2]);
	MOVF        _txt+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,293 :: 		lcd_chr_cp(txt[3]);
	MOVF        _txt+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,294 :: 		lcd_chr_cp(txt[4]);
	MOVF        _txt+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,295 :: 		lcd_chr_cp(txt[5]);
	MOVF        _txt+5, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;MotorControlTemperatura.c,296 :: 		CustomChar(2, 14);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       14
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;MotorControlTemperatura.c,297 :: 		lcd_chr(2, 15, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorControlTemperatura.c,300 :: 		} // end if temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5
L_celsius33:
;MotorControlTemperatura.c,302 :: 		} // void celsius
	RETURN      0
; end of _celsius

_media_Temperatura:

;MotorControlTemperatura.c,305 :: 		int media_Temperatura(){
;MotorControlTemperatura.c,308 :: 		int media = 0x00;
	CLRF        media_Temperatura_media_L0+0 
	CLRF        media_Temperatura_media_L0+1 
;MotorControlTemperatura.c,310 :: 		for(i = 0x00; i < 0x64; i++)
	CLRF        media_Temperatura_i_L0+0 
L_media_Temperatura34:
	MOVLW       100
	SUBWF       media_Temperatura_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_media_Temperatura35
;MotorControlTemperatura.c,311 :: 		media += adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       media_Temperatura_media_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      media_Temperatura_media_L0+1, 1 
;MotorControlTemperatura.c,310 :: 		for(i = 0x00; i < 0x64; i++)
	INCF        media_Temperatura_i_L0+0, 1 
;MotorControlTemperatura.c,311 :: 		media += adc_read(0);
	GOTO        L_media_Temperatura34
L_media_Temperatura35:
;MotorControlTemperatura.c,313 :: 		return (media/0x64);
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        media_Temperatura_media_L0+0, 0 
	MOVWF       R0 
	MOVF        media_Temperatura_media_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
;MotorControlTemperatura.c,315 :: 		} // end int media_Temperatura
	RETURN      0
; end of _media_Temperatura

_CustomChar:

;MotorControlTemperatura.c,319 :: 		void CustomChar(char pos_row, char pos_char) {
;MotorControlTemperatura.c,322 :: 		Lcd_Cmd(72);
	MOVLW       72
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorControlTemperatura.c,323 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar37:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar38
	MOVLW       _character+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar37
L_CustomChar38:
;MotorControlTemperatura.c,324 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MotorControlTemperatura.c,325 :: 		Lcd_Chr(pos_row, pos_char, 1);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;MotorControlTemperatura.c,327 :: 		}
	RETURN      0
; end of _CustomChar

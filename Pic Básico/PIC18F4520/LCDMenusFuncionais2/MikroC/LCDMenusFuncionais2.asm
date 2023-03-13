
_interrupt:

;LCDMenusFuncionais2.c,84 :: 		void interrupt(){
;LCDMenusFuncionais2.c,86 :: 		if(INT0IF_bit){
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;LCDMenusFuncionais2.c,88 :: 		INT0IF_bit = 0x00;
	BCF         INT0IF_bit+0, 1 
;LCDMenusFuncionais2.c,90 :: 		contPulsos++;
	MOVLW       1
	ADDWF       _contPulsos+0, 1 
	MOVLW       0
	ADDWFC      _contPulsos+1, 1 
	ADDWFC      _contPulsos+2, 1 
	ADDWFC      _contPulsos+3, 1 
;LCDMenusFuncionais2.c,92 :: 		} // end if INT0IF_bit
L_interrupt0:
;LCDMenusFuncionais2.c,94 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt1
;LCDMenusFuncionais2.c,96 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;LCDMenusFuncionais2.c,97 :: 		TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
	MOVLW       176
	MOVWF       TMR0L+0 
;LCDMenusFuncionais2.c,98 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;LCDMenusFuncionais2.c,100 :: 		contAux++;
	INCF        _contAux+0, 1 
;LCDMenusFuncionais2.c,102 :: 		if(contAux == 20){
	MOVF        _contAux+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;LCDMenusFuncionais2.c,104 :: 		contAux = 0x00;
	CLRF        _contAux+0 
;LCDMenusFuncionais2.c,106 :: 		contTemp++; // Variável da função de temperatura máxima e mínima
	INCF        _contTemp+0, 1 
;LCDMenusFuncionais2.c,108 :: 		contTempo++;
	MOVLW       1
	ADDWF       _contTempo+0, 1 
	MOVLW       0
	ADDWFC      _contTempo+1, 1 
	ADDWFC      _contTempo+2, 1 
	ADDWFC      _contTempo+3, 1 
;LCDMenusFuncionais2.c,110 :: 		if(contTemp == 3){
	MOVF        _contTemp+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;LCDMenusFuncionais2.c,112 :: 		contTemp = 0x00;
	CLRF        _contTemp+0 
;LCDMenusFuncionais2.c,114 :: 		tempControl = ~tempControl;
	BTG         _tempControl+0, BitPos(_tempControl+0) 
;LCDMenusFuncionais2.c,116 :: 		} // end if contTemp == 3
L_interrupt3:
;LCDMenusFuncionais2.c,118 :: 		} // end if contAux == 20
L_interrupt2:
;LCDMenusFuncionais2.c,120 :: 		} // end if TMR0IF_bit
L_interrupt1:
;LCDMenusFuncionais2.c,122 :: 		} // end void interrupt
L__interrupt55:
	RETFIE      1
; end of _interrupt

_main:

;LCDMenusFuncionais2.c,125 :: 		void main() {
;LCDMenusFuncionais2.c,130 :: 		INTCON = 0xF0; // Habilita a interrupção global, a interrupção externa INT0 e a interrupção por overflow do timer0
	MOVLW       240
	MOVWF       INTCON+0 
;LCDMenusFuncionais2.c,133 :: 		INTEDG0_bit = 0x01; // Configura a interrupção externa por borda de subida
	BSF         INTEDG0_bit+0, 6 
;LCDMenusFuncionais2.c,136 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;LCDMenusFuncionais2.c,137 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;LCDMenusFuncionais2.c,138 :: 		T0CS_bit = 0x00; // Configura o incremento do timer0 a partir do ciclo de maquina
	BCF         T0CS_bit+0, 5 
;LCDMenusFuncionais2.c,139 :: 		PSA_bit = 0x01; // Não associa o timer0 ao prescaler, o que equivale ao prescaler 1:1
	BSF         PSA_bit+0, 3 
;LCDMenusFuncionais2.c,142 :: 		TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
	MOVLW       176
	MOVWF       TMR0L+0 
;LCDMenusFuncionais2.c,143 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;LCDMenusFuncionais2.c,146 :: 		ADCON0 = 0x01; // Habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;LCDMenusFuncionais2.c,147 :: 		ADCON1 = 0x0D; // Configura apenas AN0 e AN1 como entrada analógicas
	MOVLW       13
	MOVWF       ADCON1+0 
;LCDMenusFuncionais2.c,150 :: 		TRISA = 0xFF; // Configura todo o porta como entrada digital, exceto RA0/AN0 e RA1/AN1, que são entrada analógicas
	MOVLW       255
	MOVWF       TRISA+0 
;LCDMenusFuncionais2.c,151 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;LCDMenusFuncionais2.c,152 :: 		PORTB = 0xF9; // Apenas RB1 e RB2 iniciam em Low, pois estão ligadas em Pull-Down
	MOVLW       249
	MOVWF       PORTB+0 
;LCDMenusFuncionais2.c,154 :: 		tempControl = 0;
	BCF         _tempControl+0, BitPos(_tempControl+0) 
;LCDMenusFuncionais2.c,155 :: 		tempControl2 = 0;
	BCF         _tempControl2+0, BitPos(_tempControl2+0) 
;LCDMenusFuncionais2.c,157 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais2.c,159 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;LCDMenusFuncionais2.c,160 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais2.c,161 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais2.c,164 :: 		while(1){
L_main4:
;LCDMenusFuncionais2.c,166 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;LCDMenusFuncionais2.c,168 :: 		switch(menuControl){
	GOTO        L_main6
;LCDMenusFuncionais2.c,170 :: 		case 0x01: menu1();
L_main8:
	CALL        _menu1+0, 0
;LCDMenusFuncionais2.c,171 :: 		break;
	GOTO        L_main7
;LCDMenusFuncionais2.c,172 :: 		case 0x02: menu2();
L_main9:
	CALL        _menu2+0, 0
;LCDMenusFuncionais2.c,173 :: 		break;
	GOTO        L_main7
;LCDMenusFuncionais2.c,174 :: 		case 0x03: menu3();
L_main10:
	CALL        _menu3+0, 0
;LCDMenusFuncionais2.c,175 :: 		break;
	GOTO        L_main7
;LCDMenusFuncionais2.c,176 :: 		case 0x04: menu4();
L_main11:
	CALL        _menu4+0, 0
;LCDMenusFuncionais2.c,177 :: 		break;
	GOTO        L_main7
;LCDMenusFuncionais2.c,178 :: 		case 0x05: menu5();
L_main12:
	CALL        _menu5+0, 0
;LCDMenusFuncionais2.c,179 :: 		break;
	GOTO        L_main7
;LCDMenusFuncionais2.c,180 :: 		case 0x06: menu6();
L_main13:
	CALL        _menu6+0, 0
;LCDMenusFuncionais2.c,181 :: 		break;
	GOTO        L_main7
;LCDMenusFuncionais2.c,183 :: 		} // end switch menuControl
L_main6:
	MOVF        _menuControl+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        _menuControl+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVF        _menuControl+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        _menuControl+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _menuControl+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        _menuControl+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
L_main7:
;LCDMenusFuncionais2.c,185 :: 		} // end loop infinito
	GOTO        L_main4
;LCDMenusFuncionais2.c,187 :: 		} // end void main
	GOTO        $+0
; end of _main

_celsius:

;LCDMenusFuncionais2.c,195 :: 		void celsius(){
;LCDMenusFuncionais2.c,197 :: 		ADCON0 = 0x01; // Seleciona o canal 0 do conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;LCDMenusFuncionais2.c,199 :: 		media = mediaTemperatura();
	CALL        _mediaTemperatura+0, 0
	MOVF        R0, 0 
	MOVWF       _media+0 
	MOVF        R1, 0 
	MOVWF       _media+1 
;LCDMenusFuncionais2.c,201 :: 		temperatura = ((media * 5.0)/1024.0);
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
;LCDMenusFuncionais2.c,202 :: 		temperatura = temperatura * 100.0;
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
;LCDMenusFuncionais2.c,204 :: 		if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5))
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
	GOTO        L__celsius52
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
	GOTO        L__celsius52
	GOTO        L_celsius16
L__celsius52:
;LCDMenusFuncionais2.c,205 :: 		ultimaTemperatura = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemperatura+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemperatura+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemperatura+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemperatura+3 
L_celsius16:
;LCDMenusFuncionais2.c,207 :: 		if(temperatura > temperaturaMaxima) temperaturaMaxima = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       R4 
	MOVF        _temperatura+1, 0 
	MOVWF       R5 
	MOVF        _temperatura+2, 0 
	MOVWF       R6 
	MOVF        _temperatura+3, 0 
	MOVWF       R7 
	MOVF        _temperaturaMaxima+0, 0 
	MOVWF       R0 
	MOVF        _temperaturaMaxima+1, 0 
	MOVWF       R1 
	MOVF        _temperaturaMaxima+2, 0 
	MOVWF       R2 
	MOVF        _temperaturaMaxima+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_celsius17
	MOVF        _temperatura+0, 0 
	MOVWF       _temperaturaMaxima+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _temperaturaMaxima+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _temperaturaMaxima+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _temperaturaMaxima+3 
L_celsius17:
;LCDMenusFuncionais2.c,209 :: 		if(temperatura < temperaturaMinima) temperaturaMinima = temperatura;
	MOVF        _temperaturaMinima+0, 0 
	MOVWF       R4 
	MOVF        _temperaturaMinima+1, 0 
	MOVWF       R5 
	MOVF        _temperaturaMinima+2, 0 
	MOVWF       R6 
	MOVF        _temperaturaMinima+3, 0 
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
	GOTO        L_celsius18
	MOVF        _temperatura+0, 0 
	MOVWF       _temperaturaMinima+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _temperaturaMinima+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _temperaturaMinima+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _temperaturaMinima+3 
L_celsius18:
;LCDMenusFuncionais2.c,212 :: 		if(!tempControl2){
	BTFSC       _tempControl2+0, BitPos(_tempControl2+0) 
	GOTO        L_celsius19
;LCDMenusFuncionais2.c,213 :: 		FloatToStr(ultimaTemperatura, textoTemp);
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _textoTemp+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_textoTemp+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;LCDMenusFuncionais2.c,215 :: 		if(ultimaTemperatura < 0.05){
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       122
	MOVWF       R7 
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_celsius20
;LCDMenusFuncionais2.c,216 :: 		lcd_chr(2, 6, 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,217 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,218 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,219 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,220 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,221 :: 		} // end if ultimaTemperatura < 0.05
	GOTO        L_celsius21
L_celsius20:
;LCDMenusFuncionais2.c,223 :: 		lcd_chr(2, 6, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,224 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,225 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,226 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,227 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,228 :: 		} // end else
L_celsius21:
;LCDMenusFuncionais2.c,229 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDMenusFuncionais2.c,230 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,231 :: 		} // end if !tempControl2
	GOTO        L_celsius22
L_celsius19:
;LCDMenusFuncionais2.c,233 :: 		if(!tempControl){
	BTFSC       _tempControl+0, BitPos(_tempControl+0) 
	GOTO        L_celsius23
;LCDMenusFuncionais2.c,234 :: 		FloatToStr(temperaturaMaxima, textoTemp);
	MOVF        _temperaturaMaxima+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _temperaturaMaxima+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _temperaturaMaxima+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _temperaturaMaxima+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _textoTemp+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_textoTemp+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;LCDMenusFuncionais2.c,235 :: 		lcd_chr(2, 1, 'M');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,236 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,237 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,238 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,240 :: 		lcd_chr(2, 5, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,241 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,242 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,243 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,244 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,245 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDMenusFuncionais2.c,246 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,247 :: 		} // end !tempControl
	GOTO        L_celsius24
L_celsius23:
;LCDMenusFuncionais2.c,249 :: 		FloatToStr(temperaturaMinima, textoTemp);
	MOVF        _temperaturaMinima+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _temperaturaMinima+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _temperaturaMinima+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _temperaturaMinima+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _textoTemp+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_textoTemp+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;LCDMenusFuncionais2.c,250 :: 		lcd_chr(2, 1, 'M');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,251 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,252 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,253 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,255 :: 		lcd_chr(2, 5, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,256 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,257 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,258 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,259 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,260 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDMenusFuncionais2.c,261 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,262 :: 		} // end else !tempControl
L_celsius24:
;LCDMenusFuncionais2.c,264 :: 		} // end else !tempControl2
L_celsius22:
;LCDMenusFuncionais2.c,282 :: 		} // end void celsius
	RETURN      0
; end of _celsius

_mediaTemperatura:

;LCDMenusFuncionais2.c,284 :: 		int mediaTemperatura(){
;LCDMenusFuncionais2.c,287 :: 		int adc = 0;
	CLRF        mediaTemperatura_adc_L0+0 
	CLRF        mediaTemperatura_adc_L0+1 
;LCDMenusFuncionais2.c,289 :: 		for(i = 0; i < 0x64; i++){
	CLRF        mediaTemperatura_i_L0+0 
L_mediaTemperatura25:
	MOVLW       100
	SUBWF       mediaTemperatura_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mediaTemperatura26
;LCDMenusFuncionais2.c,291 :: 		if(!tempControl) adc += adc_read(0);
	BTFSC       _tempControl+0, BitPos(_tempControl+0) 
	GOTO        L_mediaTemperatura28
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       mediaTemperatura_adc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mediaTemperatura_adc_L0+1, 1 
	GOTO        L_mediaTemperatura29
L_mediaTemperatura28:
;LCDMenusFuncionais2.c,292 :: 		else adc += adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       mediaTemperatura_adc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mediaTemperatura_adc_L0+1, 1 
L_mediaTemperatura29:
;LCDMenusFuncionais2.c,289 :: 		for(i = 0; i < 0x64; i++){
	INCF        mediaTemperatura_i_L0+0, 1 
;LCDMenusFuncionais2.c,294 :: 		} // end for
	GOTO        L_mediaTemperatura25
L_mediaTemperatura26:
;LCDMenusFuncionais2.c,296 :: 		return (adc/0x64);
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        mediaTemperatura_adc_L0+0, 0 
	MOVWF       R0 
	MOVF        mediaTemperatura_adc_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
;LCDMenusFuncionais2.c,297 :: 		} // end void mediaTemperatura
	RETURN      0
; end of _mediaTemperatura

_voltimetro:

;LCDMenusFuncionais2.c,299 :: 		void voltimetro(){
;LCDMenusFuncionais2.c,301 :: 		char mil = 0x00, cen = 0x00, dez = 0x00, uni = 0x00;
;LCDMenusFuncionais2.c,302 :: 		int adc = 0;
;LCDMenusFuncionais2.c,304 :: 		adc = adc_read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;LCDMenusFuncionais2.c,306 :: 		volt = ((adc * 5.0)/1024.0);
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
	MOVWF       _volt+0 
	MOVF        R1, 0 
	MOVWF       _volt+1 
	MOVF        R2, 0 
	MOVWF       _volt+2 
	MOVF        R3, 0 
	MOVWF       _volt+3 
;LCDMenusFuncionais2.c,308 :: 		FloatToStr(volt, textoVoltimetro);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _textoVoltimetro+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_textoVoltimetro+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;LCDMenusFuncionais2.c,310 :: 		if(volt < 0.01){
	MOVLW       10
	MOVWF       R4 
	MOVLW       215
	MOVWF       R5 
	MOVLW       35
	MOVWF       R6 
	MOVLW       120
	MOVWF       R7 
	MOVF        _volt+0, 0 
	MOVWF       R0 
	MOVF        _volt+1, 0 
	MOVWF       R1 
	MOVF        _volt+2, 0 
	MOVWF       R2 
	MOVF        _volt+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_voltimetro30
;LCDMenusFuncionais2.c,311 :: 		lcd_chr(2, 8, 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,312 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,313 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,314 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,315 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,316 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,317 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,318 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,319 :: 		}// end if volt < 0.01
	GOTO        L_voltimetro31
L_voltimetro30:
;LCDMenusFuncionais2.c,321 :: 		lcd_chr(2, 8, textoVoltimetro[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoVoltimetro+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,322 :: 		lcd_chr_cp(textoVoltimetro[1]);
	MOVF        _textoVoltimetro+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,323 :: 		lcd_chr_cp(textoVoltimetro[2]);
	MOVF        _textoVoltimetro+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,324 :: 		lcd_chr_cp(textoVoltimetro[3]);
	MOVF        _textoVoltimetro+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,325 :: 		lcd_chr_cp(textoVoltimetro[4]);
	MOVF        _textoVoltimetro+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,326 :: 		if(volt < 1){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        _volt+0, 0 
	MOVWF       R0 
	MOVF        _volt+1, 0 
	MOVWF       R1 
	MOVF        _volt+2, 0 
	MOVWF       R2 
	MOVF        _volt+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_voltimetro32
;LCDMenusFuncionais2.c,327 :: 		lcd_chr_cp('E');
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,328 :: 		lcd_chr_cp('-');
	MOVLW       45
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,329 :: 		lcd_chr_cp(49); // numero "1"
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,330 :: 		} // end if volt < 1
	GOTO        L_voltimetro33
L_voltimetro32:
;LCDMenusFuncionais2.c,332 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,333 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,334 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,335 :: 		} // end else
L_voltimetro33:
;LCDMenusFuncionais2.c,336 :: 		lcd_chr(2, 16, 'V');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,337 :: 		} // end else
L_voltimetro31:
;LCDMenusFuncionais2.c,339 :: 		} // end voltimetro
	RETURN      0
; end of _voltimetro

_conta_Pulsos:

;LCDMenusFuncionais2.c,341 :: 		void conta_Pulsos(){
;LCDMenusFuncionais2.c,343 :: 		LongToStr(contPulsos, textoPulsos);
	MOVF        _contPulsos+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _contPulsos+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _contPulsos+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _contPulsos+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _textoPulsos+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_textoPulsos+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;LCDMenusFuncionais2.c,345 :: 		lcd_Out(2, 2, textoPulsos);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _textoPulsos+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_textoPulsos+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDMenusFuncionais2.c,347 :: 		} // end void conta_Pulsos
	RETURN      0
; end of _conta_Pulsos

_conta_Tempo:

;LCDMenusFuncionais2.c,349 :: 		void conta_Tempo(){
;LCDMenusFuncionais2.c,351 :: 		LongToStr(contTempo, textoTempo);
	MOVF        _contTempo+0, 0 
	MOVWF       FARG_LongToStr_input+0 
	MOVF        _contTempo+1, 0 
	MOVWF       FARG_LongToStr_input+1 
	MOVF        _contTempo+2, 0 
	MOVWF       FARG_LongToStr_input+2 
	MOVF        _contTempo+3, 0 
	MOVWF       FARG_LongToStr_input+3 
	MOVLW       _textoTempo+0
	MOVWF       FARG_LongToStr_output+0 
	MOVLW       hi_addr(_textoTempo+0)
	MOVWF       FARG_LongToStr_output+1 
	CALL        _LongToStr+0, 0
;LCDMenusFuncionais2.c,353 :: 		lcd_out(2, 2, textoTempo);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _textoTempo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_textoTempo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDMenusFuncionais2.c,355 :: 		} // end void conta_Tempo
	RETURN      0
; end of _conta_Tempo

_dipSwitch:

;LCDMenusFuncionais2.c,357 :: 		void dipSwitch(){
;LCDMenusFuncionais2.c,359 :: 		if(!chave1) lcd_out(2, 1, "Ch1:Off");
	BTFSC       RB1_bit+0, 1 
	GOTO        L_dipSwitch34
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LCDMenusFuncionais2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LCDMenusFuncionais2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dipSwitch35
L_dipSwitch34:
;LCDMenusFuncionais2.c,360 :: 		else lcd_out(2, 1, "Ch1:On ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_LCDMenusFuncionais2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_LCDMenusFuncionais2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_dipSwitch35:
;LCDMenusFuncionais2.c,362 :: 		if(!chave2) lcd_out(2, 9, "Ch2:Off");
	BTFSC       RB2_bit+0, 2 
	GOTO        L_dipSwitch36
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_LCDMenusFuncionais2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_LCDMenusFuncionais2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dipSwitch37
L_dipSwitch36:
;LCDMenusFuncionais2.c,363 :: 		else lcd_out(2, 9, "Ch2:On ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_LCDMenusFuncionais2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_LCDMenusFuncionais2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_dipSwitch37:
;LCDMenusFuncionais2.c,365 :: 		} // end void dipSwitch
	RETURN      0
; end of _dipSwitch

_leitura_Botoes:

;LCDMenusFuncionais2.c,374 :: 		void leitura_Botoes(){
;LCDMenusFuncionais2.c,376 :: 		if(!voltaMenu) flagBotoes.B0 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes38
	BSF         _flagBotoes+0, 0 
L_leitura_Botoes38:
;LCDMenusFuncionais2.c,377 :: 		if(!avancaMenu) flagBotoes.B1 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes39
	BSF         _flagBotoes+0, 1 
L_leitura_Botoes39:
;LCDMenusFuncionais2.c,379 :: 		if(voltaMenu && flagBotoes.B0){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes42
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes42
L__leitura_Botoes54:
;LCDMenusFuncionais2.c,381 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;LCDMenusFuncionais2.c,382 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais2.c,383 :: 		menuControl--;
	DECF        _menuControl+0, 1 
;LCDMenusFuncionais2.c,385 :: 		if(menuControl == 0) menuControl = numeroMenus;
	MOVF        _menuControl+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes43
	MOVLW       6
	MOVWF       _menuControl+0 
L_leitura_Botoes43:
;LCDMenusFuncionais2.c,387 :: 		} // end if voltaMenu && flagBotoes.B0
L_leitura_Botoes42:
;LCDMenusFuncionais2.c,389 :: 		if(avancaMenu && flagBotoes.B1){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes46
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes46
L__leitura_Botoes53:
;LCDMenusFuncionais2.c,391 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;LCDMenusFuncionais2.c,392 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais2.c,393 :: 		menuControl++;
	INCF        _menuControl+0, 1 
;LCDMenusFuncionais2.c,395 :: 		if(menuControl == (numeroMenus+1)) menuControl = 0x01;
	MOVF        _menuControl+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes47
	MOVLW       1
	MOVWF       _menuControl+0 
L_leitura_Botoes47:
;LCDMenusFuncionais2.c,397 :: 		} // end if avancaMenu && flagBotoes.B1
L_leitura_Botoes46:
;LCDMenusFuncionais2.c,399 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_apaga_Display:

;LCDMenusFuncionais2.c,401 :: 		void apaga_Display(){
;LCDMenusFuncionais2.c,403 :: 		if(apagaDisplay){
	BTFSS       _apagaDisplay+0, BitPos(_apagaDisplay+0) 
	GOTO        L_apaga_Display48
;LCDMenusFuncionais2.c,405 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais2.c,407 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais2.c,409 :: 		} // end if apagaDisplay
L_apaga_Display48:
;LCDMenusFuncionais2.c,411 :: 		} // end void apaga_Display
	RETURN      0
; end of _apaga_Display

_menu1:

;LCDMenusFuncionais2.c,413 :: 		void menu1(){
;LCDMenusFuncionais2.c,415 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais2.c,417 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,418 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,419 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,420 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,421 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,422 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,423 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,424 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,425 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,426 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,427 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,429 :: 		lcd_chr(2, 1, 'I');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,430 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,431 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,432 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,434 :: 		tempControl2 = 0;
	BCF         _tempControl2+0, BitPos(_tempControl2+0) 
;LCDMenusFuncionais2.c,435 :: 		celsius();
	CALL        _celsius+0, 0
;LCDMenusFuncionais2.c,437 :: 		} // end void menu1
	RETURN      0
; end of _menu1

_menu2:

;LCDMenusFuncionais2.c,439 :: 		void menu2(){
;LCDMenusFuncionais2.c,441 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais2.c,443 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,444 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,445 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,446 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,447 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,448 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,449 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,450 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,451 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,452 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,453 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,455 :: 		tempControl2 = 1;
	BSF         _tempControl2+0, BitPos(_tempControl2+0) 
;LCDMenusFuncionais2.c,456 :: 		celsius();
	CALL        _celsius+0, 0
;LCDMenusFuncionais2.c,458 :: 		} // end void menu2
	RETURN      0
; end of _menu2

_menu3:

;LCDMenusFuncionais2.c,461 :: 		void menu3(){
;LCDMenusFuncionais2.c,463 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais2.c,465 :: 		lcd_chr(1, 2, 'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,466 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,467 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,468 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,469 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,470 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,471 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,472 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,473 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,474 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,476 :: 		lcd_chr(2, 1, 'T');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,477 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,478 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,479 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,480 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,481 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,482 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,484 :: 		ADCON0 = 0x05; // Seleciona o canal 1 do conversor AD
	MOVLW       5
	MOVWF       ADCON0+0 
;LCDMenusFuncionais2.c,485 :: 		voltimetro();
	CALL        _voltimetro+0, 0
;LCDMenusFuncionais2.c,487 :: 		} // end void menu3
	RETURN      0
; end of _menu3

_menu4:

;LCDMenusFuncionais2.c,490 :: 		void menu4(){
;LCDMenusFuncionais2.c,492 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais2.c,494 :: 		lcd_chr(1, 2, 'P');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,495 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,496 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,497 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,498 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,499 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,500 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,502 :: 		conta_Pulsos();
	CALL        _conta_Pulsos+0, 0
;LCDMenusFuncionais2.c,504 :: 		} // end void menu4
	RETURN      0
; end of _menu4

_menu5:

;LCDMenusFuncionais2.c,507 :: 		void menu5(){
;LCDMenusFuncionais2.c,509 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais2.c,511 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,512 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,513 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,514 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,515 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,517 :: 		conta_Tempo();
	CALL        _conta_Tempo+0, 0
;LCDMenusFuncionais2.c,519 :: 		} // end void menu5
	RETURN      0
; end of _menu5

_menu6:

;LCDMenusFuncionais2.c,522 :: 		void menu6(){
;LCDMenusFuncionais2.c,524 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais2.c,526 :: 		lcd_chr(1, 2, 'E');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,527 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,528 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,529 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,530 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,531 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,532 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,533 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais2.c,535 :: 		dipSwitch();
	CALL        _dipSwitch+0, 0
;LCDMenusFuncionais2.c,537 :: 		} // end void menu6
	RETURN      0
; end of _menu6

_CustomChar:

;LCDMenusFuncionais2.c,540 :: 		void CustomChar(char pos_row, char pos_char) {
;LCDMenusFuncionais2.c,542 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais2.c,543 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar49:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar50
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
	GOTO        L_CustomChar49
L_CustomChar50:
;LCDMenusFuncionais2.c,544 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais2.c,545 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais2.c,546 :: 		}
	RETURN      0
; end of _CustomChar

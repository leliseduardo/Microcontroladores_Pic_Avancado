
_interrupt:

;LCDSubMenusFuncionais.c,94 :: 		void interrupt(){
;LCDSubMenusFuncionais.c,96 :: 		if(INT0IF_bit){
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;LCDSubMenusFuncionais.c,98 :: 		INT0IF_bit = 0x00;
	BCF         INT0IF_bit+0, 1 
;LCDSubMenusFuncionais.c,100 :: 		contPulsos++;
	MOVLW       1
	ADDWF       _contPulsos+0, 1 
	MOVLW       0
	ADDWFC      _contPulsos+1, 1 
	ADDWFC      _contPulsos+2, 1 
	ADDWFC      _contPulsos+3, 1 
;LCDSubMenusFuncionais.c,102 :: 		} // end if INT0IF_bit
L_interrupt0:
;LCDSubMenusFuncionais.c,104 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt1
;LCDSubMenusFuncionais.c,106 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;LCDSubMenusFuncionais.c,107 :: 		TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
	MOVLW       176
	MOVWF       TMR0L+0 
;LCDSubMenusFuncionais.c,108 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;LCDSubMenusFuncionais.c,110 :: 		contAux++;
	INCF        _contAux+0, 1 
;LCDSubMenusFuncionais.c,112 :: 		if(contAux == 20){
	MOVF        _contAux+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;LCDSubMenusFuncionais.c,114 :: 		contAux = 0x00;
	CLRF        _contAux+0 
;LCDSubMenusFuncionais.c,116 :: 		contTemp++; // Variável da função de temperatura máxima e mínima
	INCF        _contTemp+0, 1 
;LCDSubMenusFuncionais.c,118 :: 		contTempo++;
	MOVLW       1
	ADDWF       _contTempo+0, 1 
	MOVLW       0
	ADDWFC      _contTempo+1, 1 
	ADDWFC      _contTempo+2, 1 
	ADDWFC      _contTempo+3, 1 
;LCDSubMenusFuncionais.c,120 :: 		if(contTemp == 3){
	MOVF        _contTemp+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;LCDSubMenusFuncionais.c,122 :: 		contTemp = 0x00;
	CLRF        _contTemp+0 
;LCDSubMenusFuncionais.c,124 :: 		tempControl = ~tempControl;
	BTG         _tempControl+0, BitPos(_tempControl+0) 
;LCDSubMenusFuncionais.c,126 :: 		} // end if contTemp == 3
L_interrupt3:
;LCDSubMenusFuncionais.c,128 :: 		} // end if contAux == 20
L_interrupt2:
;LCDSubMenusFuncionais.c,130 :: 		} // end if TMR0IF_bit
L_interrupt1:
;LCDSubMenusFuncionais.c,132 :: 		} // end void interrupt
L__interrupt67:
	RETFIE      1
; end of _interrupt

_main:

;LCDSubMenusFuncionais.c,135 :: 		void main() {
;LCDSubMenusFuncionais.c,140 :: 		INTCON = 0xF0; // Habilita a interrupção global, a interrupção externa INT0 e a interrupção por overflow do timer0
	MOVLW       240
	MOVWF       INTCON+0 
;LCDSubMenusFuncionais.c,143 :: 		INTEDG0_bit = 0x01; // Configura a interrupção externa por borda de subida
	BSF         INTEDG0_bit+0, 6 
;LCDSubMenusFuncionais.c,146 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;LCDSubMenusFuncionais.c,147 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;LCDSubMenusFuncionais.c,148 :: 		T0CS_bit = 0x00; // Configura o incremento do timer0 a partir do ciclo de maquina
	BCF         T0CS_bit+0, 5 
;LCDSubMenusFuncionais.c,149 :: 		PSA_bit = 0x01; // Não associa o timer0 ao prescaler, o que equivale ao prescaler 1:1
	BSF         PSA_bit+0, 3 
;LCDSubMenusFuncionais.c,152 :: 		TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
	MOVLW       176
	MOVWF       TMR0L+0 
;LCDSubMenusFuncionais.c,153 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;LCDSubMenusFuncionais.c,156 :: 		ADCON0 = 0x01; // Habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;LCDSubMenusFuncionais.c,157 :: 		ADCON1 = 0x0D; // Configura apenas AN0 e AN1 como entrada analógicas
	MOVLW       13
	MOVWF       ADCON1+0 
;LCDSubMenusFuncionais.c,160 :: 		TRISA = 0xFF; // Configura todo o porta como entrada digital, exceto RA0/AN0 e RA1/AN1, que são entrada analógicas
	MOVLW       255
	MOVWF       TRISA+0 
;LCDSubMenusFuncionais.c,161 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;LCDSubMenusFuncionais.c,162 :: 		PORTB = 0xF9; // Apenas RB1 e RB2 iniciam em Low, pois estão ligadas em Pull-Down
	MOVLW       249
	MOVWF       PORTB+0 
;LCDSubMenusFuncionais.c,164 :: 		tempControl = 0;
	BCF         _tempControl+0, BitPos(_tempControl+0) 
;LCDSubMenusFuncionais.c,165 :: 		tempControl2 = 0;
	BCF         _tempControl2+0, BitPos(_tempControl2+0) 
;LCDSubMenusFuncionais.c,167 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDSubMenusFuncionais.c,169 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;LCDSubMenusFuncionais.c,170 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDSubMenusFuncionais.c,171 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDSubMenusFuncionais.c,174 :: 		while(1){
L_main4:
;LCDSubMenusFuncionais.c,176 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;LCDSubMenusFuncionais.c,178 :: 		switch(menuControl){
	GOTO        L_main6
;LCDSubMenusFuncionais.c,180 :: 		case 0x01: menu1();
L_main8:
	CALL        _menu1+0, 0
;LCDSubMenusFuncionais.c,181 :: 		break;
	GOTO        L_main7
;LCDSubMenusFuncionais.c,182 :: 		case 0x02: menu2();
L_main9:
	CALL        _menu2+0, 0
;LCDSubMenusFuncionais.c,183 :: 		break;
	GOTO        L_main7
;LCDSubMenusFuncionais.c,184 :: 		case 0x03: menu3();
L_main10:
	CALL        _menu3+0, 0
;LCDSubMenusFuncionais.c,185 :: 		break;
	GOTO        L_main7
;LCDSubMenusFuncionais.c,186 :: 		case 0x04: menu4();
L_main11:
	CALL        _menu4+0, 0
;LCDSubMenusFuncionais.c,187 :: 		break;
	GOTO        L_main7
;LCDSubMenusFuncionais.c,188 :: 		case 0x05: menu5();
L_main12:
	CALL        _menu5+0, 0
;LCDSubMenusFuncionais.c,189 :: 		break;
	GOTO        L_main7
;LCDSubMenusFuncionais.c,190 :: 		case 0x06: menu6();
L_main13:
	CALL        _menu6+0, 0
;LCDSubMenusFuncionais.c,191 :: 		break;
	GOTO        L_main7
;LCDSubMenusFuncionais.c,193 :: 		} // end switch menuControl
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
;LCDSubMenusFuncionais.c,195 :: 		} // end loop infinito
	GOTO        L_main4
;LCDSubMenusFuncionais.c,197 :: 		} // end void main
	GOTO        $+0
; end of _main

_celsius:

;LCDSubMenusFuncionais.c,205 :: 		void celsius(){
;LCDSubMenusFuncionais.c,207 :: 		ADCON0 = 0x01; // Seleciona o canal 0 do conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;LCDSubMenusFuncionais.c,209 :: 		media = mediaTemperatura();
	CALL        _mediaTemperatura+0, 0
	MOVF        R0, 0 
	MOVWF       _media+0 
	MOVF        R1, 0 
	MOVWF       _media+1 
;LCDSubMenusFuncionais.c,211 :: 		temperatura = ((media * 5.0)/1024.0);
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
;LCDSubMenusFuncionais.c,212 :: 		temperatura = temperatura * 100.0;
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
;LCDSubMenusFuncionais.c,214 :: 		if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5))
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
	GOTO        L__celsius63
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
	GOTO        L__celsius63
	GOTO        L_celsius16
L__celsius63:
;LCDSubMenusFuncionais.c,215 :: 		ultimaTemperatura = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemperatura+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemperatura+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemperatura+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemperatura+3 
L_celsius16:
;LCDSubMenusFuncionais.c,217 :: 		if(temperatura > temperaturaMaxima) temperaturaMaxima = temperatura;
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
;LCDSubMenusFuncionais.c,219 :: 		if(temperatura < temperaturaMinima) temperaturaMinima = temperatura;
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
;LCDSubMenusFuncionais.c,222 :: 		if(!tempControl2){
	BTFSC       _tempControl2+0, BitPos(_tempControl2+0) 
	GOTO        L_celsius19
;LCDSubMenusFuncionais.c,223 :: 		FloatToStr(ultimaTemperatura, textoTemp);
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
;LCDSubMenusFuncionais.c,225 :: 		if(ultimaTemperatura < 0.05){
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
;LCDSubMenusFuncionais.c,226 :: 		lcd_chr(2, 6, 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,227 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,228 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,229 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,230 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,231 :: 		} // end if ultimaTemperatura < 0.05
	GOTO        L_celsius21
L_celsius20:
;LCDSubMenusFuncionais.c,233 :: 		lcd_chr(2, 6, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,234 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,235 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,236 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,237 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,238 :: 		} // end else
L_celsius21:
;LCDSubMenusFuncionais.c,239 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDSubMenusFuncionais.c,240 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,241 :: 		} // end if !tempControl2
	GOTO        L_celsius22
L_celsius19:
;LCDSubMenusFuncionais.c,243 :: 		if(!tempControl){
	BTFSC       _tempControl+0, BitPos(_tempControl+0) 
	GOTO        L_celsius23
;LCDSubMenusFuncionais.c,244 :: 		FloatToStr(temperaturaMaxima, textoTemp);
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
;LCDSubMenusFuncionais.c,245 :: 		lcd_chr(2, 1, 'M');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,246 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,247 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,248 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,250 :: 		lcd_chr(2, 5, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,251 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,252 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,253 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,254 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,255 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDSubMenusFuncionais.c,256 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,257 :: 		} // end !tempControl
	GOTO        L_celsius24
L_celsius23:
;LCDSubMenusFuncionais.c,259 :: 		FloatToStr(temperaturaMinima, textoTemp);
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
;LCDSubMenusFuncionais.c,260 :: 		lcd_chr(2, 1, 'M');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,261 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,262 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,263 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,265 :: 		lcd_chr(2, 5, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,266 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,267 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,268 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,269 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,270 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDSubMenusFuncionais.c,271 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,272 :: 		} // end else !tempControl
L_celsius24:
;LCDSubMenusFuncionais.c,274 :: 		} // end else !tempControl2
L_celsius22:
;LCDSubMenusFuncionais.c,292 :: 		} // end void celsius
	RETURN      0
; end of _celsius

_mediaTemperatura:

;LCDSubMenusFuncionais.c,294 :: 		int mediaTemperatura(){
;LCDSubMenusFuncionais.c,297 :: 		int adc = 0;
	CLRF        mediaTemperatura_adc_L0+0 
	CLRF        mediaTemperatura_adc_L0+1 
;LCDSubMenusFuncionais.c,299 :: 		for(i = 0; i < 0x64; i++){
	CLRF        mediaTemperatura_i_L0+0 
L_mediaTemperatura25:
	MOVLW       100
	SUBWF       mediaTemperatura_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mediaTemperatura26
;LCDSubMenusFuncionais.c,301 :: 		if(!tempControl) adc += adc_read(0);
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
;LCDSubMenusFuncionais.c,302 :: 		else adc += adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       mediaTemperatura_adc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mediaTemperatura_adc_L0+1, 1 
L_mediaTemperatura29:
;LCDSubMenusFuncionais.c,299 :: 		for(i = 0; i < 0x64; i++){
	INCF        mediaTemperatura_i_L0+0, 1 
;LCDSubMenusFuncionais.c,304 :: 		} // end for
	GOTO        L_mediaTemperatura25
L_mediaTemperatura26:
;LCDSubMenusFuncionais.c,306 :: 		return (adc/0x64);
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        mediaTemperatura_adc_L0+0, 0 
	MOVWF       R0 
	MOVF        mediaTemperatura_adc_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
;LCDSubMenusFuncionais.c,307 :: 		} // end void mediaTemperatura
	RETURN      0
; end of _mediaTemperatura

_CustomChar:

;LCDSubMenusFuncionais.c,309 :: 		void CustomChar(char pos_row, char pos_char) {
;LCDSubMenusFuncionais.c,311 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDSubMenusFuncionais.c,312 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar30:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar31
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
	GOTO        L_CustomChar30
L_CustomChar31:
;LCDSubMenusFuncionais.c,313 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDSubMenusFuncionais.c,314 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,315 :: 		}
	RETURN      0
; end of _CustomChar

_voltimetro:

;LCDSubMenusFuncionais.c,317 :: 		void voltimetro(){
;LCDSubMenusFuncionais.c,319 :: 		char mil = 0x00, cen = 0x00, dez = 0x00, uni = 0x00;
;LCDSubMenusFuncionais.c,320 :: 		int adc = 0;
;LCDSubMenusFuncionais.c,322 :: 		adc = adc_read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;LCDSubMenusFuncionais.c,324 :: 		volt = ((adc * 5.0)/1024.0);
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
;LCDSubMenusFuncionais.c,326 :: 		FloatToStr(volt, textoVoltimetro);
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
;LCDSubMenusFuncionais.c,328 :: 		if(volt < 0.01){
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
	GOTO        L_voltimetro33
;LCDSubMenusFuncionais.c,329 :: 		lcd_chr(2, 8, 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,330 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,331 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,332 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,333 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,334 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,335 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,336 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,337 :: 		}// end if volt < 0.01
	GOTO        L_voltimetro34
L_voltimetro33:
;LCDSubMenusFuncionais.c,339 :: 		lcd_chr(2, 8, textoVoltimetro[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoVoltimetro+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,340 :: 		lcd_chr_cp(textoVoltimetro[1]);
	MOVF        _textoVoltimetro+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,341 :: 		lcd_chr_cp(textoVoltimetro[2]);
	MOVF        _textoVoltimetro+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,342 :: 		lcd_chr_cp(textoVoltimetro[3]);
	MOVF        _textoVoltimetro+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,343 :: 		lcd_chr_cp(textoVoltimetro[4]);
	MOVF        _textoVoltimetro+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,344 :: 		if(volt < 1){
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
	GOTO        L_voltimetro35
;LCDSubMenusFuncionais.c,345 :: 		lcd_chr_cp('E');
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,346 :: 		lcd_chr_cp('-');
	MOVLW       45
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,347 :: 		lcd_chr_cp(49); // numero "1"
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,348 :: 		} // end if volt < 1
	GOTO        L_voltimetro36
L_voltimetro35:
;LCDSubMenusFuncionais.c,350 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,351 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,352 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,353 :: 		} // end else
L_voltimetro36:
;LCDSubMenusFuncionais.c,354 :: 		lcd_chr(2, 16, 'V');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,355 :: 		} // end else
L_voltimetro34:
;LCDSubMenusFuncionais.c,357 :: 		} // end voltimetro
	RETURN      0
; end of _voltimetro

_conta_Pulsos:

;LCDSubMenusFuncionais.c,359 :: 		void conta_Pulsos(){
;LCDSubMenusFuncionais.c,361 :: 		LongToStr(contPulsos, textoPulsos);
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
;LCDSubMenusFuncionais.c,363 :: 		lcd_Out(2, 2, textoPulsos);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _textoPulsos+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_textoPulsos+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDSubMenusFuncionais.c,365 :: 		} // end void conta_Pulsos
	RETURN      0
; end of _conta_Pulsos

_conta_Tempo:

;LCDSubMenusFuncionais.c,367 :: 		void conta_Tempo(){
;LCDSubMenusFuncionais.c,369 :: 		LongToStr(contTempo, textoTempo);
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
;LCDSubMenusFuncionais.c,371 :: 		lcd_out(2, 2, textoTempo);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _textoTempo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_textoTempo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDSubMenusFuncionais.c,373 :: 		} // end void conta_Tempo
	RETURN      0
; end of _conta_Tempo

_dipSwitch:

;LCDSubMenusFuncionais.c,375 :: 		void dipSwitch(){
;LCDSubMenusFuncionais.c,377 :: 		if(!chave1) lcd_out(2, 1, "Ch1:Off");
	BTFSC       RB1_bit+0, 1 
	GOTO        L_dipSwitch37
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LCDSubMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LCDSubMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dipSwitch38
L_dipSwitch37:
;LCDSubMenusFuncionais.c,378 :: 		else lcd_out(2, 1, "Ch1:On ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_LCDSubMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_LCDSubMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_dipSwitch38:
;LCDSubMenusFuncionais.c,380 :: 		if(!chave2) lcd_out(2, 9, "Ch2:Off");
	BTFSC       RB2_bit+0, 2 
	GOTO        L_dipSwitch39
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_LCDSubMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_LCDSubMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dipSwitch40
L_dipSwitch39:
;LCDSubMenusFuncionais.c,381 :: 		else lcd_out(2, 9, "Ch2:On ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_LCDSubMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_LCDSubMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_dipSwitch40:
;LCDSubMenusFuncionais.c,383 :: 		} // end void dipSwitch
	RETURN      0
; end of _dipSwitch

_leitura_Botoes:

;LCDSubMenusFuncionais.c,392 :: 		void leitura_Botoes(){
;LCDSubMenusFuncionais.c,394 :: 		if(!voltaMenu) flagBotoes.B0 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes41
	BSF         _flagBotoes+0, 0 
L_leitura_Botoes41:
;LCDSubMenusFuncionais.c,395 :: 		if(!avancaMenu) flagBotoes.B1 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes42
	BSF         _flagBotoes+0, 1 
L_leitura_Botoes42:
;LCDSubMenusFuncionais.c,396 :: 		if(!enter) flagBotoes.B2 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_leitura_Botoes43
	BSF         _flagBotoes+0, 2 
L_leitura_Botoes43:
;LCDSubMenusFuncionais.c,398 :: 		if(voltaMenu && flagBotoes.B0){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes46
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes46
L__leitura_Botoes66:
;LCDSubMenusFuncionais.c,400 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;LCDSubMenusFuncionais.c,401 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDSubMenusFuncionais.c,402 :: 		menuControl--;
	DECF        _menuControl+0, 1 
;LCDSubMenusFuncionais.c,404 :: 		if(menuControl == 0) menuControl = numeroMenus;
	MOVF        _menuControl+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes47
	MOVLW       6
	MOVWF       _menuControl+0 
L_leitura_Botoes47:
;LCDSubMenusFuncionais.c,406 :: 		} // end if voltaMenu && flagBotoes.B0
L_leitura_Botoes46:
;LCDSubMenusFuncionais.c,408 :: 		if(avancaMenu && flagBotoes.B1){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes50
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes50
L__leitura_Botoes65:
;LCDSubMenusFuncionais.c,410 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;LCDSubMenusFuncionais.c,411 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDSubMenusFuncionais.c,412 :: 		menuControl++;
	INCF        _menuControl+0, 1 
;LCDSubMenusFuncionais.c,414 :: 		if(menuControl == (numeroMenus+1)) menuControl = 0x01;
	MOVF        _menuControl+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes51
	MOVLW       1
	MOVWF       _menuControl+0 
L_leitura_Botoes51:
;LCDSubMenusFuncionais.c,416 :: 		} // end if avancaMenu && flagBotoes.B1
L_leitura_Botoes50:
;LCDSubMenusFuncionais.c,419 :: 		if(enter && flagBotoes.B2){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_leitura_Botoes54
	BTFSS       _flagBotoes+0, 2 
	GOTO        L_leitura_Botoes54
L__leitura_Botoes64:
;LCDSubMenusFuncionais.c,421 :: 		flagBotoes.B2 = 0x00;
	BCF         _flagBotoes+0, 2 
;LCDSubMenusFuncionais.c,422 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDSubMenusFuncionais.c,423 :: 		subMenuControl++;
	INCF        _subMenuControl+0, 1 
;LCDSubMenusFuncionais.c,425 :: 		if(subMenuControl > 0x03) subMenuControl = 0x00;
	MOVF        _subMenuControl+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_leitura_Botoes55
	CLRF        _subMenuControl+0 
L_leitura_Botoes55:
;LCDSubMenusFuncionais.c,427 :: 		} // end if enter && flagBotoes.B2
L_leitura_Botoes54:
;LCDSubMenusFuncionais.c,429 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_apaga_Display:

;LCDSubMenusFuncionais.c,431 :: 		void apaga_Display(){
;LCDSubMenusFuncionais.c,433 :: 		if(apagaDisplay){
	BTFSS       _apagaDisplay+0, BitPos(_apagaDisplay+0) 
	GOTO        L_apaga_Display56
;LCDSubMenusFuncionais.c,435 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDSubMenusFuncionais.c,437 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDSubMenusFuncionais.c,439 :: 		} // end if apagaDisplay
L_apaga_Display56:
;LCDSubMenusFuncionais.c,441 :: 		} // end void apaga_Display
	RETURN      0
; end of _apaga_Display

_menu1:

;LCDSubMenusFuncionais.c,443 :: 		void menu1(){
;LCDSubMenusFuncionais.c,445 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDSubMenusFuncionais.c,447 :: 		switch(subMenuControl){
	GOTO        L_menu157
;LCDSubMenusFuncionais.c,448 :: 		case 0x00: lcd_chr(1, 2, 'T');
L_menu159:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,449 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,450 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,451 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,452 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,453 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,454 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,455 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,456 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,457 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,458 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,460 :: 		lcd_chr(2, 1, 'I');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,461 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,462 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,463 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,465 :: 		tempControl2 = 0;
	BCF         _tempControl2+0, BitPos(_tempControl2+0) 
;LCDSubMenusFuncionais.c,466 :: 		celsius();
	CALL        _celsius+0, 0
;LCDSubMenusFuncionais.c,467 :: 		break;
	GOTO        L_menu158
;LCDSubMenusFuncionais.c,468 :: 		case 0x01: subMenu_1a();
L_menu160:
	CALL        _subMenu_1a+0, 0
;LCDSubMenusFuncionais.c,469 :: 		break;
	GOTO        L_menu158
;LCDSubMenusFuncionais.c,470 :: 		case 0x02: subMenu_1b();
L_menu161:
	CALL        _subMenu_1b+0, 0
;LCDSubMenusFuncionais.c,471 :: 		break;
	GOTO        L_menu158
;LCDSubMenusFuncionais.c,472 :: 		case 0x03: subMenu_1c();
L_menu162:
	CALL        _subMenu_1c+0, 0
;LCDSubMenusFuncionais.c,473 :: 		break;
	GOTO        L_menu158
;LCDSubMenusFuncionais.c,474 :: 		} // end switch subMenuControl
L_menu157:
	MOVF        _subMenuControl+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_menu159
	MOVF        _subMenuControl+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_menu160
	MOVF        _subMenuControl+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_menu161
	MOVF        _subMenuControl+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_menu162
L_menu158:
;LCDSubMenusFuncionais.c,476 :: 		} // end void menu1
	RETURN      0
; end of _menu1

_menu2:

;LCDSubMenusFuncionais.c,478 :: 		void menu2(){
;LCDSubMenusFuncionais.c,480 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDSubMenusFuncionais.c,482 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,483 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,484 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,485 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,486 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,487 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,488 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,489 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,490 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,491 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,492 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,494 :: 		tempControl2 = 1;
	BSF         _tempControl2+0, BitPos(_tempControl2+0) 
;LCDSubMenusFuncionais.c,495 :: 		celsius();
	CALL        _celsius+0, 0
;LCDSubMenusFuncionais.c,497 :: 		} // end void menu2
	RETURN      0
; end of _menu2

_menu3:

;LCDSubMenusFuncionais.c,500 :: 		void menu3(){
;LCDSubMenusFuncionais.c,502 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDSubMenusFuncionais.c,504 :: 		lcd_chr(1, 2, 'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,505 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,506 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,507 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,508 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,509 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,510 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,511 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,512 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,513 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,515 :: 		lcd_chr(2, 1, 'T');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,516 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,517 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,518 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,519 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,520 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,521 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,523 :: 		ADCON0 = 0x05; // Seleciona o canal 1 do conversor AD
	MOVLW       5
	MOVWF       ADCON0+0 
;LCDSubMenusFuncionais.c,524 :: 		voltimetro();
	CALL        _voltimetro+0, 0
;LCDSubMenusFuncionais.c,526 :: 		} // end void menu3
	RETURN      0
; end of _menu3

_menu4:

;LCDSubMenusFuncionais.c,529 :: 		void menu4(){
;LCDSubMenusFuncionais.c,531 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDSubMenusFuncionais.c,533 :: 		lcd_chr(1, 2, 'P');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,534 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,535 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,536 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,537 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,538 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,539 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,541 :: 		conta_Pulsos();
	CALL        _conta_Pulsos+0, 0
;LCDSubMenusFuncionais.c,543 :: 		} // end void menu4
	RETURN      0
; end of _menu4

_menu5:

;LCDSubMenusFuncionais.c,546 :: 		void menu5(){
;LCDSubMenusFuncionais.c,548 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDSubMenusFuncionais.c,550 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,551 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,552 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,553 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,554 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,556 :: 		conta_Tempo();
	CALL        _conta_Tempo+0, 0
;LCDSubMenusFuncionais.c,558 :: 		} // end void menu5
	RETURN      0
; end of _menu5

_menu6:

;LCDSubMenusFuncionais.c,561 :: 		void menu6(){
;LCDSubMenusFuncionais.c,563 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDSubMenusFuncionais.c,565 :: 		lcd_chr(1, 2, 'E');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,566 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,567 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,568 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,569 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,570 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,571 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,572 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,574 :: 		dipSwitch();
	CALL        _dipSwitch+0, 0
;LCDSubMenusFuncionais.c,576 :: 		} // end void menu6
	RETURN      0
; end of _menu6

_subMenu_1a:

;LCDSubMenusFuncionais.c,585 :: 		void subMenu_1a(){
;LCDSubMenusFuncionais.c,587 :: 		lcd_chr(1, 2, 'S');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,588 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,589 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,590 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,591 :: 		lcd_chr_cp('M');
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,592 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,593 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,594 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,595 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,596 :: 		lcd_chr_cp('1');
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,597 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,599 :: 		FloatToStr(temperaturaMaxima, textoTemp);
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
;LCDSubMenusFuncionais.c,601 :: 		lcd_chr(2, 1, 'M');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,602 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,603 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,604 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,606 :: 		lcd_chr(2, 5, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,607 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,608 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,609 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,610 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,611 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDSubMenusFuncionais.c,612 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,615 :: 		} // end void subMenu_1a
	RETURN      0
; end of _subMenu_1a

_subMenu_1b:

;LCDSubMenusFuncionais.c,618 :: 		void subMenu_1b(){
;LCDSubMenusFuncionais.c,620 :: 		lcd_chr(1, 2, 'S');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,621 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,622 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,623 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,624 :: 		lcd_chr_cp('M');
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,625 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,626 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,627 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,628 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,629 :: 		lcd_chr_cp('1');
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,630 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,632 :: 		FloatToStr(temperaturaMinima, textoTemp);
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
;LCDSubMenusFuncionais.c,634 :: 		lcd_chr(2, 1, 'M');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,635 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,636 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,637 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,639 :: 		lcd_chr(2, 5, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,640 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,641 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,642 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,643 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,644 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDSubMenusFuncionais.c,645 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,647 :: 		} // end void subMenu_1b
	RETURN      0
; end of _subMenu_1b

_subMenu_1c:

;LCDSubMenusFuncionais.c,650 :: 		void subMenu_1c(){
;LCDSubMenusFuncionais.c,652 :: 		lcd_chr(1, 2, 'S');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,653 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,654 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,655 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,656 :: 		lcd_chr_cp('M');
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,657 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,658 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,659 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,660 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,661 :: 		lcd_chr_cp('1');
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,662 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,664 :: 		FloatToStr(((temperaturaMaxima+temperaturaMinima)/2), textoTemp);
	MOVF        _temperaturaMaxima+0, 0 
	MOVWF       R0 
	MOVF        _temperaturaMaxima+1, 0 
	MOVWF       R1 
	MOVF        _temperaturaMaxima+2, 0 
	MOVWF       R2 
	MOVF        _temperaturaMaxima+3, 0 
	MOVWF       R3 
	MOVF        _temperaturaMinima+0, 0 
	MOVWF       R4 
	MOVF        _temperaturaMinima+1, 0 
	MOVWF       R5 
	MOVF        _temperaturaMinima+2, 0 
	MOVWF       R6 
	MOVF        _temperaturaMinima+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _textoTemp+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_textoTemp+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;LCDSubMenusFuncionais.c,666 :: 		lcd_chr(2, 1, 'M');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,667 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,668 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,669 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,671 :: 		lcd_chr(2, 5, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,672 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,673 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,674 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,675 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSubMenusFuncionais.c,676 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDSubMenusFuncionais.c,677 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSubMenusFuncionais.c,679 :: 		} // end void subMenu_1c
	RETURN      0
; end of _subMenu_1c

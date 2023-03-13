
_interrupt:

;LCDMenusFuncionais.c,127 :: 		void interrupt(){
;LCDMenusFuncionais.c,129 :: 		if(INT0IF_bit){
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;LCDMenusFuncionais.c,131 :: 		INT0IF_bit = 0x00;
	BCF         INT0IF_bit+0, 1 
;LCDMenusFuncionais.c,133 :: 		contPulsos++;
	MOVLW       1
	ADDWF       _contPulsos+0, 1 
	MOVLW       0
	ADDWFC      _contPulsos+1, 1 
	ADDWFC      _contPulsos+2, 1 
	ADDWFC      _contPulsos+3, 1 
;LCDMenusFuncionais.c,135 :: 		} // end if INT0IF_bit
L_interrupt0:
;LCDMenusFuncionais.c,137 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt1
;LCDMenusFuncionais.c,139 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;LCDMenusFuncionais.c,140 :: 		TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
	MOVLW       176
	MOVWF       TMR0L+0 
;LCDMenusFuncionais.c,141 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;LCDMenusFuncionais.c,143 :: 		contAux++;
	INCF        _contAux+0, 1 
;LCDMenusFuncionais.c,145 :: 		if(contAux == 20){
	MOVF        _contAux+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;LCDMenusFuncionais.c,147 :: 		contAux = 0x00;
	CLRF        _contAux+0 
;LCDMenusFuncionais.c,149 :: 		contTempo++;
	MOVLW       1
	ADDWF       _contTempo+0, 1 
	MOVLW       0
	ADDWFC      _contTempo+1, 1 
	ADDWFC      _contTempo+2, 1 
	ADDWFC      _contTempo+3, 1 
;LCDMenusFuncionais.c,151 :: 		} // end if contAux == 20
L_interrupt2:
;LCDMenusFuncionais.c,153 :: 		} // end if TMR0IF_bit
L_interrupt1:
;LCDMenusFuncionais.c,155 :: 		} // end void interrupt
L__interrupt48:
	RETFIE      1
; end of _interrupt

_main:

;LCDMenusFuncionais.c,158 :: 		void main() {
;LCDMenusFuncionais.c,163 :: 		INTCON = 0xF0; // Habilita a interrupção global, a interrupção externa INT0 e a interrupção por overflow do timer0
	MOVLW       240
	MOVWF       INTCON+0 
;LCDMenusFuncionais.c,166 :: 		INTEDG0_bit = 0x01; // Configura a interrupção externa por borda de subida
	BSF         INTEDG0_bit+0, 6 
;LCDMenusFuncionais.c,169 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;LCDMenusFuncionais.c,170 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;LCDMenusFuncionais.c,171 :: 		T0CS_bit = 0x00; // Configura o incremento do timer0 a partir do ciclo de maquina
	BCF         T0CS_bit+0, 5 
;LCDMenusFuncionais.c,172 :: 		PSA_bit = 0x01; // Não associa o timer0 ao prescaler, o que equivale ao prescaler 1:1
	BSF         PSA_bit+0, 3 
;LCDMenusFuncionais.c,175 :: 		TMR0L = 0xB0; // Inicia o timer0 em 15536, para uma contagem de 50000 e um tempo de overflow de 50ms
	MOVLW       176
	MOVWF       TMR0L+0 
;LCDMenusFuncionais.c,176 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;LCDMenusFuncionais.c,179 :: 		ADCON0 = 0x01; // Habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;LCDMenusFuncionais.c,180 :: 		ADCON1 = 0x0D; // Configura apenas AN0 e AN1 como entrada analógicas
	MOVLW       13
	MOVWF       ADCON1+0 
;LCDMenusFuncionais.c,183 :: 		TRISA = 0xFF; // Configura todo o porta como entrada digital, exceto RA0/AN0 e RA1/AN1, que são entrada analógicas
	MOVLW       255
	MOVWF       TRISA+0 
;LCDMenusFuncionais.c,184 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;LCDMenusFuncionais.c,185 :: 		PORTB = 0xF9; // Apenas RB1 e RB2 iniciam em Low, pois estão ligadas em Pull-Down
	MOVLW       249
	MOVWF       PORTB+0 
;LCDMenusFuncionais.c,187 :: 		tempControl = 0;
	BCF         _tempControl+0, BitPos(_tempControl+0) 
;LCDMenusFuncionais.c,189 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais.c,191 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;LCDMenusFuncionais.c,192 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais.c,193 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais.c,196 :: 		while(1){
L_main3:
;LCDMenusFuncionais.c,198 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;LCDMenusFuncionais.c,200 :: 		switch(menuControl){
	GOTO        L_main5
;LCDMenusFuncionais.c,202 :: 		case 0x01: menu1();
L_main7:
	CALL        _menu1+0, 0
;LCDMenusFuncionais.c,203 :: 		break;
	GOTO        L_main6
;LCDMenusFuncionais.c,204 :: 		case 0x02: menu2();
L_main8:
	CALL        _menu2+0, 0
;LCDMenusFuncionais.c,205 :: 		break;
	GOTO        L_main6
;LCDMenusFuncionais.c,206 :: 		case 0x03: menu3();
L_main9:
	CALL        _menu3+0, 0
;LCDMenusFuncionais.c,207 :: 		break;
	GOTO        L_main6
;LCDMenusFuncionais.c,208 :: 		case 0x04: menu4();
L_main10:
	CALL        _menu4+0, 0
;LCDMenusFuncionais.c,209 :: 		break;
	GOTO        L_main6
;LCDMenusFuncionais.c,210 :: 		case 0x05: menu5();
L_main11:
	CALL        _menu5+0, 0
;LCDMenusFuncionais.c,211 :: 		break;
	GOTO        L_main6
;LCDMenusFuncionais.c,212 :: 		case 0x06: menu6();
L_main12:
	CALL        _menu6+0, 0
;LCDMenusFuncionais.c,213 :: 		break;
	GOTO        L_main6
;LCDMenusFuncionais.c,215 :: 		} // end switch menuControl
L_main5:
	MOVF        _menuControl+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVF        _menuControl+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        _menuControl+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVF        _menuControl+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        _menuControl+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _menuControl+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
L_main6:
;LCDMenusFuncionais.c,217 :: 		} // end loop infinito
	GOTO        L_main3
;LCDMenusFuncionais.c,219 :: 		} // end void main
	GOTO        $+0
; end of _main

_celsius:

;LCDMenusFuncionais.c,227 :: 		void celsius(){
;LCDMenusFuncionais.c,229 :: 		ADCON0 = 0x01; // Seleciona o canal 0 do conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;LCDMenusFuncionais.c,231 :: 		media = mediaTemperatura();
	CALL        _mediaTemperatura+0, 0
	MOVF        R0, 0 
	MOVWF       _media+0 
	MOVF        R1, 0 
	MOVWF       _media+1 
;LCDMenusFuncionais.c,233 :: 		temperatura = ((media * 5.0)/1024.0);
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
;LCDMenusFuncionais.c,234 :: 		temperatura = temperatura * 100.0;
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
;LCDMenusFuncionais.c,236 :: 		if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5))
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
	GOTO        L__celsius45
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
	GOTO        L__celsius45
	GOTO        L_celsius15
L__celsius45:
;LCDMenusFuncionais.c,237 :: 		ultimaTemperatura = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemperatura+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemperatura+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemperatura+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemperatura+3 
L_celsius15:
;LCDMenusFuncionais.c,239 :: 		FloatToStr(ultimaTemperatura, textoTemp);
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
;LCDMenusFuncionais.c,241 :: 		if(ultimaTemperatura < 0.05){
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
	GOTO        L_celsius16
;LCDMenusFuncionais.c,242 :: 		lcd_chr(2, 6, 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,243 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,244 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,245 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,246 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,247 :: 		} // end if ultimaTemperatura < 0.05
	GOTO        L_celsius17
L_celsius16:
;LCDMenusFuncionais.c,249 :: 		lcd_chr(2, 6, textoTemp[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoTemp+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,250 :: 		lcd_chr_cp(textoTemp[1]);
	MOVF        _textoTemp+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,251 :: 		lcd_chr_cp(textoTemp[2]);
	MOVF        _textoTemp+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,252 :: 		lcd_chr_cp(textoTemp[3]);
	MOVF        _textoTemp+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,253 :: 		lcd_chr_cp(textoTemp[4]);
	MOVF        _textoTemp+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,254 :: 		} // end else
L_celsius17:
;LCDMenusFuncionais.c,255 :: 		customChar(2, 13);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       13
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;LCDMenusFuncionais.c,256 :: 		lcd_chr(2, 14, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,274 :: 		} // end void celsius
	RETURN      0
; end of _celsius

_mediaTemperatura:

;LCDMenusFuncionais.c,276 :: 		int mediaTemperatura(){
;LCDMenusFuncionais.c,279 :: 		int adc = 0;
	CLRF        mediaTemperatura_adc_L0+0 
	CLRF        mediaTemperatura_adc_L0+1 
;LCDMenusFuncionais.c,281 :: 		for(i = 0; i < 0x64; i++){
	CLRF        mediaTemperatura_i_L0+0 
L_mediaTemperatura18:
	MOVLW       100
	SUBWF       mediaTemperatura_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mediaTemperatura19
;LCDMenusFuncionais.c,283 :: 		if(!tempControl) adc += adc_read(0);
	BTFSC       _tempControl+0, BitPos(_tempControl+0) 
	GOTO        L_mediaTemperatura21
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       mediaTemperatura_adc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mediaTemperatura_adc_L0+1, 1 
	GOTO        L_mediaTemperatura22
L_mediaTemperatura21:
;LCDMenusFuncionais.c,284 :: 		else adc += adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       mediaTemperatura_adc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mediaTemperatura_adc_L0+1, 1 
L_mediaTemperatura22:
;LCDMenusFuncionais.c,281 :: 		for(i = 0; i < 0x64; i++){
	INCF        mediaTemperatura_i_L0+0, 1 
;LCDMenusFuncionais.c,286 :: 		} // end for
	GOTO        L_mediaTemperatura18
L_mediaTemperatura19:
;LCDMenusFuncionais.c,288 :: 		return (adc/0x64);
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        mediaTemperatura_adc_L0+0, 0 
	MOVWF       R0 
	MOVF        mediaTemperatura_adc_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
;LCDMenusFuncionais.c,289 :: 		} // end void mediaTemperatura
	RETURN      0
; end of _mediaTemperatura

_voltimetro:

;LCDMenusFuncionais.c,291 :: 		void voltimetro(){
;LCDMenusFuncionais.c,293 :: 		char mil = 0x00, cen = 0x00, dez = 0x00, uni = 0x00;
;LCDMenusFuncionais.c,294 :: 		int adc = 0;
;LCDMenusFuncionais.c,296 :: 		adc = adc_read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;LCDMenusFuncionais.c,298 :: 		volt = ((adc * 5.0)/1024.0);
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
;LCDMenusFuncionais.c,300 :: 		FloatToStr(volt, textoVoltimetro);
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
;LCDMenusFuncionais.c,302 :: 		if(volt < 0.01){
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
	GOTO        L_voltimetro23
;LCDMenusFuncionais.c,303 :: 		lcd_chr(2, 8, 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,304 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,305 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,306 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,307 :: 		lcd_chr_cp(48);
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,308 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,309 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,310 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,311 :: 		}// end if volt < 0.01
	GOTO        L_voltimetro24
L_voltimetro23:
;LCDMenusFuncionais.c,313 :: 		lcd_chr(2, 8, textoVoltimetro[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _textoVoltimetro+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,314 :: 		lcd_chr_cp(textoVoltimetro[1]);
	MOVF        _textoVoltimetro+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,315 :: 		lcd_chr_cp(textoVoltimetro[2]);
	MOVF        _textoVoltimetro+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,316 :: 		lcd_chr_cp(textoVoltimetro[3]);
	MOVF        _textoVoltimetro+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,317 :: 		lcd_chr_cp(textoVoltimetro[4]);
	MOVF        _textoVoltimetro+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,318 :: 		if(volt < 1){
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
	GOTO        L_voltimetro25
;LCDMenusFuncionais.c,319 :: 		lcd_chr_cp('E');
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,320 :: 		lcd_chr_cp('-');
	MOVLW       45
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,321 :: 		lcd_chr_cp(49); // numero "1"
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,322 :: 		} // end if volt < 1
	GOTO        L_voltimetro26
L_voltimetro25:
;LCDMenusFuncionais.c,324 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,325 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,326 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,327 :: 		} // end else
L_voltimetro26:
;LCDMenusFuncionais.c,328 :: 		lcd_chr(2, 16, 'V');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,329 :: 		} // end else
L_voltimetro24:
;LCDMenusFuncionais.c,331 :: 		} // end voltimetro
	RETURN      0
; end of _voltimetro

_conta_Pulsos:

;LCDMenusFuncionais.c,333 :: 		void conta_Pulsos(){
;LCDMenusFuncionais.c,335 :: 		LongToStr(contPulsos, textoPulsos);
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
;LCDMenusFuncionais.c,337 :: 		lcd_Out(2, 2, textoPulsos);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _textoPulsos+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_textoPulsos+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDMenusFuncionais.c,339 :: 		} // end void conta_Pulsos
	RETURN      0
; end of _conta_Pulsos

_conta_Tempo:

;LCDMenusFuncionais.c,341 :: 		void conta_Tempo(){
;LCDMenusFuncionais.c,343 :: 		LongToStr(contTempo, textoTempo);
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
;LCDMenusFuncionais.c,345 :: 		lcd_out(2, 2, textoTempo);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _textoTempo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_textoTempo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCDMenusFuncionais.c,347 :: 		} // end void conta_Tempo
	RETURN      0
; end of _conta_Tempo

_dipSwitch:

;LCDMenusFuncionais.c,349 :: 		void dipSwitch(){
;LCDMenusFuncionais.c,351 :: 		if(!chave1) lcd_out(2, 1, "Ch1:Off");
	BTFSC       RB1_bit+0, 1 
	GOTO        L_dipSwitch27
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LCDMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LCDMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dipSwitch28
L_dipSwitch27:
;LCDMenusFuncionais.c,352 :: 		else lcd_out(2, 1, "Ch1:On ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_LCDMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_LCDMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_dipSwitch28:
;LCDMenusFuncionais.c,354 :: 		if(!chave2) lcd_out(2, 9, "Ch2:Off");
	BTFSC       RB2_bit+0, 2 
	GOTO        L_dipSwitch29
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_LCDMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_LCDMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dipSwitch30
L_dipSwitch29:
;LCDMenusFuncionais.c,355 :: 		else lcd_out(2, 9, "Ch2:On ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_LCDMenusFuncionais+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_LCDMenusFuncionais+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_dipSwitch30:
;LCDMenusFuncionais.c,357 :: 		} // end void dipSwitch
	RETURN      0
; end of _dipSwitch

_leitura_Botoes:

;LCDMenusFuncionais.c,366 :: 		void leitura_Botoes(){
;LCDMenusFuncionais.c,368 :: 		if(!voltaMenu) flagBotoes.B0 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes31
	BSF         _flagBotoes+0, 0 
L_leitura_Botoes31:
;LCDMenusFuncionais.c,369 :: 		if(!avancaMenu) flagBotoes.B1 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes32
	BSF         _flagBotoes+0, 1 
L_leitura_Botoes32:
;LCDMenusFuncionais.c,371 :: 		if(voltaMenu && flagBotoes.B0){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes35
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes35
L__leitura_Botoes47:
;LCDMenusFuncionais.c,373 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;LCDMenusFuncionais.c,374 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais.c,375 :: 		menuControl--;
	DECF        _menuControl+0, 1 
;LCDMenusFuncionais.c,377 :: 		if(menuControl == 0) menuControl = numeroMenus;
	MOVF        _menuControl+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes36
	MOVLW       6
	MOVWF       _menuControl+0 
L_leitura_Botoes36:
;LCDMenusFuncionais.c,379 :: 		} // end if voltaMenu && flagBotoes.B0
L_leitura_Botoes35:
;LCDMenusFuncionais.c,381 :: 		if(avancaMenu && flagBotoes.B1){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes39
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes39
L__leitura_Botoes46:
;LCDMenusFuncionais.c,383 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;LCDMenusFuncionais.c,384 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais.c,385 :: 		menuControl++;
	INCF        _menuControl+0, 1 
;LCDMenusFuncionais.c,387 :: 		if(menuControl == (numeroMenus+1)) menuControl = 0x01;
	MOVF        _menuControl+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes40
	MOVLW       1
	MOVWF       _menuControl+0 
L_leitura_Botoes40:
;LCDMenusFuncionais.c,389 :: 		} // end if avancaMenu && flagBotoes.B1
L_leitura_Botoes39:
;LCDMenusFuncionais.c,391 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_apaga_Display:

;LCDMenusFuncionais.c,393 :: 		void apaga_Display(){
;LCDMenusFuncionais.c,395 :: 		if(apagaDisplay){
	BTFSS       _apagaDisplay+0, BitPos(_apagaDisplay+0) 
	GOTO        L_apaga_Display41
;LCDMenusFuncionais.c,397 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusFuncionais.c,399 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais.c,401 :: 		} // end if apagaDisplay
L_apaga_Display41:
;LCDMenusFuncionais.c,403 :: 		} // end void apaga_Display
	RETURN      0
; end of _apaga_Display

_menu1:

;LCDMenusFuncionais.c,405 :: 		void menu1(){
;LCDMenusFuncionais.c,407 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais.c,409 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,410 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,411 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,412 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,413 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,414 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,415 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,416 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,417 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,418 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,419 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,421 :: 		lcd_chr(2, 1, 'I');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,422 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,423 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,424 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,426 :: 		tempControl = 0;
	BCF         _tempControl+0, BitPos(_tempControl+0) 
;LCDMenusFuncionais.c,427 :: 		celsius();
	CALL        _celsius+0, 0
;LCDMenusFuncionais.c,429 :: 		} // end void menu1
	RETURN      0
; end of _menu1

_menu2:

;LCDMenusFuncionais.c,431 :: 		void menu2(){
;LCDMenusFuncionais.c,433 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais.c,435 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,436 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,437 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,438 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,439 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,440 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,441 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,442 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,443 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,444 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,445 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,447 :: 		lcd_chr(2, 1, 'E');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,448 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,449 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,450 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,452 :: 		tempControl = 1;
	BSF         _tempControl+0, BitPos(_tempControl+0) 
;LCDMenusFuncionais.c,453 :: 		celsius();
	CALL        _celsius+0, 0
;LCDMenusFuncionais.c,455 :: 		} // end void menu2
	RETURN      0
; end of _menu2

_menu3:

;LCDMenusFuncionais.c,458 :: 		void menu3(){
;LCDMenusFuncionais.c,460 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais.c,462 :: 		lcd_chr(1, 2, 'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,463 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,464 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,465 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,466 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,467 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,468 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,469 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,470 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,471 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,473 :: 		lcd_chr(2, 1, 'T');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,474 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,475 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,476 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,477 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,478 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,479 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,481 :: 		ADCON0 = 0x05; // Seleciona o canal 1 do conversor AD
	MOVLW       5
	MOVWF       ADCON0+0 
;LCDMenusFuncionais.c,482 :: 		voltimetro();
	CALL        _voltimetro+0, 0
;LCDMenusFuncionais.c,484 :: 		} // end void menu3
	RETURN      0
; end of _menu3

_menu4:

;LCDMenusFuncionais.c,487 :: 		void menu4(){
;LCDMenusFuncionais.c,489 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais.c,491 :: 		lcd_chr(1, 2, 'P');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,492 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,493 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,494 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,495 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,496 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,497 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,499 :: 		conta_Pulsos();
	CALL        _conta_Pulsos+0, 0
;LCDMenusFuncionais.c,501 :: 		} // end void menu4
	RETURN      0
; end of _menu4

_menu5:

;LCDMenusFuncionais.c,504 :: 		void menu5(){
;LCDMenusFuncionais.c,506 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais.c,508 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,509 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,510 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,511 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,512 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,514 :: 		conta_Tempo();
	CALL        _conta_Tempo+0, 0
;LCDMenusFuncionais.c,516 :: 		} // end void menu5
	RETURN      0
; end of _menu5

_menu6:

;LCDMenusFuncionais.c,519 :: 		void menu6(){
;LCDMenusFuncionais.c,521 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusFuncionais.c,523 :: 		lcd_chr(1, 2, 'E');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,524 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,525 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,526 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,527 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,528 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,529 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,530 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusFuncionais.c,532 :: 		dipSwitch();
	CALL        _dipSwitch+0, 0
;LCDMenusFuncionais.c,534 :: 		} // end void menu6
	RETURN      0
; end of _menu6

_CustomChar:

;LCDMenusFuncionais.c,537 :: 		void CustomChar(char pos_row, char pos_char) {
;LCDMenusFuncionais.c,539 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais.c,540 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar42:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar43
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
	GOTO        L_CustomChar42
L_CustomChar43:
;LCDMenusFuncionais.c,541 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusFuncionais.c,542 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusFuncionais.c,543 :: 		}
	RETURN      0
; end of _CustomChar

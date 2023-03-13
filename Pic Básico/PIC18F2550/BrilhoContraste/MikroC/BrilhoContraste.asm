
_interrupt:

;BrilhoContraste.c,79 :: 		void interrupt(){
;BrilhoContraste.c,81 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt0
;BrilhoContraste.c,83 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;BrilhoContraste.c,85 :: 		if(pwm1){
	BTFSS       LATC0_bit+0, 0 
	GOTO        L_interrupt1
;BrilhoContraste.c,87 :: 		TMR2 = duty1;
	MOVF        _duty1+0, 0 
	MOVWF       TMR2+0 
;BrilhoContraste.c,88 :: 		pwm1 = 0x00;
	BCF         LATC0_bit+0, 0 
;BrilhoContraste.c,90 :: 		} // end if pwm1
	GOTO        L_interrupt2
L_interrupt1:
;BrilhoContraste.c,93 :: 		TMR2 = 255 - duty1;
	MOVF        _duty1+0, 0 
	SUBLW       255
	MOVWF       TMR2+0 
;BrilhoContraste.c,94 :: 		pwm1 = 0x01;
	BSF         LATC0_bit+0, 0 
;BrilhoContraste.c,96 :: 		} // end else pwm1
L_interrupt2:
;BrilhoContraste.c,98 :: 		} // end if TMR2IF_bit
L_interrupt0:
;BrilhoContraste.c,100 :: 		if(TMR3IF_bit){
	BTFSS       TMR3IF_bit+0, 1 
	GOTO        L_interrupt3
;BrilhoContraste.c,102 :: 		TMR3IF_bit = 0x00;
	BCF         TMR3IF_bit+0, 1 
;BrilhoContraste.c,103 :: 		TMR3H = 0xFF;
	MOVLW       255
	MOVWF       TMR3H+0 
;BrilhoContraste.c,105 :: 		if(pwm2){
	BTFSS       LATC1_bit+0, 1 
	GOTO        L_interrupt4
;BrilhoContraste.c,107 :: 		TMR3L = duty2;
	MOVF        _duty2+0, 0 
	MOVWF       TMR3L+0 
;BrilhoContraste.c,108 :: 		pwm2 = 0x00;
	BCF         LATC1_bit+0, 1 
;BrilhoContraste.c,110 :: 		} // end if pwm2
	GOTO        L_interrupt5
L_interrupt4:
;BrilhoContraste.c,113 :: 		TMR3L = 255 - duty2;
	MOVF        _duty2+0, 0 
	SUBLW       255
	MOVWF       TMR3L+0 
;BrilhoContraste.c,114 :: 		pwm2 = 0x01;
	BSF         LATC1_bit+0, 1 
;BrilhoContraste.c,116 :: 		} // end else pwm2
L_interrupt5:
;BrilhoContraste.c,118 :: 		} // end if TMR3IF_bit
L_interrupt3:
;BrilhoContraste.c,120 :: 		} // end void interrupt
L__interrupt18:
	RETFIE      1
; end of _interrupt

_main:

;BrilhoContraste.c,122 :: 		void main() {
;BrilhoContraste.c,124 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;BrilhoContraste.c,125 :: 		TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais
	MOVLW       3
	MOVWF       TRISB+0 
;BrilhoContraste.c,126 :: 		TRISC = 0xFC; // Configura apenas RC0 e RC1 como saídas digitais
	MOVLW       252
	MOVWF       TRISC+0 
;BrilhoContraste.c,127 :: 		LATC = 0xFC; // Inicia todas as saídas do portc em Low
	MOVLW       252
	MOVWF       LATC+0 
;BrilhoContraste.c,128 :: 		INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entradas do portb
	BCF         INTCON2+0, 7 
;BrilhoContraste.c,130 :: 		INTCON = 0xC0; // Habilita a interrupção global e por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;BrilhoContraste.c,131 :: 		TMR2IE_bit = 0x01; // Registrador PIE1. Habilita a interrupção por overflow do timer2
	BSF         TMR2IE_bit+0, 1 
;BrilhoContraste.c,132 :: 		TMR3IE_bit = 0x01; // Resgistrador PIE2. Habilita a interrupção por overflow do timer3
	BSF         TMR3IE_bit+0, 1 
;BrilhoContraste.c,134 :: 		T2CON = 0x05; // Habilita o timer2, configura o prescale em 1:4 e o postscale em 1:1
	MOVLW       5
	MOVWF       T2CON+0 
;BrilhoContraste.c,135 :: 		PR2 = 0xFF; // Configura a contagem do TMR2 até 0xFF = 255
	MOVLW       255
	MOVWF       PR2+0 
;BrilhoContraste.c,136 :: 		T3CON = 0x21; // Habilita o timer3, configura com 8 bits, prescale em 1:4 e incrementa com ciclo de clock
	MOVLW       33
	MOVWF       T3CON+0 
;BrilhoContraste.c,137 :: 		TMR3H = 0xFF;
	MOVLW       255
	MOVWF       TMR3H+0 
;BrilhoContraste.c,138 :: 		TMR3L = 0x00;
	CLRF        TMR3L+0 
;BrilhoContraste.c,140 :: 		flagBotao1 = 0x00;
	BCF         _flagBotao1+0, BitPos(_flagBotao1+0) 
;BrilhoContraste.c,141 :: 		flagBotao2 = 0x00;
	BCF         _flagBotao2+0, BitPos(_flagBotao2+0) 
;BrilhoContraste.c,144 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;BrilhoContraste.c,145 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;BrilhoContraste.c,146 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;BrilhoContraste.c,147 :: 		lcd_chr(1, 1, 'B');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       66
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContraste.c,148 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,149 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,150 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,151 :: 		lcd_chr_cp('h');
	MOVLW       104
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,152 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,153 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,154 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,155 :: 		lcd_chr(2, 1, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContraste.c,156 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,157 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,158 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,159 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,160 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,161 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,162 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,163 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,164 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,165 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,168 :: 		while(1){
L_main6:
;BrilhoContraste.c,170 :: 		leitura_Botao();
	CALL        _leitura_Botao+0, 0
;BrilhoContraste.c,172 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;BrilhoContraste.c,174 :: 		} // end Loop infinito
	GOTO        L_main6
;BrilhoContraste.c,176 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botao:

;BrilhoContraste.c,179 :: 		void leitura_Botao(){
;BrilhoContraste.c,181 :: 		if(!botao1) flagBotao1 = 0x01;
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Botao8
	BSF         _flagBotao1+0, BitPos(_flagBotao1+0) 
L_leitura_Botao8:
;BrilhoContraste.c,182 :: 		if(!botao2) flagBotao2 = 0x01;
	BTFSC       RB1_bit+0, 1 
	GOTO        L_leitura_Botao9
	BSF         _flagBotao2+0, BitPos(_flagBotao2+0) 
L_leitura_Botao9:
;BrilhoContraste.c,184 :: 		if(botao1 && flagBotao1){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Botao12
	BTFSS       _flagBotao1+0, BitPos(_flagBotao1+0) 
	GOTO        L_leitura_Botao12
L__leitura_Botao17:
;BrilhoContraste.c,186 :: 		flagBotao1 = 0x00;
	BCF         _flagBotao1+0, BitPos(_flagBotao1+0) 
;BrilhoContraste.c,187 :: 		duty1 += 0x04;
	MOVLW       4
	ADDWF       _duty1+0, 1 
;BrilhoContraste.c,189 :: 		} // end if botao1 && flagBotao1
L_leitura_Botao12:
;BrilhoContraste.c,191 :: 		if(botao2 && flagBotao2){
	BTFSS       RB1_bit+0, 1 
	GOTO        L_leitura_Botao15
	BTFSS       _flagBotao2+0, BitPos(_flagBotao2+0) 
	GOTO        L_leitura_Botao15
L__leitura_Botao16:
;BrilhoContraste.c,193 :: 		flagBotao2 = 0x00;
	BCF         _flagBotao2+0, BitPos(_flagBotao2+0) 
;BrilhoContraste.c,194 :: 		duty2 += 0x04;
	MOVLW       4
	ADDWF       _duty2+0, 1 
;BrilhoContraste.c,196 :: 		} // end if botao2 && flagBotao2
L_leitura_Botao15:
;BrilhoContraste.c,198 :: 		} // end void base_Tempo()
	RETURN      0
; end of _leitura_Botao

_imprime_Display:

;BrilhoContraste.c,200 :: 		void imprime_Display(){
;BrilhoContraste.c,204 :: 		cen1 = duty1/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty1+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen1_L0+0 
;BrilhoContraste.c,205 :: 		dez1 = (duty1%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty1+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez1_L0+0 
;BrilhoContraste.c,206 :: 		uni1 = duty1%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _duty1+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni1_L0+0 
;BrilhoContraste.c,208 :: 		lcd_chr(1, 9, cen1 + 0x30);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContraste.c,209 :: 		lcd_chr_cp(dez1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,210 :: 		lcd_chr_cp(uni1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,212 :: 		cen2 = duty2/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty2+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen2_L0+0 
;BrilhoContraste.c,213 :: 		dez2 = (duty2%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty2+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez2_L0+0 
;BrilhoContraste.c,214 :: 		uni2 = duty2%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _duty2+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni2_L0+0 
;BrilhoContraste.c,216 :: 		lcd_chr(2, 12, cen2 + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContraste.c,217 :: 		lcd_chr_cp(dez2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,218 :: 		lcd_chr_cp(uni2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContraste.c,220 :: 		} // end void imprime_Display()
	RETURN      0
; end of _imprime_Display

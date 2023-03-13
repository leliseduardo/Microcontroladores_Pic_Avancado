
_interrupt:

;Relogio.c,65 :: 		void interrupt() {
;Relogio.c,67 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;Relogio.c,69 :: 		asm BSF TMR1H,7;
	BSF         TMR1H+0, 7, 1
;Relogio.c,71 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;Relogio.c,73 :: 		relogio();
	CALL        _relogio+0, 0
;Relogio.c,74 :: 		} // end if TMR1IF_bit
L_interrupt0:
;Relogio.c,76 :: 		} // end void interrupt
L__interrupt60:
	RETFIE      1
; end of _interrupt

_main:

;Relogio.c,78 :: 		void main() {
;Relogio.c,83 :: 		INTCON = 0xC0; // Habilita a interrupção global e por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;Relogio.c,86 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
	BSF         TMR1IE_bit+0, 0 
;Relogio.c,89 :: 		T1CON = 0x0B; // Configura o timer1 com 8 bits,pic com outro oscilador, prescaler 1:1, liga o oscilador do timer1, síncrono, clock
	MOVLW       11
	MOVWF       T1CON+0 
;Relogio.c,93 :: 		TMR1L = 0x00; // Inicia o timer1 em 32768, para uma contagem de 32768
	CLRF        TMR1L+0 
;Relogio.c,94 :: 		TMR1H = 0x80;
	MOVLW       128
	MOVWF       TMR1H+0 
;Relogio.c,96 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Relogio.c,97 :: 		TRISB = 0xFF; // Configura todo portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;Relogio.c,100 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;Relogio.c,101 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Relogio.c,102 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Relogio.c,105 :: 		while(1){
L_main1:
;Relogio.c,107 :: 		display_Relogio();
	CALL        _display_Relogio+0, 0
;Relogio.c,108 :: 		ajuste_Relogio();
	CALL        _ajuste_Relogio+0, 0
;Relogio.c,109 :: 		} //end loop infinito
	GOTO        L_main1
;Relogio.c,110 :: 		} // end void main
	GOTO        $+0
; end of _main

_relogio:

;Relogio.c,112 :: 		void relogio(){
;Relogio.c,114 :: 		segundo++;
	INCF        _segundo+0, 1 
;Relogio.c,116 :: 		if(segundo == 0x3C){ // Se segundo = 60
	MOVF        _segundo+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio3
;Relogio.c,118 :: 		segundo = 0x00;
	CLRF        _segundo+0 
;Relogio.c,119 :: 		minuto++;
	INCF        _minuto+0, 1 
;Relogio.c,121 :: 		if(minuto == 0x3C){ // se minuto = 60
	MOVF        _minuto+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio4
;Relogio.c,123 :: 		minuto = 0x00;
	CLRF        _minuto+0 
;Relogio.c,124 :: 		hora++;
	INCF        _hora+0, 1 
;Relogio.c,126 :: 		if(hora == 0x18){ // Se hora = 24
	MOVF        _hora+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio5
;Relogio.c,128 :: 		hora = 0x00;
	CLRF        _hora+0 
;Relogio.c,129 :: 		dia++;
	INCF        _dia+0, 1 
;Relogio.c,131 :: 		if(dia == 0x07) // Se dia = 7. Lembrando que a variável dia começa em 0
	MOVF        _dia+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio6
;Relogio.c,132 :: 		dia = 0x00;
	CLRF        _dia+0 
L_relogio6:
;Relogio.c,134 :: 		} // end if hora == 0x18
L_relogio5:
;Relogio.c,136 :: 		} // end if minuto == 0x3C
L_relogio4:
;Relogio.c,138 :: 		} // end if segundo == 0x3C
L_relogio3:
;Relogio.c,141 :: 		} // end void relogio
	RETURN      0
; end of _relogio

_display_Relogio:

;Relogio.c,143 :: 		void display_Relogio(){
;Relogio.c,145 :: 		texto[7] = segundo%10 + '0';
	MOVLW       7
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Relogio+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Relogio+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _segundo+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Relogio+0, FSR1L
	MOVFF       FLOC__display_Relogio+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Relogio.c,146 :: 		texto[6] = segundo/10 + '0';
	MOVLW       6
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Relogio+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Relogio+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _segundo+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Relogio+0, FSR1L
	MOVFF       FLOC__display_Relogio+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Relogio.c,147 :: 		texto[4] = minuto%10 + '0';
	MOVLW       4
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Relogio+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Relogio+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuto+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Relogio+0, FSR1L
	MOVFF       FLOC__display_Relogio+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Relogio.c,148 :: 		texto[3] = minuto/10 + '0';
	MOVLW       3
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Relogio+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Relogio+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuto+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Relogio+0, FSR1L
	MOVFF       FLOC__display_Relogio+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Relogio.c,149 :: 		texto[1] = hora%10 + '0';
	MOVLW       1
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Relogio+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Relogio+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hora+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Relogio+0, FSR1L
	MOVFF       FLOC__display_Relogio+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Relogio.c,150 :: 		texto[0] = hora/10 + '0';
	MOVF        _texto+0, 0 
	MOVWF       FLOC__display_Relogio+0 
	MOVF        _texto+1, 0 
	MOVWF       FLOC__display_Relogio+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hora+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Relogio+0, FSR1L
	MOVFF       FLOC__display_Relogio+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Relogio.c,152 :: 		lcd_out(1, 5, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _texto+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _texto+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Relogio.c,154 :: 		switch(dia){
	GOTO        L_display_Relogio7
;Relogio.c,156 :: 		case 0: lcd_chr(1, 14, 'D');
L_display_Relogio9:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,157 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,158 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,159 :: 		break;
	GOTO        L_display_Relogio8
;Relogio.c,160 :: 		case 1: lcd_chr(1, 14, 'S');
L_display_Relogio10:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,161 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,162 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,163 :: 		break;
	GOTO        L_display_Relogio8
;Relogio.c,164 :: 		case 2: lcd_chr(1, 14, 'T');
L_display_Relogio11:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,165 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,166 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,167 :: 		break;
	GOTO        L_display_Relogio8
;Relogio.c,168 :: 		case 3: lcd_chr(1, 14, 'Q');
L_display_Relogio12:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,169 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,170 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,171 :: 		break;
	GOTO        L_display_Relogio8
;Relogio.c,172 :: 		case 4: lcd_chr(1, 14, 'Q');
L_display_Relogio13:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,173 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,174 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,175 :: 		break;
	GOTO        L_display_Relogio8
;Relogio.c,176 :: 		case 5: lcd_chr(1, 14, 'S');
L_display_Relogio14:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,177 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,178 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,179 :: 		break;
	GOTO        L_display_Relogio8
;Relogio.c,180 :: 		case 6: lcd_chr(1, 14, 'S');
L_display_Relogio15:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,181 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,182 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,183 :: 		break;
	GOTO        L_display_Relogio8
;Relogio.c,185 :: 		} // end switch dia
L_display_Relogio7:
	MOVF        _dia+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio9
	MOVF        _dia+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio10
	MOVF        _dia+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio11
	MOVF        _dia+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio12
	MOVF        _dia+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio13
	MOVF        _dia+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio14
	MOVF        _dia+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio15
L_display_Relogio8:
;Relogio.c,187 :: 		} // end void display_Relogio
	RETURN      0
; end of _display_Relogio

_ajuste_Relogio:

;Relogio.c,189 :: 		void ajuste_Relogio(){
;Relogio.c,193 :: 		if(!botaoAjuste) flags.B0 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_ajuste_Relogio16
	BSF         _flags+0, 0 
L_ajuste_Relogio16:
;Relogio.c,194 :: 		if(!botaoSoma) flags.B1 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_ajuste_Relogio17
	BSF         _flags+0, 1 
L_ajuste_Relogio17:
;Relogio.c,195 :: 		if(!botaoSoma10) flags.B2 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ajuste_Relogio18
	BSF         _flags+0, 2 
L_ajuste_Relogio18:
;Relogio.c,197 :: 		if(botaoAjuste && flags.B0){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_ajuste_Relogio21
	BTFSS       _flags+0, 0 
	GOTO        L_ajuste_Relogio21
L__ajuste_Relogio59:
;Relogio.c,199 :: 		flags.B0 = 0x00;
	BCF         _flags+0, 0 
;Relogio.c,201 :: 		controleAjuste++;
	INCF        _controleAjuste+0, 1 
;Relogio.c,203 :: 		if(controleAjuste > 4)
	MOVF        _controleAjuste+0, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Relogio22
;Relogio.c,204 :: 		controleAjuste = 0x00;
	CLRF        _controleAjuste+0 
L_ajuste_Relogio22:
;Relogio.c,206 :: 		} // end if botaoAjuste && flags.B0
L_ajuste_Relogio21:
;Relogio.c,208 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio23
;Relogio.c,210 :: 		case 0x00: lcd_chr(1, 1, 'H'); // Ajuste hora
L_ajuste_Relogio25:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,211 :: 		lcd_chr(2, 5, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,212 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,213 :: 		break;
	GOTO        L_ajuste_Relogio24
;Relogio.c,214 :: 		case 0x01: lcd_chr(1, 1, 'M'); // Ajuste minuto
L_ajuste_Relogio26:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,215 :: 		lcd_chr(2, 5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,216 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,217 :: 		lcd_chr(2, 8, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,218 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,219 :: 		break;
	GOTO        L_ajuste_Relogio24
;Relogio.c,220 :: 		case 0x02: lcd_chr(1, 1, 'S'); // Ajuste segundos
L_ajuste_Relogio27:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,221 :: 		lcd_chr(2, 8, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,222 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,223 :: 		lcd_chr(2, 11, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,224 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,225 :: 		break;
	GOTO        L_ajuste_Relogio24
;Relogio.c,226 :: 		case 0x03: lcd_chr(1, 1, 'D'); // Ajuste dias
L_ajuste_Relogio28:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,227 :: 		lcd_chr(2, 11, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,228 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,229 :: 		lcd_chr(2, 14, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,230 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,231 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Relogio.c,232 :: 		break;
	GOTO        L_ajuste_Relogio24
;Relogio.c,233 :: 		case 0x04: lcd_chr(1, 1, ' ');     // Limpa linha 2
L_ajuste_Relogio29:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,234 :: 		for(i = 0; i < 12; i++)
	CLRF        ajuste_Relogio_i_L0+0 
L_ajuste_Relogio30:
	MOVLW       12
	SUBWF       ajuste_Relogio_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Relogio31
;Relogio.c,235 :: 		lcd_chr(2, i+5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	ADDWF       ajuste_Relogio_i_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Relogio.c,234 :: 		for(i = 0; i < 12; i++)
	INCF        ajuste_Relogio_i_L0+0, 1 
;Relogio.c,235 :: 		lcd_chr(2, i+5, ' ');
	GOTO        L_ajuste_Relogio30
L_ajuste_Relogio31:
;Relogio.c,236 :: 		break;
	GOTO        L_ajuste_Relogio24
;Relogio.c,238 :: 		} // end switch controleAjuste
L_ajuste_Relogio23:
	MOVF        _controleAjuste+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio25
	MOVF        _controleAjuste+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio26
	MOVF        _controleAjuste+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio27
	MOVF        _controleAjuste+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio28
	MOVF        _controleAjuste+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio29
L_ajuste_Relogio24:
;Relogio.c,240 :: 		if(botaoSoma && flags.B1){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_ajuste_Relogio35
	BTFSS       _flags+0, 1 
	GOTO        L_ajuste_Relogio35
L__ajuste_Relogio58:
;Relogio.c,242 :: 		flags.B1 = 0x00;
	BCF         _flags+0, 1 
;Relogio.c,244 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio36
;Relogio.c,246 :: 		case 0x00: hora++;
L_ajuste_Relogio38:
	INCF        _hora+0, 1 
;Relogio.c,247 :: 		if(hora == 0x18)
	MOVF        _hora+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio39
;Relogio.c,248 :: 		hora = 0x00;
	CLRF        _hora+0 
L_ajuste_Relogio39:
;Relogio.c,249 :: 		break;
	GOTO        L_ajuste_Relogio37
;Relogio.c,250 :: 		case 0x01: minuto++;
L_ajuste_Relogio40:
	INCF        _minuto+0, 1 
;Relogio.c,251 :: 		if(minuto == 0x3C)
	MOVF        _minuto+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio41
;Relogio.c,252 :: 		minuto = 0x00;
	CLRF        _minuto+0 
L_ajuste_Relogio41:
;Relogio.c,253 :: 		break;
	GOTO        L_ajuste_Relogio37
;Relogio.c,254 :: 		case 0x02: segundo++;
L_ajuste_Relogio42:
	INCF        _segundo+0, 1 
;Relogio.c,255 :: 		if(segundo == 0x3C)
	MOVF        _segundo+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio43
;Relogio.c,256 :: 		segundo = 0x00;
	CLRF        _segundo+0 
L_ajuste_Relogio43:
;Relogio.c,257 :: 		break;
	GOTO        L_ajuste_Relogio37
;Relogio.c,258 :: 		case 0x03: dia++;
L_ajuste_Relogio44:
	INCF        _dia+0, 1 
;Relogio.c,259 :: 		if(dia == 0x07)
	MOVF        _dia+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio45
;Relogio.c,260 :: 		dia = 0x00;
	CLRF        _dia+0 
L_ajuste_Relogio45:
;Relogio.c,261 :: 		break;
	GOTO        L_ajuste_Relogio37
;Relogio.c,263 :: 		} // end switch controleAjuste
L_ajuste_Relogio36:
	MOVF        _controleAjuste+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio38
	MOVF        _controleAjuste+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio40
	MOVF        _controleAjuste+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio42
	MOVF        _controleAjuste+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio44
L_ajuste_Relogio37:
;Relogio.c,265 :: 		} // end if botaoSoma && flags.B1
L_ajuste_Relogio35:
;Relogio.c,267 :: 		if(botaoSoma10 && flags.B2){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_ajuste_Relogio48
	BTFSS       _flags+0, 2 
	GOTO        L_ajuste_Relogio48
L__ajuste_Relogio57:
;Relogio.c,269 :: 		flags.B2 = 0x00;
	BCF         _flags+0, 2 
;Relogio.c,271 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio49
;Relogio.c,273 :: 		case 0x00: hora = hora + 10;
L_ajuste_Relogio51:
	MOVLW       10
	ADDWF       _hora+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _hora+0 
;Relogio.c,274 :: 		if(hora >= 0x18)
	MOVLW       24
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio52
;Relogio.c,275 :: 		hora = 0x00;
	CLRF        _hora+0 
L_ajuste_Relogio52:
;Relogio.c,276 :: 		break;
	GOTO        L_ajuste_Relogio50
;Relogio.c,277 :: 		case 0x01: minuto = minuto + 10;
L_ajuste_Relogio53:
	MOVLW       10
	ADDWF       _minuto+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _minuto+0 
;Relogio.c,278 :: 		if(minuto >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio54
;Relogio.c,279 :: 		minuto = 0x00;
	CLRF        _minuto+0 
L_ajuste_Relogio54:
;Relogio.c,280 :: 		break;
	GOTO        L_ajuste_Relogio50
;Relogio.c,281 :: 		case 0x02: segundo = segundo + 10;
L_ajuste_Relogio55:
	MOVLW       10
	ADDWF       _segundo+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _segundo+0 
;Relogio.c,282 :: 		if(segundo >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio56
;Relogio.c,283 :: 		segundo = 0x00;
	CLRF        _segundo+0 
L_ajuste_Relogio56:
;Relogio.c,284 :: 		break;
	GOTO        L_ajuste_Relogio50
;Relogio.c,286 :: 		} // end switch controleAjuste
L_ajuste_Relogio49:
	MOVF        _controleAjuste+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio51
	MOVF        _controleAjuste+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio53
	MOVF        _controleAjuste+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio55
L_ajuste_Relogio50:
;Relogio.c,288 :: 		} // end if botaoSoma10 && flags.B2
L_ajuste_Relogio48:
;Relogio.c,290 :: 		} // end void ajuste_Relogio
	RETURN      0
; end of _ajuste_Relogio

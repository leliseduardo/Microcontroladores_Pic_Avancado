
_interrupt:

;RelogioDespertador.c,94 :: 		void interrupt() {
;RelogioDespertador.c,96 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;RelogioDespertador.c,98 :: 		asm BSF TMR1H,7;
	BSF         TMR1H+0, 7, 1
;RelogioDespertador.c,100 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;RelogioDespertador.c,102 :: 		relogio();
	CALL        _relogio+0, 0
;RelogioDespertador.c,104 :: 		if(ligaBuzzer)
	BTFSS       _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
	GOTO        L_interrupt1
;RelogioDespertador.c,105 :: 		buzzer = ~buzzer;
	BTG         LATB0_bit+0, 0 
L_interrupt1:
;RelogioDespertador.c,106 :: 		} // end if TMR1IF_bit
L_interrupt0:
;RelogioDespertador.c,108 :: 		} // end void interrupt
L__interrupt151:
	RETFIE      1
; end of _interrupt

_main:

;RelogioDespertador.c,111 :: 		void main() {
;RelogioDespertador.c,116 :: 		INTCON = 0xC0; // Habilita a interrupção global e por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;RelogioDespertador.c,119 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
	BSF         TMR1IE_bit+0, 0 
;RelogioDespertador.c,122 :: 		T1CON = 0x0B; // Configura o timer1 com 8 bits,pic com outro oscilador, prescaler 1:1, liga o oscilador do timer1, síncrono, clock
	MOVLW       11
	MOVWF       T1CON+0 
;RelogioDespertador.c,126 :: 		TMR1L = 0x00; // Inicia o timer1 em 32768, para uma contagem de 32768
	CLRF        TMR1L+0 
;RelogioDespertador.c,127 :: 		TMR1H = 0x80;
	MOVLW       128
	MOVWF       TMR1H+0 
;RelogioDespertador.c,129 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;RelogioDespertador.c,130 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;RelogioDespertador.c,132 :: 		buzzer = 0x00; // Inicia LATB0_bit em Low
	BCF         LATB0_bit+0, 0 
;RelogioDespertador.c,133 :: 		ligaBuzzer = 0; // Inicia o bit ligaBuzzer em 0
	BCF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
;RelogioDespertador.c,136 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;RelogioDespertador.c,137 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertador.c,138 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertador.c,141 :: 		while(1){
L_main2:
;RelogioDespertador.c,143 :: 		troca_Display();
	CALL        _troca_Display+0, 0
;RelogioDespertador.c,144 :: 		ativa_Alarme();
	CALL        _ativa_Alarme+0, 0
;RelogioDespertador.c,146 :: 		} //end loop infinito
	GOTO        L_main2
;RelogioDespertador.c,147 :: 		} // end void main
	GOTO        $+0
; end of _main

_troca_Display:

;RelogioDespertador.c,152 :: 		void troca_Display(){
;RelogioDespertador.c,154 :: 		if(flags.B6){
	BTFSS       _flags+0, 6 
	GOTO        L_troca_Display4
;RelogioDespertador.c,156 :: 		if(!botaoAlarme) flags.B7 = 0x01;
	BTFSC       RB4_bit+0, 4 
	GOTO        L_troca_Display5
	BSF         _flags+0, 7 
L_troca_Display5:
;RelogioDespertador.c,158 :: 		controleAjuste_a = 0x00; // Para que flags2.B1 seja = 0x00 na troca do display
	CLRF        _controleAjuste_a+0 
;RelogioDespertador.c,160 :: 		} // end is flags.B6
L_troca_Display4:
;RelogioDespertador.c,162 :: 		if((botaoAlarme && flags.B7) || flags2.B0){
	BTFSS       RB4_bit+0, 4 
	GOTO        L__troca_Display140
	BTFSS       _flags+0, 7 
	GOTO        L__troca_Display140
	GOTO        L__troca_Display139
L__troca_Display140:
	BTFSC       _flags2+0, 0 
	GOTO        L__troca_Display139
	GOTO        L_troca_Display10
L__troca_Display139:
;RelogioDespertador.c,164 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertador.c,165 :: 		flags.B7 = 0x00;
	BCF         _flags+0, 7 
;RelogioDespertador.c,166 :: 		flags2.B0 = 0x01;
	BSF         _flags2+0, 0 
;RelogioDespertador.c,168 :: 		display_Alarme();
	CALL        _display_Alarme+0, 0
;RelogioDespertador.c,169 :: 		ajuste_Alarme();
	CALL        _ajuste_Alarme+0, 0
;RelogioDespertador.c,171 :: 		if(flags2.B1){
	BTFSS       _flags2+0, 1 
	GOTO        L_troca_Display11
;RelogioDespertador.c,173 :: 		if(!botaoAlarme) flags2.B2 = 0x01;
	BTFSC       RB4_bit+0, 4 
	GOTO        L_troca_Display12
	BSF         _flags2+0, 2 
L_troca_Display12:
;RelogioDespertador.c,175 :: 		if(botaoAlarme && flags2.B2) flags2.B0 = 0x00;
	BTFSS       RB4_bit+0, 4 
	GOTO        L_troca_Display15
	BTFSS       _flags2+0, 2 
	GOTO        L_troca_Display15
L__troca_Display138:
	BCF         _flags2+0, 0 
L_troca_Display15:
;RelogioDespertador.c,177 :: 		} // end if flags2.B1
L_troca_Display11:
;RelogioDespertador.c,179 :: 		} // end if botaoAlarme && flags.B7
	GOTO        L_troca_Display16
L_troca_Display10:
;RelogioDespertador.c,182 :: 		flags2.B1 = 0x00;
	BCF         _flags2+0, 1 
;RelogioDespertador.c,183 :: 		flags2.B2 = 0x00;
	BCF         _flags2+0, 2 
;RelogioDespertador.c,185 :: 		display_Relogio();
	CALL        _display_Relogio+0, 0
;RelogioDespertador.c,186 :: 		Ajuste_Relogio();
	CALL        _ajuste_Relogio+0, 0
;RelogioDespertador.c,188 :: 		} // end else botaoAlarme && flags.B7
L_troca_Display16:
;RelogioDespertador.c,190 :: 		} // end void display_Troca
	RETURN      0
; end of _troca_Display

_ativa_Alarme:

;RelogioDespertador.c,192 :: 		void ativa_Alarme(){
;RelogioDespertador.c,194 :: 		if(flags2.B3){
	BTFSS       _flags2+0, 3 
	GOTO        L_ativa_Alarme17
;RelogioDespertador.c,195 :: 		if(!botaoSoma10) flags2.B4 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ativa_Alarme18
	BSF         _flags2+0, 4 
L_ativa_Alarme18:
;RelogioDespertador.c,197 :: 		if(ligaBuzzer){
	BTFSS       _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
	GOTO        L_ativa_Alarme19
;RelogioDespertador.c,199 :: 		if(!botaoSoma) flags2.B7 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_ativa_Alarme20
	BSF         _flags2+0, 7 
L_ativa_Alarme20:
;RelogioDespertador.c,201 :: 		if(botaoSoma && flags2.B7){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_ativa_Alarme23
	BTFSS       _flags2+0, 7 
	GOTO        L_ativa_Alarme23
L__ativa_Alarme144:
;RelogioDespertador.c,203 :: 		flags2.B7 = 0x00;
	BCF         _flags2+0, 7 
;RelogioDespertador.c,205 :: 		ligaBuzzer = 0x00;
	BCF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
;RelogioDespertador.c,206 :: 		buzzer = 0;
	BCF         LATB0_bit+0, 0 
;RelogioDespertador.c,207 :: 		flags2.B6 = 0x01;
	BSF         _flags2+0, 6 
;RelogioDespertador.c,209 :: 		} // end if botaoSoma && flags2.B7
L_ativa_Alarme23:
;RelogioDespertador.c,211 :: 		} // end if ligaBuzzer
L_ativa_Alarme19:
;RelogioDespertador.c,213 :: 		if((botaoSoma10 && flags2.B4) || flags2.B5){
	BTFSS       RB5_bit+0, 5 
	GOTO        L__ativa_Alarme143
	BTFSS       _flags2+0, 4 
	GOTO        L__ativa_Alarme143
	GOTO        L__ativa_Alarme142
L__ativa_Alarme143:
	BTFSC       _flags2+0, 5 
	GOTO        L__ativa_Alarme142
	GOTO        L_ativa_Alarme28
L__ativa_Alarme142:
;RelogioDespertador.c,215 :: 		flags2.B5 = 0x01;
	BSF         _flags2+0, 5 
;RelogioDespertador.c,217 :: 		CustomChar(2, 1);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;RelogioDespertador.c,218 :: 		alarme();
	CALL        _alarme+0, 0
;RelogioDespertador.c,220 :: 		if(!botaoSoma10) flags2.B6 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ativa_Alarme29
	BSF         _flags2+0, 6 
L_ativa_Alarme29:
;RelogioDespertador.c,222 :: 		if(botaoSoma10 && flags2.B6){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_ativa_Alarme32
	BTFSS       _flags2+0, 6 
	GOTO        L_ativa_Alarme32
L__ativa_Alarme141:
;RelogioDespertador.c,224 :: 		flags2.B6 = 0x00;
	BCF         _flags2+0, 6 
;RelogioDespertador.c,225 :: 		flags2.B5 = 0x00;
	BCF         _flags2+0, 5 
;RelogioDespertador.c,226 :: 		flags2.B4 = 0x00;
	BCF         _flags2+0, 4 
;RelogioDespertador.c,227 :: 		ligaBuzzer = 0x00;
	BCF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
;RelogioDespertador.c,228 :: 		buzzer = 0;
	BCF         LATB0_bit+0, 0 
;RelogioDespertador.c,230 :: 		lcd_chr(2, 1, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,232 :: 		} // end if !botaoSoma10 && flags2.B4
L_ativa_Alarme32:
;RelogioDespertador.c,234 :: 		} // end if botaoSoma10 && flags2.B4
L_ativa_Alarme28:
;RelogioDespertador.c,236 :: 		} // end if flags2.B3
L_ativa_Alarme17:
;RelogioDespertador.c,238 :: 		}
	RETURN      0
; end of _ativa_Alarme

_relogio:

;RelogioDespertador.c,242 :: 		void relogio(){
;RelogioDespertador.c,244 :: 		segundo++;
	INCF        _segundo+0, 1 
;RelogioDespertador.c,246 :: 		if(segundo == 0x3C){ // Se segundo = 60
	MOVF        _segundo+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio33
;RelogioDespertador.c,248 :: 		segundo = 0x00;
	CLRF        _segundo+0 
;RelogioDespertador.c,249 :: 		minuto++;
	INCF        _minuto+0, 1 
;RelogioDespertador.c,251 :: 		if(minuto == 0x3C){ // se minuto = 60
	MOVF        _minuto+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio34
;RelogioDespertador.c,253 :: 		minuto = 0x00;
	CLRF        _minuto+0 
;RelogioDespertador.c,254 :: 		hora++;
	INCF        _hora+0, 1 
;RelogioDespertador.c,256 :: 		if(hora == 0x18){ // Se hora = 24
	MOVF        _hora+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio35
;RelogioDespertador.c,258 :: 		hora = 0x00;
	CLRF        _hora+0 
;RelogioDespertador.c,259 :: 		dia++;
	INCF        _dia+0, 1 
;RelogioDespertador.c,261 :: 		if(dia == 0x07) // Se dia = 7. Lembrando que a variável dia começa em 0
	MOVF        _dia+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio36
;RelogioDespertador.c,262 :: 		dia = 0x00;
	CLRF        _dia+0 
L_relogio36:
;RelogioDespertador.c,264 :: 		} // end if hora == 0x18
L_relogio35:
;RelogioDespertador.c,266 :: 		} // end if minuto == 0x3C
L_relogio34:
;RelogioDespertador.c,268 :: 		} // end if segundo == 0x3C
L_relogio33:
;RelogioDespertador.c,271 :: 		} // end void relogio
	RETURN      0
; end of _relogio

_display_Relogio:

;RelogioDespertador.c,273 :: 		void display_Relogio(){
;RelogioDespertador.c,275 :: 		texto[7] = segundo%10 + '0';
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
;RelogioDespertador.c,276 :: 		texto[6] = segundo/10 + '0';
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
;RelogioDespertador.c,277 :: 		texto[4] = minuto%10 + '0';
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
;RelogioDespertador.c,278 :: 		texto[3] = minuto/10 + '0';
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
;RelogioDespertador.c,279 :: 		texto[1] = hora%10 + '0';
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
;RelogioDespertador.c,280 :: 		texto[0] = hora/10 + '0';
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
;RelogioDespertador.c,282 :: 		lcd_chr(1, 3, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,283 :: 		lcd_out(1, 5, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _texto+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _texto+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RelogioDespertador.c,285 :: 		switch(dia){
	GOTO        L_display_Relogio37
;RelogioDespertador.c,287 :: 		case 0: lcd_chr(1, 14, 'D');
L_display_Relogio39:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,288 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,289 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,290 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertador.c,291 :: 		case 1: lcd_chr(1, 14, 'S');
L_display_Relogio40:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,292 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,293 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,294 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertador.c,295 :: 		case 2: lcd_chr(1, 14, 'T');
L_display_Relogio41:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,296 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,297 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,298 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertador.c,299 :: 		case 3: lcd_chr(1, 14, 'Q');
L_display_Relogio42:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,300 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,301 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,302 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertador.c,303 :: 		case 4: lcd_chr(1, 14, 'Q');
L_display_Relogio43:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,304 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,305 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,306 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertador.c,307 :: 		case 5: lcd_chr(1, 14, 'S');
L_display_Relogio44:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,308 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,309 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,310 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertador.c,311 :: 		case 6: lcd_chr(1, 14, 'S');
L_display_Relogio45:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,312 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,313 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,314 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertador.c,316 :: 		} // end switch dia
L_display_Relogio37:
	MOVF        _dia+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio39
	MOVF        _dia+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio40
	MOVF        _dia+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio41
	MOVF        _dia+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio42
	MOVF        _dia+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio43
	MOVF        _dia+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio44
	MOVF        _dia+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Relogio45
L_display_Relogio38:
;RelogioDespertador.c,318 :: 		} // end void display_Relogio
	RETURN      0
; end of _display_Relogio

_ajuste_Relogio:

;RelogioDespertador.c,320 :: 		void ajuste_Relogio(){
;RelogioDespertador.c,324 :: 		if(!botaoAjuste) flags.B0 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_ajuste_Relogio46
	BSF         _flags+0, 0 
L_ajuste_Relogio46:
;RelogioDespertador.c,325 :: 		if(!botaoSoma) flags.B1 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_ajuste_Relogio47
	BSF         _flags+0, 1 
L_ajuste_Relogio47:
;RelogioDespertador.c,326 :: 		if(!botaoSoma10) flags.B2 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ajuste_Relogio48
	BSF         _flags+0, 2 
L_ajuste_Relogio48:
;RelogioDespertador.c,328 :: 		if(botaoAjuste && flags.B0){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_ajuste_Relogio51
	BTFSS       _flags+0, 0 
	GOTO        L_ajuste_Relogio51
L__ajuste_Relogio147:
;RelogioDespertador.c,330 :: 		flags.B0 = 0x00;
	BCF         _flags+0, 0 
;RelogioDespertador.c,332 :: 		controleAjuste++;
	INCF        _controleAjuste+0, 1 
;RelogioDespertador.c,334 :: 		if(controleAjuste > 4)
	MOVF        _controleAjuste+0, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Relogio52
;RelogioDespertador.c,335 :: 		controleAjuste = 0x00;
	CLRF        _controleAjuste+0 
L_ajuste_Relogio52:
;RelogioDespertador.c,337 :: 		} // end if botaoAjuste && flags.B0
L_ajuste_Relogio51:
;RelogioDespertador.c,339 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio53
;RelogioDespertador.c,341 :: 		case 0x00: lcd_chr(1, 1, 'H'); // Ajuste hora
L_ajuste_Relogio55:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,342 :: 		lcd_chr(2, 5, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,343 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,344 :: 		flags.B6 = 0x00; // Flag que desabilita a troca de displays
	BCF         _flags+0, 6 
;RelogioDespertador.c,345 :: 		flags2.B3 = 0x00; // Flag que desabilita a ativação do alarme
	BCF         _flags2+0, 3 
;RelogioDespertador.c,346 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertador.c,347 :: 		case 0x01: lcd_chr(1, 1, 'M'); // Ajuste minuto
L_ajuste_Relogio56:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,348 :: 		lcd_chr(2, 5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,349 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,350 :: 		lcd_chr(2, 8, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,351 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,352 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertador.c,353 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertador.c,354 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertador.c,355 :: 		case 0x02: lcd_chr(1, 1, 'S'); // Ajuste segundos
L_ajuste_Relogio57:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,356 :: 		lcd_chr(2, 8, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,357 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,358 :: 		lcd_chr(2, 11, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,359 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,360 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertador.c,361 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertador.c,362 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertador.c,363 :: 		case 0x03: lcd_chr(1, 1, 'D'); // Ajuste dias
L_ajuste_Relogio58:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,364 :: 		lcd_chr(2, 11, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,365 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,366 :: 		lcd_chr(2, 14, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,367 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,368 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,369 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertador.c,370 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertador.c,371 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertador.c,372 :: 		case 0x04: lcd_chr(1, 1, ' ');     // Limpa linha 2
L_ajuste_Relogio59:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,373 :: 		for(i = 0; i < 12; i++)
	CLRF        ajuste_Relogio_i_L0+0 
L_ajuste_Relogio60:
	MOVLW       12
	SUBWF       ajuste_Relogio_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Relogio61
;RelogioDespertador.c,374 :: 		lcd_chr(2, i+5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	ADDWF       ajuste_Relogio_i_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,373 :: 		for(i = 0; i < 12; i++)
	INCF        ajuste_Relogio_i_L0+0, 1 
;RelogioDespertador.c,374 :: 		lcd_chr(2, i+5, ' ');
	GOTO        L_ajuste_Relogio60
L_ajuste_Relogio61:
;RelogioDespertador.c,375 :: 		flags.B6 = 0x01; // Flag que habilita a troca de displays
	BSF         _flags+0, 6 
;RelogioDespertador.c,376 :: 		flags2.B3 = 0x01; // Flag que habilita a ativação do alarme
	BSF         _flags2+0, 3 
;RelogioDespertador.c,377 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertador.c,379 :: 		} // end switch controleAjuste
L_ajuste_Relogio53:
	MOVF        _controleAjuste+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio55
	MOVF        _controleAjuste+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio56
	MOVF        _controleAjuste+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio57
	MOVF        _controleAjuste+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio58
	MOVF        _controleAjuste+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio59
L_ajuste_Relogio54:
;RelogioDespertador.c,381 :: 		if(botaoSoma && flags.B1){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_ajuste_Relogio65
	BTFSS       _flags+0, 1 
	GOTO        L_ajuste_Relogio65
L__ajuste_Relogio146:
;RelogioDespertador.c,383 :: 		flags.B1 = 0x00;
	BCF         _flags+0, 1 
;RelogioDespertador.c,385 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio66
;RelogioDespertador.c,387 :: 		case 0x00: hora++;
L_ajuste_Relogio68:
	INCF        _hora+0, 1 
;RelogioDespertador.c,388 :: 		if(hora == 0x18)
	MOVF        _hora+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio69
;RelogioDespertador.c,389 :: 		hora = 0x00;
	CLRF        _hora+0 
L_ajuste_Relogio69:
;RelogioDespertador.c,390 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertador.c,391 :: 		case 0x01: minuto++;
L_ajuste_Relogio70:
	INCF        _minuto+0, 1 
;RelogioDespertador.c,392 :: 		if(minuto == 0x3C)
	MOVF        _minuto+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio71
;RelogioDespertador.c,393 :: 		minuto = 0x00;
	CLRF        _minuto+0 
L_ajuste_Relogio71:
;RelogioDespertador.c,394 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertador.c,395 :: 		case 0x02: segundo++;
L_ajuste_Relogio72:
	INCF        _segundo+0, 1 
;RelogioDespertador.c,396 :: 		if(segundo == 0x3C)
	MOVF        _segundo+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio73
;RelogioDespertador.c,397 :: 		segundo = 0x00;
	CLRF        _segundo+0 
L_ajuste_Relogio73:
;RelogioDespertador.c,398 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertador.c,399 :: 		case 0x03: dia++;
L_ajuste_Relogio74:
	INCF        _dia+0, 1 
;RelogioDespertador.c,400 :: 		if(dia == 0x07)
	MOVF        _dia+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio75
;RelogioDespertador.c,401 :: 		dia = 0x00;
	CLRF        _dia+0 
L_ajuste_Relogio75:
;RelogioDespertador.c,402 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertador.c,404 :: 		} // end switch controleAjuste
L_ajuste_Relogio66:
	MOVF        _controleAjuste+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio68
	MOVF        _controleAjuste+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio70
	MOVF        _controleAjuste+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio72
	MOVF        _controleAjuste+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio74
L_ajuste_Relogio67:
;RelogioDespertador.c,406 :: 		} // end if botaoSoma && flags.B1
L_ajuste_Relogio65:
;RelogioDespertador.c,408 :: 		if(botaoSoma10 && flags.B2){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_ajuste_Relogio78
	BTFSS       _flags+0, 2 
	GOTO        L_ajuste_Relogio78
L__ajuste_Relogio145:
;RelogioDespertador.c,410 :: 		flags.B2 = 0x00;
	BCF         _flags+0, 2 
;RelogioDespertador.c,412 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio79
;RelogioDespertador.c,414 :: 		case 0x00: hora = hora + 10;
L_ajuste_Relogio81:
	MOVLW       10
	ADDWF       _hora+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _hora+0 
;RelogioDespertador.c,415 :: 		if(hora >= 0x18)
	MOVLW       24
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio82
;RelogioDespertador.c,416 :: 		hora = 0x00;
	CLRF        _hora+0 
L_ajuste_Relogio82:
;RelogioDespertador.c,417 :: 		break;
	GOTO        L_ajuste_Relogio80
;RelogioDespertador.c,418 :: 		case 0x01: minuto = minuto + 10;
L_ajuste_Relogio83:
	MOVLW       10
	ADDWF       _minuto+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _minuto+0 
;RelogioDespertador.c,419 :: 		if(minuto >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio84
;RelogioDespertador.c,420 :: 		minuto = 0x00;
	CLRF        _minuto+0 
L_ajuste_Relogio84:
;RelogioDespertador.c,421 :: 		break;
	GOTO        L_ajuste_Relogio80
;RelogioDespertador.c,422 :: 		case 0x02: segundo = segundo + 10;
L_ajuste_Relogio85:
	MOVLW       10
	ADDWF       _segundo+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _segundo+0 
;RelogioDespertador.c,423 :: 		if(segundo >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio86
;RelogioDespertador.c,424 :: 		segundo = 0x00;
	CLRF        _segundo+0 
L_ajuste_Relogio86:
;RelogioDespertador.c,425 :: 		break;
	GOTO        L_ajuste_Relogio80
;RelogioDespertador.c,427 :: 		} // end switch controleAjuste
L_ajuste_Relogio79:
	MOVF        _controleAjuste+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio81
	MOVF        _controleAjuste+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio83
	MOVF        _controleAjuste+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Relogio85
L_ajuste_Relogio80:
;RelogioDespertador.c,429 :: 		} // end if botaoSoma10 && flags.B2
L_ajuste_Relogio78:
;RelogioDespertador.c,431 :: 		} // end void ajuste_Relogio
	RETURN      0
; end of _ajuste_Relogio

_alarme:

;RelogioDespertador.c,439 :: 		void alarme(){
;RelogioDespertador.c,441 :: 		if(hora == hora_a){
	MOVF        _hora+0, 0 
	XORWF       _hora_a+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_alarme87
;RelogioDespertador.c,443 :: 		if(minuto == minuto_a){
	MOVF        _minuto+0, 0 
	XORWF       _minuto_a+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_alarme88
;RelogioDespertador.c,445 :: 		if(dia == dia_a)
	MOVF        _dia+0, 0 
	XORWF       _dia_a+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_alarme89
;RelogioDespertador.c,446 :: 		ligaBuzzer = 1;
	BSF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
L_alarme89:
;RelogioDespertador.c,448 :: 		} // end minuto = minuto_a
L_alarme88:
;RelogioDespertador.c,450 :: 		} // end if hora == hora_a
L_alarme87:
;RelogioDespertador.c,451 :: 		}
	RETURN      0
; end of _alarme

_display_Alarme:

;RelogioDespertador.c,453 :: 		void display_Alarme(){
;RelogioDespertador.c,455 :: 		texto2[4] = minuto_a%10 + '0';
	MOVLW       4
	ADDWF       _texto2+0, 0 
	MOVWF       FLOC__display_Alarme+0 
	MOVLW       0
	ADDWFC      _texto2+1, 0 
	MOVWF       FLOC__display_Alarme+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuto_a+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Alarme+0, FSR1L
	MOVFF       FLOC__display_Alarme+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RelogioDespertador.c,456 :: 		texto2[3] = minuto_a/10 + '0';
	MOVLW       3
	ADDWF       _texto2+0, 0 
	MOVWF       FLOC__display_Alarme+0 
	MOVLW       0
	ADDWFC      _texto2+1, 0 
	MOVWF       FLOC__display_Alarme+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuto_a+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Alarme+0, FSR1L
	MOVFF       FLOC__display_Alarme+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RelogioDespertador.c,457 :: 		texto2[1] = hora_a%10 + '0';
	MOVLW       1
	ADDWF       _texto2+0, 0 
	MOVWF       FLOC__display_Alarme+0 
	MOVLW       0
	ADDWFC      _texto2+1, 0 
	MOVWF       FLOC__display_Alarme+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hora_a+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Alarme+0, FSR1L
	MOVFF       FLOC__display_Alarme+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RelogioDespertador.c,458 :: 		texto2[0] = hora_a/10 + '0';
	MOVF        _texto2+0, 0 
	MOVWF       FLOC__display_Alarme+0 
	MOVF        _texto2+1, 0 
	MOVWF       FLOC__display_Alarme+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hora_a+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Alarme+0, FSR1L
	MOVFF       FLOC__display_Alarme+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;RelogioDespertador.c,460 :: 		CustomChar(1, 1);
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;RelogioDespertador.c,461 :: 		lcd_out(1, 5, texto2);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _texto2+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _texto2+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RelogioDespertador.c,462 :: 		lcd_chr(1, 10, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,463 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,464 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,466 :: 		switch(dia_a){
	GOTO        L_display_Alarme90
;RelogioDespertador.c,468 :: 		case 0: lcd_chr(1, 14, 'D');
L_display_Alarme92:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,469 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,470 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,471 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertador.c,472 :: 		case 1: lcd_chr(1, 14, 'S');
L_display_Alarme93:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,473 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,474 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,475 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertador.c,476 :: 		case 2: lcd_chr(1, 14, 'T');
L_display_Alarme94:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,477 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,478 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,479 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertador.c,480 :: 		case 3: lcd_chr(1, 14, 'Q');
L_display_Alarme95:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,481 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,482 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,483 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertador.c,484 :: 		case 4: lcd_chr(1, 14, 'Q');
L_display_Alarme96:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,485 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,486 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,487 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertador.c,488 :: 		case 5: lcd_chr(1, 14, 'S');
L_display_Alarme97:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,489 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,490 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,491 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertador.c,492 :: 		case 6: lcd_chr(1, 14, 'S');
L_display_Alarme98:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,493 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,494 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,495 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertador.c,497 :: 		} // end switch dia_a
L_display_Alarme90:
	MOVF        _dia_a+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Alarme92
	MOVF        _dia_a+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Alarme93
	MOVF        _dia_a+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Alarme94
	MOVF        _dia_a+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Alarme95
	MOVF        _dia_a+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Alarme96
	MOVF        _dia_a+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Alarme97
	MOVF        _dia_a+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Alarme98
L_display_Alarme91:
;RelogioDespertador.c,499 :: 		} // end display_Alarme
	RETURN      0
; end of _display_Alarme

_ajuste_Alarme:

;RelogioDespertador.c,501 :: 		void ajuste_Alarme(){
;RelogioDespertador.c,505 :: 		if(!botaoAjuste) flags.B3 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_ajuste_Alarme99
	BSF         _flags+0, 3 
L_ajuste_Alarme99:
;RelogioDespertador.c,506 :: 		if(!botaoSoma) flags.B4 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_ajuste_Alarme100
	BSF         _flags+0, 4 
L_ajuste_Alarme100:
;RelogioDespertador.c,507 :: 		if(!botaoSoma10) flags.B5 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ajuste_Alarme101
	BSF         _flags+0, 5 
L_ajuste_Alarme101:
;RelogioDespertador.c,509 :: 		if(botaoAjuste && flags.B3){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_ajuste_Alarme104
	BTFSS       _flags+0, 3 
	GOTO        L_ajuste_Alarme104
L__ajuste_Alarme150:
;RelogioDespertador.c,511 :: 		flags.B3 = 0x00;
	BCF         _flags+0, 3 
;RelogioDespertador.c,513 :: 		controleAjuste_a++;
	INCF        _controleAjuste_a+0, 1 
;RelogioDespertador.c,515 :: 		if(controleAjuste_a > 0x03)
	MOVF        _controleAjuste_a+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Alarme105
;RelogioDespertador.c,516 :: 		controleAjuste_a = 0x00;
	CLRF        _controleAjuste_a+0 
L_ajuste_Alarme105:
;RelogioDespertador.c,518 :: 		} // end if botaoAjuste_a && flags.B3
L_ajuste_Alarme104:
;RelogioDespertador.c,520 :: 		switch(controleAjuste_a){
	GOTO        L_ajuste_Alarme106
;RelogioDespertador.c,522 :: 		case 0x00: lcd_chr(1, 3, 'H'); // Ajuste hora
L_ajuste_Alarme108:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,523 :: 		lcd_chr(2, 5, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,524 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,525 :: 		flags2.B1 = 0x00; // Flag que desabilita troca de displays
	BCF         _flags2+0, 1 
;RelogioDespertador.c,526 :: 		flags2.B3 = 0x00; // Flag que desabilita a ativação do alarme
	BCF         _flags2+0, 3 
;RelogioDespertador.c,527 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertador.c,528 :: 		case 0x01: lcd_chr(1, 3, 'M'); // Ajuste minuto
L_ajuste_Alarme109:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,529 :: 		lcd_chr(2, 5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,530 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,531 :: 		lcd_chr(2, 8, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,532 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,533 :: 		flags2.B1 = 0x00;
	BCF         _flags2+0, 1 
;RelogioDespertador.c,534 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertador.c,535 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertador.c,536 :: 		case 0x02: lcd_chr(1, 3, 'D'); // Ajuste dias
L_ajuste_Alarme110:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,537 :: 		lcd_chr(2, 8, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,538 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,539 :: 		lcd_chr(2, 14, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,540 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,541 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertador.c,542 :: 		flags2.B1 = 0x00;
	BCF         _flags2+0, 1 
;RelogioDespertador.c,543 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertador.c,544 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertador.c,545 :: 		case 0x03: lcd_chr(1, 3, ' ');     // Limpa linha 2
L_ajuste_Alarme111:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,546 :: 		for(i = 0; i < 12; i++)
	CLRF        ajuste_Alarme_i_L0+0 
L_ajuste_Alarme112:
	MOVLW       12
	SUBWF       ajuste_Alarme_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Alarme113
;RelogioDespertador.c,547 :: 		lcd_chr(2, i+5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	ADDWF       ajuste_Alarme_i_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,546 :: 		for(i = 0; i < 12; i++)
	INCF        ajuste_Alarme_i_L0+0, 1 
;RelogioDespertador.c,547 :: 		lcd_chr(2, i+5, ' ');
	GOTO        L_ajuste_Alarme112
L_ajuste_Alarme113:
;RelogioDespertador.c,548 :: 		flags2.B1 = 0x01; // Flag que habilita a troca de displays
	BSF         _flags2+0, 1 
;RelogioDespertador.c,549 :: 		flags2.B3 = 0x01; // Flag que habilita a ativação do alarme
	BSF         _flags2+0, 3 
;RelogioDespertador.c,550 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertador.c,552 :: 		} // end switch controleAjuste_a
L_ajuste_Alarme106:
	MOVF        _controleAjuste_a+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme108
	MOVF        _controleAjuste_a+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme109
	MOVF        _controleAjuste_a+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme110
	MOVF        _controleAjuste_a+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme111
L_ajuste_Alarme107:
;RelogioDespertador.c,554 :: 		if(botaoSoma && flags.B4){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_ajuste_Alarme117
	BTFSS       _flags+0, 4 
	GOTO        L_ajuste_Alarme117
L__ajuste_Alarme149:
;RelogioDespertador.c,556 :: 		flags.B4 = 0x00;
	BCF         _flags+0, 4 
;RelogioDespertador.c,558 :: 		switch(controleAjuste_a){
	GOTO        L_ajuste_Alarme118
;RelogioDespertador.c,560 :: 		case 0x00: hora_a++;
L_ajuste_Alarme120:
	INCF        _hora_a+0, 1 
;RelogioDespertador.c,561 :: 		if(hora_a == 0x18)
	MOVF        _hora_a+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Alarme121
;RelogioDespertador.c,562 :: 		hora_a = 0x00;
	CLRF        _hora_a+0 
L_ajuste_Alarme121:
;RelogioDespertador.c,563 :: 		break;
	GOTO        L_ajuste_Alarme119
;RelogioDespertador.c,564 :: 		case 0x01: minuto_a++;
L_ajuste_Alarme122:
	INCF        _minuto_a+0, 1 
;RelogioDespertador.c,565 :: 		if(minuto_a == 0x3C)
	MOVF        _minuto_a+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Alarme123
;RelogioDespertador.c,566 :: 		minuto_a = 0x00;
	CLRF        _minuto_a+0 
L_ajuste_Alarme123:
;RelogioDespertador.c,567 :: 		break;
	GOTO        L_ajuste_Alarme119
;RelogioDespertador.c,568 :: 		case 0x02: dia_a++;
L_ajuste_Alarme124:
	INCF        _dia_a+0, 1 
;RelogioDespertador.c,569 :: 		if(dia_a == 0x07)
	MOVF        _dia_a+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Alarme125
;RelogioDespertador.c,570 :: 		dia_a = 0x00;
	CLRF        _dia_a+0 
L_ajuste_Alarme125:
;RelogioDespertador.c,571 :: 		break;
	GOTO        L_ajuste_Alarme119
;RelogioDespertador.c,573 :: 		} // end switch controleAjuste_a
L_ajuste_Alarme118:
	MOVF        _controleAjuste_a+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme120
	MOVF        _controleAjuste_a+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme122
	MOVF        _controleAjuste_a+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme124
L_ajuste_Alarme119:
;RelogioDespertador.c,575 :: 		} // end if botaoSoma && flags.B4
L_ajuste_Alarme117:
;RelogioDespertador.c,577 :: 		if(botaoSoma10 && flags.B5){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_ajuste_Alarme128
	BTFSS       _flags+0, 5 
	GOTO        L_ajuste_Alarme128
L__ajuste_Alarme148:
;RelogioDespertador.c,579 :: 		flags.B5 = 0x00;
	BCF         _flags+0, 5 
;RelogioDespertador.c,581 :: 		switch(controleAjuste_a){
	GOTO        L_ajuste_Alarme129
;RelogioDespertador.c,583 :: 		case 0x00: hora_a = hora_a + 10;
L_ajuste_Alarme131:
	MOVLW       10
	ADDWF       _hora_a+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _hora_a+0 
;RelogioDespertador.c,584 :: 		if(hora_a >= 0x18)
	MOVLW       24
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Alarme132
;RelogioDespertador.c,585 :: 		hora_a = 0x00;
	CLRF        _hora_a+0 
L_ajuste_Alarme132:
;RelogioDespertador.c,586 :: 		break;
	GOTO        L_ajuste_Alarme130
;RelogioDespertador.c,587 :: 		case 0x01: minuto_a = minuto_a + 10;
L_ajuste_Alarme133:
	MOVLW       10
	ADDWF       _minuto_a+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _minuto_a+0 
;RelogioDespertador.c,588 :: 		if(minuto_a >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Alarme134
;RelogioDespertador.c,589 :: 		minuto_a = 0x00;
	CLRF        _minuto_a+0 
L_ajuste_Alarme134:
;RelogioDespertador.c,590 :: 		break;
	GOTO        L_ajuste_Alarme130
;RelogioDespertador.c,592 :: 		} // end switch controleAjuste_a
L_ajuste_Alarme129:
	MOVF        _controleAjuste_a+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme131
	MOVF        _controleAjuste_a+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_ajuste_Alarme133
L_ajuste_Alarme130:
;RelogioDespertador.c,594 :: 		} // end if botaoSoma10 && flags.B5
L_ajuste_Alarme128:
;RelogioDespertador.c,596 :: 		} // end void ajuste_Alarme
	RETURN      0
; end of _ajuste_Alarme

_CustomChar:

;RelogioDespertador.c,605 :: 		void CustomChar(char pos_row, char pos_char) {
;RelogioDespertador.c,607 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertador.c,608 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar135:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar136
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
	GOTO        L_CustomChar135
L_CustomChar136:
;RelogioDespertador.c,609 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertador.c,610 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertador.c,611 :: 		}
	RETURN      0
; end of _CustomChar

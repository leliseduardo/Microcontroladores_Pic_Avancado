
_interrupt:

;RelogioDespertadorTermometro.c,79 :: 		void interrupt() {
;RelogioDespertadorTermometro.c,81 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;RelogioDespertadorTermometro.c,83 :: 		asm BSF TMR1H,7;
	BSF         TMR1H+0, 7, 1
;RelogioDespertadorTermometro.c,85 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;RelogioDespertadorTermometro.c,87 :: 		relogio();
	CALL        _relogio+0, 0
;RelogioDespertadorTermometro.c,89 :: 		if(ligaBuzzer)
	BTFSS       _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
	GOTO        L_interrupt1
;RelogioDespertadorTermometro.c,90 :: 		buzzer = ~buzzer;
	BTG         LATB0_bit+0, 0 
L_interrupt1:
;RelogioDespertadorTermometro.c,91 :: 		} // end if TMR1IF_bit
L_interrupt0:
;RelogioDespertadorTermometro.c,93 :: 		} // end void interrupt
L__interrupt164:
	RETFIE      1
; end of _interrupt

_main:

;RelogioDespertadorTermometro.c,96 :: 		void main() {
;RelogioDespertadorTermometro.c,101 :: 		INTCON = 0xC0; // Habilita a interrupção global e por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;RelogioDespertadorTermometro.c,104 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
	BSF         TMR1IE_bit+0, 0 
;RelogioDespertadorTermometro.c,107 :: 		T1CON = 0x0B; // Configura o timer1 com 8 bits,pic com outro oscilador, prescaler 1:1, liga o oscilador do timer1, síncrono, clock
	MOVLW       11
	MOVWF       T1CON+0 
;RelogioDespertadorTermometro.c,111 :: 		TMR1L = 0x00; // Inicia o timer1 em 32768, para uma contagem de 32768
	CLRF        TMR1L+0 
;RelogioDespertadorTermometro.c,112 :: 		TMR1H = 0x80;
	MOVLW       128
	MOVWF       TMR1H+0 
;RelogioDespertadorTermometro.c,115 :: 		ADCON0 = 0x01; // Configura AN0 como canal analógico e ativa o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;RelogioDespertadorTermometro.c,116 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão em Vss e Vdd e configura apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;RelogioDespertadorTermometro.c,118 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;RelogioDespertadorTermometro.c,119 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;RelogioDespertadorTermometro.c,121 :: 		buzzer = 0x00; // Inicia LATB0_bit em Low
	BCF         LATB0_bit+0, 0 
;RelogioDespertadorTermometro.c,122 :: 		ligaBuzzer = 0; // Inicia o bit ligaBuzzer em 0
	BCF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
;RelogioDespertadorTermometro.c,125 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;RelogioDespertadorTermometro.c,126 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertadorTermometro.c,127 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertadorTermometro.c,130 :: 		while(1){
L_main2:
;RelogioDespertadorTermometro.c,132 :: 		troca_Display();
	CALL        _troca_Display+0, 0
;RelogioDespertadorTermometro.c,134 :: 		ativa_Alarme();
	CALL        _ativa_Alarme+0, 0
;RelogioDespertadorTermometro.c,136 :: 		celcius();
	CALL        _celcius+0, 0
;RelogioDespertadorTermometro.c,138 :: 		} //end loop infinito
	GOTO        L_main2
;RelogioDespertadorTermometro.c,139 :: 		} // end void main
	GOTO        $+0
; end of _main

_troca_Display:

;RelogioDespertadorTermometro.c,144 :: 		void troca_Display(){
;RelogioDespertadorTermometro.c,146 :: 		if(flags.B6){
	BTFSS       _flags+0, 6 
	GOTO        L_troca_Display4
;RelogioDespertadorTermometro.c,148 :: 		if(!botaoAlarme) flags.B7 = 0x01;
	BTFSC       RB4_bit+0, 4 
	GOTO        L_troca_Display5
	BSF         _flags+0, 7 
L_troca_Display5:
;RelogioDespertadorTermometro.c,150 :: 		controleAjuste_a = 0x00; // Para que flags2.B1 seja = 0x00 na troca do display
	CLRF        _controleAjuste_a+0 
;RelogioDespertadorTermometro.c,152 :: 		} // end is flags.B6
L_troca_Display4:
;RelogioDespertadorTermometro.c,154 :: 		if((botaoAlarme && flags.B7) || flags2.B0){
	BTFSS       RB4_bit+0, 4 
	GOTO        L__troca_Display152
	BTFSS       _flags+0, 7 
	GOTO        L__troca_Display152
	GOTO        L__troca_Display151
L__troca_Display152:
	BTFSC       _flags2+0, 0 
	GOTO        L__troca_Display151
	GOTO        L_troca_Display10
L__troca_Display151:
;RelogioDespertadorTermometro.c,156 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertadorTermometro.c,157 :: 		flags.B7 = 0x00;
	BCF         _flags+0, 7 
;RelogioDespertadorTermometro.c,158 :: 		flags2.B0 = 0x01;
	BSF         _flags2+0, 0 
;RelogioDespertadorTermometro.c,160 :: 		display_Alarme();
	CALL        _display_Alarme+0, 0
;RelogioDespertadorTermometro.c,161 :: 		ajuste_Alarme();
	CALL        _ajuste_Alarme+0, 0
;RelogioDespertadorTermometro.c,163 :: 		if(flags2.B1){
	BTFSS       _flags2+0, 1 
	GOTO        L_troca_Display11
;RelogioDespertadorTermometro.c,165 :: 		if(!botaoAlarme) flags2.B2 = 0x01;
	BTFSC       RB4_bit+0, 4 
	GOTO        L_troca_Display12
	BSF         _flags2+0, 2 
L_troca_Display12:
;RelogioDespertadorTermometro.c,167 :: 		if(botaoAlarme && flags2.B2) flags2.B0 = 0x00;
	BTFSS       RB4_bit+0, 4 
	GOTO        L_troca_Display15
	BTFSS       _flags2+0, 2 
	GOTO        L_troca_Display15
L__troca_Display150:
	BCF         _flags2+0, 0 
L_troca_Display15:
;RelogioDespertadorTermometro.c,169 :: 		} // end if flags2.B1
L_troca_Display11:
;RelogioDespertadorTermometro.c,171 :: 		} // end if botaoAlarme && flags.B7
	GOTO        L_troca_Display16
L_troca_Display10:
;RelogioDespertadorTermometro.c,174 :: 		flags2.B1 = 0x00;
	BCF         _flags2+0, 1 
;RelogioDespertadorTermometro.c,175 :: 		flags2.B2 = 0x00;
	BCF         _flags2+0, 2 
;RelogioDespertadorTermometro.c,177 :: 		display_Relogio();
	CALL        _display_Relogio+0, 0
;RelogioDespertadorTermometro.c,178 :: 		Ajuste_Relogio();
	CALL        _ajuste_Relogio+0, 0
;RelogioDespertadorTermometro.c,180 :: 		} // end else botaoAlarme && flags.B7
L_troca_Display16:
;RelogioDespertadorTermometro.c,182 :: 		} // end void display_Troca
	RETURN      0
; end of _troca_Display

_ativa_Alarme:

;RelogioDespertadorTermometro.c,184 :: 		void ativa_Alarme(){
;RelogioDespertadorTermometro.c,186 :: 		if(flags2.B3){
	BTFSS       _flags2+0, 3 
	GOTO        L_ativa_Alarme17
;RelogioDespertadorTermometro.c,187 :: 		if(!botaoSoma10) flags2.B4 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ativa_Alarme18
	BSF         _flags2+0, 4 
L_ativa_Alarme18:
;RelogioDespertadorTermometro.c,189 :: 		if(ligaBuzzer){
	BTFSS       _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
	GOTO        L_ativa_Alarme19
;RelogioDespertadorTermometro.c,191 :: 		if(!botaoSoma) flags2.B7 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_ativa_Alarme20
	BSF         _flags2+0, 7 
L_ativa_Alarme20:
;RelogioDespertadorTermometro.c,193 :: 		if(botaoSoma && flags2.B7){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_ativa_Alarme23
	BTFSS       _flags2+0, 7 
	GOTO        L_ativa_Alarme23
L__ativa_Alarme156:
;RelogioDespertadorTermometro.c,195 :: 		flags2.B7 = 0x00;
	BCF         _flags2+0, 7 
;RelogioDespertadorTermometro.c,197 :: 		ligaBuzzer = 0x00;
	BCF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
;RelogioDespertadorTermometro.c,198 :: 		buzzer = 0;
	BCF         LATB0_bit+0, 0 
;RelogioDespertadorTermometro.c,199 :: 		flags2.B6 = 0x01;
	BSF         _flags2+0, 6 
;RelogioDespertadorTermometro.c,201 :: 		} // end if botaoSoma && flags2.B7
L_ativa_Alarme23:
;RelogioDespertadorTermometro.c,203 :: 		} // end if ligaBuzzer
L_ativa_Alarme19:
;RelogioDespertadorTermometro.c,205 :: 		if((botaoSoma10 && flags2.B4) || flags2.B5){
	BTFSS       RB5_bit+0, 5 
	GOTO        L__ativa_Alarme155
	BTFSS       _flags2+0, 4 
	GOTO        L__ativa_Alarme155
	GOTO        L__ativa_Alarme154
L__ativa_Alarme155:
	BTFSC       _flags2+0, 5 
	GOTO        L__ativa_Alarme154
	GOTO        L_ativa_Alarme28
L__ativa_Alarme154:
;RelogioDespertadorTermometro.c,207 :: 		flags2.B5 = 0x01;
	BSF         _flags2+0, 5 
;RelogioDespertadorTermometro.c,209 :: 		CustomChar(1, 4, 1);
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       4
	MOVWF       FARG_CustomChar_pos_char+0 
	MOVLW       1
	MOVWF       FARG_CustomChar_option+0 
	CALL        _CustomChar+0, 0
;RelogioDespertadorTermometro.c,210 :: 		alarme();
	CALL        _alarme+0, 0
;RelogioDespertadorTermometro.c,212 :: 		if(!botaoSoma10) flags2.B6 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ativa_Alarme29
	BSF         _flags2+0, 6 
L_ativa_Alarme29:
;RelogioDespertadorTermometro.c,214 :: 		if(botaoSoma10 && flags2.B6){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_ativa_Alarme32
	BTFSS       _flags2+0, 6 
	GOTO        L_ativa_Alarme32
L__ativa_Alarme153:
;RelogioDespertadorTermometro.c,216 :: 		flags2.B6 = 0x00;
	BCF         _flags2+0, 6 
;RelogioDespertadorTermometro.c,217 :: 		flags2.B5 = 0x00;
	BCF         _flags2+0, 5 
;RelogioDespertadorTermometro.c,218 :: 		flags2.B4 = 0x00;
	BCF         _flags2+0, 4 
;RelogioDespertadorTermometro.c,219 :: 		ligaBuzzer = 0x00;
	BCF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
;RelogioDespertadorTermometro.c,220 :: 		buzzer = 0;
	BCF         LATB0_bit+0, 0 
;RelogioDespertadorTermometro.c,222 :: 		lcd_chr(1, 4, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,224 :: 		} // end if !botaoSoma10 && flags2.B4
L_ativa_Alarme32:
;RelogioDespertadorTermometro.c,226 :: 		} // end if botaoSoma10 && flags2.B4
L_ativa_Alarme28:
;RelogioDespertadorTermometro.c,228 :: 		} // end if flags2.B3
L_ativa_Alarme17:
;RelogioDespertadorTermometro.c,230 :: 		}
	RETURN      0
; end of _ativa_Alarme

_relogio:

;RelogioDespertadorTermometro.c,234 :: 		void relogio(){
;RelogioDespertadorTermometro.c,236 :: 		segundo++;
	INCF        _segundo+0, 1 
;RelogioDespertadorTermometro.c,238 :: 		if(segundo == 0x3C){ // Se segundo = 60
	MOVF        _segundo+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio33
;RelogioDespertadorTermometro.c,240 :: 		segundo = 0x00;
	CLRF        _segundo+0 
;RelogioDespertadorTermometro.c,241 :: 		minuto++;
	INCF        _minuto+0, 1 
;RelogioDespertadorTermometro.c,243 :: 		if(minuto == 0x3C){ // se minuto = 60
	MOVF        _minuto+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio34
;RelogioDespertadorTermometro.c,245 :: 		minuto = 0x00;
	CLRF        _minuto+0 
;RelogioDespertadorTermometro.c,246 :: 		hora++;
	INCF        _hora+0, 1 
;RelogioDespertadorTermometro.c,248 :: 		if(hora == 0x18){ // Se hora = 24
	MOVF        _hora+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio35
;RelogioDespertadorTermometro.c,250 :: 		hora = 0x00;
	CLRF        _hora+0 
;RelogioDespertadorTermometro.c,251 :: 		dia++;
	INCF        _dia+0, 1 
;RelogioDespertadorTermometro.c,253 :: 		if(dia == 0x07) // Se dia = 7. Lembrando que a variável dia começa em 0
	MOVF        _dia+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_relogio36
;RelogioDespertadorTermometro.c,254 :: 		dia = 0x00;
	CLRF        _dia+0 
L_relogio36:
;RelogioDespertadorTermometro.c,256 :: 		} // end if hora == 0x18
L_relogio35:
;RelogioDespertadorTermometro.c,258 :: 		} // end if minuto == 0x3C
L_relogio34:
;RelogioDespertadorTermometro.c,260 :: 		} // end if segundo == 0x3C
L_relogio33:
;RelogioDespertadorTermometro.c,263 :: 		} // end void relogio
	RETURN      0
; end of _relogio

_display_Relogio:

;RelogioDespertadorTermometro.c,265 :: 		void display_Relogio(){
;RelogioDespertadorTermometro.c,267 :: 		texto[7] = segundo%10 + '0';
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
;RelogioDespertadorTermometro.c,268 :: 		texto[6] = segundo/10 + '0';
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
;RelogioDespertadorTermometro.c,269 :: 		texto[4] = minuto%10 + '0';
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
;RelogioDespertadorTermometro.c,270 :: 		texto[3] = minuto/10 + '0';
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
;RelogioDespertadorTermometro.c,271 :: 		texto[1] = hora%10 + '0';
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
;RelogioDespertadorTermometro.c,272 :: 		texto[0] = hora/10 + '0';
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
;RelogioDespertadorTermometro.c,274 :: 		lcd_chr(1, 3, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,275 :: 		lcd_out(1, 5, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _texto+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _texto+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RelogioDespertadorTermometro.c,277 :: 		switch(dia){
	GOTO        L_display_Relogio37
;RelogioDespertadorTermometro.c,279 :: 		case 0: lcd_chr(1, 14, 'D');
L_display_Relogio39:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,280 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,281 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,282 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertadorTermometro.c,283 :: 		case 1: lcd_chr(1, 14, 'S');
L_display_Relogio40:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,284 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,285 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,286 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertadorTermometro.c,287 :: 		case 2: lcd_chr(1, 14, 'T');
L_display_Relogio41:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,288 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,289 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,290 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertadorTermometro.c,291 :: 		case 3: lcd_chr(1, 14, 'Q');
L_display_Relogio42:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,292 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,293 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,294 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertadorTermometro.c,295 :: 		case 4: lcd_chr(1, 14, 'Q');
L_display_Relogio43:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,296 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,297 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,298 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertadorTermometro.c,299 :: 		case 5: lcd_chr(1, 14, 'S');
L_display_Relogio44:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,300 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,301 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,302 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertadorTermometro.c,303 :: 		case 6: lcd_chr(1, 14, 'S');
L_display_Relogio45:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,304 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,305 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,306 :: 		break;
	GOTO        L_display_Relogio38
;RelogioDespertadorTermometro.c,308 :: 		} // end switch dia
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
;RelogioDespertadorTermometro.c,310 :: 		} // end void display_Relogio
	RETURN      0
; end of _display_Relogio

_ajuste_Relogio:

;RelogioDespertadorTermometro.c,312 :: 		void ajuste_Relogio(){
;RelogioDespertadorTermometro.c,316 :: 		if(!botaoAjuste) flags.B0 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_ajuste_Relogio46
	BSF         _flags+0, 0 
L_ajuste_Relogio46:
;RelogioDespertadorTermometro.c,317 :: 		if(!botaoSoma) flags.B1 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_ajuste_Relogio47
	BSF         _flags+0, 1 
L_ajuste_Relogio47:
;RelogioDespertadorTermometro.c,318 :: 		if(!botaoSoma10) flags.B2 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ajuste_Relogio48
	BSF         _flags+0, 2 
L_ajuste_Relogio48:
;RelogioDespertadorTermometro.c,320 :: 		if(botaoAjuste && flags.B0){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_ajuste_Relogio51
	BTFSS       _flags+0, 0 
	GOTO        L_ajuste_Relogio51
L__ajuste_Relogio159:
;RelogioDespertadorTermometro.c,322 :: 		flags.B0 = 0x00;
	BCF         _flags+0, 0 
;RelogioDespertadorTermometro.c,324 :: 		controleAjuste++;
	INCF        _controleAjuste+0, 1 
;RelogioDespertadorTermometro.c,326 :: 		if(controleAjuste > 4)
	MOVF        _controleAjuste+0, 0 
	SUBLW       4
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Relogio52
;RelogioDespertadorTermometro.c,327 :: 		controleAjuste = 0x00;
	CLRF        _controleAjuste+0 
L_ajuste_Relogio52:
;RelogioDespertadorTermometro.c,329 :: 		} // end if botaoAjuste && flags.B0
L_ajuste_Relogio51:
;RelogioDespertadorTermometro.c,331 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio53
;RelogioDespertadorTermometro.c,333 :: 		case 0x00: lcd_chr(1, 1, 'H'); // Ajuste hora
L_ajuste_Relogio55:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,334 :: 		lcd_chr(2, 5, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,335 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,336 :: 		flags.B6 = 0x00; // Flag que desabilita a troca de displays
	BCF         _flags+0, 6 
;RelogioDespertadorTermometro.c,337 :: 		flags2.B3 = 0x00; // Flag que desabilita a ativação do alarme
	BCF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,338 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertadorTermometro.c,339 :: 		case 0x01: lcd_chr(1, 1, 'M'); // Ajuste minuto
L_ajuste_Relogio56:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,340 :: 		lcd_chr(2, 5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,341 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,342 :: 		lcd_chr(2, 8, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,343 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,344 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertadorTermometro.c,345 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,346 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertadorTermometro.c,347 :: 		case 0x02: lcd_chr(1, 1, 'S'); // Ajuste segundos
L_ajuste_Relogio57:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,348 :: 		lcd_chr(2, 8, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,349 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,350 :: 		lcd_chr(2, 11, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,351 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,352 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertadorTermometro.c,353 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,354 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertadorTermometro.c,355 :: 		case 0x03: lcd_chr(1, 1, 'D'); // Ajuste dias
L_ajuste_Relogio58:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,356 :: 		lcd_chr(2, 11, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,357 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,358 :: 		lcd_chr(2, 14, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,359 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,360 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,361 :: 		flags.B6 = 0x00;
	BCF         _flags+0, 6 
;RelogioDespertadorTermometro.c,362 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,363 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertadorTermometro.c,364 :: 		case 0x04: lcd_chr(1, 1, ' ');     // Limpa linha 2
L_ajuste_Relogio59:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,365 :: 		for(i = 0; i < 12; i++)
	CLRF        ajuste_Relogio_i_L0+0 
L_ajuste_Relogio60:
	MOVLW       12
	SUBWF       ajuste_Relogio_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Relogio61
;RelogioDespertadorTermometro.c,366 :: 		lcd_chr(2, i+5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	ADDWF       ajuste_Relogio_i_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,365 :: 		for(i = 0; i < 12; i++)
	INCF        ajuste_Relogio_i_L0+0, 1 
;RelogioDespertadorTermometro.c,366 :: 		lcd_chr(2, i+5, ' ');
	GOTO        L_ajuste_Relogio60
L_ajuste_Relogio61:
;RelogioDespertadorTermometro.c,367 :: 		flags.B6 = 0x01; // Flag que habilita a troca de displays
	BSF         _flags+0, 6 
;RelogioDespertadorTermometro.c,368 :: 		flags2.B3 = 0x01; // Flag que habilita a ativação do alarme
	BSF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,369 :: 		break;
	GOTO        L_ajuste_Relogio54
;RelogioDespertadorTermometro.c,371 :: 		} // end switch controleAjuste
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
;RelogioDespertadorTermometro.c,373 :: 		if(botaoSoma && flags.B1){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_ajuste_Relogio65
	BTFSS       _flags+0, 1 
	GOTO        L_ajuste_Relogio65
L__ajuste_Relogio158:
;RelogioDespertadorTermometro.c,375 :: 		flags.B1 = 0x00;
	BCF         _flags+0, 1 
;RelogioDespertadorTermometro.c,377 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio66
;RelogioDespertadorTermometro.c,379 :: 		case 0x00: hora++;
L_ajuste_Relogio68:
	INCF        _hora+0, 1 
;RelogioDespertadorTermometro.c,380 :: 		if(hora == 0x18)
	MOVF        _hora+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio69
;RelogioDespertadorTermometro.c,381 :: 		hora = 0x00;
	CLRF        _hora+0 
L_ajuste_Relogio69:
;RelogioDespertadorTermometro.c,382 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertadorTermometro.c,383 :: 		case 0x01: minuto++;
L_ajuste_Relogio70:
	INCF        _minuto+0, 1 
;RelogioDespertadorTermometro.c,384 :: 		if(minuto == 0x3C)
	MOVF        _minuto+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio71
;RelogioDespertadorTermometro.c,385 :: 		minuto = 0x00;
	CLRF        _minuto+0 
L_ajuste_Relogio71:
;RelogioDespertadorTermometro.c,386 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertadorTermometro.c,387 :: 		case 0x02: segundo++;
L_ajuste_Relogio72:
	INCF        _segundo+0, 1 
;RelogioDespertadorTermometro.c,388 :: 		if(segundo == 0x3C)
	MOVF        _segundo+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio73
;RelogioDespertadorTermometro.c,389 :: 		segundo = 0x00;
	CLRF        _segundo+0 
L_ajuste_Relogio73:
;RelogioDespertadorTermometro.c,390 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertadorTermometro.c,391 :: 		case 0x03: dia++;
L_ajuste_Relogio74:
	INCF        _dia+0, 1 
;RelogioDespertadorTermometro.c,392 :: 		if(dia == 0x07)
	MOVF        _dia+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Relogio75
;RelogioDespertadorTermometro.c,393 :: 		dia = 0x00;
	CLRF        _dia+0 
L_ajuste_Relogio75:
;RelogioDespertadorTermometro.c,394 :: 		break;
	GOTO        L_ajuste_Relogio67
;RelogioDespertadorTermometro.c,396 :: 		} // end switch controleAjuste
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
;RelogioDespertadorTermometro.c,398 :: 		} // end if botaoSoma && flags.B1
L_ajuste_Relogio65:
;RelogioDespertadorTermometro.c,400 :: 		if(botaoSoma10 && flags.B2){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_ajuste_Relogio78
	BTFSS       _flags+0, 2 
	GOTO        L_ajuste_Relogio78
L__ajuste_Relogio157:
;RelogioDespertadorTermometro.c,402 :: 		flags.B2 = 0x00;
	BCF         _flags+0, 2 
;RelogioDespertadorTermometro.c,404 :: 		switch(controleAjuste){
	GOTO        L_ajuste_Relogio79
;RelogioDespertadorTermometro.c,406 :: 		case 0x00: hora = hora + 10;
L_ajuste_Relogio81:
	MOVLW       10
	ADDWF       _hora+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _hora+0 
;RelogioDespertadorTermometro.c,407 :: 		if(hora >= 0x18)
	MOVLW       24
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio82
;RelogioDespertadorTermometro.c,408 :: 		hora = 0x00;
	CLRF        _hora+0 
L_ajuste_Relogio82:
;RelogioDespertadorTermometro.c,409 :: 		break;
	GOTO        L_ajuste_Relogio80
;RelogioDespertadorTermometro.c,410 :: 		case 0x01: minuto = minuto + 10;
L_ajuste_Relogio83:
	MOVLW       10
	ADDWF       _minuto+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _minuto+0 
;RelogioDespertadorTermometro.c,411 :: 		if(minuto >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio84
;RelogioDespertadorTermometro.c,412 :: 		minuto = 0x00;
	CLRF        _minuto+0 
L_ajuste_Relogio84:
;RelogioDespertadorTermometro.c,413 :: 		break;
	GOTO        L_ajuste_Relogio80
;RelogioDespertadorTermometro.c,414 :: 		case 0x02: segundo = segundo + 10;
L_ajuste_Relogio85:
	MOVLW       10
	ADDWF       _segundo+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _segundo+0 
;RelogioDespertadorTermometro.c,415 :: 		if(segundo >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Relogio86
;RelogioDespertadorTermometro.c,416 :: 		segundo = 0x00;
	CLRF        _segundo+0 
L_ajuste_Relogio86:
;RelogioDespertadorTermometro.c,417 :: 		break;
	GOTO        L_ajuste_Relogio80
;RelogioDespertadorTermometro.c,419 :: 		} // end switch controleAjuste
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
;RelogioDespertadorTermometro.c,421 :: 		} // end if botaoSoma10 && flags.B2
L_ajuste_Relogio78:
;RelogioDespertadorTermometro.c,423 :: 		} // end void ajuste_Relogio
	RETURN      0
; end of _ajuste_Relogio

_alarme:

;RelogioDespertadorTermometro.c,431 :: 		void alarme(){
;RelogioDespertadorTermometro.c,433 :: 		if(hora == hora_a){
	MOVF        _hora+0, 0 
	XORWF       _hora_a+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_alarme87
;RelogioDespertadorTermometro.c,435 :: 		if(minuto == minuto_a){
	MOVF        _minuto+0, 0 
	XORWF       _minuto_a+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_alarme88
;RelogioDespertadorTermometro.c,437 :: 		if(dia == dia_a)
	MOVF        _dia+0, 0 
	XORWF       _dia_a+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_alarme89
;RelogioDespertadorTermometro.c,438 :: 		ligaBuzzer = 1;
	BSF         _ligaBuzzer+0, BitPos(_ligaBuzzer+0) 
L_alarme89:
;RelogioDespertadorTermometro.c,440 :: 		} // end minuto = minuto_a
L_alarme88:
;RelogioDespertadorTermometro.c,442 :: 		} // end if hora == hora_a
L_alarme87:
;RelogioDespertadorTermometro.c,443 :: 		}
	RETURN      0
; end of _alarme

_display_Alarme:

;RelogioDespertadorTermometro.c,445 :: 		void display_Alarme(){
;RelogioDespertadorTermometro.c,447 :: 		texto2[4] = minuto_a%10 + '0';
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
;RelogioDespertadorTermometro.c,448 :: 		texto2[3] = minuto_a/10 + '0';
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
;RelogioDespertadorTermometro.c,449 :: 		texto2[1] = hora_a%10 + '0';
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
;RelogioDespertadorTermometro.c,450 :: 		texto2[0] = hora_a/10 + '0';
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
;RelogioDespertadorTermometro.c,452 :: 		CustomChar(1, 1, 1);
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_char+0 
	MOVLW       1
	MOVWF       FARG_CustomChar_option+0 
	CALL        _CustomChar+0, 0
;RelogioDespertadorTermometro.c,453 :: 		lcd_out(1, 5, texto2);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _texto2+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _texto2+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;RelogioDespertadorTermometro.c,454 :: 		lcd_chr(1, 10, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,455 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,456 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,458 :: 		switch(dia_a){
	GOTO        L_display_Alarme90
;RelogioDespertadorTermometro.c,460 :: 		case 0: lcd_chr(1, 14, 'D');
L_display_Alarme92:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,461 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,462 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,463 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertadorTermometro.c,464 :: 		case 1: lcd_chr(1, 14, 'S');
L_display_Alarme93:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,465 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,466 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,467 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertadorTermometro.c,468 :: 		case 2: lcd_chr(1, 14, 'T');
L_display_Alarme94:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,469 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,470 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,471 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertadorTermometro.c,472 :: 		case 3: lcd_chr(1, 14, 'Q');
L_display_Alarme95:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,473 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,474 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,475 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertadorTermometro.c,476 :: 		case 4: lcd_chr(1, 14, 'Q');
L_display_Alarme96:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       81
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,477 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,478 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,479 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertadorTermometro.c,480 :: 		case 5: lcd_chr(1, 14, 'S');
L_display_Alarme97:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,481 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,482 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,483 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertadorTermometro.c,484 :: 		case 6: lcd_chr(1, 14, 'S');
L_display_Alarme98:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,485 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,486 :: 		lcd_chr_cp('b');
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,487 :: 		break;
	GOTO        L_display_Alarme91
;RelogioDespertadorTermometro.c,489 :: 		} // end switch dia_a
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
;RelogioDespertadorTermometro.c,491 :: 		} // end display_Alarme
	RETURN      0
; end of _display_Alarme

_ajuste_Alarme:

;RelogioDespertadorTermometro.c,493 :: 		void ajuste_Alarme(){
;RelogioDespertadorTermometro.c,497 :: 		if(!botaoAjuste) flags.B3 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_ajuste_Alarme99
	BSF         _flags+0, 3 
L_ajuste_Alarme99:
;RelogioDespertadorTermometro.c,498 :: 		if(!botaoSoma) flags.B4 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_ajuste_Alarme100
	BSF         _flags+0, 4 
L_ajuste_Alarme100:
;RelogioDespertadorTermometro.c,499 :: 		if(!botaoSoma10) flags.B5 = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_ajuste_Alarme101
	BSF         _flags+0, 5 
L_ajuste_Alarme101:
;RelogioDespertadorTermometro.c,501 :: 		if(botaoAjuste && flags.B3){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_ajuste_Alarme104
	BTFSS       _flags+0, 3 
	GOTO        L_ajuste_Alarme104
L__ajuste_Alarme162:
;RelogioDespertadorTermometro.c,503 :: 		flags.B3 = 0x00;
	BCF         _flags+0, 3 
;RelogioDespertadorTermometro.c,505 :: 		controleAjuste_a++;
	INCF        _controleAjuste_a+0, 1 
;RelogioDespertadorTermometro.c,507 :: 		if(controleAjuste_a > 0x03)
	MOVF        _controleAjuste_a+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Alarme105
;RelogioDespertadorTermometro.c,508 :: 		controleAjuste_a = 0x00;
	CLRF        _controleAjuste_a+0 
L_ajuste_Alarme105:
;RelogioDespertadorTermometro.c,510 :: 		} // end if botaoAjuste_a && flags.B3
L_ajuste_Alarme104:
;RelogioDespertadorTermometro.c,512 :: 		switch(controleAjuste_a){
	GOTO        L_ajuste_Alarme106
;RelogioDespertadorTermometro.c,514 :: 		case 0x00: lcd_chr(1, 3, 'H'); // Ajuste hora
L_ajuste_Alarme108:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,515 :: 		lcd_chr(2, 5, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,516 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,517 :: 		flags2.B1 = 0x00; // Flag que desabilita troca de displays
	BCF         _flags2+0, 1 
;RelogioDespertadorTermometro.c,518 :: 		flags2.B3 = 0x00; // Flag que desabilita a ativação do alarme
	BCF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,519 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertadorTermometro.c,520 :: 		case 0x01: lcd_chr(1, 3, 'M'); // Ajuste minuto
L_ajuste_Alarme109:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,521 :: 		lcd_chr(2, 5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,522 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,523 :: 		lcd_chr(2, 8, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,524 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,525 :: 		flags2.B1 = 0x00;
	BCF         _flags2+0, 1 
;RelogioDespertadorTermometro.c,526 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,527 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertadorTermometro.c,528 :: 		case 0x02: lcd_chr(1, 3, 'D'); // Ajuste dias
L_ajuste_Alarme110:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,529 :: 		lcd_chr(2, 8, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,530 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,531 :: 		lcd_chr(2, 14, '^');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,532 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,533 :: 		lcd_chr_cp('^');
	MOVLW       94
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,534 :: 		flags2.B1 = 0x00;
	BCF         _flags2+0, 1 
;RelogioDespertadorTermometro.c,535 :: 		flags2.B3 = 0x00;
	BCF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,536 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertadorTermometro.c,537 :: 		case 0x03: lcd_chr(1, 3, ' ');     // Limpa linha 2
L_ajuste_Alarme111:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,538 :: 		for(i = 0; i < 12; i++)
	CLRF        ajuste_Alarme_i_L0+0 
L_ajuste_Alarme112:
	MOVLW       12
	SUBWF       ajuste_Alarme_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ajuste_Alarme113
;RelogioDespertadorTermometro.c,539 :: 		lcd_chr(2, i+5, ' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	ADDWF       ajuste_Alarme_i_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,538 :: 		for(i = 0; i < 12; i++)
	INCF        ajuste_Alarme_i_L0+0, 1 
;RelogioDespertadorTermometro.c,539 :: 		lcd_chr(2, i+5, ' ');
	GOTO        L_ajuste_Alarme112
L_ajuste_Alarme113:
;RelogioDespertadorTermometro.c,540 :: 		flags2.B1 = 0x01; // Flag que habilita a troca de displays
	BSF         _flags2+0, 1 
;RelogioDespertadorTermometro.c,541 :: 		flags2.B3 = 0x01; // Flag que habilita a ativação do alarme
	BSF         _flags2+0, 3 
;RelogioDespertadorTermometro.c,542 :: 		break;
	GOTO        L_ajuste_Alarme107
;RelogioDespertadorTermometro.c,544 :: 		} // end switch controleAjuste_a
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
;RelogioDespertadorTermometro.c,546 :: 		if(botaoSoma && flags.B4){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_ajuste_Alarme117
	BTFSS       _flags+0, 4 
	GOTO        L_ajuste_Alarme117
L__ajuste_Alarme161:
;RelogioDespertadorTermometro.c,548 :: 		flags.B4 = 0x00;
	BCF         _flags+0, 4 
;RelogioDespertadorTermometro.c,550 :: 		switch(controleAjuste_a){
	GOTO        L_ajuste_Alarme118
;RelogioDespertadorTermometro.c,552 :: 		case 0x00: hora_a++;
L_ajuste_Alarme120:
	INCF        _hora_a+0, 1 
;RelogioDespertadorTermometro.c,553 :: 		if(hora_a == 0x18)
	MOVF        _hora_a+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Alarme121
;RelogioDespertadorTermometro.c,554 :: 		hora_a = 0x00;
	CLRF        _hora_a+0 
L_ajuste_Alarme121:
;RelogioDespertadorTermometro.c,555 :: 		break;
	GOTO        L_ajuste_Alarme119
;RelogioDespertadorTermometro.c,556 :: 		case 0x01: minuto_a++;
L_ajuste_Alarme122:
	INCF        _minuto_a+0, 1 
;RelogioDespertadorTermometro.c,557 :: 		if(minuto_a == 0x3C)
	MOVF        _minuto_a+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Alarme123
;RelogioDespertadorTermometro.c,558 :: 		minuto_a = 0x00;
	CLRF        _minuto_a+0 
L_ajuste_Alarme123:
;RelogioDespertadorTermometro.c,559 :: 		break;
	GOTO        L_ajuste_Alarme119
;RelogioDespertadorTermometro.c,560 :: 		case 0x02: dia_a++;
L_ajuste_Alarme124:
	INCF        _dia_a+0, 1 
;RelogioDespertadorTermometro.c,561 :: 		if(dia_a == 0x07)
	MOVF        _dia_a+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_ajuste_Alarme125
;RelogioDespertadorTermometro.c,562 :: 		dia_a = 0x00;
	CLRF        _dia_a+0 
L_ajuste_Alarme125:
;RelogioDespertadorTermometro.c,563 :: 		break;
	GOTO        L_ajuste_Alarme119
;RelogioDespertadorTermometro.c,565 :: 		} // end switch controleAjuste_a
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
;RelogioDespertadorTermometro.c,567 :: 		} // end if botaoSoma && flags.B4
L_ajuste_Alarme117:
;RelogioDespertadorTermometro.c,569 :: 		if(botaoSoma10 && flags.B5){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_ajuste_Alarme128
	BTFSS       _flags+0, 5 
	GOTO        L_ajuste_Alarme128
L__ajuste_Alarme160:
;RelogioDespertadorTermometro.c,571 :: 		flags.B5 = 0x00;
	BCF         _flags+0, 5 
;RelogioDespertadorTermometro.c,573 :: 		switch(controleAjuste_a){
	GOTO        L_ajuste_Alarme129
;RelogioDespertadorTermometro.c,575 :: 		case 0x00: hora_a = hora_a + 10;
L_ajuste_Alarme131:
	MOVLW       10
	ADDWF       _hora_a+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _hora_a+0 
;RelogioDespertadorTermometro.c,576 :: 		if(hora_a >= 0x18)
	MOVLW       24
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Alarme132
;RelogioDespertadorTermometro.c,577 :: 		hora_a = 0x00;
	CLRF        _hora_a+0 
L_ajuste_Alarme132:
;RelogioDespertadorTermometro.c,578 :: 		break;
	GOTO        L_ajuste_Alarme130
;RelogioDespertadorTermometro.c,579 :: 		case 0x01: minuto_a = minuto_a + 10;
L_ajuste_Alarme133:
	MOVLW       10
	ADDWF       _minuto_a+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _minuto_a+0 
;RelogioDespertadorTermometro.c,580 :: 		if(minuto_a >= 0x3C)
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_ajuste_Alarme134
;RelogioDespertadorTermometro.c,581 :: 		minuto_a = 0x00;
	CLRF        _minuto_a+0 
L_ajuste_Alarme134:
;RelogioDespertadorTermometro.c,582 :: 		break;
	GOTO        L_ajuste_Alarme130
;RelogioDespertadorTermometro.c,584 :: 		} // end switch controleAjuste_a
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
;RelogioDespertadorTermometro.c,586 :: 		} // end if botaoSoma10 && flags.B5
L_ajuste_Alarme128:
;RelogioDespertadorTermometro.c,588 :: 		} // end void ajuste_Alarme
	RETURN      0
; end of _ajuste_Alarme

_celcius:

;RelogioDespertadorTermometro.c,595 :: 		void celcius(){
;RelogioDespertadorTermometro.c,597 :: 		char dez_t = 0x00, uni_t = 0x00;
	CLRF        celcius_uni_t_L0+0 
;RelogioDespertadorTermometro.c,600 :: 		media = media_Temperatura();
	CALL        _media_Temperatura+0, 0
;RelogioDespertadorTermometro.c,602 :: 		temperatura = ((media * 500) / 1024);
	MOVLW       244
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       R5 
	MOVF        R1, 0 
	MOVWF       R6 
	MOVF        R2, 0 
	MOVWF       R7 
	MOVF        R3, 0 
	MOVWF       R8 
	MOVF        R4, 0 
L__celcius165:
	BZ          L__celcius166
	RRCF        R8, 1 
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	BCF         R8, 7 
	BTFSC       R8, 6 
	BSF         R8, 7 
	ADDLW       255
	GOTO        L__celcius165
L__celcius166:
	MOVF        R5, 0 
	MOVWF       _temperatura+0 
	MOVF        R6, 0 
	MOVWF       _temperatura+1 
	MOVF        R7, 0 
	MOVWF       _temperatura+2 
	MOVF        R8, 0 
	MOVWF       _temperatura+3 
;RelogioDespertadorTermometro.c,604 :: 		if(temperatura > (ultimaTemperatura + 1) || temperatura < (ultimaTemperatura - 1)){
	MOVLW       1
	ADDWF       _ultimaTemperatura+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ultimaTemperatura+1, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ultimaTemperatura+2, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      _ultimaTemperatura+3, 0 
	MOVWF       R4 
	MOVF        R8, 0 
	SUBWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__celcius167
	MOVF        R7, 0 
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__celcius167
	MOVF        R6, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__celcius167
	MOVF        R5, 0 
	SUBWF       R1, 0 
L__celcius167:
	BTFSS       STATUS+0, 0 
	GOTO        L__celcius163
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R3 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R4 
	MOVLW       1
	SUBWF       R1, 1 
	MOVLW       0
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	SUBWFB      R4, 1 
	MOVF        R4, 0 
	SUBWF       _temperatura+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__celcius168
	MOVF        R3, 0 
	SUBWF       _temperatura+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__celcius168
	MOVF        R2, 0 
	SUBWF       _temperatura+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__celcius168
	MOVF        R1, 0 
	SUBWF       _temperatura+0, 0 
L__celcius168:
	BTFSS       STATUS+0, 0 
	GOTO        L__celcius163
	GOTO        L_celcius137
L__celcius163:
;RelogioDespertadorTermometro.c,606 :: 		ultimaTemperatura = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemperatura+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemperatura+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemperatura+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemperatura+3 
;RelogioDespertadorTermometro.c,608 :: 		uni_t = (ultimaTemperatura % 10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _temperatura+0, 0 
	MOVWF       R0 
	MOVF        _temperatura+1, 0 
	MOVWF       R1 
	MOVF        _temperatura+2, 0 
	MOVWF       R2 
	MOVF        _temperatura+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       celcius_uni_t_L0+0 
;RelogioDespertadorTermometro.c,609 :: 		dez_t = (ultimaTemperatura / 10);
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
;RelogioDespertadorTermometro.c,611 :: 		lcd_chr(2, 1, dez_t+48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,612 :: 		lcd_chr_cp(uni_t+48);
	MOVLW       48
	ADDWF       celcius_uni_t_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;RelogioDespertadorTermometro.c,613 :: 		CustomChar(2, 3, 2);
	MOVLW       2
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       3
	MOVWF       FARG_CustomChar_pos_char+0 
	MOVLW       2
	MOVWF       FARG_CustomChar_option+0 
	CALL        _CustomChar+0, 0
;RelogioDespertadorTermometro.c,614 :: 		lcd_chr(2, 4, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,616 :: 		} // end if temperatura > (ultimaTemperatura + 1) || (temperatura < (ultimaTemperatura - 1)
L_celcius137:
;RelogioDespertadorTermometro.c,618 :: 		} // end void celcius
	RETURN      0
; end of _celcius

_media_Temperatura:

;RelogioDespertadorTermometro.c,620 :: 		long media_Temperatura(){
;RelogioDespertadorTermometro.c,623 :: 		long adc = 0x00;
	CLRF        media_Temperatura_adc_L0+0 
	CLRF        media_Temperatura_adc_L0+1 
	CLRF        media_Temperatura_adc_L0+2 
	CLRF        media_Temperatura_adc_L0+3 
;RelogioDespertadorTermometro.c,625 :: 		for(i = 0x00; i < 0x64; i++)
	CLRF        media_Temperatura_i_L0+0 
	CLRF        media_Temperatura_i_L0+1 
L_media_Temperatura138:
	MOVLW       128
	XORWF       media_Temperatura_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__media_Temperatura169
	MOVLW       100
	SUBWF       media_Temperatura_i_L0+0, 0 
L__media_Temperatura169:
	BTFSC       STATUS+0, 0 
	GOTO        L_media_Temperatura139
;RelogioDespertadorTermometro.c,626 :: 		adc += adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       media_Temperatura_adc_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      media_Temperatura_adc_L0+1, 1 
	MOVLW       0
	ADDWFC      media_Temperatura_adc_L0+2, 1 
	ADDWFC      media_Temperatura_adc_L0+3, 1 
;RelogioDespertadorTermometro.c,625 :: 		for(i = 0x00; i < 0x64; i++)
	INFSNZ      media_Temperatura_i_L0+0, 1 
	INCF        media_Temperatura_i_L0+1, 1 
;RelogioDespertadorTermometro.c,626 :: 		adc += adc_read(0);
	GOTO        L_media_Temperatura138
L_media_Temperatura139:
;RelogioDespertadorTermometro.c,628 :: 		return (adc/0x64);
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        media_Temperatura_adc_L0+0, 0 
	MOVWF       R0 
	MOVF        media_Temperatura_adc_L0+1, 0 
	MOVWF       R1 
	MOVF        media_Temperatura_adc_L0+2, 0 
	MOVWF       R2 
	MOVF        media_Temperatura_adc_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
;RelogioDespertadorTermometro.c,630 :: 		} // end int media_Temperatura
	RETURN      0
; end of _media_Temperatura

_CustomChar:

;RelogioDespertadorTermometro.c,637 :: 		void CustomChar(char pos_row, char pos_char, char option) {
;RelogioDespertadorTermometro.c,642 :: 		if(option == 1){
	MOVF        FARG_CustomChar_option+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_CustomChar141
;RelogioDespertadorTermometro.c,645 :: 		Lcd_Cmd(64);
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertadorTermometro.c,646 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L1+0 
L_CustomChar142:
	MOVF        CustomChar_i_L1+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar143
	MOVLW       CustomChar_character_L0+0
	ADDWF       CustomChar_i_L1+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(CustomChar_character_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(CustomChar_character_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L1+0, 1 
	GOTO        L_CustomChar142
L_CustomChar143:
;RelogioDespertadorTermometro.c,647 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertadorTermometro.c,648 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	CLRF        FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,650 :: 		} // end if option == 1
	GOTO        L_CustomChar145
L_CustomChar141:
;RelogioDespertadorTermometro.c,651 :: 		else if(option == 2){
	MOVF        FARG_CustomChar_option+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_CustomChar146
;RelogioDespertadorTermometro.c,654 :: 		Lcd_Cmd(72);
	MOVLW       72
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertadorTermometro.c,655 :: 		for (j = 0; j <= 7; j++) Lcd_Chr_CP(character2[j]);
	CLRF        CustomChar_j_L1+0 
L_CustomChar147:
	MOVF        CustomChar_j_L1+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar148
	MOVLW       CustomChar_character2_L0+0
	ADDWF       CustomChar_j_L1+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(CustomChar_character2_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(CustomChar_character2_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_j_L1+0, 1 
	GOTO        L_CustomChar147
L_CustomChar148:
;RelogioDespertadorTermometro.c,656 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;RelogioDespertadorTermometro.c,657 :: 		Lcd_Chr(pos_row, pos_char, 1);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;RelogioDespertadorTermometro.c,659 :: 		} // end if option == 2
L_CustomChar146:
L_CustomChar145:
;RelogioDespertadorTermometro.c,660 :: 		}
	RETURN      0
; end of _CustomChar

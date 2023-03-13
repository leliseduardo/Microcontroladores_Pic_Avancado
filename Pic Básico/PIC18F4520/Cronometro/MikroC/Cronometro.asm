
_interrupt:

;Cronometro.c,64 :: 		void interrupt(){
;Cronometro.c,66 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;Cronometro.c,68 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;Cronometro.c,69 :: 		TMR0L = 0xF0;
	MOVLW       240
	MOVWF       TMR0L+0 
;Cronometro.c,70 :: 		TMR0H = 0xD8;
	MOVLW       216
	MOVWF       TMR0H+0 
;Cronometro.c,72 :: 		cronometro();
	CALL        _cronometro+0, 0
;Cronometro.c,74 :: 		saidaTeste = ~saidaTeste;
	BTG         LATB0_bit+0, 0 
;Cronometro.c,75 :: 		} // end if TMR0IF_bit
L_interrupt0:
;Cronometro.c,77 :: 		} // end void interrupt
L__interrupt18:
	RETFIE      1
; end of _interrupt

_main:

;Cronometro.c,79 :: 		void main() {
;Cronometro.c,82 :: 		INTCON = 0x80; // Habilita a interrupção global, desabilita a interrupção por overflow do timer0, por enquanto
	MOVLW       128
	MOVWF       INTCON+0 
;Cronometro.c,85 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;Cronometro.c,86 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;Cronometro.c,87 :: 		T0CS_bit = 0x00; // Incrementa o timer0 com o ciclo de máquina
	BCF         T0CS_bit+0, 5 
;Cronometro.c,88 :: 		PSA_bit = 0x01; // Não associa o prescaler ao timer0, isso equivale a prescaler 1:1
	BSF         PSA_bit+0, 3 
;Cronometro.c,90 :: 		TMR0L = 0xF0; // Inicia <TMR0L::TMR0H> em 55536, para uma contagem de 10000
	MOVLW       240
	MOVWF       TMR0L+0 
;Cronometro.c,91 :: 		TMR0H = 0xD8;
	MOVLW       216
	MOVWF       TMR0H+0 
;Cronometro.c,93 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Cronometro.c,94 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;Cronometro.c,95 :: 		saidaTeste = 0x00; // Inicia LATB0 em Low
	BCF         LATB0_bit+0, 0 
;Cronometro.c,98 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;Cronometro.c,99 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Cronometro.c,100 :: 		lcd_CMD(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Cronometro.c,103 :: 		while(1){
L_main1:
;Cronometro.c,105 :: 		if(!botaoIniciaPara) flagBotoes.B0 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_main3
	BSF         _flagBotoes+0, 0 
L_main3:
;Cronometro.c,107 :: 		if(!TMR0IE_bit) // Se a interrupção do timer0 está desligada
	BTFSC       TMR0IE_bit+0, 5 
	GOTO        L_main4
;Cronometro.c,108 :: 		if(!botaoZera) flagBotoes.B1 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_main5
	BSF         _flagBotoes+0, 1 
L_main5:
L_main4:
;Cronometro.c,110 :: 		if(botaoIniciaPara && flagBotoes.B0){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_main8
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_main8
L__main17:
;Cronometro.c,112 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;Cronometro.c,114 :: 		TMR0IE_bit = ~TMR0IE_bit;
	BTG         TMR0IE_bit+0, 5 
;Cronometro.c,115 :: 		} // end if botaoIniciaPara && flagBotoes.B0
L_main8:
;Cronometro.c,117 :: 		if(botaoZera && flagBotoes.B1){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_main11
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_main11
L__main16:
;Cronometro.c,119 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;Cronometro.c,121 :: 		hora = 0x00;
	CLRF        _hora+0 
;Cronometro.c,122 :: 		minutos = 0x00;
	CLRF        _minutos+0 
;Cronometro.c,123 :: 		segundos = 0x00;
	CLRF        _segundos+0 
;Cronometro.c,124 :: 		centesimo = 0x00;
	CLRF        _centesimo+0 
;Cronometro.c,125 :: 		} // end if botaoZera && flagBotoes.B1
L_main11:
;Cronometro.c,127 :: 		display_Cronometro();
	CALL        _display_Cronometro+0, 0
;Cronometro.c,129 :: 		} // end loop infinito
	GOTO        L_main1
;Cronometro.c,131 :: 		} // end void main
	GOTO        $+0
; end of _main

_cronometro:

;Cronometro.c,133 :: 		void cronometro(){
;Cronometro.c,135 :: 		centesimo++;
	INCF        _centesimo+0, 1 
;Cronometro.c,137 :: 		if(centesimo == 0x64){ // Se centesimo = 100
	MOVF        _centesimo+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_cronometro12
;Cronometro.c,139 :: 		centesimo = 0x00;
	CLRF        _centesimo+0 
;Cronometro.c,141 :: 		segundos++;
	INCF        _segundos+0, 1 
;Cronometro.c,143 :: 		if(segundos == 0x3C){ // Se segundos = 60
	MOVF        _segundos+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_cronometro13
;Cronometro.c,145 :: 		segundos = 0x00;
	CLRF        _segundos+0 
;Cronometro.c,147 :: 		minutos++;
	INCF        _minutos+0, 1 
;Cronometro.c,149 :: 		if(minutos == 0x6C){ // Se minutos = 60
	MOVF        _minutos+0, 0 
	XORLW       108
	BTFSS       STATUS+0, 2 
	GOTO        L_cronometro14
;Cronometro.c,151 :: 		minutos = 0x00;
	CLRF        _minutos+0 
;Cronometro.c,153 :: 		hora++;
	INCF        _hora+0, 1 
;Cronometro.c,155 :: 		if(hora == 0x18) // Se hora = 24
	MOVF        _hora+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_cronometro15
;Cronometro.c,156 :: 		hora = 0x00;
	CLRF        _hora+0 
L_cronometro15:
;Cronometro.c,159 :: 		} // end if minutos = 60
L_cronometro14:
;Cronometro.c,161 :: 		} // end if segundos == 0x3C
L_cronometro13:
;Cronometro.c,163 :: 		} // end if centesimo == 0x64
L_cronometro12:
;Cronometro.c,165 :: 		} // end void cronometro
	RETURN      0
; end of _cronometro

_display_Cronometro:

;Cronometro.c,167 :: 		void display_Cronometro(){
;Cronometro.c,169 :: 		texto[0] = hora/10 + '0';
	MOVF        _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVF        _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hora+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,170 :: 		texto[1] = hora%10 + '0';
	MOVLW       1
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _hora+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,171 :: 		texto[3] = minutos/10 + '0';
	MOVLW       3
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minutos+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,172 :: 		texto[4] = minutos%10 + '0';
	MOVLW       4
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _minutos+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,173 :: 		texto[6] = segundos/10 + '0';
	MOVLW       6
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _segundos+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,174 :: 		texto[7] = segundos%10 + '0';
	MOVLW       7
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _segundos+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,175 :: 		texto[9] = centesimo/10 + '0';
	MOVLW       9
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _centesimo+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,176 :: 		texto[10] = centesimo%10 + '0';
	MOVLW       10
	ADDWF       _texto+0, 0 
	MOVWF       FLOC__display_Cronometro+0 
	MOVLW       0
	ADDWFC      _texto+1, 0 
	MOVWF       FLOC__display_Cronometro+1 
	MOVLW       10
	MOVWF       R4 
	MOVF        _centesimo+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__display_Cronometro+0, FSR1L
	MOVFF       FLOC__display_Cronometro+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;Cronometro.c,178 :: 		lcd_out(1, 3, texto);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _texto+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _texto+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Cronometro.c,180 :: 		} // end void display_Cronometro
	RETURN      0
; end of _display_Cronometro


_interrupt:

;PWMMotorLCD2.c,83 :: 		void interrupt(){
;PWMMotorLCD2.c,85 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;PWMMotorLCD2.c,87 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;PWMMotorLCD2.c,88 :: 		TMR1L = 0xB0;
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD2.c,89 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD2.c,91 :: 		cont++;
	INCF        _cont+0, 1 
;PWMMotorLCD2.c,93 :: 		if(cont == 40){
	MOVF        _cont+0, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;PWMMotorLCD2.c,95 :: 		cont = 0x00;
	CLRF        _cont+0 
;PWMMotorLCD2.c,96 :: 		control = 1;
	BSF         _control+0, BitPos(_control+0) 
;PWMMotorLCD2.c,97 :: 		} // end cont == 40
L_interrupt1:
;PWMMotorLCD2.c,99 :: 		} // end if TMR1IF_bit
L_interrupt0:
;PWMMotorLCD2.c,101 :: 		} // end void interrupt
L__interrupt28:
	RETFIE      1
; end of _interrupt

_main:

;PWMMotorLCD2.c,103 :: 		void main() {
;PWMMotorLCD2.c,106 :: 		INTCON = 0xC0; // Habilita a interrupção global e a interrupção por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;PWMMotorLCD2.c,109 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção por overflow do timer1
	BSF         TMR1IE_bit+0, 0 
;PWMMotorLCD2.c,111 :: 		T1CON = 0x00; // Configura o timer1 com 8 bits, prescaler 1:1, incrementa com ciclo de máquina e inicialmente timer1 desabilitado
	CLRF        T1CON+0 
;PWMMotorLCD2.c,114 :: 		TMR1L = 0xB0; // Inicia em 15536, para uma contagem de 50000
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD2.c,115 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD2.c,117 :: 		ADCON1 = 0x0F; // Configura todas as portas que poderiam ser analógicas como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;PWMMotorLCD2.c,118 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;PWMMotorLCD2.c,119 :: 		control = 0; // Inicia o bit control em 0
	BCF         _control+0, BitPos(_control+0) 
;PWMMotorLCD2.c,121 :: 		lcd_Init();
	CALL        _Lcd_Init+0, 0
;PWMMotorLCD2.c,122 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWMMotorLCD2.c,123 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWMMotorLCD2.c,125 :: 		set_Frequency();
	CALL        _set_Frequency+0, 0
;PWMMotorLCD2.c,126 :: 		for(i = 0; i < 17; i++) lcd_chr(1, i, ' ');
	CLRF        _i+0 
L_main2:
	MOVLW       17
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        _i+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	INCF        _i+0, 1 
	GOTO        L_main2
L_main3:
;PWMMotorLCD2.c,128 :: 		CCP1CON = 0x0C;
	MOVLW       12
	MOVWF       CCP1CON+0 
;PWMMotorLCD2.c,129 :: 		T2CON = 0x04; // Habilita o timer2, prescaler 1:1 e postscaler 1:1
	MOVLW       4
	MOVWF       T2CON+0 
;PWMMotorLCD2.c,130 :: 		PR2 = parametro; // PR2 é o registrador que define até que numero o timer2 irá contar, de TMR2 até PR2
	MOVF        _parametro+0, 0 
	MOVWF       PR2+0 
;PWMMotorLCD2.c,131 :: 		PWM1_Stop();
	CALL        _PWM1_Stop+0, 0
;PWMMotorLCD2.c,132 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMMotorLCD2.c,134 :: 		control = 0;
	BCF         _control+0, BitPos(_control+0) 
;PWMMotorLCD2.c,135 :: 		set_Duty();
	CALL        _set_Duty+0, 0
;PWMMotorLCD2.c,136 :: 		for(i = 0; i < 17; i++) lcd_chr(1, i, ' ');
	CLRF        _i+0 
L_main5:
	MOVLW       17
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        _i+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	INCF        _i+0, 1 
	GOTO        L_main5
L_main6:
;PWMMotorLCD2.c,137 :: 		lcd_out(1, 3, "Motor acionado");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_PWMMotorLCD2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_PWMMotorLCD2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PWMMotorLCD2.c,139 :: 		PWM1_start();
	CALL        _PWM1_Start+0, 0
;PWMMotorLCD2.c,140 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMMotorLCD2.c,143 :: 		while(1){
L_main8:
;PWMMotorLCD2.c,147 :: 		} // end loop infinito
	GOTO        L_main8
;PWMMotorLCD2.c,149 :: 		} // end void main
	GOTO        $+0
; end of _main

_set_Frequency:

;PWMMotorLCD2.c,153 :: 		void set_Frequency(){
;PWMMotorLCD2.c,155 :: 		char mil = 0x00, cen = 0x00, dez = 0x00, uni = 0x00;
	CLRF        set_Frequency_mil_L0+0 
	CLRF        set_Frequency_cen_L0+0 
	CLRF        set_Frequency_dez_L0+0 
	CLRF        set_Frequency_uni_L0+0 
;PWMMotorLCD2.c,157 :: 		while(!control){
L_set_Frequency10:
	BTFSC       _control+0, BitPos(_control+0) 
	GOTO        L_set_Frequency11
;PWMMotorLCD2.c,159 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;PWMMotorLCD2.c,161 :: 		lcd_chr(1, 2, 'S');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMMotorLCD2.c,162 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,163 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,164 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,165 :: 		lcd_chr_cp('F');
	MOVLW       70
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,166 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,167 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,168 :: 		lcd_chr_cp('q');
	MOVLW       113
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,169 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,170 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,171 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,172 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,173 :: 		lcd_chr_cp('y');
	MOVLW       121
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,174 :: 		lcd_chr_cp('!');
	MOVLW       33
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,176 :: 		aux = (4 * (parametro + 1));
	MOVF        _parametro+0, 0 
	ADDLW       1
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVF        R2, 0 
	MOVWF       R5 
	RLCF        R4, 1 
	BCF         R4, 0 
	RLCF        R5, 1 
	RLCF        R4, 1 
	BCF         R4, 0 
	RLCF        R5, 1 
	MOVF        R4, 0 
	MOVWF       _aux+0 
	MOVF        R5, 0 
	MOVWF       _aux+1 
;PWMMotorLCD2.c,177 :: 		frequencia  = (4000 / aux);
	MOVLW       160
	MOVWF       R0 
	MOVLW       15
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _frequencia+0 
	MOVF        R1, 0 
	MOVWF       _frequencia+1 
;PWMMotorLCD2.c,179 :: 		mil = frequencia/1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       set_Frequency_mil_L0+0 
;PWMMotorLCD2.c,180 :: 		cen = ((frequencia%1000)/100);
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _frequencia+0, 0 
	MOVWF       R0 
	MOVF        _frequencia+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       set_Frequency_cen_L0+0 
;PWMMotorLCD2.c,181 :: 		dez = ((frequencia%100)/10);
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _frequencia+0, 0 
	MOVWF       R0 
	MOVF        _frequencia+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       set_Frequency_dez_L0+0 
;PWMMotorLCD2.c,182 :: 		uni = frequencia%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _frequencia+0, 0 
	MOVWF       R0 
	MOVF        _frequencia+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       set_Frequency_uni_L0+0 
;PWMMotorLCD2.c,184 :: 		lcd_chr(2, 1, mil + 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       set_Frequency_mil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMMotorLCD2.c,185 :: 		lcd_chr_cp(cen + 48);
	MOVLW       48
	ADDWF       set_Frequency_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,186 :: 		lcd_chr_cp(dez + 48);
	MOVLW       48
	ADDWF       set_Frequency_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,187 :: 		lcd_chr_cp(uni + 48);
	MOVLW       48
	ADDWF       set_Frequency_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,188 :: 		lcd_chr_cp('K');
	MOVLW       75
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,189 :: 		lcd_chr_cp('H');
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,190 :: 		lcd_chr_cp('z');
	MOVLW       122
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,191 :: 		} // end while control
	GOTO        L_set_Frequency10
L_set_Frequency11:
;PWMMotorLCD2.c,192 :: 		} // end void set_Duty
	RETURN      0
; end of _set_Frequency

_set_Duty:

;PWMMotorLCD2.c,194 :: 		void set_Duty(){
;PWMMotorLCD2.c,196 :: 		char cen = 0x00, dez = 0x00, uni = 0x00;
	CLRF        set_Duty_cen_L0+0 
	CLRF        set_Duty_dez_L0+0 
	CLRF        set_Duty_uni_L0+0 
;PWMMotorLCD2.c,198 :: 		flagBotoes.B2 = 0x01;
	BSF         _flagBotoes+0, 2 
;PWMMotorLCD2.c,200 :: 		while(!control){
L_set_Duty12:
	BTFSC       _control+0, BitPos(_control+0) 
	GOTO        L_set_Duty13
;PWMMotorLCD2.c,202 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;PWMMotorLCD2.c,204 :: 		lcd_chr(1, 3, 'S');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMMotorLCD2.c,205 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,206 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,207 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,208 :: 		lcd_chr_cp('D');
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,209 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,210 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,211 :: 		lcd_chr_cp('y');
	MOVLW       121
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,212 :: 		lcd_chr_cp('!');
	MOVLW       33
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,214 :: 		aux = ((100 * duty ) / 255);
	MOVLW       100
	MULWF       _duty+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVLW       255
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
;PWMMotorLCD2.c,216 :: 		cen = aux/100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       set_Duty_cen_L0+0 
;PWMMotorLCD2.c,217 :: 		dez = (aux%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _aux+0, 0 
	MOVWF       R0 
	MOVF        _aux+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       set_Duty_dez_L0+0 
;PWMMotorLCD2.c,218 :: 		uni = aux%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _aux+0, 0 
	MOVWF       R0 
	MOVF        _aux+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       set_Duty_uni_L0+0 
;PWMMotorLCD2.c,220 :: 		lcd_chr(2, 12, cen + 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       set_Duty_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMMotorLCD2.c,221 :: 		lcd_chr_cp(dez + 48);
	MOVLW       48
	ADDWF       set_Duty_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,222 :: 		lcd_chr_cp(uni + 48);
	MOVLW       48
	ADDWF       set_Duty_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,223 :: 		lcd_chr_cp('%');
	MOVLW       37
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD2.c,225 :: 		} // end while control
	GOTO        L_set_Duty12
L_set_Duty13:
;PWMMotorLCD2.c,226 :: 		} // end void set_Duty
	RETURN      0
; end of _set_Duty

_leitura_Botoes:

;PWMMotorLCD2.c,229 :: 		void leitura_Botoes(){
;PWMMotorLCD2.c,231 :: 		if(!decrementa){
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes14
;PWMMotorLCD2.c,233 :: 		flagBotoes.B0 = 0x01;
	BSF         _flagBotoes+0, 0 
;PWMMotorLCD2.c,235 :: 		TMR1ON_bit = 0x01;
	BSF         TMR1ON_bit+0, 0 
;PWMMotorLCD2.c,236 :: 		} // end if !decrementa
L_leitura_Botoes14:
;PWMMotorLCD2.c,238 :: 		if(!incrementa) {
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes15
;PWMMotorLCD2.c,240 :: 		flagBotoes.B1 = 0x01;
	BSF         _flagBotoes+0, 1 
;PWMMotorLCD2.c,242 :: 		TMR1ON_bit = 0x01;
	BSF         TMR1ON_bit+0, 0 
;PWMMotorLCD2.c,243 :: 		} // end if !incrementa
L_leitura_Botoes15:
;PWMMotorLCD2.c,245 :: 		if(decrementa && flagBotoes.B0){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes18
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes18
L__leitura_Botoes27:
;PWMMotorLCD2.c,247 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;PWMMotorLCD2.c,248 :: 		TMR1ON_bit = 0x00;
	BCF         TMR1ON_bit+0, 0 
;PWMMotorLCD2.c,249 :: 		TMR1L = 0xB0;
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD2.c,250 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD2.c,251 :: 		cont = 0x00;
	CLRF        _cont+0 
;PWMMotorLCD2.c,252 :: 		if(!flagBotoes.B2) parametro--;
	BTFSC       _flagBotoes+0, 2 
	GOTO        L_leitura_Botoes19
	DECF        _parametro+0, 1 
L_leitura_Botoes19:
;PWMMotorLCD2.c,253 :: 		if(flagBotoes.B2) duty--;
	BTFSS       _flagBotoes+0, 2 
	GOTO        L_leitura_Botoes20
	DECF        _duty+0, 1 
L_leitura_Botoes20:
;PWMMotorLCD2.c,254 :: 		} // end if decrementa && flagBotoes.B0
L_leitura_Botoes18:
;PWMMotorLCD2.c,256 :: 		if(incrementa && flagBotoes.B1){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes23
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes23
L__leitura_Botoes26:
;PWMMotorLCD2.c,258 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;PWMMotorLCD2.c,259 :: 		TMR1ON_bit = 0x00;
	BCF         TMR1ON_bit+0, 0 
;PWMMotorLCD2.c,260 :: 		TMR1L = 0xB0;
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD2.c,261 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD2.c,262 :: 		cont = 0x00;
	CLRF        _cont+0 
;PWMMotorLCD2.c,263 :: 		if(!flagBotoes.B2) parametro++;
	BTFSC       _flagBotoes+0, 2 
	GOTO        L_leitura_Botoes24
	INCF        _parametro+0, 1 
L_leitura_Botoes24:
;PWMMotorLCD2.c,264 :: 		if(flagBotoes.B2) duty++;;
	BTFSS       _flagBotoes+0, 2 
	GOTO        L_leitura_Botoes25
	INCF        _duty+0, 1 
L_leitura_Botoes25:
;PWMMotorLCD2.c,265 :: 		} // end incrementa && flagBotoes.B1
L_leitura_Botoes23:
;PWMMotorLCD2.c,267 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

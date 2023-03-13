
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;PWM4Interrupcoes.c,61 :: 		void interrupt(){
;PWM4Interrupcoes.c,63 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;PWM4Interrupcoes.c,65 :: 		INTF_bit = 0x00;
	BCF        INTF_bit+0, 1
;PWM4Interrupcoes.c,67 :: 		controlPWM++;
	INCF       _controlPWM+0, 1
;PWM4Interrupcoes.c,69 :: 		if(controlPWM > 3) controlPWM = 0x01;
	MOVF       _controlPWM+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
	MOVLW      1
	MOVWF      _controlPWM+0
L_interrupt1:
;PWM4Interrupcoes.c,70 :: 		}
L_interrupt0:
;PWM4Interrupcoes.c,72 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt2
;PWM4Interrupcoes.c,74 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;PWM4Interrupcoes.c,76 :: 		if(pwmOut1){
	BTFSS      RA0_bit+0, 0
	GOTO       L_interrupt3
;PWM4Interrupcoes.c,78 :: 		TMR0 = PWM1;
	MOVF       _PWM1+0, 0
	MOVWF      TMR0+0
;PWM4Interrupcoes.c,79 :: 		pwmOut1 = 0x00;
	BCF        RA0_bit+0, 0
;PWM4Interrupcoes.c,80 :: 		}
	GOTO       L_interrupt4
L_interrupt3:
;PWM4Interrupcoes.c,83 :: 		TMR0 = 255 - PWM1;
	MOVF       _PWM1+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;PWM4Interrupcoes.c,84 :: 		pwmOut1 = 0x01;
	BSF        RA0_bit+0, 0
;PWM4Interrupcoes.c,85 :: 		}
L_interrupt4:
;PWM4Interrupcoes.c,86 :: 		}
L_interrupt2:
;PWM4Interrupcoes.c,88 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt5
;PWM4Interrupcoes.c,90 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;PWM4Interrupcoes.c,91 :: 		TMR1H = 0xFF;
	MOVLW      255
	MOVWF      TMR1H+0
;PWM4Interrupcoes.c,93 :: 		if(pwmOut2){
	BTFSS      RA4_bit+0, 4
	GOTO       L_interrupt6
;PWM4Interrupcoes.c,95 :: 		TMR1L = PWM2;
	MOVF       _PWM2+0, 0
	MOVWF      TMR1L+0
;PWM4Interrupcoes.c,96 :: 		pwmOut2 = 0x00;
	BCF        RA4_bit+0, 4
;PWM4Interrupcoes.c,97 :: 		}
	GOTO       L_interrupt7
L_interrupt6:
;PWM4Interrupcoes.c,100 :: 		TMR1L = 255 - PWM2;
	MOVF       _PWM2+0, 0
	SUBLW      255
	MOVWF      TMR1L+0
;PWM4Interrupcoes.c,101 :: 		pwmOut2 = 0x01;
	BSF        RA4_bit+0, 4
;PWM4Interrupcoes.c,102 :: 		}
L_interrupt7:
;PWM4Interrupcoes.c,103 :: 		}
L_interrupt5:
;PWM4Interrupcoes.c,105 :: 		if(TMR2IF_bit){
	BTFSS      TMR2IF_bit+0, 1
	GOTO       L_interrupt8
;PWM4Interrupcoes.c,107 :: 		TMR2IF_bit = 0x00;
	BCF        TMR2IF_bit+0, 1
;PWM4Interrupcoes.c,109 :: 		if(pwmOut3){
	BTFSS      RB1_bit+0, 1
	GOTO       L_interrupt9
;PWM4Interrupcoes.c,111 :: 		TMR2 = PWM3;
	MOVF       _PWM3+0, 0
	MOVWF      TMR2+0
;PWM4Interrupcoes.c,112 :: 		pwmOut3 = 0x00;
	BCF        RB1_bit+0, 1
;PWM4Interrupcoes.c,113 :: 		}
	GOTO       L_interrupt10
L_interrupt9:
;PWM4Interrupcoes.c,116 :: 		TMR2 = 255 - PWM3;
	MOVF       _PWM3+0, 0
	SUBLW      255
	MOVWF      TMR2+0
;PWM4Interrupcoes.c,117 :: 		pwmOut3 = 0x01;
	BSF        RB1_bit+0, 1
;PWM4Interrupcoes.c,118 :: 		}
L_interrupt10:
;PWM4Interrupcoes.c,119 :: 		}
L_interrupt8:
;PWM4Interrupcoes.c,120 :: 		}
L__interrupt39:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;PWM4Interrupcoes.c,122 :: 		void main() {
;PWM4Interrupcoes.c,124 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;PWM4Interrupcoes.c,129 :: 		OPTION_REG = 0x88; // Liga pullups internos, interrup. externa por borda de descida, tmr0 por ciclo de maquina interno, utilizando
	MOVLW      136
	MOVWF      OPTION_REG+0
;PWM4Interrupcoes.c,131 :: 		INTCON = 0xF0; // Habilita a interrupção global, por periféricos e ativa a interrupção do timer1 e interrupção externa
	MOVLW      240
	MOVWF      INTCON+0
;PWM4Interrupcoes.c,134 :: 		T1CON = 0x01; // Ativa o timer1 e configura o prescaler para 1:1
	MOVLW      1
	MOVWF      T1CON+0
;PWM4Interrupcoes.c,135 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1. Essa flag é do registrador PIE1
	BSF        TMR1IE_bit+0, 0
;PWM4Interrupcoes.c,136 :: 		TMR1H = 0xFF; // Fazendo o neeble mais significativo igual a 0xFF = 0b11111111, simula-se um timer de 8 bits, já que tmr1 é de 16
	MOVLW      255
	MOVWF      TMR1H+0
;PWM4Interrupcoes.c,140 :: 		T2CON = 0x04; // Ativa o timer2 e configura o prescaler para 1:1 e o postscaler para 1:1
	MOVLW      4
	MOVWF      T2CON+0
;PWM4Interrupcoes.c,141 :: 		TMR2IE_bit = 0x01; // Habilita a interrupção do timer2, comparando TMR2 com PR2
	BSF        TMR2IE_bit+0, 1
;PWM4Interrupcoes.c,142 :: 		PR2 = 0xFF; // Faz o TMR2 contar até 0xFF. O TMR2, diferentemente de TMR0 e TMR1, conta de 0 até um número, e não a partir de um
	MOVLW      255
	MOVWF      PR2+0
;PWM4Interrupcoes.c,147 :: 		TRISA = 0xE8; // Configura apenas RA0, RA1 e RA4 como saídas digitais
	MOVLW      232
	MOVWF      TRISA+0
;PWM4Interrupcoes.c,148 :: 		TRISB = 0x01; // Configura todo o portb como saída digital
	MOVLW      1
	MOVWF      TRISB+0
;PWM4Interrupcoes.c,149 :: 		PORTA = 0xE8; // Inicia apenas RA0, RA1 e RA4 em Low
	MOVLW      232
	MOVWF      PORTA+0
;PWM4Interrupcoes.c,150 :: 		PORTB = 0x01; // Inicia todo portb em Low
	MOVLW      1
	MOVWF      PORTB+0
;PWM4Interrupcoes.c,154 :: 		botA = 0x00;
	BCF        _botA+0, BitPos(_botA+0)
;PWM4Interrupcoes.c,155 :: 		botD = 0x00;
	BCF        _botD+0, BitPos(_botD+0)
;PWM4Interrupcoes.c,157 :: 		PWM1 = 0x80;  // Inicia os três PWMs em 0x80 (hexadecimal) = 128 (decimal), que corresponde a um dutyCicle de 50%
	MOVLW      128
	MOVWF      _PWM1+0
;PWM4Interrupcoes.c,158 :: 		PWM2 = 0x80;
	MOVLW      128
	MOVWF      _PWM2+0
;PWM4Interrupcoes.c,159 :: 		PWM3 = 0x80;
	MOVLW      128
	MOVWF      _PWM3+0
;PWM4Interrupcoes.c,163 :: 		lcd_init();
	CALL       _Lcd_Init+0
;PWM4Interrupcoes.c,164 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PWM4Interrupcoes.c,165 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PWM4Interrupcoes.c,166 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	NOP
	NOP
;PWM4Interrupcoes.c,168 :: 		while(1){
L_main12:
;PWM4Interrupcoes.c,170 :: 		alteraPWM();
	CALL       _alteraPWM+0
;PWM4Interrupcoes.c,171 :: 		}
	GOTO       L_main12
;PWM4Interrupcoes.c,172 :: 		}
	GOTO       $+0
; end of _main

_alteraPWM:

;PWM4Interrupcoes.c,174 :: 		void alteraPWM(){
;PWM4Interrupcoes.c,176 :: 		if(!botAumenta) botA = 0x01;
	BTFSC      RA5_bit+0, 5
	GOTO       L_alteraPWM14
	BSF        _botA+0, BitPos(_botA+0)
L_alteraPWM14:
;PWM4Interrupcoes.c,177 :: 		if(!botDiminui) botD = 0x01;
	BTFSC      RA3_bit+0, 3
	GOTO       L_alteraPWM15
	BSF        _botD+0, BitPos(_botD+0)
L_alteraPWM15:
;PWM4Interrupcoes.c,179 :: 		if(botAumenta && botA){  // Este if, que teste se o botao não está pressionado e testa se a variável bot1 está em 0x01, é uma forma
	BTFSS      RA5_bit+0, 5
	GOTO       L_alteraPWM18
	BTFSS      _botA+0, BitPos(_botA+0)
	GOTO       L_alteraPWM18
L__alteraPWM38:
;PWM4Interrupcoes.c,181 :: 		botA = 0x00;
	BCF        _botA+0, BitPos(_botA+0)
;PWM4Interrupcoes.c,183 :: 		switch(controlPWM){
	GOTO       L_alteraPWM19
;PWM4Interrupcoes.c,185 :: 		case 0x01: PWM1 = PWM1 + 4;
L_alteraPWM21:
	MOVLW      4
	ADDWF      _PWM1+0, 1
;PWM4Interrupcoes.c,186 :: 		break;
	GOTO       L_alteraPWM20
;PWM4Interrupcoes.c,187 :: 		case 0x02: PWM2 = PWM2 + 4;
L_alteraPWM22:
	MOVLW      4
	ADDWF      _PWM2+0, 1
;PWM4Interrupcoes.c,188 :: 		break;
	GOTO       L_alteraPWM20
;PWM4Interrupcoes.c,189 :: 		case 0x03: PWM3 = PWM3 + 4;
L_alteraPWM23:
	MOVLW      4
	ADDWF      _PWM3+0, 1
;PWM4Interrupcoes.c,190 :: 		break;
	GOTO       L_alteraPWM20
;PWM4Interrupcoes.c,191 :: 		}
L_alteraPWM19:
	MOVF       _controlPWM+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM21
	MOVF       _controlPWM+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM22
	MOVF       _controlPWM+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM23
L_alteraPWM20:
;PWM4Interrupcoes.c,192 :: 		}
L_alteraPWM18:
;PWM4Interrupcoes.c,194 :: 		if(botDiminui && botD){
	BTFSS      RA3_bit+0, 3
	GOTO       L_alteraPWM26
	BTFSS      _botD+0, BitPos(_botD+0)
	GOTO       L_alteraPWM26
L__alteraPWM37:
;PWM4Interrupcoes.c,196 :: 		botD = 0x00;
	BCF        _botD+0, BitPos(_botD+0)
;PWM4Interrupcoes.c,198 :: 		switch(controlPWM){
	GOTO       L_alteraPWM27
;PWM4Interrupcoes.c,200 :: 		case 0x01: PWM1 = PWM1 - 4;
L_alteraPWM29:
	MOVLW      4
	SUBWF      _PWM1+0, 1
;PWM4Interrupcoes.c,201 :: 		break;
	GOTO       L_alteraPWM28
;PWM4Interrupcoes.c,202 :: 		case 0x02: PWM2 = PWM2 - 4;
L_alteraPWM30:
	MOVLW      4
	SUBWF      _PWM2+0, 1
;PWM4Interrupcoes.c,203 :: 		break;
	GOTO       L_alteraPWM28
;PWM4Interrupcoes.c,204 :: 		case 0x03: PWM3 = PWM3 - 4;
L_alteraPWM31:
	MOVLW      4
	SUBWF      _PWM3+0, 1
;PWM4Interrupcoes.c,205 :: 		break;
	GOTO       L_alteraPWM28
;PWM4Interrupcoes.c,206 :: 		}
L_alteraPWM27:
	MOVF       _controlPWM+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM29
	MOVF       _controlPWM+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM30
	MOVF       _controlPWM+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM31
L_alteraPWM28:
;PWM4Interrupcoes.c,207 :: 		}
L_alteraPWM26:
;PWM4Interrupcoes.c,209 :: 		switch(controlPWM){
	GOTO       L_alteraPWM32
;PWM4Interrupcoes.c,211 :: 		case 0x01:
L_alteraPWM34:
;PWM4Interrupcoes.c,212 :: 		led0 = 0x01;
	BSF        RA2_bit+0, 2
;PWM4Interrupcoes.c,213 :: 		led1 = 0x00;
	BCF        RA1_bit+0, 1
;PWM4Interrupcoes.c,214 :: 		lcd_out(1,1, "PWM 1");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_PWM4Interrupcoes+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM4Interrupcoes.c,215 :: 		IntToStr(PWM1, txt);
	MOVF       _PWM1+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;PWM4Interrupcoes.c,216 :: 		lcd_out(2,1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM4Interrupcoes.c,217 :: 		break;
	GOTO       L_alteraPWM33
;PWM4Interrupcoes.c,218 :: 		case 0x02:
L_alteraPWM35:
;PWM4Interrupcoes.c,219 :: 		led0 = 0x00;
	BCF        RA2_bit+0, 2
;PWM4Interrupcoes.c,220 :: 		led1 = 0x01;
	BSF        RA1_bit+0, 1
;PWM4Interrupcoes.c,221 :: 		lcd_out(1,1, "PWM 2");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_PWM4Interrupcoes+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM4Interrupcoes.c,222 :: 		IntToStr(PWM2, txt);
	MOVF       _PWM2+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;PWM4Interrupcoes.c,223 :: 		lcd_out(2,1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM4Interrupcoes.c,224 :: 		break;
	GOTO       L_alteraPWM33
;PWM4Interrupcoes.c,225 :: 		case 0x03:
L_alteraPWM36:
;PWM4Interrupcoes.c,226 :: 		led0 = 0x01;
	BSF        RA2_bit+0, 2
;PWM4Interrupcoes.c,227 :: 		led1 = 0x01;
	BSF        RA1_bit+0, 1
;PWM4Interrupcoes.c,228 :: 		lcd_out(1,1, "PWM 3");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_PWM4Interrupcoes+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM4Interrupcoes.c,229 :: 		IntToStr(PWM3, txt);
	MOVF       _PWM3+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;PWM4Interrupcoes.c,230 :: 		lcd_out(2,1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PWM4Interrupcoes.c,231 :: 		break;
	GOTO       L_alteraPWM33
;PWM4Interrupcoes.c,232 :: 		}
L_alteraPWM32:
	MOVF       _controlPWM+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM34
	MOVF       _controlPWM+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM35
	MOVF       _controlPWM+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_alteraPWM36
L_alteraPWM33:
;PWM4Interrupcoes.c,233 :: 		}
	RETURN
; end of _alteraPWM

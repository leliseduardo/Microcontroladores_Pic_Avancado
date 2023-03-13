
_interrupt:

;BrilhoContrasteEncoder.c,61 :: 		void interrupt(){
;BrilhoContrasteEncoder.c,63 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;BrilhoContrasteEncoder.c,65 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;BrilhoContrasteEncoder.c,66 :: 		TMR1H = 0xFF;
	MOVLW       255
	MOVWF       TMR1H+0 
;BrilhoContrasteEncoder.c,67 :: 		TMR1L = 0x37;
	MOVLW       55
	MOVWF       TMR1L+0 
;BrilhoContrasteEncoder.c,69 :: 		baseTempo += 0x01;
	INCF        _baseTempo+0, 1 
;BrilhoContrasteEncoder.c,71 :: 		if(baseTempo == 0x64){ // Lê o encoder a cada 5ms
	MOVF        _baseTempo+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;BrilhoContrasteEncoder.c,73 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
;BrilhoContrasteEncoder.c,75 :: 		leitura_Encoder();
	CALL        _leitura_Encoder+0, 0
;BrilhoContrasteEncoder.c,77 :: 		} // end if baseTempo == 0x64
L_interrupt1:
;BrilhoContrasteEncoder.c,79 :: 		} // end TMR1IF_Bit
L_interrupt0:
;BrilhoContrasteEncoder.c,81 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt2
;BrilhoContrasteEncoder.c,83 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;BrilhoContrasteEncoder.c,85 :: 		if(pwm1){
	BTFSS       LATC0_bit+0, 0 
	GOTO        L_interrupt3
;BrilhoContrasteEncoder.c,87 :: 		TMR2 = duty1;
	MOVF        _duty1+0, 0 
	MOVWF       TMR2+0 
;BrilhoContrasteEncoder.c,88 :: 		pwm1 = 0x00;
	BCF         LATC0_bit+0, 0 
;BrilhoContrasteEncoder.c,90 :: 		} // end if pwm1
	GOTO        L_interrupt4
L_interrupt3:
;BrilhoContrasteEncoder.c,93 :: 		TMR2 = 255 - duty1;
	MOVF        _duty1+0, 0 
	SUBLW       255
	MOVWF       TMR2+0 
;BrilhoContrasteEncoder.c,94 :: 		pwm1 = 0x01;
	BSF         LATC0_bit+0, 0 
;BrilhoContrasteEncoder.c,96 :: 		} // end else pwm1
L_interrupt4:
;BrilhoContrasteEncoder.c,98 :: 		} // end if TMR2IF_bit
L_interrupt2:
;BrilhoContrasteEncoder.c,100 :: 		if(TMR3IF_bit){
	BTFSS       TMR3IF_bit+0, 1 
	GOTO        L_interrupt5
;BrilhoContrasteEncoder.c,102 :: 		TMR3IF_bit = 0x00;
	BCF         TMR3IF_bit+0, 1 
;BrilhoContrasteEncoder.c,103 :: 		TMR3H = 0xFF;
	MOVLW       255
	MOVWF       TMR3H+0 
;BrilhoContrasteEncoder.c,105 :: 		if(pwm2){
	BTFSS       LATC1_bit+0, 1 
	GOTO        L_interrupt6
;BrilhoContrasteEncoder.c,107 :: 		TMR3L = duty2;
	MOVF        _duty2+0, 0 
	MOVWF       TMR3L+0 
;BrilhoContrasteEncoder.c,108 :: 		pwm2 = 0x00;
	BCF         LATC1_bit+0, 1 
;BrilhoContrasteEncoder.c,110 :: 		} // end if pwm2
	GOTO        L_interrupt7
L_interrupt6:
;BrilhoContrasteEncoder.c,113 :: 		TMR3L = 255 - duty2;
	MOVF        _duty2+0, 0 
	SUBLW       255
	MOVWF       TMR3L+0 
;BrilhoContrasteEncoder.c,114 :: 		pwm2 = 0x01;
	BSF         LATC1_bit+0, 1 
;BrilhoContrasteEncoder.c,116 :: 		} // end else pwm2
L_interrupt7:
;BrilhoContrasteEncoder.c,118 :: 		} // end if TMR3IF_bit
L_interrupt5:
;BrilhoContrasteEncoder.c,120 :: 		} // end void interrupt
L__interrupt26:
	RETFIE      1
; end of _interrupt

_main:

;BrilhoContrasteEncoder.c,122 :: 		void main() {
;BrilhoContrasteEncoder.c,124 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;BrilhoContrasteEncoder.c,125 :: 		TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais
	MOVLW       3
	MOVWF       TRISB+0 
;BrilhoContrasteEncoder.c,126 :: 		TRISC = 0xFC; // Configura apenas RC0 e RC1 como saídas digitais
	MOVLW       252
	MOVWF       TRISC+0 
;BrilhoContrasteEncoder.c,127 :: 		LATC = 0xFC; // Inicia todas as saídas do portc em Low
	MOVLW       252
	MOVWF       LATC+0 
;BrilhoContrasteEncoder.c,129 :: 		INTCON = 0xC0; // Habilita a interrupção global e por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;BrilhoContrasteEncoder.c,130 :: 		TMR1IE_bit = 0x01; // Registrador PIE1. Hablita a interrupção por overflow do timer1
	BSF         TMR1IE_bit+0, 0 
;BrilhoContrasteEncoder.c,131 :: 		TMR2IE_bit = 0x01; // Registrador PIE1. Habilita a interrupção por overflow do timer2
	BSF         TMR2IE_bit+0, 1 
;BrilhoContrasteEncoder.c,132 :: 		TMR3IE_bit = 0x01; // Resgistrador PIE2. Habilita a interrupção por overflow do timer3
	BSF         TMR3IE_bit+0, 1 
;BrilhoContrasteEncoder.c,134 :: 		T1CON = 0x01; // Habilita o timer1, configura com 8 bits, prescale em 1:1, incrementa com ciclo de maquina
	MOVLW       1
	MOVWF       T1CON+0 
;BrilhoContrasteEncoder.c,135 :: 		TMR1H = 0xFF;
	MOVLW       255
	MOVWF       TMR1H+0 
;BrilhoContrasteEncoder.c,136 :: 		TMR1L = 0x37; // Inicia em 55 para uma contagem de 200
	MOVLW       55
	MOVWF       TMR1L+0 
;BrilhoContrasteEncoder.c,137 :: 		T2CON = 0x05; // Habilita o timer2, configura o prescale em 1:4 e o postscale em 1:1
	MOVLW       5
	MOVWF       T2CON+0 
;BrilhoContrasteEncoder.c,138 :: 		PR2 = 0xFF; // Configura a contagem do TMR2 até 0xFF = 255
	MOVLW       255
	MOVWF       PR2+0 
;BrilhoContrasteEncoder.c,139 :: 		T3CON = 0x21; // Habilita o timer3, configura com 8 bits, prescale em 1:4 e incrementa com ciclo de clock
	MOVLW       33
	MOVWF       T3CON+0 
;BrilhoContrasteEncoder.c,140 :: 		TMR3H = 0xFF;
	MOVLW       255
	MOVWF       TMR3H+0 
;BrilhoContrasteEncoder.c,141 :: 		TMR3L = 0x00;
	CLRF        TMR3L+0 
;BrilhoContrasteEncoder.c,143 :: 		flagEnc = 0x00;
	BCF         _flagEnc+0, BitPos(_flagEnc+0) 
;BrilhoContrasteEncoder.c,144 :: 		control = 0x00;
	BCF         _control+0, BitPos(_control+0) 
;BrilhoContrasteEncoder.c,145 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;BrilhoContrasteEncoder.c,148 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;BrilhoContrasteEncoder.c,149 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;BrilhoContrasteEncoder.c,150 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;BrilhoContrasteEncoder.c,151 :: 		lcd_chr(1, 1, 'B');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       66
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContrasteEncoder.c,152 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,153 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,154 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,155 :: 		lcd_chr_cp('h');
	MOVLW       104
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,156 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,157 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,158 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,159 :: 		lcd_chr(2, 1, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContrasteEncoder.c,160 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,161 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,162 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,163 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,164 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,165 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,166 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,167 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,168 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,169 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,172 :: 		while(1){
L_main8:
;BrilhoContrasteEncoder.c,174 :: 		if(!botao) flagBotao = 0x01;
	BTFSC       RC2_bit+0, 2 
	GOTO        L_main10
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
L_main10:
;BrilhoContrasteEncoder.c,176 :: 		if(botao && flagBotao){
	BTFSS       RC2_bit+0, 2 
	GOTO        L_main13
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_main13
L__main25:
;BrilhoContrasteEncoder.c,178 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;BrilhoContrasteEncoder.c,179 :: 		control = ~control;
	BTG         _control+0, BitPos(_control+0) 
;BrilhoContrasteEncoder.c,181 :: 		} // end if botao && flagBotao
L_main13:
;BrilhoContrasteEncoder.c,183 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;BrilhoContrasteEncoder.c,185 :: 		} // end Loop infinito
	GOTO        L_main8
;BrilhoContrasteEncoder.c,187 :: 		} // end void main
	GOTO        $+0
; end of _main

_imprime_Display:

;BrilhoContrasteEncoder.c,190 :: 		void imprime_Display(){
;BrilhoContrasteEncoder.c,194 :: 		cen1 = duty1/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty1+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen1_L0+0 
;BrilhoContrasteEncoder.c,195 :: 		dez1 = (duty1%100)/10;
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
;BrilhoContrasteEncoder.c,196 :: 		uni1 = duty1%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _duty1+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni1_L0+0 
;BrilhoContrasteEncoder.c,198 :: 		lcd_chr(1, 9, cen1 + 0x30);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContrasteEncoder.c,199 :: 		lcd_chr_cp(dez1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,200 :: 		lcd_chr_cp(uni1 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,202 :: 		cen2 = duty2/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty2+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen2_L0+0 
;BrilhoContrasteEncoder.c,203 :: 		dez2 = (duty2%100)/10;
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
;BrilhoContrasteEncoder.c,204 :: 		uni2 = duty2%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _duty2+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni2_L0+0 
;BrilhoContrasteEncoder.c,206 :: 		lcd_chr(2, 12, cen2 + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;BrilhoContrasteEncoder.c,207 :: 		lcd_chr_cp(dez2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,208 :: 		lcd_chr_cp(uni2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;BrilhoContrasteEncoder.c,210 :: 		} // end void imprime_Display()
	RETURN      0
; end of _imprime_Display

_leitura_Encoder:

;BrilhoContrasteEncoder.c,212 :: 		void leitura_Encoder(){
;BrilhoContrasteEncoder.c,214 :: 		if(!encoderA){
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Encoder14
;BrilhoContrasteEncoder.c,216 :: 		if(!flagEnc){
	BTFSC       _flagEnc+0, BitPos(_flagEnc+0) 
	GOTO        L_leitura_Encoder15
;BrilhoContrasteEncoder.c,218 :: 		if(!control){
	BTFSC       _control+0, BitPos(_control+0) 
	GOTO        L_leitura_Encoder16
;BrilhoContrasteEncoder.c,219 :: 		flagEnc = 0x01;
	BSF         _flagEnc+0, BitPos(_flagEnc+0) 
;BrilhoContrasteEncoder.c,220 :: 		duty1 += 0x01;
	INCF        _duty1+0, 1 
;BrilhoContrasteEncoder.c,221 :: 		} // end if !control
L_leitura_Encoder16:
;BrilhoContrasteEncoder.c,222 :: 		if(control){
	BTFSS       _control+0, BitPos(_control+0) 
	GOTO        L_leitura_Encoder17
;BrilhoContrasteEncoder.c,223 :: 		flagEnc = 0x01;
	BSF         _flagEnc+0, BitPos(_flagEnc+0) 
;BrilhoContrasteEncoder.c,224 :: 		duty2 += 0x01;
	INCF        _duty2+0, 1 
;BrilhoContrasteEncoder.c,225 :: 		} // end if !control
L_leitura_Encoder17:
;BrilhoContrasteEncoder.c,227 :: 		} // end if !flagEnc
L_leitura_Encoder15:
;BrilhoContrasteEncoder.c,229 :: 		} // end if !encoderA
	GOTO        L_leitura_Encoder18
L_leitura_Encoder14:
;BrilhoContrasteEncoder.c,232 :: 		if(!encoderB){
	BTFSC       RB1_bit+0, 1 
	GOTO        L_leitura_Encoder19
;BrilhoContrasteEncoder.c,234 :: 		if(!flagEnc){
	BTFSC       _flagEnc+0, BitPos(_flagEnc+0) 
	GOTO        L_leitura_Encoder20
;BrilhoContrasteEncoder.c,236 :: 		if(!control){
	BTFSC       _control+0, BitPos(_control+0) 
	GOTO        L_leitura_Encoder21
;BrilhoContrasteEncoder.c,237 :: 		flagEnc = 0x01;
	BSF         _flagEnc+0, BitPos(_flagEnc+0) 
;BrilhoContrasteEncoder.c,238 :: 		duty1 -= 0x01;
	DECF        _duty1+0, 1 
;BrilhoContrasteEncoder.c,239 :: 		} // end if !control
L_leitura_Encoder21:
;BrilhoContrasteEncoder.c,240 :: 		if(control){
	BTFSS       _control+0, BitPos(_control+0) 
	GOTO        L_leitura_Encoder22
;BrilhoContrasteEncoder.c,241 :: 		flagEnc = 0x01;
	BSF         _flagEnc+0, BitPos(_flagEnc+0) 
;BrilhoContrasteEncoder.c,242 :: 		duty2 -= 0x01;
	DECF        _duty2+0, 1 
;BrilhoContrasteEncoder.c,243 :: 		} // end if !control
L_leitura_Encoder22:
;BrilhoContrasteEncoder.c,245 :: 		} // end if !flagEnc
L_leitura_Encoder20:
;BrilhoContrasteEncoder.c,247 :: 		} // end if !encoderB
L_leitura_Encoder19:
;BrilhoContrasteEncoder.c,249 :: 		} // end else !encoderA
L_leitura_Encoder18:
;BrilhoContrasteEncoder.c,251 :: 		if(encoderA){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Encoder23
;BrilhoContrasteEncoder.c,253 :: 		if(encoderB) flagEnc = 0x00;
	BTFSS       RB1_bit+0, 1 
	GOTO        L_leitura_Encoder24
	BCF         _flagEnc+0, BitPos(_flagEnc+0) 
L_leitura_Encoder24:
;BrilhoContrasteEncoder.c,255 :: 		} // end if encoderA
L_leitura_Encoder23:
;BrilhoContrasteEncoder.c,257 :: 		} // end void leitura_Encoder
	RETURN      0
; end of _leitura_Encoder

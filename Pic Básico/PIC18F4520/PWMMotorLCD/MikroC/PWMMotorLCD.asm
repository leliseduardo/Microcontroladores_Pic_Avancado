
_interrupt:

;PWMMotorLCD.c,62 :: 		void interrupt(){
;PWMMotorLCD.c,64 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;PWMMotorLCD.c,66 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;PWMMotorLCD.c,67 :: 		TMR1L = 0xB0;
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD.c,68 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD.c,70 :: 		cont++;
	INCF        _cont+0, 1 
;PWMMotorLCD.c,72 :: 		if(cont == 40){
	MOVF        _cont+0, 0 
	XORLW       40
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;PWMMotorLCD.c,74 :: 		cont = 0x00;
	CLRF        _cont+0 
;PWMMotorLCD.c,75 :: 		control = 1;
	BSF         _control+0, BitPos(_control+0) 
;PWMMotorLCD.c,76 :: 		} // end cont == 40
L_interrupt1:
;PWMMotorLCD.c,78 :: 		} // end if TMR1IF_bit
L_interrupt0:
;PWMMotorLCD.c,80 :: 		} // end void interrupt
L__interrupt19:
	RETFIE      1
; end of _interrupt

_main:

;PWMMotorLCD.c,82 :: 		void main() {
;PWMMotorLCD.c,85 :: 		INTCON = 0xC0; // Habilita a interrupção global e a interrupção por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;PWMMotorLCD.c,88 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção por overflow do timer1
	BSF         TMR1IE_bit+0, 0 
;PWMMotorLCD.c,90 :: 		T1CON = 0x00; // Configura o timer1 com 8 bits, prescaler 1:1, incrementa com ciclo de máquina e inicialmente timer1 desabilitado
	CLRF        T1CON+0 
;PWMMotorLCD.c,93 :: 		TMR1L = 0xB0; // Inicia em 15536, para uma contagem de 50000
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD.c,94 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD.c,96 :: 		ADCON1 = 0x0F; // Configura todas as portas que poderiam ser analógicas como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;PWMMotorLCD.c,97 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;PWMMotorLCD.c,98 :: 		control = 0; // Inicia o bit control em 0
	BCF         _control+0, BitPos(_control+0) 
;PWMMotorLCD.c,100 :: 		lcd_Init();
	CALL        _Lcd_Init+0, 0
;PWMMotorLCD.c,101 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWMMotorLCD.c,102 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWMMotorLCD.c,104 :: 		PWM1_Init(1000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;PWMMotorLCD.c,105 :: 		PWM1_Stop();
	CALL        _PWM1_Stop+0, 0
;PWMMotorLCD.c,106 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMMotorLCD.c,109 :: 		set_Duty();
	CALL        _set_Duty+0, 0
;PWMMotorLCD.c,110 :: 		for(i = 0; i < 17; i++) lcd_chr(1, i, ' ');
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
;PWMMotorLCD.c,111 :: 		lcd_out(1, 3, "Motor acionado");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_PWMMotorLCD+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_PWMMotorLCD+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PWMMotorLCD.c,113 :: 		while(1){
L_main5:
;PWMMotorLCD.c,115 :: 		PWM1_start();
	CALL        _PWM1_Start+0, 0
;PWMMotorLCD.c,116 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWMMotorLCD.c,117 :: 		} // end loop infinito
	GOTO        L_main5
;PWMMotorLCD.c,119 :: 		} // end void main
	GOTO        $+0
; end of _main

_set_Duty:

;PWMMotorLCD.c,121 :: 		void set_Duty(){
;PWMMotorLCD.c,123 :: 		char cen = 0x00, dez = 0x00, uni = 0x00;
	CLRF        set_Duty_cen_L0+0 
	CLRF        set_Duty_dez_L0+0 
	CLRF        set_Duty_uni_L0+0 
;PWMMotorLCD.c,125 :: 		while(!control){
L_set_Duty7:
	BTFSC       _control+0, BitPos(_control+0) 
	GOTO        L_set_Duty8
;PWMMotorLCD.c,127 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;PWMMotorLCD.c,129 :: 		lcd_chr(1, 3, 'S');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMMotorLCD.c,130 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,131 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,132 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,133 :: 		lcd_chr_cp('D');
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,134 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,135 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,136 :: 		lcd_chr_cp('y');
	MOVLW       121
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,137 :: 		lcd_chr_cp('!');
	MOVLW       33
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,139 :: 		cen = duty/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       set_Duty_cen_L0+0 
;PWMMotorLCD.c,140 :: 		dez = (duty%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _duty+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       set_Duty_dez_L0+0 
;PWMMotorLCD.c,141 :: 		uni = duty%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _duty+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       set_Duty_uni_L0+0 
;PWMMotorLCD.c,143 :: 		lcd_chr(2, 5, cen + 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       set_Duty_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PWMMotorLCD.c,144 :: 		lcd_chr_cp(dez + 48);
	MOVLW       48
	ADDWF       set_Duty_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,145 :: 		lcd_chr_cp(uni + 48);
	MOVLW       48
	ADDWF       set_Duty_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PWMMotorLCD.c,147 :: 		} // end while control
	GOTO        L_set_Duty7
L_set_Duty8:
;PWMMotorLCD.c,148 :: 		} // end void set_Duty
	RETURN      0
; end of _set_Duty

_leitura_Botoes:

;PWMMotorLCD.c,151 :: 		void leitura_Botoes(){
;PWMMotorLCD.c,153 :: 		if(!decrementa){
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes9
;PWMMotorLCD.c,155 :: 		flagBotoes.B0 = 0x01;
	BSF         _flagBotoes+0, 0 
;PWMMotorLCD.c,157 :: 		TMR1ON_bit = 0x01;
	BSF         TMR1ON_bit+0, 0 
;PWMMotorLCD.c,158 :: 		} // end if !decrementa
L_leitura_Botoes9:
;PWMMotorLCD.c,160 :: 		if(!incrementa) {
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes10
;PWMMotorLCD.c,162 :: 		flagBotoes.B1 = 0x01;
	BSF         _flagBotoes+0, 1 
;PWMMotorLCD.c,164 :: 		TMR1ON_bit = 0x01;
	BSF         TMR1ON_bit+0, 0 
;PWMMotorLCD.c,165 :: 		} // end if !incrementa
L_leitura_Botoes10:
;PWMMotorLCD.c,167 :: 		if(decrementa && flagBotoes.B0){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes13
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes13
L__leitura_Botoes18:
;PWMMotorLCD.c,169 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;PWMMotorLCD.c,170 :: 		TMR1ON_bit = 0x00;
	BCF         TMR1ON_bit+0, 0 
;PWMMotorLCD.c,171 :: 		TMR1L = 0xB0;
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD.c,172 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD.c,173 :: 		cont = 0x00;
	CLRF        _cont+0 
;PWMMotorLCD.c,174 :: 		duty--;
	DECF        _duty+0, 1 
;PWMMotorLCD.c,175 :: 		} // end if decrementa && flagBotoes.B0
L_leitura_Botoes13:
;PWMMotorLCD.c,177 :: 		if(incrementa && flagBotoes.B1){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes16
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes16
L__leitura_Botoes17:
;PWMMotorLCD.c,179 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;PWMMotorLCD.c,180 :: 		TMR1ON_bit = 0x00;
	BCF         TMR1ON_bit+0, 0 
;PWMMotorLCD.c,181 :: 		TMR1L = 0xB0;
	MOVLW       176
	MOVWF       TMR1L+0 
;PWMMotorLCD.c,182 :: 		TMR1H = 0x3C;
	MOVLW       60
	MOVWF       TMR1H+0 
;PWMMotorLCD.c,183 :: 		cont = 0x00;
	CLRF        _cont+0 
;PWMMotorLCD.c,184 :: 		duty++;
	INCF        _duty+0, 1 
;PWMMotorLCD.c,185 :: 		} // end incrementa && flagBotoes.B1
L_leitura_Botoes16:
;PWMMotorLCD.c,187 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

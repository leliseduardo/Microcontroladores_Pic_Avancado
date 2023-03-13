
_main:

;EncoderRotativoPWM.c,36 :: 		void main() {
;EncoderRotativoPWM.c,38 :: 		ADCON1 = 0x0F; // Configura todos os ports que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;EncoderRotativoPWM.c,39 :: 		TRISC = 0xFB; // Configura RC2 como saída digital, o resto como entrada
	MOVLW       251
	MOVWF       TRISC+0 
;EncoderRotativoPWM.c,40 :: 		PORTC = 0xFB; // Inicia todas as entradas em High
	MOVLW       251
	MOVWF       PORTC+0 
;EncoderRotativoPWM.c,42 :: 		PWM1_Init(2000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       124
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;EncoderRotativoPWM.c,43 :: 		PWM1_Set_Duty(128);
	MOVLW       128
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;EncoderRotativoPWM.c,44 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;EncoderRotativoPWM.c,46 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;EncoderRotativoPWM.c,47 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderRotativoPWM.c,48 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderRotativoPWM.c,51 :: 		while(1){
L_main0:
;EncoderRotativoPWM.c,53 :: 		lcd_out(1, 2, "PWM Encoder");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_EncoderRotativoPWM+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_EncoderRotativoPWM+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EncoderRotativoPWM.c,54 :: 		display_Encoder();
	CALL        _display_Encoder+0, 0
;EncoderRotativoPWM.c,56 :: 		} // end Loop nnfinito
	GOTO        L_main0
;EncoderRotativoPWM.c,58 :: 		} // end void main
	GOTO        $+0
; end of _main

_display_Encoder:

;EncoderRotativoPWM.c,60 :: 		void display_Encoder(){
;EncoderRotativoPWM.c,63 :: 		unsigned char cen = 0x00, dez = 0x00, uni = 0x00;
	CLRF        display_Encoder_cen_L0+0 
	CLRF        display_Encoder_dez_L0+0 
	CLRF        display_Encoder_uni_L0+0 
;EncoderRotativoPWM.c,66 :: 		encoder = leitura_Encoder();
	CALL        _leitura_Encoder+0, 0
	MOVF        R0, 0 
	MOVWF       display_Encoder_encoder_L0+0 
;EncoderRotativoPWM.c,68 :: 		if(encoder){
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Encoder2
;EncoderRotativoPWM.c,70 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderRotativoPWM.c,71 :: 		cont += encoder;
	MOVF        display_Encoder_encoder_L0+0, 0 
	ADDWF       display_Encoder_cont_L0+0, 1 
;EncoderRotativoPWM.c,73 :: 		} // end if encoder
L_display_Encoder2:
;EncoderRotativoPWM.c,75 :: 		PWM1_Set_Duty(cont);
	MOVF        display_Encoder_cont_L0+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;EncoderRotativoPWM.c,77 :: 		cen = cont/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        display_Encoder_cont_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       display_Encoder_cen_L0+0 
;EncoderRotativoPWM.c,78 :: 		dez = (cont%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        display_Encoder_cont_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       display_Encoder_dez_L0+0 
;EncoderRotativoPWM.c,79 :: 		uni = cont%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        display_Encoder_cont_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       display_Encoder_uni_L0+0 
;EncoderRotativoPWM.c,81 :: 		lcd_chr(2, 7, cen + 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       display_Encoder_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EncoderRotativoPWM.c,82 :: 		lcd_chr_cp(dez + 48);
	MOVLW       48
	ADDWF       display_Encoder_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EncoderRotativoPWM.c,83 :: 		lcd_chr_cp(uni + 48);
	MOVLW       48
	ADDWF       display_Encoder_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EncoderRotativoPWM.c,85 :: 		} // end void display_Encoder
	RETURN      0
; end of _display_Encoder

_leitura_Encoder:

;EncoderRotativoPWM.c,87 :: 		char leitura_Encoder(){
;EncoderRotativoPWM.c,92 :: 		AB <<= 2;
	MOVF        leitura_Encoder_AB_L0+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       leitura_Encoder_AB_L0+0 
;EncoderRotativoPWM.c,93 :: 		AB |= ( PORTC & 0x03);
	MOVLW       3
	ANDWF       PORTC+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       leitura_Encoder_AB_L0+0 
;EncoderRotativoPWM.c,95 :: 		return ( estadosEncoder[( AB & 0x0F )]);
	MOVLW       15
	ANDWF       R0, 1 
	MOVLW       leitura_Encoder_estadosEncoder_L0+0
	MOVWF       FSR0L 
	MOVLW       hi_addr(leitura_Encoder_estadosEncoder_L0+0)
	MOVWF       FSR0H 
	MOVF        R0, 0 
	ADDWF       FSR0L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;EncoderRotativoPWM.c,97 :: 		} // end void leitura_Encoder
	RETURN      0
; end of _leitura_Encoder

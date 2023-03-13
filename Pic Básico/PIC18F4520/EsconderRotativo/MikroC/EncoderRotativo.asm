
_main:

;EncoderRotativo.c,38 :: 		void main() {
;EncoderRotativo.c,40 :: 		ADCON1 = 0x0F; // Configura todos os ports que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;EncoderRotativo.c,42 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;EncoderRotativo.c,43 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderRotativo.c,44 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderRotativo.c,47 :: 		while(1){
L_main0:
;EncoderRotativo.c,49 :: 		lcd_out(1, 2, "Teste Enconder");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_EncoderRotativo+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_EncoderRotativo+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EncoderRotativo.c,50 :: 		display_Encoder();
	CALL        _display_Encoder+0, 0
;EncoderRotativo.c,52 :: 		} // end Loop nnfinito
	GOTO        L_main0
;EncoderRotativo.c,54 :: 		} // end void main
	GOTO        $+0
; end of _main

_display_Encoder:

;EncoderRotativo.c,56 :: 		void display_Encoder(){
;EncoderRotativo.c,59 :: 		unsigned char cen = 0x00, dez = 0x00, uni = 0x00;
	CLRF        display_Encoder_cen_L0+0 
	CLRF        display_Encoder_dez_L0+0 
	CLRF        display_Encoder_uni_L0+0 
;EncoderRotativo.c,62 :: 		encoder = leitura_Encoder();
	CALL        _leitura_Encoder+0, 0
	MOVF        R0, 0 
	MOVWF       display_Encoder_encoder_L0+0 
;EncoderRotativo.c,64 :: 		if(encoder){
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_display_Encoder2
;EncoderRotativo.c,66 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderRotativo.c,67 :: 		cont += encoder;
	MOVF        display_Encoder_encoder_L0+0, 0 
	ADDWF       display_Encoder_cont_L0+0, 1 
;EncoderRotativo.c,69 :: 		} // end if encoder
L_display_Encoder2:
;EncoderRotativo.c,71 :: 		cen = cont/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        display_Encoder_cont_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       display_Encoder_cen_L0+0 
;EncoderRotativo.c,72 :: 		dez = (cont%100)/10;
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
;EncoderRotativo.c,73 :: 		uni = cont%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        display_Encoder_cont_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       display_Encoder_uni_L0+0 
;EncoderRotativo.c,75 :: 		lcd_chr(2, 7, cen + 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       display_Encoder_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EncoderRotativo.c,76 :: 		lcd_chr_cp(dez + 48);
	MOVLW       48
	ADDWF       display_Encoder_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EncoderRotativo.c,77 :: 		lcd_chr_cp(uni + 48);
	MOVLW       48
	ADDWF       display_Encoder_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EncoderRotativo.c,79 :: 		} // end void display_Encoder
	RETURN      0
; end of _display_Encoder

_leitura_Encoder:

;EncoderRotativo.c,81 :: 		char leitura_Encoder(){
;EncoderRotativo.c,86 :: 		AB <<= 2;
	MOVF        leitura_Encoder_AB_L0+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       leitura_Encoder_AB_L0+0 
;EncoderRotativo.c,87 :: 		AB |= ( PORTC & 0x03);
	MOVLW       3
	ANDWF       PORTC+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       leitura_Encoder_AB_L0+0 
;EncoderRotativo.c,89 :: 		return ( estadosEncoder[( AB & 0x0F )]);
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
;EncoderRotativo.c,91 :: 		} // end void leitura_Encoder
	RETURN      0
; end of _leitura_Encoder

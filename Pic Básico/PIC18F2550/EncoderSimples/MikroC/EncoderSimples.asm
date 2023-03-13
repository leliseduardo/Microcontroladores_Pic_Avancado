
_interrupt:

;EncoderSimples.c,54 :: 		void interrupt(){
;EncoderSimples.c,56 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;EncoderSimples.c,58 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;EncoderSimples.c,59 :: 		TMR1H = 0xFF;
	MOVLW       255
	MOVWF       TMR1H+0 
;EncoderSimples.c,60 :: 		TMR1L = 0x37;
	MOVLW       55
	MOVWF       TMR1L+0 
;EncoderSimples.c,62 :: 		baseTempo += 0x01;
	INCF        _baseTempo+0, 1 
;EncoderSimples.c,64 :: 		if(baseTempo == 0x64){ // Lê o encoder a cada 5ms
	MOVF        _baseTempo+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;EncoderSimples.c,66 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
;EncoderSimples.c,68 :: 		leitura_Encoder();
	CALL        _leitura_Encoder+0, 0
;EncoderSimples.c,70 :: 		} // end if baseTempo == 0x64
L_interrupt1:
;EncoderSimples.c,72 :: 		} // end TMR1IF_Bit
L_interrupt0:
;EncoderSimples.c,74 :: 		} // end void interrupt
L__interrupt11:
	RETFIE      1
; end of _interrupt

_main:

;EncoderSimples.c,77 :: 		void main() {
;EncoderSimples.c,79 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;EncoderSimples.c,80 :: 		TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como saída
	MOVLW       3
	MOVWF       TRISB+0 
;EncoderSimples.c,82 :: 		INTCON = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;EncoderSimples.c,83 :: 		TMR1IE_bit = 0x01; // Registrador PIE1. Hablita a interrupção por overflow do timer1
	BSF         TMR1IE_bit+0, 0 
;EncoderSimples.c,84 :: 		T1CON = 0x01; // Habilita o timer1, configura com 8 bits, prescale em 1:1, incrementa com ciclo de maquina
	MOVLW       1
	MOVWF       T1CON+0 
;EncoderSimples.c,85 :: 		TMR1H = 0xFF;
	MOVLW       255
	MOVWF       TMR1H+0 
;EncoderSimples.c,86 :: 		TMR1L = 0x37; // Inicia em 55 para uma contagem de 200
	MOVLW       55
	MOVWF       TMR1L+0 
;EncoderSimples.c,88 :: 		flagEnc = 0x00;
	BCF         _flagEnc+0, BitPos(_flagEnc+0) 
;EncoderSimples.c,91 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;EncoderSimples.c,92 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderSimples.c,93 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EncoderSimples.c,94 :: 		lcd_out(1, 2, "Teste Encoder");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_EncoderSimples+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_EncoderSimples+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EncoderSimples.c,97 :: 		while(1){
L_main2:
;EncoderSimples.c,99 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;EncoderSimples.c,101 :: 		} // end Loop infinito
	GOTO        L_main2
;EncoderSimples.c,103 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Encoder:

;EncoderSimples.c,107 :: 		void leitura_Encoder(){
;EncoderSimples.c,109 :: 		if(!encoderA){
	BTFSC       RB0_bit+0, 0 
	GOTO        L_leitura_Encoder4
;EncoderSimples.c,111 :: 		if(!flagEnc){
	BTFSC       _flagEnc+0, BitPos(_flagEnc+0) 
	GOTO        L_leitura_Encoder5
;EncoderSimples.c,113 :: 		flagEnc = 0x01;
	BSF         _flagEnc+0, BitPos(_flagEnc+0) 
;EncoderSimples.c,114 :: 		cont += 0x01;
	INCF        _cont+0, 1 
;EncoderSimples.c,116 :: 		} // end if !flagEnc
L_leitura_Encoder5:
;EncoderSimples.c,118 :: 		} // end if !encoderA
	GOTO        L_leitura_Encoder6
L_leitura_Encoder4:
;EncoderSimples.c,121 :: 		if(!encoderB){
	BTFSC       RB1_bit+0, 1 
	GOTO        L_leitura_Encoder7
;EncoderSimples.c,123 :: 		if(!flagEnc){
	BTFSC       _flagEnc+0, BitPos(_flagEnc+0) 
	GOTO        L_leitura_Encoder8
;EncoderSimples.c,125 :: 		flagEnc = 0x01;
	BSF         _flagEnc+0, BitPos(_flagEnc+0) 
;EncoderSimples.c,126 :: 		cont -= 0x01;
	DECF        _cont+0, 1 
;EncoderSimples.c,128 :: 		} // end if !flagEnc
L_leitura_Encoder8:
;EncoderSimples.c,130 :: 		} // end if !encoderB
L_leitura_Encoder7:
;EncoderSimples.c,132 :: 		} // end else !encoderA
L_leitura_Encoder6:
;EncoderSimples.c,134 :: 		if(encoderA){
	BTFSS       RB0_bit+0, 0 
	GOTO        L_leitura_Encoder9
;EncoderSimples.c,136 :: 		if(encoderB) flagEnc = 0x00;
	BTFSS       RB1_bit+0, 1 
	GOTO        L_leitura_Encoder10
	BCF         _flagEnc+0, BitPos(_flagEnc+0) 
L_leitura_Encoder10:
;EncoderSimples.c,138 :: 		} // end if encoderA
L_leitura_Encoder9:
;EncoderSimples.c,140 :: 		} // end void leitura_Encoder
	RETURN      0
; end of _leitura_Encoder

_imprime_Display:

;EncoderSimples.c,144 :: 		void imprime_Display(){
;EncoderSimples.c,148 :: 		cen = cont/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _cont+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen_L0+0 
;EncoderSimples.c,149 :: 		dez =(cont%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _cont+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez_L0+0 
;EncoderSimples.c,150 :: 		uni = cont%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _cont+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni_L0+0 
;EncoderSimples.c,152 :: 		lcd_chr(2, 8, cen + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EncoderSimples.c,153 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EncoderSimples.c,154 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EncoderSimples.c,156 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

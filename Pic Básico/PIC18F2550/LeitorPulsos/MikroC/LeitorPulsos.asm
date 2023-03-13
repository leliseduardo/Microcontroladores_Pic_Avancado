
_interrupt:

;LeitorPulsos.c,51 :: 		void interrupt(){
;LeitorPulsos.c,53 :: 		if(INT0IF_bit){
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;LeitorPulsos.c,55 :: 		INT0IF_bit = 0x00;
	BCF         INT0IF_bit+0, 1 
;LeitorPulsos.c,56 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
	CLRF        _baseTempo+1 
;LeitorPulsos.c,57 :: 		pulso++;
	INCF        _pulso+0, 1 
;LeitorPulsos.c,58 :: 		cont = pulso;
	MOVF        _pulso+0, 0 
	MOVWF       _cont+0 
;LeitorPulsos.c,60 :: 		} // end if INT0IF_bit
L_interrupt0:
;LeitorPulsos.c,62 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt1
;LeitorPulsos.c,64 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;LeitorPulsos.c,66 :: 		baseTempo++;
	INFSNZ      _baseTempo+0, 1 
	INCF        _baseTempo+1, 1 
;LeitorPulsos.c,68 :: 		if(baseTempo == 2000){  // A cada 2000 x 50us = 100ms a variável pulsoé limpa
	MOVF        _baseTempo+1, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt6
	MOVLW       208
	XORWF       _baseTempo+0, 0 
L__interrupt6:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;LeitorPulsos.c,70 :: 		baseTempo = 0;
	CLRF        _baseTempo+0 
	CLRF        _baseTempo+1 
;LeitorPulsos.c,72 :: 		pulso = 0x00;
	CLRF        _pulso+0 
;LeitorPulsos.c,74 :: 		} // end if baseTempo == 2000
L_interrupt2:
;LeitorPulsos.c,76 :: 		} // end if TMR2IF_bit
L_interrupt1:
;LeitorPulsos.c,78 :: 		} // end void interrupt
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;LeitorPulsos.c,81 :: 		void main() {
;LeitorPulsos.c,83 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;LeitorPulsos.c,84 :: 		TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como saída
	MOVLW       3
	MOVWF       TRISB+0 
;LeitorPulsos.c,86 :: 		INTCON = 0xD0; // Habilita a interrupção global, a interrupção por periféricos e a interrupção externa INT0
	MOVLW       208
	MOVWF       INTCON+0 
;LeitorPulsos.c,87 :: 		INTEDG0_bit = 0x01; // Registrador INTCON2. Configura a interrupção externa INT0 por borda de subida
	BSF         INTEDG0_bit+0, 6 
;LeitorPulsos.c,88 :: 		TMR2ON_bit = 0x01; // Registrador T2CON. Habilita o timer2
	BSF         TMR2ON_bit+0, 2 
;LeitorPulsos.c,89 :: 		PR2 = 200; // Configura o TMR2 para contar até 200
	MOVLW       200
	MOVWF       PR2+0 
;LeitorPulsos.c,90 :: 		TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2
	BSF         TMR2IE_bit+0, 1 
;LeitorPulsos.c,92 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;LeitorPulsos.c,93 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LeitorPulsos.c,94 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LeitorPulsos.c,95 :: 		lcd_chr(1, 1, 'P');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos.c,96 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,97 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,98 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,99 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,100 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,101 :: 		lcd_chr_cp('S');
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,102 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,103 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,104 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,105 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,106 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,109 :: 		while(1){
L_main3:
;LeitorPulsos.c,111 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;LeitorPulsos.c,113 :: 		} // end Loop infinito
	GOTO        L_main3
;LeitorPulsos.c,115 :: 		} // end void main
	GOTO        $+0
; end of _main

_imprime_Display:

;LeitorPulsos.c,118 :: 		void imprime_Display(){
;LeitorPulsos.c,122 :: 		cen = cont/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _cont+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen_L0+0 
;LeitorPulsos.c,123 :: 		dez = (cont%100)/10;
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
;LeitorPulsos.c,124 :: 		uni = cont%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _cont+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni_L0+0 
;LeitorPulsos.c,126 :: 		lcd_chr(2, 8, cen + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos.c,127 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,128 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos.c,130 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

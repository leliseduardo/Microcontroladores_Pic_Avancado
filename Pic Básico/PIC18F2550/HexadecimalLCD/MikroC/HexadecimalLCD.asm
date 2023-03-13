
_main:

;HexadecimalLCD.c,34 :: 		void main() {
;HexadecimalLCD.c,36 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;HexadecimalLCD.c,38 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;HexadecimalLCD.c,39 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;HexadecimalLCD.c,40 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;HexadecimalLCD.c,43 :: 		while(1){
L_main0:
;HexadecimalLCD.c,45 :: 		valor += 0x01;
	INCF        _valor+0, 1 
;HexadecimalLCD.c,47 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;HexadecimalLCD.c,49 :: 		decimal_Hexadecimal(valor);
	MOVF        _valor+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	CALL        _decimal_Hexadecimal+0, 0
;HexadecimalLCD.c,51 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;HexadecimalLCD.c,53 :: 		} // end Loop infinito
	GOTO        L_main0
;HexadecimalLCD.c,55 :: 		} // end void main
	GOTO        $+0
; end of _main

_imprime_Display:

;HexadecimalLCD.c,58 :: 		void imprime_Display(){
;HexadecimalLCD.c,62 :: 		lcd_chr(1, 1, 'D');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;HexadecimalLCD.c,63 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,64 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,65 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,66 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,67 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,68 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,69 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,70 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,71 :: 		lcd_chr_cp('H');
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,72 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,73 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,74 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,75 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,76 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,77 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,79 :: 		cen = valor/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen_L0+0 
;HexadecimalLCD.c,80 :: 		dez = (valor%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez_L0+0 
;HexadecimalLCD.c,81 :: 		uni = valor%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni_L0+0 
;HexadecimalLCD.c,83 :: 		lcd_chr(2, 2, cen + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;HexadecimalLCD.c,84 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,85 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,87 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_decimal_Hexadecimal:

;HexadecimalLCD.c,90 :: 		void decimal_Hexadecimal(unsigned char n){
;HexadecimalLCD.c,95 :: 		valorH = n & 0xF0; // Faz com que em valorH só se mantenha o valor do nible mais significativo, e o nible menos significativo todo em 0.
	MOVLW       240
	ANDWF       FARG_decimal_Hexadecimal_n+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       decimal_Hexadecimal_valorH_L0+0 
;HexadecimalLCD.c,97 :: 		valorH = valorH >> 4; // valorH = 1101 0000, por exemplo. Com o comando valorH = valorH >> 4, valorH = 000 1101
	MOVF        R2, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	RRCF        R1, 1 
	BCF         R1, 7 
	MOVF        R1, 0 
	MOVWF       decimal_Hexadecimal_valorH_L0+0 
;HexadecimalLCD.c,98 :: 		if(valorH > 0x09)
	MOVF        R1, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_decimal_Hexadecimal3
;HexadecimalLCD.c,99 :: 		valorH += 0x37; // Se valorH for maior que 9, soma-se o número 0x37 da tabela ASC para imprimir o número como letra, de A a F
	MOVLW       55
	ADDWF       decimal_Hexadecimal_valorH_L0+0, 1 
	GOTO        L_decimal_Hexadecimal4
L_decimal_Hexadecimal3:
;HexadecimalLCD.c,101 :: 		valorH += 0x30; // Se valorH for menor que 9, soma-se o número 0x30 da tabela ASC para imprimir o número correspondente, de 0 a 9
	MOVLW       48
	ADDWF       decimal_Hexadecimal_valorH_L0+0, 1 
L_decimal_Hexadecimal4:
;HexadecimalLCD.c,103 :: 		valorL = n & 0x0F;
	MOVLW       15
	ANDWF       FARG_decimal_Hexadecimal_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       decimal_Hexadecimal_valorL_L0+0 
;HexadecimalLCD.c,104 :: 		if(valorL > 0x09)
	MOVF        R1, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_decimal_Hexadecimal5
;HexadecimalLCD.c,105 :: 		valorL += 0x37;
	MOVLW       55
	ADDWF       decimal_Hexadecimal_valorL_L0+0, 1 
	GOTO        L_decimal_Hexadecimal6
L_decimal_Hexadecimal5:
;HexadecimalLCD.c,107 :: 		valorL += 0x30;
	MOVLW       48
	ADDWF       decimal_Hexadecimal_valorL_L0+0, 1 
L_decimal_Hexadecimal6:
;HexadecimalLCD.c,109 :: 		lcd_chr(2, 10, valorH);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        decimal_Hexadecimal_valorH_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;HexadecimalLCD.c,110 :: 		lcd_chr_cp(valorL);
	MOVF        decimal_Hexadecimal_valorL_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;HexadecimalLCD.c,112 :: 		} // end void decimal_Hexadecimal
	RETURN      0
; end of _decimal_Hexadecimal

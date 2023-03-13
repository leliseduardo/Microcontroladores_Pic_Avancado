
_main:

;DebbugLCD.c,38 :: 		void main() {
;DebbugLCD.c,40 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;DebbugLCD.c,42 :: 		T0CON = 0x07; // Desabilita o timer0, configura com 16 bits, incremento com ciclo de máquina e prescale em 1:256
	MOVLW       7
	MOVWF       T0CON+0 
;DebbugLCD.c,43 :: 		TMR0L = 0x00;
	CLRF        TMR0L+0 
;DebbugLCD.c,44 :: 		TMR0H = 0x00;
	CLRF        TMR0H+0 
;DebbugLCD.c,46 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;DebbugLCD.c,47 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;DebbugLCD.c,48 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;DebbugLCD.c,51 :: 		while(1){
L_main0:
;DebbugLCD.c,53 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;DebbugLCD.c,54 :: 		decimal_Hexadecimal((unsigned char)TMR0H, 10);
	MOVF        TMR0H+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	MOVLW       10
	MOVWF       FARG_decimal_Hexadecimal_col+0 
	CALL        _decimal_Hexadecimal+0, 0
;DebbugLCD.c,55 :: 		decimal_Hexadecimal((unsigned char)TMR0L, 12);
	MOVF        TMR0L+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	MOVLW       12
	MOVWF       FARG_decimal_Hexadecimal_col+0 
	CALL        _decimal_Hexadecimal+0, 0
;DebbugLCD.c,57 :: 		if(!incrementoT0)
	BTFSC       RC0_bit+0, 0 
	GOTO        L_main2
;DebbugLCD.c,58 :: 		TMR0ON_bit = 0x01; // Liga o timer0
	BSF         TMR0ON_bit+0, 7 
	GOTO        L_main3
L_main2:
;DebbugLCD.c,60 :: 		TMR0ON_bit = 0x00; // Desliga o timer0
	BCF         TMR0ON_bit+0, 7 
L_main3:
;DebbugLCD.c,62 :: 		if(!prescaleT0){
	BTFSC       RC1_bit+0, 1 
	GOTO        L_main4
;DebbugLCD.c,64 :: 		T0PS2_bit = 0x00;
	BCF         T0PS2_bit+0, 2 
;DebbugLCD.c,65 :: 		T0PS1_bit = 0x00;
	BCF         T0PS1_bit+0, 1 
;DebbugLCD.c,66 :: 		T0PS0_bit = 0x00;
	BCF         T0PS0_bit+0, 0 
;DebbugLCD.c,70 :: 		} // end if !prescaleT0
	GOTO        L_main5
L_main4:
;DebbugLCD.c,73 :: 		T0PS2_bit = 0x01;
	BSF         T0PS2_bit+0, 2 
;DebbugLCD.c,74 :: 		T0PS1_bit = 0x01;
	BSF         T0PS1_bit+0, 1 
;DebbugLCD.c,75 :: 		T0PS0_bit = 0x01;
	BSF         T0PS0_bit+0, 0 
;DebbugLCD.c,79 :: 		} // end else !prescaleT0
L_main5:
;DebbugLCD.c,81 :: 		} // end Loop infinito
	GOTO        L_main0
;DebbugLCD.c,83 :: 		} // end void main
	GOTO        $+0
; end of _main

_imprime_Display:

;DebbugLCD.c,86 :: 		void imprime_Display(){
;DebbugLCD.c,90 :: 		lcd_chr(2, 4, 'T');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD.c,91 :: 		lcd_chr_cp('M');
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD.c,92 :: 		lcd_chr_cp('R');
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD.c,93 :: 		lcd_chr_cp('0');
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD.c,95 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_decimal_Hexadecimal:

;DebbugLCD.c,98 :: 		void decimal_Hexadecimal(unsigned char n, unsigned char col){
;DebbugLCD.c,103 :: 		valorH = n & 0xF0; // Faz com que em valorH só se mantenha o valor do nible mais significativo, e o nible menos significativo todo em 0.
	MOVLW       240
	ANDWF       FARG_decimal_Hexadecimal_n+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       decimal_Hexadecimal_valorH_L0+0 
;DebbugLCD.c,105 :: 		valorH = valorH >> 4; // valorH = 1101 0000, por exemplo. Com o comando valorH = valorH >> 4, valorH = 000 1101
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
;DebbugLCD.c,106 :: 		if(valorH > 0x09)
	MOVF        R1, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_decimal_Hexadecimal6
;DebbugLCD.c,107 :: 		valorH += 0x37; // Se valorH for maior que 9, soma-se o número 0x37 da tabela ASC para imprimir o número como letra, de A a F
	MOVLW       55
	ADDWF       decimal_Hexadecimal_valorH_L0+0, 1 
	GOTO        L_decimal_Hexadecimal7
L_decimal_Hexadecimal6:
;DebbugLCD.c,109 :: 		valorH += 0x30; // Se valorH for menor que 9, soma-se o número 0x30 da tabela ASC para imprimir o número correspondente, de 0 a 9
	MOVLW       48
	ADDWF       decimal_Hexadecimal_valorH_L0+0, 1 
L_decimal_Hexadecimal7:
;DebbugLCD.c,111 :: 		valorL = n & 0x0F;
	MOVLW       15
	ANDWF       FARG_decimal_Hexadecimal_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       decimal_Hexadecimal_valorL_L0+0 
;DebbugLCD.c,112 :: 		if(valorL > 0x09)
	MOVF        R1, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_decimal_Hexadecimal8
;DebbugLCD.c,113 :: 		valorL += 0x37;
	MOVLW       55
	ADDWF       decimal_Hexadecimal_valorL_L0+0, 1 
	GOTO        L_decimal_Hexadecimal9
L_decimal_Hexadecimal8:
;DebbugLCD.c,115 :: 		valorL += 0x30;
	MOVLW       48
	ADDWF       decimal_Hexadecimal_valorL_L0+0, 1 
L_decimal_Hexadecimal9:
;DebbugLCD.c,117 :: 		lcd_chr(2, col, valorH);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_decimal_Hexadecimal_col+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        decimal_Hexadecimal_valorH_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD.c,118 :: 		lcd_chr_cp(valorL);
	MOVF        decimal_Hexadecimal_valorL_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD.c,120 :: 		} // end void decimal_Hexadecimal
	RETURN      0
; end of _decimal_Hexadecimal

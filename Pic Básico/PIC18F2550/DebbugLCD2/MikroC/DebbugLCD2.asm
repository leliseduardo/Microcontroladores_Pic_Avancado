
_main:

;DebbugLCD2.c,46 :: 		void main() {
;DebbugLCD2.c,48 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;DebbugLCD2.c,50 :: 		T0CON = 0x07; // Desabilita o timer0, configura com 16 bits, incremento com ciclo de máquina e prescale em 1:256
	MOVLW       7
	MOVWF       T0CON+0 
;DebbugLCD2.c,51 :: 		TMR0H = 0x97;
	MOVLW       151
	MOVWF       TMR0H+0 
;DebbugLCD2.c,52 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;DebbugLCD2.c,54 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;DebbugLCD2.c,55 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;DebbugLCD2.c,56 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;DebbugLCD2.c,59 :: 		while(1){
L_main0:
;DebbugLCD2.c,61 :: 		if(!incremento) flagBotoes.B0 = 0x01;
	BTFSC       RC0_bit+0, 0 
	GOTO        L_main2
	BSF         _flagBotoes+0, 0 
L_main2:
;DebbugLCD2.c,62 :: 		if(!decremento) flagBotoes.B1 = 0x01;
	BTFSC       RC1_bit+0, 1 
	GOTO        L_main3
	BSF         _flagBotoes+0, 1 
L_main3:
;DebbugLCD2.c,64 :: 		if(incremento && flagBotoes.B0){
	BTFSS       RC0_bit+0, 0 
	GOTO        L_main6
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_main6
L__main32:
;DebbugLCD2.c,66 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;DebbugLCD2.c,68 :: 		valor += 0x01;
	INCF        _valor+0, 1 
;DebbugLCD2.c,70 :: 		if(valor > 0x05) valor = 0x01;
	MOVF        _valor+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
	MOVLW       1
	MOVWF       _valor+0 
L_main7:
;DebbugLCD2.c,72 :: 		} // end if incremento && flagBotoes.B0
L_main6:
;DebbugLCD2.c,74 :: 		if(decremento && flagBotoes.B1){
	BTFSS       RC1_bit+0, 1 
	GOTO        L_main10
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_main10
L__main31:
;DebbugLCD2.c,76 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;DebbugLCD2.c,78 :: 		valor -= 0x01;
	DECF        _valor+0, 1 
;DebbugLCD2.c,80 :: 		if(valor < 0x01) valor = 0x05;
	MOVLW       1
	SUBWF       _valor+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main11
	MOVLW       5
	MOVWF       _valor+0 
L_main11:
;DebbugLCD2.c,82 :: 		} // end if decremento && flagBotoes.B1
L_main10:
;DebbugLCD2.c,84 :: 		switch(valor){
	GOTO        L_main12
;DebbugLCD2.c,86 :: 		case 0x01: imprime_Display(0x01);
L_main14:
	MOVLW       1
	MOVWF       FARG_imprime_Display_msg+0 
	CALL        _imprime_Display+0, 0
;DebbugLCD2.c,87 :: 		decimal_Hexadecimal((unsigned char)TMR0H, 10);
	MOVF        TMR0H+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	MOVLW       10
	MOVWF       FARG_decimal_Hexadecimal_col+0 
	CALL        _decimal_Hexadecimal+0, 0
;DebbugLCD2.c,88 :: 		break;
	GOTO        L_main13
;DebbugLCD2.c,89 :: 		case 0x02: imprime_Display(0x02);
L_main15:
	MOVLW       2
	MOVWF       FARG_imprime_Display_msg+0 
	CALL        _imprime_Display+0, 0
;DebbugLCD2.c,90 :: 		decimal_Hexadecimal((unsigned char)TMR0L, 10);
	MOVF        TMR0L+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	MOVLW       10
	MOVWF       FARG_decimal_Hexadecimal_col+0 
	CALL        _decimal_Hexadecimal+0, 0
;DebbugLCD2.c,91 :: 		break;
	GOTO        L_main13
;DebbugLCD2.c,92 :: 		case 0x03: imprime_Display(0x03);
L_main16:
	MOVLW       3
	MOVWF       FARG_imprime_Display_msg+0 
	CALL        _imprime_Display+0, 0
;DebbugLCD2.c,93 :: 		decimal_Hexadecimal((unsigned char)T0CON, 10);
	MOVF        T0CON+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	MOVLW       10
	MOVWF       FARG_decimal_Hexadecimal_col+0 
	CALL        _decimal_Hexadecimal+0, 0
;DebbugLCD2.c,94 :: 		break;
	GOTO        L_main13
;DebbugLCD2.c,95 :: 		case 0x04: imprime_Display(0x04);
L_main17:
	MOVLW       4
	MOVWF       FARG_imprime_Display_msg+0 
	CALL        _imprime_Display+0, 0
;DebbugLCD2.c,96 :: 		decimal_Hexadecimal((unsigned char)TRISC, 10);
	MOVF        TRISC+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	MOVLW       10
	MOVWF       FARG_decimal_Hexadecimal_col+0 
	CALL        _decimal_Hexadecimal+0, 0
;DebbugLCD2.c,97 :: 		break;
	GOTO        L_main13
;DebbugLCD2.c,98 :: 		case 0x05: imprime_Display(0x05);
L_main18:
	MOVLW       5
	MOVWF       FARG_imprime_Display_msg+0 
	CALL        _imprime_Display+0, 0
;DebbugLCD2.c,99 :: 		decimal_Hexadecimal((unsigned char)STATUS, 10);
	MOVF        STATUS+0, 0 
	MOVWF       FARG_decimal_Hexadecimal_n+0 
	MOVLW       10
	MOVWF       FARG_decimal_Hexadecimal_col+0 
	CALL        _decimal_Hexadecimal+0, 0
;DebbugLCD2.c,100 :: 		break;
	GOTO        L_main13
;DebbugLCD2.c,102 :: 		} // end switch valor
L_main12:
	MOVF        _valor+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVF        _valor+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _valor+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVF        _valor+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	MOVF        _valor+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
L_main13:
;DebbugLCD2.c,104 :: 		imprime_Display(0);
	CLRF        FARG_imprime_Display_msg+0 
	CALL        _imprime_Display+0, 0
;DebbugLCD2.c,106 :: 		} // end Loop infinito
	GOTO        L_main0
;DebbugLCD2.c,108 :: 		} // end void main
	GOTO        $+0
; end of _main

_imprime_Display:

;DebbugLCD2.c,111 :: 		void imprime_Display(unsigned char msg){
;DebbugLCD2.c,113 :: 		switch(msg){
	GOTO        L_imprime_Display19
;DebbugLCD2.c,115 :: 		case 0x00: lcd_chr(1, 2, 'R');
L_imprime_Display21:
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD2.c,116 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,117 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,118 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,119 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,120 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,121 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,122 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,123 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,124 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,125 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,126 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,127 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,128 :: 		break;
	GOTO        L_imprime_Display20
;DebbugLCD2.c,129 :: 		case 0x01: lcd_chr(2, 2, 'T');
L_imprime_Display22:
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD2.c,130 :: 		lcd_chr_cp('M');
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,131 :: 		lcd_chr_cp('R');
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,132 :: 		lcd_chr_cp('0');
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,133 :: 		lcd_chr_cp('H');
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,134 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,135 :: 		break;
	GOTO        L_imprime_Display20
;DebbugLCD2.c,136 :: 		case 0x02: lcd_chr(2, 2, 'T');
L_imprime_Display23:
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD2.c,137 :: 		lcd_chr_cp('M');
	MOVLW       77
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,138 :: 		lcd_chr_cp('R');
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,139 :: 		lcd_chr_cp('0');
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,140 :: 		lcd_chr_cp('L');
	MOVLW       76
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,141 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,142 :: 		break;
	GOTO        L_imprime_Display20
;DebbugLCD2.c,143 :: 		case 0x03: lcd_chr(2, 2, 'T');
L_imprime_Display24:
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD2.c,144 :: 		lcd_chr_cp('0');
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,145 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,146 :: 		lcd_chr_cp('O');
	MOVLW       79
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,147 :: 		lcd_chr_cp('N');
	MOVLW       78
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,148 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,149 :: 		break;
	GOTO        L_imprime_Display20
;DebbugLCD2.c,150 :: 		case 0x04: lcd_chr(2, 2, 'T');
L_imprime_Display25:
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD2.c,151 :: 		lcd_chr_cp('R');
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,152 :: 		lcd_chr_cp('I');
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,153 :: 		lcd_chr_cp('S');
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,154 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,155 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,156 :: 		break;
	GOTO        L_imprime_Display20
;DebbugLCD2.c,157 :: 		case 0x05: lcd_chr(2, 2, 'S');
L_imprime_Display26:
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD2.c,158 :: 		lcd_chr_cp('T');
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,159 :: 		lcd_chr_cp('A');
	MOVLW       65
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,160 :: 		lcd_chr_cp('T');
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,161 :: 		lcd_chr_cp('U');
	MOVLW       85
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,162 :: 		lcd_chr_cp('S');
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,163 :: 		break;
	GOTO        L_imprime_Display20
;DebbugLCD2.c,165 :: 		} // end switch msg
L_imprime_Display19:
	MOVF        FARG_imprime_Display_msg+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_imprime_Display21
	MOVF        FARG_imprime_Display_msg+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_imprime_Display22
	MOVF        FARG_imprime_Display_msg+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_imprime_Display23
	MOVF        FARG_imprime_Display_msg+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_imprime_Display24
	MOVF        FARG_imprime_Display_msg+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_imprime_Display25
	MOVF        FARG_imprime_Display_msg+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_imprime_Display26
L_imprime_Display20:
;DebbugLCD2.c,167 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_decimal_Hexadecimal:

;DebbugLCD2.c,170 :: 		void decimal_Hexadecimal(unsigned char n, unsigned char col){
;DebbugLCD2.c,175 :: 		valorH = n & 0xF0; // Faz com que em valorH só se mantenha o valor do nible mais significativo, e o nible menos significativo todo em 0.
	MOVLW       240
	ANDWF       FARG_decimal_Hexadecimal_n+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       decimal_Hexadecimal_valorH_L0+0 
;DebbugLCD2.c,177 :: 		valorH = valorH >> 4; // valorH = 1101 0000, por exemplo. Com o comando valorH = valorH >> 4, valorH = 000 1101
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
;DebbugLCD2.c,178 :: 		if(valorH > 0x09)
	MOVF        R1, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_decimal_Hexadecimal27
;DebbugLCD2.c,179 :: 		valorH += 0x37; // Se valorH for maior que 9, soma-se o número 0x37 da tabela ASC para imprimir o número como letra, de A a F
	MOVLW       55
	ADDWF       decimal_Hexadecimal_valorH_L0+0, 1 
	GOTO        L_decimal_Hexadecimal28
L_decimal_Hexadecimal27:
;DebbugLCD2.c,181 :: 		valorH += 0x30; // Se valorH for menor que 9, soma-se o número 0x30 da tabela ASC para imprimir o número correspondente, de 0 a 9
	MOVLW       48
	ADDWF       decimal_Hexadecimal_valorH_L0+0, 1 
L_decimal_Hexadecimal28:
;DebbugLCD2.c,183 :: 		valorL = n & 0x0F;
	MOVLW       15
	ANDWF       FARG_decimal_Hexadecimal_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       decimal_Hexadecimal_valorL_L0+0 
;DebbugLCD2.c,184 :: 		if(valorL > 0x09)
	MOVF        R1, 0 
	SUBLW       9
	BTFSC       STATUS+0, 0 
	GOTO        L_decimal_Hexadecimal29
;DebbugLCD2.c,185 :: 		valorL += 0x37;
	MOVLW       55
	ADDWF       decimal_Hexadecimal_valorL_L0+0, 1 
	GOTO        L_decimal_Hexadecimal30
L_decimal_Hexadecimal29:
;DebbugLCD2.c,187 :: 		valorL += 0x30;
	MOVLW       48
	ADDWF       decimal_Hexadecimal_valorL_L0+0, 1 
L_decimal_Hexadecimal30:
;DebbugLCD2.c,189 :: 		lcd_chr(2, col, valorH);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_decimal_Hexadecimal_col+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        decimal_Hexadecimal_valorH_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DebbugLCD2.c,190 :: 		lcd_chr_cp(valorL);
	MOVF        decimal_Hexadecimal_valorL_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DebbugLCD2.c,192 :: 		} // end void decimal_Hexadecimal
	RETURN      0
; end of _decimal_Hexadecimal

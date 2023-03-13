
_main:

;LCDLimpezaInteligente.c,56 :: 		void main() {
;LCDLimpezaInteligente.c,58 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;LCDLimpezaInteligente.c,59 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;LCDLimpezaInteligente.c,61 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDLimpezaInteligente.c,63 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;LCDLimpezaInteligente.c,64 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDLimpezaInteligente.c,65 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDLimpezaInteligente.c,68 :: 		while(1){
L_main0:
;LCDLimpezaInteligente.c,70 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;LCDLimpezaInteligente.c,72 :: 		switch(menuControl){
	GOTO        L_main2
;LCDLimpezaInteligente.c,74 :: 		case 0x01: menu1();
L_main4:
	CALL        _menu1+0, 0
;LCDLimpezaInteligente.c,75 :: 		break;
	GOTO        L_main3
;LCDLimpezaInteligente.c,76 :: 		case 0x02: menu2();
L_main5:
	CALL        _menu2+0, 0
;LCDLimpezaInteligente.c,77 :: 		break;
	GOTO        L_main3
;LCDLimpezaInteligente.c,78 :: 		case 0x03: menu3();
L_main6:
	CALL        _menu3+0, 0
;LCDLimpezaInteligente.c,79 :: 		break;
	GOTO        L_main3
;LCDLimpezaInteligente.c,80 :: 		case 0x04: menu4();
L_main7:
	CALL        _menu4+0, 0
;LCDLimpezaInteligente.c,81 :: 		break;
	GOTO        L_main3
;LCDLimpezaInteligente.c,83 :: 		} // end switch menuControl
L_main2:
	MOVF        _menuControl+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
	MOVF        _menuControl+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVF        _menuControl+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        _menuControl+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
L_main3:
;LCDLimpezaInteligente.c,85 :: 		} // end Loop infinito
	GOTO        L_main0
;LCDLimpezaInteligente.c,87 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;LCDLimpezaInteligente.c,89 :: 		void leitura_Botoes(){
;LCDLimpezaInteligente.c,91 :: 		if(!voltaMenu) flagBotoes.B0 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes8
	BSF         _flagBotoes+0, 0 
L_leitura_Botoes8:
;LCDLimpezaInteligente.c,92 :: 		if(!avancaMenu) flagBotoes.B1 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes9
	BSF         _flagBotoes+0, 1 
L_leitura_Botoes9:
;LCDLimpezaInteligente.c,94 :: 		if(voltaMenu && flagBotoes.B0){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes12
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes12
L__leitura_Botoes20:
;LCDLimpezaInteligente.c,96 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;LCDLimpezaInteligente.c,97 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDLimpezaInteligente.c,98 :: 		menuControl--;
	DECF        _menuControl+0, 1 
;LCDLimpezaInteligente.c,100 :: 		if(menuControl == 0x00) menuControl = 0x04;
	MOVF        _menuControl+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes13
	MOVLW       4
	MOVWF       _menuControl+0 
L_leitura_Botoes13:
;LCDLimpezaInteligente.c,102 :: 		} // end if voltaMenu && flagBotoes.B0
L_leitura_Botoes12:
;LCDLimpezaInteligente.c,104 :: 		if(avancaMenu && flagBotoes.B1){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes16
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes16
L__leitura_Botoes19:
;LCDLimpezaInteligente.c,106 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;LCDLimpezaInteligente.c,107 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDLimpezaInteligente.c,108 :: 		menuControl++;
	INCF        _menuControl+0, 1 
;LCDLimpezaInteligente.c,110 :: 		if(menuControl == 0x05) menuControl = 0x01;
	MOVF        _menuControl+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes17
	MOVLW       1
	MOVWF       _menuControl+0 
L_leitura_Botoes17:
;LCDLimpezaInteligente.c,112 :: 		} // end if avancaMenu && flagBotoes.B1
L_leitura_Botoes16:
;LCDLimpezaInteligente.c,114 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_apaga_Display:

;LCDLimpezaInteligente.c,116 :: 		void apaga_Display(){
;LCDLimpezaInteligente.c,118 :: 		if(apagaDisplay){
	BTFSS       _apagaDisplay+0, BitPos(_apagaDisplay+0) 
	GOTO        L_apaga_Display18
;LCDLimpezaInteligente.c,120 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDLimpezaInteligente.c,122 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDLimpezaInteligente.c,124 :: 		} // end if apagaDisplay
L_apaga_Display18:
;LCDLimpezaInteligente.c,126 :: 		} // end void apaga_Display
	RETURN      0
; end of _apaga_Display

_menu1:

;LCDLimpezaInteligente.c,128 :: 		void menu1(){
;LCDLimpezaInteligente.c,130 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDLimpezaInteligente.c,132 :: 		lcd_chr(1, 1, 'R');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,133 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,134 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,135 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,136 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,137 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,138 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,139 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,140 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,141 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,142 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,143 :: 		lcd_chr_cp('v');
	MOVLW       118
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,144 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,145 :: 		lcd_chr_cp('j');
	MOVLW       106
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,146 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,148 :: 		lcd_chr(2, 2, 'P');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,149 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,150 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,151 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,152 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,153 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,155 :: 		lcd_chr(2, 10, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,156 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,157 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,158 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,159 :: 		lcd_chr_cp('2');
	MOVLW       50
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,160 :: 		lcd_chr_cp('h');
	MOVLW       104
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,162 :: 		} // end void menu1
	RETURN      0
; end of _menu1

_menu2:

;LCDLimpezaInteligente.c,164 :: 		void menu2(){
;LCDLimpezaInteligente.c,166 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDLimpezaInteligente.c,168 :: 		lcd_chr(1, 1, 'R');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,169 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,170 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,171 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,172 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,173 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,174 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,175 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,176 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,177 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,178 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,179 :: 		lcd_chr_cp('v');
	MOVLW       118
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,180 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,181 :: 		lcd_chr_cp('j');
	MOVLW       106
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,182 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,184 :: 		lcd_chr(2, 2, 'I');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,185 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,186 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,188 :: 		lcd_chr(2, 10, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,189 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,190 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,191 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,192 :: 		lcd_chr_cp('3');
	MOVLW       51
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,193 :: 		lcd_chr_cp('h');
	MOVLW       104
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,195 :: 		} // end void menu2
	RETURN      0
; end of _menu2

_menu3:

;LCDLimpezaInteligente.c,197 :: 		void menu3(){
;LCDLimpezaInteligente.c,199 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDLimpezaInteligente.c,201 :: 		lcd_chr(1, 1, 'R');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,202 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,203 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,204 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,205 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,206 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,207 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,208 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,209 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,210 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,211 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,212 :: 		lcd_chr_cp('v');
	MOVLW       118
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,213 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,214 :: 		lcd_chr_cp('j');
	MOVLW       106
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,215 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,217 :: 		lcd_chr(2, 2, 'S');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,218 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,219 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,220 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,221 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,223 :: 		lcd_chr(2, 10, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,224 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,225 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,226 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,227 :: 		lcd_chr_cp('5');
	MOVLW       53
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,228 :: 		lcd_chr_cp('h');
	MOVLW       104
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,230 :: 		} // end void menu3
	RETURN      0
; end of _menu3

_menu4:

;LCDLimpezaInteligente.c,232 :: 		void menu4(){
;LCDLimpezaInteligente.c,234 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDLimpezaInteligente.c,236 :: 		lcd_chr(1, 1, 'R');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       82
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,237 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,238 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,239 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,240 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,241 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,242 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,243 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,244 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,245 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,246 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,247 :: 		lcd_chr_cp('v');
	MOVLW       118
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,248 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,249 :: 		lcd_chr_cp('j');
	MOVLW       106
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,250 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,252 :: 		lcd_chr(2, 2, 'W');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       87
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,253 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,254 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,255 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,256 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,258 :: 		lcd_chr(2, 10, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDLimpezaInteligente.c,259 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,260 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,261 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,262 :: 		lcd_chr_cp('2');
	MOVLW       50
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,263 :: 		lcd_chr_cp('h');
	MOVLW       104
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDLimpezaInteligente.c,265 :: 		} // end void menu4
	RETURN      0
; end of _menu4

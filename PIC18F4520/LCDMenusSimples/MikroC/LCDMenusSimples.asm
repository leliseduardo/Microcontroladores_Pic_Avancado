
_main:

;LCDMenusSimples.c,57 :: 		void main() {
;LCDMenusSimples.c,60 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;LCDMenusSimples.c,61 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;LCDMenusSimples.c,63 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusSimples.c,65 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;LCDMenusSimples.c,66 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusSimples.c,67 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusSimples.c,70 :: 		while(1){
L_main0:
;LCDMenusSimples.c,72 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;LCDMenusSimples.c,74 :: 		switch(menuControl){
	GOTO        L_main2
;LCDMenusSimples.c,76 :: 		case 0x01: menu1();
L_main4:
	CALL        _menu1+0, 0
;LCDMenusSimples.c,77 :: 		break;
	GOTO        L_main3
;LCDMenusSimples.c,78 :: 		case 0x02: menu2();
L_main5:
	CALL        _menu2+0, 0
;LCDMenusSimples.c,79 :: 		break;
	GOTO        L_main3
;LCDMenusSimples.c,80 :: 		case 0x03: menu3();
L_main6:
	CALL        _menu3+0, 0
;LCDMenusSimples.c,81 :: 		break;
	GOTO        L_main3
;LCDMenusSimples.c,82 :: 		case 0x04: menu4();
L_main7:
	CALL        _menu4+0, 0
;LCDMenusSimples.c,83 :: 		break;
	GOTO        L_main3
;LCDMenusSimples.c,84 :: 		case 0x05: menu5();
L_main8:
	CALL        _menu5+0, 0
;LCDMenusSimples.c,85 :: 		break;
	GOTO        L_main3
;LCDMenusSimples.c,86 :: 		case 0x06: menu6();
L_main9:
	CALL        _menu6+0, 0
;LCDMenusSimples.c,87 :: 		break;
	GOTO        L_main3
;LCDMenusSimples.c,89 :: 		} // end switch menuControl
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
	MOVF        _menuControl+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        _menuControl+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
L_main3:
;LCDMenusSimples.c,91 :: 		} // end loop infinito
	GOTO        L_main0
;LCDMenusSimples.c,93 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;LCDMenusSimples.c,95 :: 		void leitura_Botoes(){
;LCDMenusSimples.c,97 :: 		if(!voltaMenu) flagBotoes.B0 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes10
	BSF         _flagBotoes+0, 0 
L_leitura_Botoes10:
;LCDMenusSimples.c,98 :: 		if(!avancaMenu) flagBotoes.B1 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes11
	BSF         _flagBotoes+0, 1 
L_leitura_Botoes11:
;LCDMenusSimples.c,100 :: 		if(voltaMenu && flagBotoes.B0){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes14
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes14
L__leitura_Botoes22:
;LCDMenusSimples.c,102 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;LCDMenusSimples.c,103 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusSimples.c,104 :: 		menuControl--;
	DECF        _menuControl+0, 1 
;LCDMenusSimples.c,106 :: 		if(menuControl == 0) menuControl = numeroMenus;
	MOVF        _menuControl+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes15
	MOVLW       6
	MOVWF       _menuControl+0 
L_leitura_Botoes15:
;LCDMenusSimples.c,108 :: 		} // end if voltaMenu && flagBotoes.B0
L_leitura_Botoes14:
;LCDMenusSimples.c,110 :: 		if(avancaMenu && flagBotoes.B1){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes18
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes18
L__leitura_Botoes21:
;LCDMenusSimples.c,112 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;LCDMenusSimples.c,113 :: 		apagaDisplay = 1;
	BSF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusSimples.c,114 :: 		menuControl++;
	INCF        _menuControl+0, 1 
;LCDMenusSimples.c,116 :: 		if(menuControl == (numeroMenus+1)) menuControl = 0x01;
	MOVF        _menuControl+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_leitura_Botoes19
	MOVLW       1
	MOVWF       _menuControl+0 
L_leitura_Botoes19:
;LCDMenusSimples.c,118 :: 		} // end if avancaMenu && flagBotoes.B1
L_leitura_Botoes18:
;LCDMenusSimples.c,120 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes

_apaga_Display:

;LCDMenusSimples.c,122 :: 		void apaga_Display(){
;LCDMenusSimples.c,124 :: 		if(apagaDisplay){
	BTFSS       _apagaDisplay+0, BitPos(_apagaDisplay+0) 
	GOTO        L_apaga_Display20
;LCDMenusSimples.c,126 :: 		apagaDisplay = 0;
	BCF         _apagaDisplay+0, BitPos(_apagaDisplay+0) 
;LCDMenusSimples.c,128 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDMenusSimples.c,130 :: 		} // end if apagaDisplay
L_apaga_Display20:
;LCDMenusSimples.c,132 :: 		} // end void apaga_Display
	RETURN      0
; end of _apaga_Display

_menu1:

;LCDMenusSimples.c,134 :: 		void menu1(){
;LCDMenusSimples.c,136 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusSimples.c,138 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,139 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,140 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,141 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,142 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,143 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,144 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,145 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,146 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,147 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,148 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,150 :: 		lcd_chr(2, 2, 'I');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,151 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,152 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,153 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,155 :: 		} // end void menu1
	RETURN      0
; end of _menu1

_menu2:

;LCDMenusSimples.c,157 :: 		void menu2(){
;LCDMenusSimples.c,159 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusSimples.c,161 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,162 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,163 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,164 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,165 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,166 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,167 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,168 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,169 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,170 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,171 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,173 :: 		lcd_chr(2, 2, 'E');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,174 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,175 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,176 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,178 :: 		} // end void menu2
	RETURN      0
; end of _menu2

_menu3:

;LCDMenusSimples.c,181 :: 		void menu3(){
;LCDMenusSimples.c,183 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusSimples.c,185 :: 		lcd_chr(1, 2, 'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,186 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,187 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,188 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,189 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,190 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,191 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,192 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,193 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,194 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,196 :: 		lcd_chr(2, 2, 'T');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,197 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,198 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,199 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,200 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,201 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,202 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,204 :: 		} // end void menu3
	RETURN      0
; end of _menu3

_menu4:

;LCDMenusSimples.c,207 :: 		void menu4(){
;LCDMenusSimples.c,209 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusSimples.c,211 :: 		lcd_chr(1, 2, 'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,212 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,213 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,214 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,215 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,216 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,217 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,218 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,220 :: 		lcd_chr(2, 2, 'P');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,221 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,222 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,223 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,224 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,225 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,226 :: 		lcd_chr_cp(':');
	MOVLW       58
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,228 :: 		} // end void menu4
	RETURN      0
; end of _menu4

_menu5:

;LCDMenusSimples.c,231 :: 		void menu5(){
;LCDMenusSimples.c,233 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusSimples.c,235 :: 		lcd_chr(1, 2, 'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,236 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,237 :: 		lcd_chr_cp('m');
	MOVLW       109
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,238 :: 		lcd_chr_cp('p');
	MOVLW       112
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,239 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,241 :: 		} // end void menu5
	RETURN      0
; end of _menu5

_menu6:

;LCDMenusSimples.c,244 :: 		void menu6(){
;LCDMenusSimples.c,246 :: 		apaga_Display();
	CALL        _apaga_Display+0, 0
;LCDMenusSimples.c,248 :: 		lcd_chr(1, 2, 'E');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       69
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDMenusSimples.c,249 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,250 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,251 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,252 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,253 :: 		lcd_chr_cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,254 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,255 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,256 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,257 :: 		lcd_chr_cp('H');
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,258 :: 		lcd_chr_cp('I');
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,259 :: 		lcd_chr_cp('G');
	MOVLW       71
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,260 :: 		lcd_chr_cp('H');
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDMenusSimples.c,263 :: 		} // end void menu6
	RETURN      0
; end of _menu6

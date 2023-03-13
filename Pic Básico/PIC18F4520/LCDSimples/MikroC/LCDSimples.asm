
_main:

;LCDSimples.c,43 :: 		void main() {
;LCDSimples.c,45 :: 		ADCON0 = 0x00; // Desabilita os conversores AD
	CLRF        ADCON0+0 
;LCDSimples.c,46 :: 		ADCON1  = 0x0F; // Configura todas as portas que podem ser analógicas, como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;LCDSimples.c,50 :: 		lcd_Init();
	CALL        _Lcd_Init+0, 0
;LCDSimples.c,51 :: 		lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDSimples.c,52 :: 		lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCDSimples.c,54 :: 		while(1){
L_main0:
;LCDSimples.c,56 :: 		HelloWorld();
	CALL        _HelloWorld+0, 0
;LCDSimples.c,60 :: 		} //end while
	GOTO        L_main0
;LCDSimples.c,61 :: 		} // end void main
	GOTO        $+0
; end of _main

_HelloWorld:

;LCDSimples.c,64 :: 		void HelloWorld(){
;LCDSimples.c,66 :: 		lcd_Chr(1, 3, 'H'); // Função que escreve um único caracter na linha e coluna especificada
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       72
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSimples.c,67 :: 		lcd_Chr_Cp('e'); // Função que escreve um único caracter na próxima posição vazia, isto é, após o último caracter escrito
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,68 :: 		lcd_Chr_Cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,69 :: 		lcd_Chr_Cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,70 :: 		lcd_Chr_Cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,71 :: 		lcd_Chr_Cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,72 :: 		lcd_Chr_Cp('W');
	MOVLW       87
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,73 :: 		lcd_Chr_Cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,74 :: 		lcd_Chr_Cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,75 :: 		lcd_Chr_Cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,76 :: 		lcd_Chr_Cp('d');
	MOVLW       100
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,77 :: 		lcd_Chr_Cp('!');
	MOVLW       33
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,79 :: 		lcd_Chr(2, 4, 'P');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LCDSimples.c,80 :: 		lcd_Chr_Cp('I');
	MOVLW       73
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,81 :: 		lcd_Chr_Cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,82 :: 		lcd_Chr_Cp('1');
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,83 :: 		lcd_Chr_Cp('8');
	MOVLW       56
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,84 :: 		lcd_Chr_Cp('F');
	MOVLW       70
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,85 :: 		lcd_Chr_Cp('4');
	MOVLW       52
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,86 :: 		lcd_Chr_Cp('5');
	MOVLW       53
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,87 :: 		lcd_Chr_Cp('2');
	MOVLW       50
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,88 :: 		lcd_Chr_Cp('0');
	MOVLW       48
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LCDSimples.c,89 :: 		} // end void HelloWorld
	RETURN      0
; end of _HelloWorld

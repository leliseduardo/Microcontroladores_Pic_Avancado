
_main:

;ComparadorIntLuminosidade.c,43 :: 		void main() {
;ComparadorIntLuminosidade.c,46 :: 		CMCON = 0x04; // Configura os comparadores internos para ter a entrada não-inversora em comum e a inversora em RA0 (comparador 1)
	MOVLW       4
	MOVWF       CMCON+0 
;ComparadorIntLuminosidade.c,48 :: 		TRISA = 0xFF; // Configura todo o porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;ComparadorIntLuminosidade.c,49 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;ComparadorIntLuminosidade.c,50 :: 		LATB = 0x00; // Inicia todo portb em Low
	CLRF        LATB+0 
;ComparadorIntLuminosidade.c,54 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;ComparadorIntLuminosidade.c,55 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ComparadorIntLuminosidade.c,56 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ComparadorIntLuminosidade.c,58 :: 		textoDisplay();
	CALL        _textoDisplay+0, 0
;ComparadorIntLuminosidade.c,61 :: 		while(1){
L_main0:
;ComparadorIntLuminosidade.c,63 :: 		if(C1OUT_bit){
	BTFSS       C1OUT_bit+0, 6 
	GOTO        L_main2
;ComparadorIntLuminosidade.c,65 :: 		LATB0_bit = 0x01;
	BSF         LATB0_bit+0, 0 
;ComparadorIntLuminosidade.c,66 :: 		luzBaixa();
	CALL        _luzBaixa+0, 0
;ComparadorIntLuminosidade.c,67 :: 		}
	GOTO        L_main3
L_main2:
;ComparadorIntLuminosidade.c,70 :: 		LATB0_bit = 0x00;
	BCF         LATB0_bit+0, 0 
;ComparadorIntLuminosidade.c,71 :: 		luzAlta();
	CALL        _luzAlta+0, 0
;ComparadorIntLuminosidade.c,72 :: 		} // end if
L_main3:
;ComparadorIntLuminosidade.c,73 :: 		} // end while
	GOTO        L_main0
;ComparadorIntLuminosidade.c,74 :: 		} // end void mais
	GOTO        $+0
; end of _main

_textoDisplay:

;ComparadorIntLuminosidade.c,76 :: 		void textoDisplay(){
;ComparadorIntLuminosidade.c,78 :: 		lcd_chr(1, 1, 'S');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;ComparadorIntLuminosidade.c,79 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,80 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,81 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,82 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,83 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,84 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,85 :: 		lcd_chr_cp('L');
	MOVLW       76
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,86 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,87 :: 		lcd_chr_cp('z');
	MOVLW       122
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,88 :: 		}
	RETURN      0
; end of _textoDisplay

_luzBaixa:

;ComparadorIntLuminosidade.c,90 :: 		void luzBaixa(){
;ComparadorIntLuminosidade.c,92 :: 		lcd_chr(2, 1, 'L');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       76
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;ComparadorIntLuminosidade.c,93 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,94 :: 		lcd_chr_cp('z');
	MOVLW       122
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,95 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,96 :: 		lcd_chr_cp('B');
	MOVLW       66
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,97 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,98 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,99 :: 		lcd_chr_cp('x');
	MOVLW       120
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,100 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,101 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,102 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,103 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,104 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,105 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,106 :: 		}
	RETURN      0
; end of _luzBaixa

_luzAlta:

;ComparadorIntLuminosidade.c,108 :: 		void luzAlta(){
;ComparadorIntLuminosidade.c,110 :: 		lcd_chr(2, 1, 'L');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       76
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;ComparadorIntLuminosidade.c,111 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,112 :: 		lcd_chr_cp('z');
	MOVLW       122
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,113 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,114 :: 		lcd_chr_cp('A');
	MOVLW       65
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,115 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,116 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,117 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,118 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,119 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,120 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,121 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,122 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,123 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;ComparadorIntLuminosidade.c,124 :: 		}
	RETURN      0
; end of _luzAlta


_main:

;mini_clp_source_ihm.c,89 :: 		void main()
;mini_clp_source_ihm.c,91 :: 		CMCON    = 0x07;                            //desabilita comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;mini_clp_source_ihm.c,92 :: 		TRISA    = 0x2F;                            //configura RA7,RA6,RA4 como saída
	MOVLW      47
	MOVWF      TRISA+0
;mini_clp_source_ihm.c,93 :: 		TRISB    = 0x0B;                            //configura RB7,RB6,RB5,RB4,RB3 como saída
	MOVLW      11
	MOVWF      TRISB+0
;mini_clp_source_ihm.c,94 :: 		PORTA    = 0x2F;                            //inicializa PORTA (saídas em LOW)
	MOVLW      47
	MOVWF      PORTA+0
;mini_clp_source_ihm.c,95 :: 		PORTB    = 0x0B;                            //inicializa PORTB
	MOVLW      11
	MOVWF      PORTB+0
;mini_clp_source_ihm.c,97 :: 		Lcd_Init();                                 //inicializa LCD
	CALL       _Lcd_Init+0
;mini_clp_source_ihm.c,98 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                   //desliga cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;mini_clp_source_ihm.c,99 :: 		Lcd_Cmd(_LCD_CLEAR);                        //limpa display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;mini_clp_source_ihm.c,101 :: 		boot_sys();                                 //faz boot do sistema
	CALL       _boot_sys+0
;mini_clp_source_ihm.c,103 :: 		Lcd_Cmd(_LCD_CLEAR);                        //limpa display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;mini_clp_source_ihm.c,107 :: 		while(1)                                    //Loop Infinito
L_main0:
;mini_clp_source_ihm.c,110 :: 		read_bts();                              //lê botões
	CALL       _read_bts+0
;mini_clp_source_ihm.c,112 :: 		principal();                             //processamento principal
	CALL       _principal+0
;mini_clp_source_ihm.c,117 :: 		} //end while
	GOTO       L_main0
;mini_clp_source_ihm.c,120 :: 		} //end main
	GOTO       $+0
; end of _main

_principal:

;mini_clp_source_ihm.c,129 :: 		void principal()
;mini_clp_source_ihm.c,131 :: 		switch(menu_num)                            //verifica menu_num
	GOTO       L_principal2
;mini_clp_source_ihm.c,133 :: 		case 0: menu_1(); break;                 //caso 0, mostra menu_1
L_principal4:
	CALL       _menu_1+0
	GOTO       L_principal3
;mini_clp_source_ihm.c,134 :: 		case 1: menu_2(); break;                 //caso 1, mostra menu_2
L_principal5:
	CALL       _menu_2+0
	GOTO       L_principal3
;mini_clp_source_ihm.c,135 :: 		case 2: menu_3(); break;                 //caso 2, mostra menu_3
L_principal6:
	CALL       _menu_3+0
	GOTO       L_principal3
;mini_clp_source_ihm.c,136 :: 		case 3: menu_4(); break;                 //caso 3, mostra menu_4
L_principal7:
	CALL       _menu_4+0
	GOTO       L_principal3
;mini_clp_source_ihm.c,139 :: 		} //end menu_num
L_principal2:
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__principal57
	MOVLW      0
	XORWF      _menu_num+0, 0
L__principal57:
	BTFSC      STATUS+0, 2
	GOTO       L_principal4
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__principal58
	MOVLW      1
	XORWF      _menu_num+0, 0
L__principal58:
	BTFSC      STATUS+0, 2
	GOTO       L_principal5
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__principal59
	MOVLW      2
	XORWF      _menu_num+0, 0
L__principal59:
	BTFSC      STATUS+0, 2
	GOTO       L_principal6
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__principal60
	MOVLW      3
	XORWF      _menu_num+0, 0
L__principal60:
	BTFSC      STATUS+0, 2
	GOTO       L_principal7
L_principal3:
;mini_clp_source_ihm.c,141 :: 		} //end principal
	RETURN
; end of _principal

_menu_1:

;mini_clp_source_ihm.c,146 :: 		void menu_1()
;mini_clp_source_ihm.c,149 :: 		one_clear_LCD();                         //limpa display
	CALL       _one_clear_LCD+0
;mini_clp_source_ihm.c,150 :: 		lcd_msg(1);                              //chama mensagens e mostra os
	MOVLW      1
	MOVWF      FARG_lcd_msg_opt+0
	CALL       _lcd_msg+0
;mini_clp_source_ihm.c,153 :: 		} //end menu_1
	RETURN
; end of _menu_1

_menu_2:

;mini_clp_source_ihm.c,158 :: 		void menu_2()
;mini_clp_source_ihm.c,161 :: 		one_clear_LCD();                         //limpa display
	CALL       _one_clear_LCD+0
;mini_clp_source_ihm.c,162 :: 		lcd_msg(2);                              //chama mensagens e mostra os
	MOVLW      2
	MOVWF      FARG_lcd_msg_opt+0
	CALL       _lcd_msg+0
;mini_clp_source_ihm.c,165 :: 		} //end menu_2
	RETURN
; end of _menu_2

_menu_3:

;mini_clp_source_ihm.c,170 :: 		void menu_3()
;mini_clp_source_ihm.c,173 :: 		one_clear_LCD();                         //limpa display
	CALL       _one_clear_LCD+0
;mini_clp_source_ihm.c,174 :: 		lcd_msg(3);                              //chama mensagens e mostra os
	MOVLW      3
	MOVWF      FARG_lcd_msg_opt+0
	CALL       _lcd_msg+0
;mini_clp_source_ihm.c,177 :: 		} //end menu_3
	RETURN
; end of _menu_3

_menu_4:

;mini_clp_source_ihm.c,182 :: 		void menu_4()
;mini_clp_source_ihm.c,185 :: 		one_clear_LCD();                         //limpa display
	CALL       _one_clear_LCD+0
;mini_clp_source_ihm.c,186 :: 		lcd_msg(4);                              //chama mensagens e mostra os
	MOVLW      4
	MOVWF      FARG_lcd_msg_opt+0
	CALL       _lcd_msg+0
;mini_clp_source_ihm.c,190 :: 		} //end menu_4
	RETURN
; end of _menu_4

_read_bts:

;mini_clp_source_ihm.c,195 :: 		void read_bts()
;mini_clp_source_ihm.c,197 :: 		if(!bt_up)   bt_up_f   = 0x01;              //se botão up pressionado, seta flag
	BTFSC      RA0_bit+0, 0
	GOTO       L_read_bts8
	BSF        _flagsA+0, 0
L_read_bts8:
;mini_clp_source_ihm.c,198 :: 		if(!bt_down) bt_down_f = 0x01;              //se botão down pressionado, seta flag
	BTFSC      RA1_bit+0, 1
	GOTO       L_read_bts9
	BSF        _flagsA+0, 1
L_read_bts9:
;mini_clp_source_ihm.c,199 :: 		if(!bt_ent)  bt_ent_f  = 0x01;              //se botão enter pressionado, seta flag
	BTFSC      RA2_bit+0, 2
	GOTO       L_read_bts10
	BSF        _flagsA+0, 2
L_read_bts10:
;mini_clp_source_ihm.c,202 :: 		if(bt_up && bt_up_f)                        //se botão up solto e flag setada
	BTFSS      RA0_bit+0, 0
	GOTO       L_read_bts13
	BTFSS      _flagsA+0, 0
	GOTO       L_read_bts13
L__read_bts56:
;mini_clp_source_ihm.c,204 :: 		bt_up_f = 0x00;                          //limpa flag
	BCF        _flagsA+0, 0
;mini_clp_source_ihm.c,206 :: 		if(!control) menu_num += 1;              //incrementa menu_num, se control igual a 0
	MOVF       _control+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_read_bts14
	INCF       _menu_num+0, 1
	BTFSC      STATUS+0, 2
	INCF       _menu_num+1, 1
	GOTO       L_read_bts15
L_read_bts14:
;mini_clp_source_ihm.c,208 :: 		else if(menu_num == 2)                   //se menu_num igual a 2...
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_bts61
	MOVLW      2
	XORWF      _menu_num+0, 0
L__read_bts61:
	BTFSS      STATUS+0, 2
	GOTO       L_read_bts16
;mini_clp_source_ihm.c,210 :: 		if(pos[control][menu_num] < 24) pos[control][menu_num] ++;
	MOVF       _control+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _pos+0
	ADDWF      R0+0, 1
	MOVF       _menu_num+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      24
	SUBWF      INDF+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts17
	MOVF       _control+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _pos+0
	ADDWF      R0+0, 1
	MOVF       _menu_num+0, 0
	ADDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_read_bts17:
;mini_clp_source_ihm.c,211 :: 		}
	GOTO       L_read_bts18
L_read_bts16:
;mini_clp_source_ihm.c,213 :: 		else pos[control][menu_num] = 1;         //senão, força posição atual para 1
	MOVF       _control+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _pos+0
	ADDWF      R0+0, 1
	MOVF       _menu_num+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      1
	MOVWF      INDF+0
L_read_bts18:
L_read_bts15:
;mini_clp_source_ihm.c,217 :: 		if(menu_num > 3) menu_num = 0;           //se menu_num maior que 3, volta para 0
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _menu_num+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_bts62
	MOVF       _menu_num+0, 0
	SUBLW      3
L__read_bts62:
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts19
	CLRF       _menu_num+0
	CLRF       _menu_num+1
L_read_bts19:
;mini_clp_source_ihm.c,219 :: 		lcd_clr = 1;                             //seta flag de limpeza do LCD
	BSF        _flagsA+0, 3
;mini_clp_source_ihm.c,222 :: 		} //end bt_up
L_read_bts13:
;mini_clp_source_ihm.c,225 :: 		if(bt_down && bt_down_f)                    //se botão down solto e flag setada
	BTFSS      RA1_bit+0, 1
	GOTO       L_read_bts22
	BTFSS      _flagsA+0, 1
	GOTO       L_read_bts22
L__read_bts55:
;mini_clp_source_ihm.c,227 :: 		bt_down_f = 0x00;                        //limpa flag
	BCF        _flagsA+0, 1
;mini_clp_source_ihm.c,229 :: 		if(!control) menu_num -= 1;              //decrementa menu_num, se control igual a 0
	MOVF       _control+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_read_bts23
	MOVLW      1
	SUBWF      _menu_num+0, 1
	BTFSS      STATUS+0, 0
	DECF       _menu_num+1, 1
	GOTO       L_read_bts24
L_read_bts23:
;mini_clp_source_ihm.c,231 :: 		else if(menu_num == 2)                   //se menu_num igual a 2...
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_bts63
	MOVLW      2
	XORWF      _menu_num+0, 0
L__read_bts63:
	BTFSS      STATUS+0, 2
	GOTO       L_read_bts25
;mini_clp_source_ihm.c,233 :: 		if(pos[control][menu_num]) pos[control][menu_num] --;
	MOVF       _control+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _pos+0
	ADDWF      R0+0, 1
	MOVF       _menu_num+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts26
	MOVF       _control+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _pos+0
	ADDWF      R0+0, 1
	MOVF       _menu_num+0, 0
	ADDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	DECF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
L_read_bts26:
;mini_clp_source_ihm.c,234 :: 		}
	GOTO       L_read_bts27
L_read_bts25:
;mini_clp_source_ihm.c,236 :: 		else pos[control][menu_num] = 0;         //senão, força posição atual para 0
	MOVF       _control+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      _pos+0
	ADDWF      R0+0, 1
	MOVF       _menu_num+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	CLRF       INDF+0
L_read_bts27:
L_read_bts24:
;mini_clp_source_ihm.c,240 :: 		if(menu_num < 0) menu_num = 3;           //se menu_num menor que 0, volta para 3
	MOVLW      128
	XORWF      _menu_num+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_bts64
	MOVLW      0
	SUBWF      _menu_num+0, 0
L__read_bts64:
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts28
	MOVLW      3
	MOVWF      _menu_num+0
	MOVLW      0
	MOVWF      _menu_num+1
L_read_bts28:
;mini_clp_source_ihm.c,242 :: 		lcd_clr = 1;                             //seta flag de limpeza do LCD
	BSF        _flagsA+0, 3
;mini_clp_source_ihm.c,245 :: 		} //end bt_down
L_read_bts22:
;mini_clp_source_ihm.c,248 :: 		if(bt_ent && bt_ent_f)                      //se botão enter solto e flag setada
	BTFSS      RA2_bit+0, 2
	GOTO       L_read_bts31
	BTFSS      _flagsA+0, 2
	GOTO       L_read_bts31
L__read_bts54:
;mini_clp_source_ihm.c,250 :: 		bt_ent_f = 0x00;                         //limpa flag
	BCF        _flagsA+0, 2
;mini_clp_source_ihm.c,252 :: 		if(menu_num != 3) control += 1;          //incrementa control, se menu_num for diferente de 3
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__read_bts65
	MOVLW      3
	XORWF      _menu_num+0, 0
L__read_bts65:
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts32
	INCF       _control+0, 1
L_read_bts32:
;mini_clp_source_ihm.c,254 :: 		if(control > 3) control = 0;             //se control maior que 3, volta para 0
	MOVF       _control+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts33
	CLRF       _control+0
L_read_bts33:
;mini_clp_source_ihm.c,256 :: 		lcd_clr = 1;                             //seta flag de limpeza do LCD
	BSF        _flagsA+0, 3
;mini_clp_source_ihm.c,259 :: 		} //end bt_ent
L_read_bts31:
;mini_clp_source_ihm.c,262 :: 		} //end read_bts
	RETURN
; end of _read_bts

_lcd_msg:

;mini_clp_source_ihm.c,267 :: 		void lcd_msg(char opt)
;mini_clp_source_ihm.c,272 :: 		switch(opt)                                 //verifica opt
	GOTO       L_lcd_msg34
;mini_clp_source_ihm.c,274 :: 		case 1:                                  //caso 1, mensagens do menu_1
L_lcd_msg36:
;mini_clp_source_ihm.c,275 :: 		Lcd_Chr(1,3,'A');                     //
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,276 :: 		Lcd_Chr_Cp ('c');                     //
	MOVLW      99
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,277 :: 		Lcd_Chr_Cp ('i');                     //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,278 :: 		Lcd_Chr_Cp ('o');                     //
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,279 :: 		Lcd_Chr_Cp ('n');                     //
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,280 :: 		Lcd_Chr_Cp ('a');                     //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,281 :: 		Lcd_Chr_Cp ('r');                     //
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,282 :: 		Lcd_Chr_Cp (' ');                     //
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,283 :: 		Lcd_Chr_Cp ('s');                     //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,284 :: 		Lcd_Chr_Cp ('a');                     //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,285 :: 		Lcd_Chr_Cp ('i');                     //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,286 :: 		Lcd_Chr_Cp ('d');                     //
	MOVLW      100
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,287 :: 		Lcd_Chr_Cp ('a');                     //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,288 :: 		Lcd_Chr_Cp ('s');                     //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,290 :: 		Lcd_Chr(2,4,'O');                     //
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,291 :: 		Lcd_Chr_Cp ('U');                     //
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,292 :: 		Lcd_Chr_Cp ('T');                     //
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,293 :: 		Lcd_Chr_Cp ('1');                     //
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,295 :: 		Lcd_Chr(3,4,'O');                     //
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,296 :: 		Lcd_Chr_Cp ('U');                     //
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,297 :: 		Lcd_Chr_Cp ('T');                     //
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,298 :: 		Lcd_Chr_Cp ('2');                     //
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,300 :: 		Lcd_Chr(4,4,'O');                     //
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,301 :: 		Lcd_Chr_Cp ('U');                     //
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,302 :: 		Lcd_Chr_Cp ('T');                     //
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,303 :: 		Lcd_Chr_Cp ('3');                     //
	MOVLW      51
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,304 :: 		break;                                //
	GOTO       L_lcd_msg35
;mini_clp_source_ihm.c,306 :: 		case 2:                                  //caso 2, mensagens do menu_2
L_lcd_msg37:
;mini_clp_source_ihm.c,307 :: 		Lcd_Chr(1,3,'T');                     //
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,308 :: 		Lcd_Chr_Cp ('e');                     //
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,309 :: 		Lcd_Chr_Cp ('s');                     //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,310 :: 		Lcd_Chr_Cp ('t');                     //
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,311 :: 		Lcd_Chr_Cp ('a');                     //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,312 :: 		Lcd_Chr_Cp ('r');                     //
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,313 :: 		Lcd_Chr_Cp (' ');                     //
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,314 :: 		Lcd_Chr_Cp ('D');                     //
	MOVLW      68
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,315 :: 		Lcd_Chr_Cp ('i');                     //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,316 :: 		Lcd_Chr_Cp ('g');                     //
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,317 :: 		Lcd_Chr_Cp ('i');                     //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,318 :: 		Lcd_Chr_Cp ('t');                     //
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,319 :: 		Lcd_Chr_Cp ('a');                     //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,320 :: 		Lcd_Chr_Cp ('l');                     //
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,322 :: 		Lcd_Chr(2,4,'I');                     //
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,323 :: 		Lcd_Chr_Cp ('N');                     //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,324 :: 		Lcd_Chr_Cp ('1');                     //
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,326 :: 		Lcd_Chr(3,4,'I');                     //
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,327 :: 		Lcd_Chr_Cp ('N');                     //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,328 :: 		Lcd_Chr_Cp ('2');                     //
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,330 :: 		Lcd_Chr(4,4,'I');                     //
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,331 :: 		Lcd_Chr_Cp ('N');                     //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,332 :: 		Lcd_Chr_Cp ('3');                     //
	MOVLW      51
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,333 :: 		break;                                //
	GOTO       L_lcd_msg35
;mini_clp_source_ihm.c,335 :: 		case 3:                                  //caso 3, mensagens do menu_3
L_lcd_msg38:
;mini_clp_source_ihm.c,336 :: 		Lcd_Chr(1,3,'T');                     //
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,337 :: 		Lcd_Chr_Cp ('e');                     //
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,338 :: 		Lcd_Chr_Cp ('s');                     //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,339 :: 		Lcd_Chr_Cp ('t');                     //
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,340 :: 		Lcd_Chr_Cp ('a');                     //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,341 :: 		Lcd_Chr_Cp ('r');                     //
	MOVLW      114
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,342 :: 		Lcd_Chr_Cp (' ');                     //
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,343 :: 		Lcd_Chr_Cp ('A');                     //
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,344 :: 		Lcd_Chr_Cp ('n');                     //
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,345 :: 		Lcd_Chr_Cp ('a');                     //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,346 :: 		Lcd_Chr_Cp ('l');                     //
	MOVLW      108
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,347 :: 		Lcd_Chr_Cp ('o');                     //
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,348 :: 		Lcd_Chr_Cp ('g');                     //
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,349 :: 		Lcd_Chr_Cp ('s');                     //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,351 :: 		Lcd_Chr(2,4,'A');                     //
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,352 :: 		Lcd_Chr_Cp ('N');                     //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,353 :: 		Lcd_Chr_Cp ('1');                     //
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,355 :: 		Lcd_Chr(3,4,'A');                     //
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,356 :: 		Lcd_Chr_Cp ('N');                     //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,357 :: 		Lcd_Chr_Cp ('2');                     //
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,359 :: 		Lcd_Chr(4,4,'A');                     //
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,360 :: 		Lcd_Chr_Cp ('N');                     //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,361 :: 		Lcd_Chr_Cp ('3');                     //
	MOVLW      51
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,362 :: 		break;                                //
	GOTO       L_lcd_msg35
;mini_clp_source_ihm.c,364 :: 		case 4:                               //caso 4, mensagens do menu_4
L_lcd_msg39:
;mini_clp_source_ihm.c,365 :: 		Lcd_Chr(1,3,'R');                     //
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      82
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,366 :: 		Lcd_Chr_Cp ('e');                     //
	MOVLW      101
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,367 :: 		Lcd_Chr_Cp ('s');                     //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,368 :: 		Lcd_Chr_Cp ('u');                     //
	MOVLW      117
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,369 :: 		Lcd_Chr_Cp ('m');                     //
	MOVLW      109
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,370 :: 		Lcd_Chr_Cp ('o');                     //
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,371 :: 		Lcd_Chr_Cp (' ');                     //
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,372 :: 		Lcd_Chr_Cp ('C');                     //
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,373 :: 		Lcd_Chr_Cp ('o');                     //
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,374 :: 		Lcd_Chr_Cp ('n');                     //
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,375 :: 		Lcd_Chr_Cp ('f');                     //
	MOVLW      102
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,376 :: 		Lcd_Chr_Cp ('i');                     //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,377 :: 		Lcd_Chr_Cp ('g');                     //
	MOVLW      103
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,378 :: 		Lcd_Chr_Cp ('s');                     //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,379 :: 		break;                                //
	GOTO       L_lcd_msg35
;mini_clp_source_ihm.c,382 :: 		} //end opt
L_lcd_msg34:
	MOVF       FARG_lcd_msg_opt+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg36
	MOVF       FARG_lcd_msg_opt+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg37
	MOVF       FARG_lcd_msg_opt+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg38
	MOVF       FARG_lcd_msg_opt+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg39
L_lcd_msg35:
;mini_clp_source_ihm.c,385 :: 		if(menu_num != 3)                           //se menu_num diferente de 3
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__lcd_msg66
	MOVLW      3
	XORWF      _menu_num+0, 0
L__lcd_msg66:
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg40
;mini_clp_source_ihm.c,388 :: 		if(menu_num == 2)                         //se menu_num igual a 2..
	MOVLW      0
	XORWF      _menu_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__lcd_msg67
	MOVLW      2
	XORWF      _menu_num+0, 0
L__lcd_msg67:
	BTFSS      STATUS+0, 2
	GOTO       L_lcd_msg41
;mini_clp_source_ihm.c,390 :: 		dez1 = pos[1][menu_num]/10;             //calcula dezena1 da posição atual
	MOVF       _menu_num+0, 0
	ADDLW      _pos+3
	MOVWF      FLOC__lcd_msg+0
	MOVF       FLOC__lcd_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      lcd_msg_dez1_L0+0
;mini_clp_source_ihm.c,391 :: 		uni1 = pos[1][menu_num]%10;             //calcula unidade1 da posição atual
	MOVF       FLOC__lcd_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      lcd_msg_uni1_L0+0
;mini_clp_source_ihm.c,393 :: 		dez2 = pos[2][menu_num]/10;             //calcula dezena2 da posição atual
	MOVF       _menu_num+0, 0
	ADDLW      _pos+6
	MOVWF      FLOC__lcd_msg+0
	MOVF       FLOC__lcd_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      lcd_msg_dez2_L0+0
;mini_clp_source_ihm.c,394 :: 		uni2 = pos[2][menu_num]%10;             //calcula unidade2 da posição atual
	MOVF       FLOC__lcd_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      lcd_msg_uni2_L0+0
;mini_clp_source_ihm.c,396 :: 		dez3 = pos[3][menu_num]/10;             //calcula dezena3 da posição atual
	MOVF       _menu_num+0, 0
	ADDLW      _pos+9
	MOVWF      FLOC__lcd_msg+0
	MOVF       FLOC__lcd_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      lcd_msg_dez3_L0+0
;mini_clp_source_ihm.c,397 :: 		uni3 = pos[3][menu_num]%10;             //calcula unidade3 da posição atual
	MOVF       FLOC__lcd_msg+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      lcd_msg_uni3_L0+0
;mini_clp_source_ihm.c,399 :: 		Lcd_Chr(2,12,dez1+48);                  //imprime parâmetro 1 de
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      lcd_msg_dez1_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,400 :: 		Lcd_Chr_Cp  (uni1+48);                  //tensão de teste
	MOVLW      48
	ADDWF      lcd_msg_uni1_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,401 :: 		Lcd_Chr_Cp  ('V');                      //unidade em Volts
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,402 :: 		Lcd_Chr(3,12,dez2+48);                  //imprime parâmetro 2 de
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      lcd_msg_dez2_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,403 :: 		Lcd_Chr_Cp  (uni2+48);                  //tensão de teste
	MOVLW      48
	ADDWF      lcd_msg_uni2_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,404 :: 		Lcd_Chr_Cp  ('V');                      //unidade em Volts
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,405 :: 		Lcd_Chr(4,12,dez3+48);                  //imprime parâmetro 3 de
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      lcd_msg_dez3_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,406 :: 		Lcd_Chr_Cp  (uni3+48);                  //tensão de teste
	MOVLW      48
	ADDWF      lcd_msg_uni3_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,407 :: 		Lcd_Chr_Cp  ('V');                      //unidade em Volts
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,410 :: 		} //end if menu_num aninhado
	GOTO       L_lcd_msg42
L_lcd_msg41:
;mini_clp_source_ihm.c,414 :: 		Lcd_Chr(2,12,pos[1][menu_num]+48);      //imprime status da entrada/saída 1
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _menu_num+0, 0
	ADDLW      _pos+3
	MOVWF      FSR
	MOVLW      48
	ADDWF      INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,415 :: 		Lcd_Chr(3,12,pos[2][menu_num]+48);      //imprime status da entrada/saída 2
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _menu_num+0, 0
	ADDLW      _pos+6
	MOVWF      FSR
	MOVLW      48
	ADDWF      INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,416 :: 		Lcd_Chr(4,12,pos[3][menu_num]+48);      //imprime status da entrada/saída 3
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _menu_num+0, 0
	ADDLW      _pos+9
	MOVWF      FSR
	MOVLW      48
	ADDWF      INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,419 :: 		} //end else menu_num aninhado
L_lcd_msg42:
;mini_clp_source_ihm.c,422 :: 		switch(control)                           //verifica control
	GOTO       L_lcd_msg43
;mini_clp_source_ihm.c,424 :: 		case 0: Lcd_Chr(1,1, '>');             //caso 0, imprime >   no início da linha 1
L_lcd_msg45:
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      62
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,425 :: 		Lcd_Chr(1,20,'<'); break;      //        imprime <   no final da linha 1
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      20
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      60
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	GOTO       L_lcd_msg44
;mini_clp_source_ihm.c,426 :: 		case 1: Lcd_Chr(2,1, '*'); break;      //caso 2, posiciona * na linha 2, coluna 1
L_lcd_msg46:
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      42
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	GOTO       L_lcd_msg44
;mini_clp_source_ihm.c,427 :: 		case 2: Lcd_Chr(3,1, '*'); break;      //caso 3, posiciona * na linha 3, coluna 1
L_lcd_msg47:
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      42
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	GOTO       L_lcd_msg44
;mini_clp_source_ihm.c,428 :: 		case 3: Lcd_Chr(4,1, '*'); break;      //caso 4, posiciona * na linha 4, coluna 1
L_lcd_msg48:
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      42
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	GOTO       L_lcd_msg44
;mini_clp_source_ihm.c,430 :: 		} //end switch control
L_lcd_msg43:
	MOVF       _control+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg45
	MOVF       _control+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg46
	MOVF       _control+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg47
	MOVF       _control+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_lcd_msg48
L_lcd_msg44:
;mini_clp_source_ihm.c,433 :: 		} //end if menu_num
	GOTO       L_lcd_msg49
L_lcd_msg40:
;mini_clp_source_ihm.c,439 :: 		Lcd_Chr(2,1,'O');                         //imprime saídas digitais
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,440 :: 		Lcd_Chr_Cp ('U');                         //
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,441 :: 		Lcd_Chr_Cp ('T');                         //
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,442 :: 		Lcd_Chr_Cp ('1');                         //
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,444 :: 		Lcd_Chr(3,1,'O');                         //
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,445 :: 		Lcd_Chr_Cp ('U');                         //
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,446 :: 		Lcd_Chr_Cp ('T');                         //
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,447 :: 		Lcd_Chr_Cp ('2');                         //
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,449 :: 		Lcd_Chr(4,1,'O');                         //
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,450 :: 		Lcd_Chr_Cp ('U');                         //
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,451 :: 		Lcd_Chr_Cp ('T');                         //
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,452 :: 		Lcd_Chr_Cp ('3');                         //
	MOVLW      51
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,454 :: 		Lcd_Chr(2,6,pos[1][0]+48);                //imprime status da saída 1
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _pos+3, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,455 :: 		Lcd_Chr(3,6,pos[2][0]+48);                //imprime status da saída 2
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _pos+6, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,456 :: 		Lcd_Chr(4,6,pos[3][0]+48);                //imprime status da saída 3
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _pos+9, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,459 :: 		Lcd_Chr(2,8,'I');                         //imprime entradas digitais
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,460 :: 		Lcd_Chr_Cp ('N');                         //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,461 :: 		Lcd_Chr_Cp ('1');                         //
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,463 :: 		Lcd_Chr(3,8,'I');                         //
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,464 :: 		Lcd_Chr_Cp ('N');                         //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,465 :: 		Lcd_Chr_Cp ('2');                         //
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,467 :: 		Lcd_Chr(4,8,'I');                         //
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,468 :: 		Lcd_Chr_Cp ('N');                         //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,469 :: 		Lcd_Chr_Cp ('3');                         //
	MOVLW      51
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,471 :: 		Lcd_Chr(2,12,pos[1][1]+48);               //imprime status da entrada 1
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _pos+4, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,472 :: 		Lcd_Chr(3,12,pos[2][1]+48);               //imprime status da entrada 2
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _pos+7, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,473 :: 		Lcd_Chr(4,12,pos[3][1]+48);               //imprime status da entrada 3
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _pos+10, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,476 :: 		Lcd_Chr(2,14,'A');                        //imprime entradas analógicas
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,477 :: 		Lcd_Chr_Cp  ('N');                        //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,478 :: 		Lcd_Chr_Cp  ('1');                        //
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,480 :: 		Lcd_Chr(3,14,'A');                        //
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,481 :: 		Lcd_Chr_Cp  ('N');                        //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,482 :: 		Lcd_Chr_Cp  ('2');                        //
	MOVLW      50
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,484 :: 		Lcd_Chr(4,14,'A');                        //
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,485 :: 		Lcd_Chr_Cp  ('N');                        //
	MOVLW      78
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,486 :: 		Lcd_Chr_Cp  ('3');                        //
	MOVLW      51
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,488 :: 		Lcd_Chr(2,18,dez1+48);                    //imprime tensão
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      18
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      lcd_msg_dez1_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,489 :: 		Lcd_Chr_Cp  (uni1+48);                    //ajustada para entrada 1
	MOVLW      48
	ADDWF      lcd_msg_uni1_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,490 :: 		Lcd_Chr_Cp  ('V');                        //
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,491 :: 		Lcd_Chr(3,18,dez2+48);                    //imprime tensão
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      18
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      lcd_msg_dez2_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,492 :: 		Lcd_Chr_Cp  (uni2+48);                    //ajustada para entrada 2
	MOVLW      48
	ADDWF      lcd_msg_uni2_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,493 :: 		Lcd_Chr_Cp  ('V');                        //
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,494 :: 		Lcd_Chr(4,18,dez3+48);                    //imprime tensão
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      18
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      lcd_msg_dez3_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,495 :: 		Lcd_Chr_Cp  (uni3+48);                    //ajustada para entrada 3
	MOVLW      48
	ADDWF      lcd_msg_uni3_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,496 :: 		Lcd_Chr_Cp  ('V');                        //
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,499 :: 		} //end else
L_lcd_msg49:
;mini_clp_source_ihm.c,502 :: 		} //end lcd_msg
	RETURN
; end of _lcd_msg

_boot_sys:

;mini_clp_source_ihm.c,507 :: 		void boot_sys()
;mini_clp_source_ihm.c,509 :: 		char boot_cnt = 0;                          //variável local para temporização
	CLRF       boot_sys_boot_cnt_L0+0
;mini_clp_source_ihm.c,511 :: 		Lcd_Chr(1,5, 'C');                          //escreve mensagem
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,512 :: 		Lcd_Chr_Cp  ('L');                          //
	MOVLW      76
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,513 :: 		Lcd_Chr_Cp  ('P');                          //
	MOVLW      80
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,514 :: 		Lcd_Chr_Cp  (' ');                          //
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,515 :: 		Lcd_Chr_Cp  ('W');                          //
	MOVLW      87
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,516 :: 		Lcd_Chr_Cp  ('R');                          //
	MOVLW      82
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,517 :: 		Lcd_Chr_Cp  (' ');                          //
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,518 :: 		Lcd_Chr_Cp  ('K');                          //
	MOVLW      75
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,519 :: 		Lcd_Chr_Cp  ('i');                          //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,520 :: 		Lcd_Chr_Cp  ('t');                          //
	MOVLW      116
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,521 :: 		Lcd_Chr_Cp  ('s');                          //
	MOVLW      115
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,523 :: 		Lcd_Chr(2,8, 'v');                          //
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      118
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,524 :: 		Lcd_Chr_Cp  ('1');                          //
	MOVLW      49
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,525 :: 		Lcd_Chr_Cp  ('.');                          //
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,526 :: 		Lcd_Chr_Cp  ('0');                          //
	MOVLW      48
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,528 :: 		Lcd_Chr(3,5, 'I');                          //
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,529 :: 		Lcd_Chr_Cp  ('n');                          //
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,530 :: 		Lcd_Chr_Cp  ('i');                          //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,531 :: 		Lcd_Chr_Cp  ('c');                          //
	MOVLW      99
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,532 :: 		Lcd_Chr_Cp  ('i');                          //
	MOVLW      105
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,533 :: 		Lcd_Chr_Cp  ('a');                          //
	MOVLW      97
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,534 :: 		Lcd_Chr_Cp  ('n');                          //
	MOVLW      110
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,535 :: 		Lcd_Chr_Cp  ('d');                          //
	MOVLW      100
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,536 :: 		Lcd_Chr_Cp  ('o');                          //
	MOVLW      111
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,537 :: 		Lcd_Chr_Cp  ('.');                          //
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,538 :: 		Lcd_Chr_Cp  ('.');                          //
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,539 :: 		Lcd_Chr_Cp  ('.');                          //
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,541 :: 		Lcd_Chr(4,1,'#');                           //imprime caractere de status "carregando"
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      35
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;mini_clp_source_ihm.c,543 :: 		while(boot_cnt < 20)                        //processa enquanto boot_cnt menor que 20
L_boot_sys50:
	MOVLW      20
	SUBWF      boot_sys_boot_cnt_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_boot_sys51
;mini_clp_source_ihm.c,546 :: 		Lcd_Chr_Cp('#');                         //imprime caractere de status "carregando"
	MOVLW      35
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;mini_clp_source_ihm.c,547 :: 		delay_ms(100);                           //aguarda 100ms
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_boot_sys52:
	DECFSZ     R13+0, 1
	GOTO       L_boot_sys52
	DECFSZ     R12+0, 1
	GOTO       L_boot_sys52
	NOP
	NOP
;mini_clp_source_ihm.c,548 :: 		boot_cnt += 1;                           //incrementa boot_cnt
	INCF       boot_sys_boot_cnt_L0+0, 1
;mini_clp_source_ihm.c,550 :: 		} //end while
	GOTO       L_boot_sys50
L_boot_sys51:
;mini_clp_source_ihm.c,552 :: 		rst_ctr = 0x01;                             //libera PIC16F877A
	BSF        RA4_bit+0, 4
;mini_clp_source_ihm.c,555 :: 		} //end boot_sys
	RETURN
; end of _boot_sys

_one_clear_LCD:

;mini_clp_source_ihm.c,560 :: 		void one_clear_LCD()                           //Limpa o LCD uma única vez
;mini_clp_source_ihm.c,562 :: 		if(lcd_clr)                                 //lcd_clr setada?
	BTFSS      _flagsA+0, 3
	GOTO       L_one_clear_LCD53
;mini_clp_source_ihm.c,564 :: 		Lcd_Cmd(_LCD_CLEAR);                     //limpa display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;mini_clp_source_ihm.c,565 :: 		lcd_clr = 0x00;                          //limpa flag para invalidar o laço
	BCF        _flagsA+0, 3
;mini_clp_source_ihm.c,567 :: 		} //end if lcd_clr
L_one_clear_LCD53:
;mini_clp_source_ihm.c,570 :: 		} //end one_clear_LCD
	RETURN
; end of _one_clear_LCD

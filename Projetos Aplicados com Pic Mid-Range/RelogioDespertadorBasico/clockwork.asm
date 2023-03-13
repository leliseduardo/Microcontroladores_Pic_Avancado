
_despertar:

;clockwork.c,43 :: 		void despertar()                               //Função do despertador
;clockwork.c,48 :: 		if(segundos == a_segundos)
	MOVF       _segundos+0, 0
	XORWF      _a_segundos+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_despertar0
;clockwork.c,50 :: 		if(minutos == a_minutos)
	MOVF       _minutos+0, 0
	XORWF      _a_minutos+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_despertar1
;clockwork.c,52 :: 		if(horas == a_horas)
	MOVF       _horas+0, 0
	XORWF      _a_horas+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_despertar2
;clockwork.c,54 :: 		if(dias == a_dias)
	MOVF       _dias+0, 0
	XORWF      _a_dias+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_despertar3
;clockwork.c,57 :: 		relay = 0x01;                    //Liga o relé
	BSF        RB4_bit+0, 4
;clockwork.c,58 :: 		led   = 0x01;                    //Liga LED
	BSF        RB5_bit+0, 5
;clockwork.c,60 :: 		} //end if dias
L_despertar3:
;clockwork.c,62 :: 		} //end if horas
L_despertar2:
;clockwork.c,64 :: 		} //end if minutos
L_despertar1:
;clockwork.c,66 :: 		} //end if segundos
L_despertar0:
;clockwork.c,68 :: 		} //end despertar
	RETURN
; end of _despertar

_disp_horario:

;clockwork.c,73 :: 		void disp_horario()                            //Função para exibir a hora atual
;clockwork.c,77 :: 		text1[7] = segundos%10 + '0';
	MOVLW      7
	ADDWF      _text1+0, 0
	MOVWF      FLOC__disp_horario+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _segundos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_horario+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,78 :: 		text1[6] = segundos/10 + '0';
	MOVLW      6
	ADDWF      _text1+0, 0
	MOVWF      FLOC__disp_horario+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _segundos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_horario+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,79 :: 		text1[4] = minutos%10 + '0';
	MOVLW      4
	ADDWF      _text1+0, 0
	MOVWF      FLOC__disp_horario+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _minutos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_horario+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,80 :: 		text1[3] = minutos/10 + '0';
	MOVLW      3
	ADDWF      _text1+0, 0
	MOVWF      FLOC__disp_horario+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _minutos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_horario+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,81 :: 		text1[1] = horas%10 + '0';
	INCF       _text1+0, 0
	MOVWF      FLOC__disp_horario+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _horas+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_horario+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,82 :: 		text1[0] = horas/10 + '0';
	MOVF       _text1+0, 0
	MOVWF      FLOC__disp_horario+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _horas+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_horario+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,84 :: 		Lcd_Chr(1,5, text1[0]);                   //Imprimi o horário no display
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,85 :: 		Lcd_Chr_Cp  (text1[1]);                   //
	INCF       _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,86 :: 		Lcd_Chr_Cp  (text1[2]);                   //
	MOVLW      2
	ADDWF      _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,87 :: 		Lcd_Chr_Cp  (text1[3]);                   //
	MOVLW      3
	ADDWF      _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,88 :: 		Lcd_Chr_Cp  (text1[4]);                   //
	MOVLW      4
	ADDWF      _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,89 :: 		Lcd_Chr_Cp  (text1[5]);                   //
	MOVLW      5
	ADDWF      _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,90 :: 		Lcd_Chr_Cp  (text1[6]);                   //
	MOVLW      6
	ADDWF      _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,91 :: 		Lcd_Chr_Cp  (text1[7]);                   //
	MOVLW      7
	ADDWF      _text1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,93 :: 		switch(dias)                              //Converte número do dia para nome do dia
	GOTO       L_disp_horario4
;clockwork.c,95 :: 		case 0:
L_disp_horario6:
;clockwork.c,96 :: 		Lcd_Chr(1,14,'D');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      68
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,97 :: 		Lcd_Chr_Cp  ('O');
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,98 :: 		Lcd_Chr_Cp  ('M');
	MOVLW      77
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,99 :: 		break;
	GOTO       L_disp_horario5
;clockwork.c,100 :: 		case 1:
L_disp_horario7:
;clockwork.c,101 :: 		Lcd_Chr(1,14,'S');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,102 :: 		Lcd_Chr_Cp  ('E');
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,103 :: 		Lcd_Chr_Cp  ('G');
	MOVLW      71
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,104 :: 		break;
	GOTO       L_disp_horario5
;clockwork.c,105 :: 		case 2:
L_disp_horario8:
;clockwork.c,106 :: 		Lcd_Chr(1,14,'T');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,107 :: 		Lcd_Chr_Cp  ('E');
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,108 :: 		Lcd_Chr_Cp  ('R');
	MOVLW      82
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,109 :: 		break;
	GOTO       L_disp_horario5
;clockwork.c,110 :: 		case 3:
L_disp_horario9:
;clockwork.c,111 :: 		Lcd_Chr(1,14,'Q');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      81
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,112 :: 		Lcd_Chr_Cp  ('U');
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,113 :: 		Lcd_Chr_Cp  ('A');
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,114 :: 		break;
	GOTO       L_disp_horario5
;clockwork.c,115 :: 		case 4:
L_disp_horario10:
;clockwork.c,116 :: 		Lcd_Chr(1,14,'Q');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      81
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,117 :: 		Lcd_Chr_Cp  ('U');
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,118 :: 		Lcd_Chr_Cp  ('I');
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,119 :: 		break;
	GOTO       L_disp_horario5
;clockwork.c,120 :: 		case 5:
L_disp_horario11:
;clockwork.c,121 :: 		Lcd_Chr(1,14,'S');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,122 :: 		Lcd_Chr_Cp  ('E');
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,123 :: 		Lcd_Chr_Cp  ('X');
	MOVLW      88
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,124 :: 		break;
	GOTO       L_disp_horario5
;clockwork.c,125 :: 		case 6:
L_disp_horario12:
;clockwork.c,126 :: 		Lcd_Chr(1,14,'S');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,127 :: 		Lcd_Chr_Cp  ('A');
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,128 :: 		Lcd_Chr_Cp  ('B');
	MOVLW      66
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,129 :: 		break;
	GOTO       L_disp_horario5
;clockwork.c,131 :: 		} //end switch
L_disp_horario4:
	MOVF       _dias+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_disp_horario6
	MOVF       _dias+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_disp_horario7
	MOVF       _dias+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_disp_horario8
	MOVF       _dias+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_disp_horario9
	MOVF       _dias+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_disp_horario10
	MOVF       _dias+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_disp_horario11
	MOVF       _dias+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_disp_horario12
L_disp_horario5:
;clockwork.c,134 :: 		} //end relogio
	RETURN
; end of _disp_horario

_relogio:

;clockwork.c,139 :: 		void relogio()                                 //Função para controle das variáveis do relógio
;clockwork.c,141 :: 		segundos++;                               //Incrementa os segundos
	INCF       _segundos+0, 1
;clockwork.c,143 :: 		if(segundos == 0x3c)                      //Segundos igual a 60?
	MOVF       _segundos+0, 0
	XORLW      60
	BTFSS      STATUS+0, 2
	GOTO       L_relogio13
;clockwork.c,145 :: 		segundos = 0x00;                      //Reinicia os segundos
	CLRF       _segundos+0
;clockwork.c,146 :: 		minutos++;                            //Incrementa os minutos
	INCF       _minutos+0, 1
;clockwork.c,148 :: 		if(minutos == 0x3c)                   //Minutos igual a 60?
	MOVF       _minutos+0, 0
	XORLW      60
	BTFSS      STATUS+0, 2
	GOTO       L_relogio14
;clockwork.c,150 :: 		minutos = 0x00;                    //Reinicia os minutos
	CLRF       _minutos+0
;clockwork.c,151 :: 		horas++;                           //Incrementa as horas
	INCF       _horas+0, 1
;clockwork.c,153 :: 		if(horas == 0x18)                  //Horas igual a 24 ?
	MOVF       _horas+0, 0
	XORLW      24
	BTFSS      STATUS+0, 2
	GOTO       L_relogio15
;clockwork.c,155 :: 		horas = 0x00;                   //Reinicia as horas
	CLRF       _horas+0
;clockwork.c,156 :: 		dias++;                         //Incrementa os dias
	INCF       _dias+0, 1
;clockwork.c,158 :: 		if(dias == 0x07) dias = 0x00;   //Se dias igual a 7, reinicia
	MOVF       _dias+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_relogio16
	CLRF       _dias+0
L_relogio16:
;clockwork.c,161 :: 		} //end if horas
L_relogio15:
;clockwork.c,163 :: 		} //end if minutos
L_relogio14:
;clockwork.c,165 :: 		} //end if segundos
L_relogio13:
;clockwork.c,167 :: 		} //end relogio
	RETURN
; end of _relogio

_ajusta_relogio:

;clockwork.c,172 :: 		void ajusta_relogio()                          //Função para ajuste do relógio
;clockwork.c,175 :: 		char i = 0;                               //Variável para iterações
	CLRF       ajusta_relogio_i_L0+0
;clockwork.c,177 :: 		if(!plus)       plus_f      = 0x01;       //Se pressionar o botão 'mais', seta a flag
	BTFSC      RA0_bit+0, 0
	GOTO       L_ajusta_relogio17
	BSF        _flagsA+0, 0
L_ajusta_relogio17:
;clockwork.c,178 :: 		if(!plus10)     plus10_f    = 0x01;       //Se pressionar o botão 'mais 10', seta a flag
	BTFSC      RA1_bit+0, 1
	GOTO       L_ajusta_relogio18
	BSF        _flagsA+0, 1
L_ajusta_relogio18:
;clockwork.c,179 :: 		if(!adj_watch)  adj_watch_f = 0x01;       //Se pressionar o botão 'ajuste das horas', seta a flag
	BTFSC      RA2_bit+0, 2
	GOTO       L_ajusta_relogio19
	BSF        _flagsA+0, 2
L_ajusta_relogio19:
;clockwork.c,182 :: 		if(adj_watch && adj_watch_f)              //Soltou botão de ajuste e flag setada?
	BTFSS      RA2_bit+0, 2
	GOTO       L_ajusta_relogio22
	BTFSS      _flagsA+0, 2
	GOTO       L_ajusta_relogio22
L__ajusta_relogio124:
;clockwork.c,184 :: 		adj_watch_f = 0x00;                    //Limpa flag05
	BCF        _flagsA+0, 2
;clockwork.c,185 :: 		ctrl_watch++;                          //Incrementa variável de controle do ajuste
	INCF       _ctrl_watch+0, 1
;clockwork.c,188 :: 		if(ctrl_watch > 0x05) ctrl_watch = 0x00;
	MOVF       _ctrl_watch+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio23
	CLRF       _ctrl_watch+0
L_ajusta_relogio23:
;clockwork.c,190 :: 		} //end if adj_watch
L_ajusta_relogio22:
;clockwork.c,193 :: 		switch(ctrl_watch)                        //Verifica variável de controle de ajuste das horas
	GOTO       L_ajusta_relogio24
;clockwork.c,195 :: 		case 0x00:                             //Caso seja igual a 0
L_ajusta_relogio26:
;clockwork.c,196 :: 		Lcd_Chr (1,1,' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,197 :: 		Lcd_Chr (2,5,'^');             //Demonstra ajuste das horas
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,198 :: 		Lcd_Chr_Cp  ('^');
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,199 :: 		Lcd_Chr (2,8,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,200 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,201 :: 		Lcd_Chr(2,11,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,202 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,203 :: 		break;
	GOTO       L_ajusta_relogio25
;clockwork.c,204 :: 		case 0x01:                             //Caso seja igual a 1
L_ajusta_relogio27:
;clockwork.c,205 :: 		Lcd_Chr (2,5,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,206 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,207 :: 		Lcd_Chr (2,8,'^');             //Demonstra ajuste dos minutos
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,208 :: 		Lcd_Chr_Cp  ('^');
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,209 :: 		Lcd_Chr(2,11,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,210 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,211 :: 		break;
	GOTO       L_ajusta_relogio25
;clockwork.c,212 :: 		case 0x02:                             //Caso seja igual a 2
L_ajusta_relogio28:
;clockwork.c,213 :: 		Lcd_Chr (2,5,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,214 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,215 :: 		Lcd_Chr (2,8,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,216 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,217 :: 		Lcd_Chr(2,11,'^');             //Demonstra ajuste dos segundos
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,218 :: 		Lcd_Chr_Cp  ('^');
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,219 :: 		break;
	GOTO       L_ajusta_relogio25
;clockwork.c,220 :: 		case 0x03:                             //Caso seja igual a 3
L_ajusta_relogio29:
;clockwork.c,221 :: 		Lcd_Chr (2,5,' ');             //Demonstra ajuste dos dias
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,222 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,223 :: 		Lcd_Chr (2,8,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,224 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,225 :: 		Lcd_Chr(2,11,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,226 :: 		Lcd_Chr_Cp  (' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,227 :: 		Lcd_Chr(2,14,'^');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,228 :: 		break;
	GOTO       L_ajusta_relogio25
;clockwork.c,230 :: 		case 0x04:                             //Caso seja igual a 5
L_ajusta_relogio30:
;clockwork.c,231 :: 		despertar();                                   //Desperta!
	CALL       _despertar+0
;clockwork.c,232 :: 		if(minutos == (a_minutos + 10))
	MOVLW      10
	ADDWF      _a_minutos+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ajusta_relogio128
	MOVF       R1+0, 0
	XORWF      _minutos+0, 0
L__ajusta_relogio128:
	BTFSS      STATUS+0, 2
	GOTO       L_ajusta_relogio31
;clockwork.c,234 :: 		relay = 0x00;                 //Desliga relé após 10 minutos
	BCF        RB4_bit+0, 4
;clockwork.c,235 :: 		led   = 0x00;                 //Desliga led  após 10 minutos
	BCF        RB5_bit+0, 5
;clockwork.c,237 :: 		}
L_ajusta_relogio31:
;clockwork.c,238 :: 		Lcd_Chr(1,1,'D');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      68
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,239 :: 		for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
	CLRF       ajusta_relogio_i_L0+0
L_ajusta_relogio32:
	MOVLW      12
	SUBWF      ajusta_relogio_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio33
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	ADDWF      ajusta_relogio_i_L0+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	INCF       ajusta_relogio_i_L0+0, 1
	GOTO       L_ajusta_relogio32
L_ajusta_relogio33:
;clockwork.c,240 :: 		break;
	GOTO       L_ajusta_relogio25
;clockwork.c,241 :: 		case 0x05:                             //Caso seja igual a 5
L_ajusta_relogio35:
;clockwork.c,242 :: 		Lcd_Chr(1,1,' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,243 :: 		for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
	CLRF       ajusta_relogio_i_L0+0
L_ajusta_relogio36:
	MOVLW      12
	SUBWF      ajusta_relogio_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio37
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	ADDWF      ajusta_relogio_i_L0+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	INCF       ajusta_relogio_i_L0+0, 1
	GOTO       L_ajusta_relogio36
L_ajusta_relogio37:
;clockwork.c,244 :: 		break;
	GOTO       L_ajusta_relogio25
;clockwork.c,245 :: 		} //end switch ctrl_watch
L_ajusta_relogio24:
	MOVF       _ctrl_watch+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio26
	MOVF       _ctrl_watch+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio27
	MOVF       _ctrl_watch+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio28
	MOVF       _ctrl_watch+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio29
	MOVF       _ctrl_watch+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio30
	MOVF       _ctrl_watch+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio35
L_ajusta_relogio25:
;clockwork.c,248 :: 		if(plus && plus_f)                  //Botão 'mais' foi solto e a flag foi setada?
	BTFSS      RA0_bit+0, 0
	GOTO       L_ajusta_relogio41
	BTFSS      _flagsA+0, 0
	GOTO       L_ajusta_relogio41
L__ajusta_relogio123:
;clockwork.c,250 :: 		plus_f = 0x00;                   //Limpa a flag07
	BCF        _flagsA+0, 0
;clockwork.c,252 :: 		switch(ctrl_watch)               //Switch na variável de controle
	GOTO       L_ajusta_relogio42
;clockwork.c,254 :: 		case 0x00:                     //Caso 0, libera ajuste das horas, incremento de unidades
L_ajusta_relogio44:
;clockwork.c,255 :: 		horas++;
	INCF       _horas+0, 1
;clockwork.c,256 :: 		if(horas > 0x17) horas = 0x00;
	MOVF       _horas+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio45
	CLRF       _horas+0
L_ajusta_relogio45:
;clockwork.c,257 :: 		break;
	GOTO       L_ajusta_relogio43
;clockwork.c,258 :: 		case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de unidades
L_ajusta_relogio46:
;clockwork.c,259 :: 		minutos++;
	INCF       _minutos+0, 1
;clockwork.c,260 :: 		if(minutos > 0x3b) minutos = 0x00;
	MOVF       _minutos+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio47
	CLRF       _minutos+0
L_ajusta_relogio47:
;clockwork.c,261 :: 		break;
	GOTO       L_ajusta_relogio43
;clockwork.c,262 :: 		case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de unidades
L_ajusta_relogio48:
;clockwork.c,263 :: 		segundos++;
	INCF       _segundos+0, 1
;clockwork.c,264 :: 		if(segundos > 0x3b) segundos = 0x00;
	MOVF       _segundos+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio49
	CLRF       _segundos+0
L_ajusta_relogio49:
;clockwork.c,265 :: 		break;
	GOTO       L_ajusta_relogio43
;clockwork.c,266 :: 		case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
L_ajusta_relogio50:
;clockwork.c,267 :: 		dias++;
	INCF       _dias+0, 1
;clockwork.c,268 :: 		if(dias > 0x06) dias = 0x00;
	MOVF       _dias+0, 0
	SUBLW      6
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio51
	CLRF       _dias+0
L_ajusta_relogio51:
;clockwork.c,269 :: 		break;
	GOTO       L_ajusta_relogio43
;clockwork.c,270 :: 		} //end switch
L_ajusta_relogio42:
	MOVF       _ctrl_watch+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio44
	MOVF       _ctrl_watch+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio46
	MOVF       _ctrl_watch+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio48
	MOVF       _ctrl_watch+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio50
L_ajusta_relogio43:
;clockwork.c,271 :: 		} //end if plus
L_ajusta_relogio41:
;clockwork.c,273 :: 		if(plus10 && plus10_f)              //Botão 'mais10' solto e a flag foi setada?
	BTFSS      RA1_bit+0, 1
	GOTO       L_ajusta_relogio54
	BTFSS      _flagsA+0, 1
	GOTO       L_ajusta_relogio54
L__ajusta_relogio122:
;clockwork.c,275 :: 		plus10_f = 0x00;                 //Limpa a flag06
	BCF        _flagsA+0, 1
;clockwork.c,277 :: 		switch(ctrl_watch)        //Switch na variável de controle
	GOTO       L_ajusta_relogio55
;clockwork.c,279 :: 		case 0x00:
L_ajusta_relogio57:
;clockwork.c,280 :: 		horas = horas + 10;      //Caso 0, libera ajuste das horas, incremento de dezenas
	MOVLW      10
	ADDWF      _horas+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _horas+0
;clockwork.c,281 :: 		if(horas > 0x17) horas = 0x00;
	MOVF       R1+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio58
	CLRF       _horas+0
L_ajusta_relogio58:
;clockwork.c,282 :: 		break;
	GOTO       L_ajusta_relogio56
;clockwork.c,283 :: 		case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de dezenas
L_ajusta_relogio59:
;clockwork.c,284 :: 		minutos = minutos + 10;
	MOVLW      10
	ADDWF      _minutos+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _minutos+0
;clockwork.c,285 :: 		if(minutos > 0x3b) minutos = 0x00;
	MOVF       R1+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio60
	CLRF       _minutos+0
L_ajusta_relogio60:
;clockwork.c,286 :: 		break;
	GOTO       L_ajusta_relogio56
;clockwork.c,287 :: 		case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de dezenas
L_ajusta_relogio61:
;clockwork.c,288 :: 		segundos = segundos + 10;
	MOVLW      10
	ADDWF      _segundos+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _segundos+0
;clockwork.c,289 :: 		if(segundos > 0x3b) segundos = 0x00;
	MOVF       R1+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio62
	CLRF       _segundos+0
L_ajusta_relogio62:
;clockwork.c,290 :: 		break;
	GOTO       L_ajusta_relogio56
;clockwork.c,291 :: 		case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
L_ajusta_relogio63:
;clockwork.c,292 :: 		dias++;
	INCF       _dias+0, 1
;clockwork.c,293 :: 		if(dias > 0x06) dias = 0x00;
	MOVF       _dias+0, 0
	SUBLW      6
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_relogio64
	CLRF       _dias+0
L_ajusta_relogio64:
;clockwork.c,294 :: 		break;
	GOTO       L_ajusta_relogio56
;clockwork.c,295 :: 		} //end switch
L_ajusta_relogio55:
	MOVF       _ctrl_watch+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio57
	MOVF       _ctrl_watch+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio59
	MOVF       _ctrl_watch+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio61
	MOVF       _ctrl_watch+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_relogio63
L_ajusta_relogio56:
;clockwork.c,297 :: 		} //end if plus10
L_ajusta_relogio54:
;clockwork.c,299 :: 		} //end ajusta_relogio
	RETURN
; end of _ajusta_relogio

_disp_alarme:

;clockwork.c,308 :: 		void disp_alarme()                             //Função para exibir a hora ajustada para o despertador
;clockwork.c,312 :: 		text2[7] = a_segundos%10 + '0';
	MOVLW      7
	ADDWF      _text2+0, 0
	MOVWF      FLOC__disp_alarme+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _a_segundos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_alarme+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,313 :: 		text2[6] = a_segundos/10 + '0';
	MOVLW      6
	ADDWF      _text2+0, 0
	MOVWF      FLOC__disp_alarme+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _a_segundos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_alarme+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,314 :: 		text2[4] = a_minutos%10 + '0';
	MOVLW      4
	ADDWF      _text2+0, 0
	MOVWF      FLOC__disp_alarme+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _a_minutos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_alarme+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,315 :: 		text2[3] = a_minutos/10 + '0';
	MOVLW      3
	ADDWF      _text2+0, 0
	MOVWF      FLOC__disp_alarme+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _a_minutos+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_alarme+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,316 :: 		text2[1] = a_horas%10 + '0';
	INCF       _text2+0, 0
	MOVWF      FLOC__disp_alarme+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _a_horas+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_alarme+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,317 :: 		text2[0] = a_horas/10 + '0';
	MOVF       _text2+0, 0
	MOVWF      FLOC__disp_alarme+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _a_horas+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__disp_alarme+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;clockwork.c,319 :: 		Lcd_Chr(1,5, text2[0]);                   //Imprimi o horário de despertar no display
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,320 :: 		Lcd_Chr_Cp  (text2[1]);                   //
	INCF       _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,321 :: 		Lcd_Chr_Cp  (text2[2]);                   //
	MOVLW      2
	ADDWF      _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,322 :: 		Lcd_Chr_Cp  (text2[3]);                   //
	MOVLW      3
	ADDWF      _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,323 :: 		Lcd_Chr_Cp  (text2[4]);                   //
	MOVLW      4
	ADDWF      _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,324 :: 		Lcd_Chr_Cp  (text2[5]);                   //
	MOVLW      5
	ADDWF      _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,325 :: 		Lcd_Chr_Cp  (text2[6]);                   //
	MOVLW      6
	ADDWF      _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,326 :: 		Lcd_Chr_Cp  (text2[7]);                   //
	MOVLW      7
	ADDWF      _text2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,328 :: 		switch(a_dias)                             //Converte o número dos dias em string
	GOTO       L_disp_alarme65
;clockwork.c,330 :: 		case 0:
L_disp_alarme67:
;clockwork.c,331 :: 		Lcd_Chr(1,14,'D');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      68
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,332 :: 		Lcd_Chr_Cp('O');
	MOVLW      79
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,333 :: 		Lcd_Chr_Cp('M');
	MOVLW      77
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,334 :: 		break;
	GOTO       L_disp_alarme66
;clockwork.c,335 :: 		case 1:
L_disp_alarme68:
;clockwork.c,336 :: 		Lcd_Chr(1,14,'S');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,337 :: 		Lcd_Chr_Cp('E');
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,338 :: 		Lcd_Chr_Cp('G');
	MOVLW      71
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,339 :: 		break;
	GOTO       L_disp_alarme66
;clockwork.c,340 :: 		case 2:
L_disp_alarme69:
;clockwork.c,341 :: 		Lcd_Chr(1,14,'T');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      84
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,342 :: 		Lcd_Chr_Cp('E');
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,343 :: 		Lcd_Chr_Cp('R');
	MOVLW      82
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,344 :: 		break;
	GOTO       L_disp_alarme66
;clockwork.c,345 :: 		case 3:
L_disp_alarme70:
;clockwork.c,346 :: 		Lcd_Chr(1,14,'Q');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      81
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,347 :: 		Lcd_Chr_Cp('U');
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,348 :: 		Lcd_Chr_Cp('A');
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,349 :: 		break;
	GOTO       L_disp_alarme66
;clockwork.c,350 :: 		case 4:
L_disp_alarme71:
;clockwork.c,351 :: 		Lcd_Chr(1,14,'Q');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      81
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,352 :: 		Lcd_Chr_Cp('U');
	MOVLW      85
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,353 :: 		Lcd_Chr_Cp('I');
	MOVLW      73
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,354 :: 		break;
	GOTO       L_disp_alarme66
;clockwork.c,355 :: 		case 5:
L_disp_alarme72:
;clockwork.c,356 :: 		Lcd_Chr(1,14,'S');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,357 :: 		Lcd_Chr_Cp('E');
	MOVLW      69
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,358 :: 		Lcd_Chr_Cp('X');
	MOVLW      88
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,359 :: 		break;
	GOTO       L_disp_alarme66
;clockwork.c,360 :: 		case 6:
L_disp_alarme73:
;clockwork.c,361 :: 		Lcd_Chr(1,14,'S');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      83
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,362 :: 		Lcd_Chr_Cp('A');
	MOVLW      65
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,363 :: 		Lcd_Chr_Cp('B');
	MOVLW      66
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,364 :: 		break;
	GOTO       L_disp_alarme66
;clockwork.c,366 :: 		} //end switch
L_disp_alarme65:
	MOVF       _a_dias+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_disp_alarme67
	MOVF       _a_dias+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_disp_alarme68
	MOVF       _a_dias+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_disp_alarme69
	MOVF       _a_dias+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_disp_alarme70
	MOVF       _a_dias+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_disp_alarme71
	MOVF       _a_dias+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_disp_alarme72
	MOVF       _a_dias+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_disp_alarme73
L_disp_alarme66:
;clockwork.c,369 :: 		} //end disp_alarme
	RETURN
; end of _disp_alarme

_ajusta_alarme:

;clockwork.c,374 :: 		void ajusta_alarme()                           //Função para ajuste do despertador
;clockwork.c,378 :: 		char i = 0;                               //Variável para iterações
	CLRF       ajusta_alarme_i_L0+0
;clockwork.c,380 :: 		if(!plus)       plus_f      = 0x01;       //Se pressionar o botão 'mais', seta a flag
	BTFSC      RA0_bit+0, 0
	GOTO       L_ajusta_alarme74
	BSF        _flagsA+0, 0
L_ajusta_alarme74:
;clockwork.c,381 :: 		if(!plus10)     plus10_f    = 0x01;       //Se pressionar o botão 'mais 10', seta a flag
	BTFSC      RA1_bit+0, 1
	GOTO       L_ajusta_alarme75
	BSF        _flagsA+0, 1
L_ajusta_alarme75:
;clockwork.c,382 :: 		if(!adj_watch)  adj_watch_f = 0x01;       //Se pressionar o botão 'ajuste das horas', seta a flag
	BTFSC      RA2_bit+0, 2
	GOTO       L_ajusta_alarme76
	BSF        _flagsA+0, 2
L_ajusta_alarme76:
;clockwork.c,385 :: 		if(adj_watch && adj_watch_f)              //Soltou botão de ajuste e flag setada?
	BTFSS      RA2_bit+0, 2
	GOTO       L_ajusta_alarme79
	BTFSS      _flagsA+0, 2
	GOTO       L_ajusta_alarme79
L__ajusta_alarme127:
;clockwork.c,387 :: 		adj_watch_f = 0x00;                    //Limpa flag05
	BCF        _flagsA+0, 2
;clockwork.c,388 :: 		ctrl_watch++;                          //Incrementa variável de controle do ajuste
	INCF       _ctrl_watch+0, 1
;clockwork.c,391 :: 		if(ctrl_watch > 0x05) ctrl_watch = 0x00;
	MOVF       _ctrl_watch+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme80
	CLRF       _ctrl_watch+0
L_ajusta_alarme80:
;clockwork.c,393 :: 		} //end if adj_watch
L_ajusta_alarme79:
;clockwork.c,395 :: 		switch(ctrl_watch)                        //Switch da variável de controle de ajuste das horas
	GOTO       L_ajusta_alarme81
;clockwork.c,397 :: 		case 0x00:                             //Caso seja igual a 0
L_ajusta_alarme83:
;clockwork.c,398 :: 		Lcd_Chr(1,1,' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,399 :: 		Lcd_Chr(2,5,'^');              //Demonstra ajuste das horas
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,400 :: 		Lcd_Chr_Cp('^');
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,401 :: 		Lcd_Chr(2,8,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,402 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,403 :: 		Lcd_Chr(2,11,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,404 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,406 :: 		break;
	GOTO       L_ajusta_alarme82
;clockwork.c,407 :: 		case 0x01:                             //Caso seja igual a 1
L_ajusta_alarme84:
;clockwork.c,408 :: 		Lcd_Chr(2,5,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,409 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,410 :: 		Lcd_Chr(2,8,'^');              //Demonstra ajuste dos minutos
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,411 :: 		Lcd_Chr_Cp('^');
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,412 :: 		Lcd_Chr(2,11,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,413 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,414 :: 		break;
	GOTO       L_ajusta_alarme82
;clockwork.c,415 :: 		case 0x02:                             //Caso seja igual a 2
L_ajusta_alarme85:
;clockwork.c,416 :: 		Lcd_Chr(2,5,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,417 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,418 :: 		Lcd_Chr(2,8,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,419 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,420 :: 		Lcd_Chr(2,11,'^');             //Demonstra ajuste dos segundos
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,421 :: 		Lcd_Chr_Cp('^');
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,422 :: 		break;
	GOTO       L_ajusta_alarme82
;clockwork.c,423 :: 		case 0x03:                             //Caso seja igual a 3
L_ajusta_alarme86:
;clockwork.c,424 :: 		Lcd_Chr(2,5,' ');              //Demonstra ajuste dos dias
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,425 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,426 :: 		Lcd_Chr(2,8,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,427 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,428 :: 		Lcd_Chr(2,11,' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,429 :: 		Lcd_Chr_Cp(' ');
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;clockwork.c,430 :: 		Lcd_Chr(2,14,'^');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      94
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,431 :: 		break;
	GOTO       L_ajusta_alarme82
;clockwork.c,432 :: 		case 0x04:
L_ajusta_alarme87:
;clockwork.c,433 :: 		despertar();                                   //Desperta!
	CALL       _despertar+0
;clockwork.c,434 :: 		if(minutos == (a_minutos + 10))
	MOVLW      10
	ADDWF      _a_minutos+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ajusta_alarme129
	MOVF       R1+0, 0
	XORWF      _minutos+0, 0
L__ajusta_alarme129:
	BTFSS      STATUS+0, 2
	GOTO       L_ajusta_alarme88
;clockwork.c,436 :: 		relay = 0x00;                 //Desliga relé após 10 minutos
	BCF        RB4_bit+0, 4
;clockwork.c,437 :: 		led   = 0x00;                 //Desliga led  após 10 minutos
	BCF        RB5_bit+0, 5
;clockwork.c,439 :: 		}
L_ajusta_alarme88:
;clockwork.c,440 :: 		Lcd_Chr(1,1,'D');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      68
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,441 :: 		for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
	CLRF       ajusta_alarme_i_L0+0
L_ajusta_alarme89:
	MOVLW      12
	SUBWF      ajusta_alarme_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme90
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	ADDWF      ajusta_alarme_i_L0+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	INCF       ajusta_alarme_i_L0+0, 1
	GOTO       L_ajusta_alarme89
L_ajusta_alarme90:
;clockwork.c,442 :: 		break;
	GOTO       L_ajusta_alarme82
;clockwork.c,443 :: 		case 0x05:                             //Caso seja igual a 5
L_ajusta_alarme92:
;clockwork.c,444 :: 		Lcd_Chr(1,1,' ');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;clockwork.c,445 :: 		for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
	CLRF       ajusta_alarme_i_L0+0
L_ajusta_alarme93:
	MOVLW      12
	SUBWF      ajusta_alarme_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme94
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	ADDWF      ajusta_alarme_i_L0+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	INCF       ajusta_alarme_i_L0+0, 1
	GOTO       L_ajusta_alarme93
L_ajusta_alarme94:
;clockwork.c,446 :: 		break;
	GOTO       L_ajusta_alarme82
;clockwork.c,447 :: 		}
L_ajusta_alarme81:
	MOVF       _ctrl_watch+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme83
	MOVF       _ctrl_watch+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme84
	MOVF       _ctrl_watch+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme85
	MOVF       _ctrl_watch+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme86
	MOVF       _ctrl_watch+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme87
	MOVF       _ctrl_watch+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme92
L_ajusta_alarme82:
;clockwork.c,450 :: 		if(plus && plus_f)                  //Botão 'mais' foi solto e a flag foi setada?
	BTFSS      RA0_bit+0, 0
	GOTO       L_ajusta_alarme98
	BTFSS      _flagsA+0, 0
	GOTO       L_ajusta_alarme98
L__ajusta_alarme126:
;clockwork.c,452 :: 		plus_f = 0x00;                   //Limpa a flag07
	BCF        _flagsA+0, 0
;clockwork.c,454 :: 		switch(ctrl_watch)               //Switch na variável de controle
	GOTO       L_ajusta_alarme99
;clockwork.c,456 :: 		case 0x00:                     //Caso 0, libera ajuste das horas, incremento de unidades
L_ajusta_alarme101:
;clockwork.c,457 :: 		a_horas++;
	INCF       _a_horas+0, 1
;clockwork.c,458 :: 		if(a_horas > 0x17) a_horas = 0x00;
	MOVF       _a_horas+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme102
	CLRF       _a_horas+0
L_ajusta_alarme102:
;clockwork.c,459 :: 		break;
	GOTO       L_ajusta_alarme100
;clockwork.c,460 :: 		case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de unidades
L_ajusta_alarme103:
;clockwork.c,461 :: 		a_minutos++;
	INCF       _a_minutos+0, 1
;clockwork.c,462 :: 		if(a_minutos > 0x3b) a_minutos = 0x00;
	MOVF       _a_minutos+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme104
	CLRF       _a_minutos+0
L_ajusta_alarme104:
;clockwork.c,463 :: 		break;
	GOTO       L_ajusta_alarme100
;clockwork.c,464 :: 		case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de unidades
L_ajusta_alarme105:
;clockwork.c,465 :: 		a_segundos++;
	INCF       _a_segundos+0, 1
;clockwork.c,466 :: 		if(a_segundos > 0x3b) a_segundos = 0x00;
	MOVF       _a_segundos+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme106
	CLRF       _a_segundos+0
L_ajusta_alarme106:
;clockwork.c,467 :: 		break;
	GOTO       L_ajusta_alarme100
;clockwork.c,468 :: 		case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
L_ajusta_alarme107:
;clockwork.c,469 :: 		a_dias++;
	INCF       _a_dias+0, 1
;clockwork.c,470 :: 		if(a_dias > 0x06) a_dias = 0x00;
	MOVF       _a_dias+0, 0
	SUBLW      6
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme108
	CLRF       _a_dias+0
L_ajusta_alarme108:
;clockwork.c,471 :: 		break;
	GOTO       L_ajusta_alarme100
;clockwork.c,472 :: 		} //end switch
L_ajusta_alarme99:
	MOVF       _ctrl_watch+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme101
	MOVF       _ctrl_watch+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme103
	MOVF       _ctrl_watch+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme105
	MOVF       _ctrl_watch+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme107
L_ajusta_alarme100:
;clockwork.c,473 :: 		} //end if plus
L_ajusta_alarme98:
;clockwork.c,475 :: 		if(plus10 && plus10_f)              //Botão 'mais10' solto e a flag foi setada?
	BTFSS      RA1_bit+0, 1
	GOTO       L_ajusta_alarme111
	BTFSS      _flagsA+0, 1
	GOTO       L_ajusta_alarme111
L__ajusta_alarme125:
;clockwork.c,477 :: 		plus10_f = 0x00;                 //Limpa a flag06
	BCF        _flagsA+0, 1
;clockwork.c,479 :: 		switch(ctrl_watch)        //Switch na variável de controle
	GOTO       L_ajusta_alarme112
;clockwork.c,481 :: 		case 0x00:
L_ajusta_alarme114:
;clockwork.c,482 :: 		a_horas = a_horas + 10;      //Caso 0, libera ajuste das horas, incremento de dezenas
	MOVLW      10
	ADDWF      _a_horas+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _a_horas+0
;clockwork.c,483 :: 		if(a_horas > 0x17) a_horas = 0x00;
	MOVF       R1+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme115
	CLRF       _a_horas+0
L_ajusta_alarme115:
;clockwork.c,484 :: 		break;
	GOTO       L_ajusta_alarme113
;clockwork.c,485 :: 		case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de dezenas
L_ajusta_alarme116:
;clockwork.c,486 :: 		a_minutos = a_minutos + 10;
	MOVLW      10
	ADDWF      _a_minutos+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _a_minutos+0
;clockwork.c,487 :: 		if(a_minutos > 0x3b) a_minutos = 0x00;
	MOVF       R1+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme117
	CLRF       _a_minutos+0
L_ajusta_alarme117:
;clockwork.c,488 :: 		break;
	GOTO       L_ajusta_alarme113
;clockwork.c,489 :: 		case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de dezenas
L_ajusta_alarme118:
;clockwork.c,490 :: 		a_segundos = a_segundos + 10;
	MOVLW      10
	ADDWF      _a_segundos+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _a_segundos+0
;clockwork.c,491 :: 		if(a_segundos > 0x3b) a_segundos = 0x00;
	MOVF       R1+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme119
	CLRF       _a_segundos+0
L_ajusta_alarme119:
;clockwork.c,492 :: 		break;
	GOTO       L_ajusta_alarme113
;clockwork.c,493 :: 		case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
L_ajusta_alarme120:
;clockwork.c,494 :: 		a_dias++;
	INCF       _a_dias+0, 1
;clockwork.c,495 :: 		if(a_dias > 0x06) a_dias = 0x00;
	MOVF       _a_dias+0, 0
	SUBLW      6
	BTFSC      STATUS+0, 0
	GOTO       L_ajusta_alarme121
	CLRF       _a_dias+0
L_ajusta_alarme121:
;clockwork.c,496 :: 		break;
	GOTO       L_ajusta_alarme113
;clockwork.c,497 :: 		} //end switch
L_ajusta_alarme112:
	MOVF       _ctrl_watch+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme114
	MOVF       _ctrl_watch+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme116
	MOVF       _ctrl_watch+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme118
	MOVF       _ctrl_watch+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_ajusta_alarme120
L_ajusta_alarme113:
;clockwork.c,499 :: 		} //end if plus10
L_ajusta_alarme111:
;clockwork.c,501 :: 		} //end ajusta_alarme
	RETURN
; end of _ajusta_alarme

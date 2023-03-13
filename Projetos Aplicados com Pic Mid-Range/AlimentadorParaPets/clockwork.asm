
_relogio:

;clockwork.c,40 :: 		void relogio()                                 //Função para controle das variáveis do relógio
;clockwork.c,42 :: 		segundos_0++;                             //Incrementa os segundos
	INCF       _segundos_0+0, 1
;clockwork.c,44 :: 		if(segundos_0 == 0x3c)                    //Segundos igual a 60?
	MOVF       _segundos_0+0, 0
	XORLW      60
	BTFSS      STATUS+0, 2
	GOTO       L_relogio0
;clockwork.c,46 :: 		segundos_0 = 0x00;                    //Reinicia os segundos
	CLRF       _segundos_0+0
;clockwork.c,47 :: 		minutos_0++;                          //Incrementa os minutos
	INCF       _minutos_0+0, 1
;clockwork.c,49 :: 		if(minutos_0 == 0x3c)                 //Minutos igual a 60?
	MOVF       _minutos_0+0, 0
	XORLW      60
	BTFSS      STATUS+0, 2
	GOTO       L_relogio1
;clockwork.c,51 :: 		minutos_0 = 0x00;                  //Reinicia os minutos
	CLRF       _minutos_0+0
;clockwork.c,52 :: 		horas_0++;                         //Incrementa as horas
	INCF       _horas_0+0, 1
;clockwork.c,54 :: 		if(horas_0 == 0x18) horas_0 = 0x00; //Se horas igual a 24, reinicia
	MOVF       _horas_0+0, 0
	XORLW      24
	BTFSS      STATUS+0, 2
	GOTO       L_relogio2
	CLRF       _horas_0+0
L_relogio2:
;clockwork.c,57 :: 		} //end if minutos
L_relogio1:
;clockwork.c,59 :: 		} //end if segundos
L_relogio0:
;clockwork.c,61 :: 		} //end relogio
	RETURN
; end of _relogio

_check_clk:

;clockwork.c,66 :: 		void check_clk()
;clockwork.c,68 :: 		if(horas_0 == horas_1 && minutos_0 == minutos_1)
	MOVF       _horas_0+0, 0
	XORWF      _horas_1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_clk5
	MOVF       _minutos_0+0, 0
	XORWF      _minutos_1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_clk5
L__check_clk14:
;clockwork.c,70 :: 		feed  = 0x01;
	BSF        _flagsA+0, 5
;clockwork.c,71 :: 		feed2 = 0x01;
	BSF        _flagsA+0, 4
;clockwork.c,73 :: 		}
L_check_clk5:
;clockwork.c,75 :: 		if(horas_0 == horas_2 && minutos_0 == minutos_2)
	MOVF       _horas_0+0, 0
	XORWF      _horas_2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_clk8
	MOVF       _minutos_0+0, 0
	XORWF      _minutos_2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_clk8
L__check_clk13:
;clockwork.c,77 :: 		feed  = 0x01;
	BSF        _flagsA+0, 5
;clockwork.c,78 :: 		feed2 = 0x01;
	BSF        _flagsA+0, 4
;clockwork.c,80 :: 		}
L_check_clk8:
;clockwork.c,82 :: 		if(horas_0 == horas_3 && minutos_0 == minutos_3)
	MOVF       _horas_0+0, 0
	XORWF      _horas_3+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_clk11
	MOVF       _minutos_0+0, 0
	XORWF      _minutos_3+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_clk11
L__check_clk12:
;clockwork.c,84 :: 		feed  = 0x01;
	BSF        _flagsA+0, 5
;clockwork.c,85 :: 		feed2 = 0x01;
	BSF        _flagsA+0, 4
;clockwork.c,87 :: 		}
L_check_clk11:
;clockwork.c,92 :: 		}
	RETURN
; end of _check_clk

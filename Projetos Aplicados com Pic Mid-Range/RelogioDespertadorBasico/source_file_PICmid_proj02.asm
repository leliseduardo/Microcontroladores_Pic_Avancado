
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;source_file_PICmid_proj02.c,101 :: 		void interrupt()
;source_file_PICmid_proj02.c,103 :: 		if(TMR0IF_bit)                              //Houve o estouro do Timer0?
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;source_file_PICmid_proj02.c,106 :: 		TMR0IF_bit   = 0x00;                     //Limpa flag
	BCF        TMR0IF_bit+0, 2
;source_file_PICmid_proj02.c,107 :: 		TMR0         = 0x06;                     //Reinicia Timer0
	MOVLW      6
	MOVWF      TMR0+0
;source_file_PICmid_proj02.c,108 :: 		counter_T0  += 0x01;                     //Incrementa contador T0
	INCF       _counter_T0+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter_T0+1, 1
;source_file_PICmid_proj02.c,113 :: 		if(counter_T0 == 500)                    //counter igual a 500?
	MOVF       _counter_T0+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt12
	MOVLW      244
	XORWF      _counter_T0+0, 0
L__interrupt12:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;source_file_PICmid_proj02.c,115 :: 		counter_T0 = 0x00;                    //reinicia counter
	CLRF       _counter_T0+0
	CLRF       _counter_T0+1
;source_file_PICmid_proj02.c,119 :: 		relogio();
	CALL       _relogio+0
;source_file_PICmid_proj02.c,121 :: 		debug_clk = ~debug_clk;               //inverte o estado da saída de debug
	MOVLW      1
	XORWF      RC0_bit+0, 1
;source_file_PICmid_proj02.c,123 :: 		} //end if counter
L_interrupt1:
;source_file_PICmid_proj02.c,128 :: 		} //end if
L_interrupt0:
;source_file_PICmid_proj02.c,130 :: 		} //end interrupt
L__interrupt11:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;source_file_PICmid_proj02.c,134 :: 		void main()
;source_file_PICmid_proj02.c,136 :: 		TRISB        = 0xCF;                        //Configura RB4 e RB5 como saída
	MOVLW      207
	MOVWF      TRISB+0
;source_file_PICmid_proj02.c,137 :: 		PORTB        = 0xCF;                        //Inicializa PORTB
	MOVLW      207
	MOVWF      PORTB+0
;source_file_PICmid_proj02.c,139 :: 		CMCON        = 0x07;                        //Desabilita comparadores
	MOVLW      7
	MOVWF      CMCON+0
;source_file_PICmid_proj02.c,140 :: 		ADCON1       = 0x07;                        //Configura todos I/Os como digitais
	MOVLW      7
	MOVWF      ADCON1+0
;source_file_PICmid_proj02.c,142 :: 		OPTION_REG   = 0x84;                        //Desabilita resistores de pull-up internos, prescaler 1:32 associado ao Timer0
	MOVLW      132
	MOVWF      OPTION_REG+0
;source_file_PICmid_proj02.c,143 :: 		GIE_bit      = 0x01;                        //Habilita interrupção global
	BSF        GIE_bit+0, 7
;source_file_PICmid_proj02.c,144 :: 		TMR0IE_bit   = 0x01;                        //Habilita interrupção do timer0
	BSF        TMR0IE_bit+0, 5
;source_file_PICmid_proj02.c,145 :: 		TMR0         = 0x06;                        //Inicializa Timer0 em 6
	MOVLW      6
	MOVWF      TMR0+0
;source_file_PICmid_proj02.c,155 :: 		TRISC        = 0x02;                        //Configura todo PORTD como saída, exceto RC1
	MOVLW      2
	MOVWF      TRISC+0
;source_file_PICmid_proj02.c,156 :: 		PORTC        = 0x02;                        //Inicializa PORTC
	MOVLW      2
	MOVWF      PORTC+0
;source_file_PICmid_proj02.c,158 :: 		Lcd_Init();                                 //Inicia módulo LCD
	CALL       _Lcd_Init+0
;source_file_PICmid_proj02.c,159 :: 		Lcd_Cmd(_LCD_CLEAR);                        //Limpa display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;source_file_PICmid_proj02.c,160 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                   //Apaga cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;source_file_PICmid_proj02.c,164 :: 		while(1)                                    //Loop Infinito
L_main2:
;source_file_PICmid_proj02.c,166 :: 		if(!adj_alarm) adj_alarm_f = 0x01;
	BTFSC      RA3_bit+0, 3
	GOTO       L_main4
	BSF        _flagsA+0, 3
L_main4:
;source_file_PICmid_proj02.c,167 :: 		if(adj_alarm && adj_alarm_f)
	BTFSS      RA3_bit+0, 3
	GOTO       L_main7
	BTFSS      _flagsA+0, 3
	GOTO       L_main7
L__main10:
;source_file_PICmid_proj02.c,169 :: 		adj_alarm_f = 0x00;
	BCF        _flagsA+0, 3
;source_file_PICmid_proj02.c,170 :: 		alarm_mode = ~alarm_mode;
	MOVLW      16
	XORWF      _flagsA+0, 1
;source_file_PICmid_proj02.c,172 :: 		} //end if adj_alarm
L_main7:
;source_file_PICmid_proj02.c,175 :: 		if(alarm_mode)
	BTFSS      _flagsA+0, 4
	GOTO       L_main8
;source_file_PICmid_proj02.c,177 :: 		disp_alarme();
	CALL       _disp_alarme+0
;source_file_PICmid_proj02.c,178 :: 		ajusta_alarme();
	CALL       _ajusta_alarme+0
;source_file_PICmid_proj02.c,180 :: 		} //end if alarm_mode
	GOTO       L_main9
L_main8:
;source_file_PICmid_proj02.c,184 :: 		disp_horario();
	CALL       _disp_horario+0
;source_file_PICmid_proj02.c,185 :: 		ajusta_relogio();
	CALL       _ajusta_relogio+0
;source_file_PICmid_proj02.c,187 :: 		} //end else
L_main9:
;source_file_PICmid_proj02.c,189 :: 		} //end while
	GOTO       L_main2
;source_file_PICmid_proj02.c,192 :: 		} //end main
	GOTO       $+0
; end of _main

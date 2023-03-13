
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;source_file_PICmid_proj03.c,109 :: 		void interrupt()
;source_file_PICmid_proj03.c,111 :: 		if(TMR0IF_bit)                              //Houve o estouro do Timer0?
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;source_file_PICmid_proj03.c,114 :: 		TMR0IF_bit   = 0x00;                     //Limpa flag
	BCF        TMR0IF_bit+0, 2
;source_file_PICmid_proj03.c,115 :: 		TMR0         = 0x06;                     //Reinicia Timer0
	MOVLW      6
	MOVWF      TMR0+0
;source_file_PICmid_proj03.c,116 :: 		counter_T0  += 0x01;                     //Incrementa counter_T0
	INCF       _counter_T0+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter_T0+1, 1
;source_file_PICmid_proj03.c,117 :: 		counter_bk  += 0x01;                     //Incrementa counter_bk
	INCF       _counter_bk+0, 1
;source_file_PICmid_proj03.c,120 :: 		multiplex();                             //chama função de multiplexação
	CALL       _multiplex+0
;source_file_PICmid_proj03.c,122 :: 		if(counter_bk == 100)                    //counter_bk igual a 100?
	MOVF       _counter_bk+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;source_file_PICmid_proj03.c,124 :: 		counter_bk = 0x00;                    //reinicia counter_bk
	CLRF       _counter_bk+0
;source_file_PICmid_proj03.c,127 :: 		blk = ~blk;                           //inverte blk (parâmetro a ser ajustado pisca)
	MOVLW      128
	XORWF      _flagsA+0, 1
;source_file_PICmid_proj03.c,129 :: 		} //end if counter_bk
L_interrupt1:
;source_file_PICmid_proj03.c,131 :: 		if(counter_T0 == 250)                    //counter igual a 250?
	MOVLW      0
	XORWF      _counter_T0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt161
	MOVLW      250
	XORWF      _counter_T0+0, 0
L__interrupt161:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;source_file_PICmid_proj03.c,133 :: 		counter_T0 = 0x00;                    //reinicia counter
	CLRF       _counter_T0+0
	CLRF       _counter_T0+1
;source_file_PICmid_proj03.c,136 :: 		debug_clk = ~debug_clk;               //inverte o estado da saída de debug
	MOVLW      1
	XORWF      RC0_bit+0, 1
;source_file_PICmid_proj03.c,138 :: 		if(!debug_clk) relogio();             //chama função do relógio quando debug_clk for low
	BTFSC      RC0_bit+0, 0
	GOTO       L_interrupt3
	CALL       _relogio+0
L_interrupt3:
;source_file_PICmid_proj03.c,142 :: 		if(plus_f) adj_count+=1;              //incrementa adj_count, se plus_f setada
	BTFSS      _flagsA+0, 0
	GOTO       L_interrupt4
	INCF       _adj_count+0, 1
L_interrupt4:
;source_file_PICmid_proj03.c,143 :: 		if(adj_count == 4)                    //adj_count igual a 4?
	MOVF       _adj_count+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;source_file_PICmid_proj03.c,145 :: 		adj_count = 0x00;                  //reinicia
	CLRF       _adj_count+0
;source_file_PICmid_proj03.c,146 :: 		run_sys   = ~run_sys;              //inverte estado de run_sys
	MOVLW      64
	XORWF      _flagsA+0, 1
;source_file_PICmid_proj03.c,148 :: 		} //end if adj_count
L_interrupt5:
;source_file_PICmid_proj03.c,151 :: 		if(feed)                              //feed setada?
	BTFSS      _flagsA+0, 5
	GOTO       L_interrupt6
;source_file_PICmid_proj03.c,153 :: 		run_sys = 0;                       //limpa run_sys
	BCF        _flagsA+0, 6
;source_file_PICmid_proj03.c,154 :: 		feed_count+=1;                     //incrementa feed_count
	INCF       _feed_count+0, 1
;source_file_PICmid_proj03.c,155 :: 		buzz  = 0x01;                      //aciona buzzer
	BSF        RC1_bit+0, 1
;source_file_PICmid_proj03.c,156 :: 		motor = 0x01;                      //aciona motor
	BSF        RA5_bit+0, 5
;source_file_PICmid_proj03.c,158 :: 		} //end if feed
L_interrupt6:
;source_file_PICmid_proj03.c,160 :: 		if(feed_count == 20)                  //feed_count chegou em 20?
	MOVF       _feed_count+0, 0
	XORLW      20
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
;source_file_PICmid_proj03.c,162 :: 		feed_count = 0x00;                 //limpa feed_count
	CLRF       _feed_count+0
;source_file_PICmid_proj03.c,163 :: 		buzz  = 0x00;                      //desliga buzzer
	BCF        RC1_bit+0, 1
;source_file_PICmid_proj03.c,164 :: 		motor = 0x00;                      //desliga motor
	BCF        RA5_bit+0, 5
;source_file_PICmid_proj03.c,165 :: 		feed = 0x00;                       //limpa flag feed
	BCF        _flagsA+0, 5
;source_file_PICmid_proj03.c,167 :: 		} //end feed_count
L_interrupt7:
;source_file_PICmid_proj03.c,170 :: 		if(feed2) feed_count2+=1;             //incrementa feed_count2, se feed2 setada
	BTFSS      _flagsA+0, 4
	GOTO       L_interrupt8
	INCF       _feed_count2+0, 1
L_interrupt8:
;source_file_PICmid_proj03.c,172 :: 		if(feed_count2 == 140)                //feed_count2 chegou em 140?
	MOVF       _feed_count2+0, 0
	XORLW      140
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt9
;source_file_PICmid_proj03.c,174 :: 		feed_count2 = 0x00;                //limpa feed_count2
	CLRF       _feed_count2+0
;source_file_PICmid_proj03.c,175 :: 		run_sys     = 0x01;                //seta run_sys
	BSF        _flagsA+0, 6
;source_file_PICmid_proj03.c,176 :: 		feed2       = 0x00;                //limpa flag feed2
	BCF        _flagsA+0, 4
;source_file_PICmid_proj03.c,178 :: 		} //end if feed_count2
L_interrupt9:
;source_file_PICmid_proj03.c,180 :: 		} //end if counter
L_interrupt2:
;source_file_PICmid_proj03.c,183 :: 		} //end if TMR0IF_bit
L_interrupt0:
;source_file_PICmid_proj03.c,185 :: 		} //end interrupt
L__interrupt160:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;source_file_PICmid_proj03.c,190 :: 		void main()
;source_file_PICmid_proj03.c,193 :: 		CMCON        = 0x07;                        //Desabilita comparadores
	MOVLW      7
	MOVWF      CMCON+0
;source_file_PICmid_proj03.c,194 :: 		ADCON1       = 0x07;                        //Configura todos I/Os como digitais
	MOVLW      7
	MOVWF      ADCON1+0
;source_file_PICmid_proj03.c,196 :: 		OPTION_REG   = 0x84;                        //Desabilita resistores de pull-up internos, prescaler 1:32 associado ao Timer0
	MOVLW      132
	MOVWF      OPTION_REG+0
;source_file_PICmid_proj03.c,197 :: 		GIE_bit      = 0x01;                        //Habilita interrupção global
	BSF        GIE_bit+0, 7
;source_file_PICmid_proj03.c,198 :: 		TMR0IE_bit   = 0x01;                        //Habilita interrupção do timer0
	BSF        TMR0IE_bit+0, 5
;source_file_PICmid_proj03.c,199 :: 		TMR0         = 0x06;                        //Inicializa Timer0 em 6
	MOVLW      6
	MOVWF      TMR0+0
;source_file_PICmid_proj03.c,208 :: 		TRISA.RA5    = 0x00;                        //Configura RA5 como saída digital
	BCF        TRISA+0, 5
;source_file_PICmid_proj03.c,209 :: 		motor        = 0x00;                        //motor inicia desligado
	BCF        RA5_bit+0, 5
;source_file_PICmid_proj03.c,210 :: 		TRISB        = 0x80;                        //Configura todo PORTB como saída, exceto RB7
	MOVLW      128
	MOVWF      TRISB+0
;source_file_PICmid_proj03.c,211 :: 		PORTB        = 0x80;                        //Inicializa PORTB
	MOVLW      128
	MOVWF      PORTB+0
;source_file_PICmid_proj03.c,212 :: 		TRISC        = 0x00;                        //Configura todo PORTD como saída
	CLRF       TRISC+0
;source_file_PICmid_proj03.c,213 :: 		PORTC        = 0x00;                        //Inicializa PORTC
	CLRF       PORTC+0
;source_file_PICmid_proj03.c,216 :: 		while(1)                                    //Loop Infinito
L_main10:
;source_file_PICmid_proj03.c,218 :: 		read_bts();                              //lê botões
	CALL       _read_bts+0
;source_file_PICmid_proj03.c,219 :: 		update_data();                           //atualiza dados
	CALL       _update_data+0
;source_file_PICmid_proj03.c,221 :: 		if(run_sys) check_clk();                 //compara horários, se run_sys setada
	BTFSS      _flagsA+0, 6
	GOTO       L_main12
	CALL       _check_clk+0
L_main12:
;source_file_PICmid_proj03.c,223 :: 		led = run_sys;                           //led recebe o estado atual de run_sys
	BTFSC      _flagsA+0, 6
	GOTO       L__main162
	BCF        RC2_bit+0, 2
	GOTO       L__main163
L__main162:
	BSF        RC2_bit+0, 2
L__main163:
;source_file_PICmid_proj03.c,225 :: 		} //end while
	GOTO       L_main10
;source_file_PICmid_proj03.c,228 :: 		} //end main
	GOTO       $+0
; end of _main

_update_data:

;source_file_PICmid_proj03.c,237 :: 		void update_data()
;source_file_PICmid_proj03.c,239 :: 		switch(new_prog)
	GOTO       L_update_data13
;source_file_PICmid_proj03.c,241 :: 		case 1:
L_update_data15:
;source_file_PICmid_proj03.c,242 :: 		hr_disp   = horas_0;
	MOVF       _horas_0+0, 0
	MOVWF      _hr_disp+0
;source_file_PICmid_proj03.c,243 :: 		mn_disp   = minutos_0;
	MOVF       _minutos_0+0, 0
	MOVWF      _mn_disp+0
;source_file_PICmid_proj03.c,244 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,245 :: 		case 2:
L_update_data16:
;source_file_PICmid_proj03.c,246 :: 		delay_ms(741);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      10
	MOVWF      R12+0
	MOVLW      77
	MOVWF      R13+0
L_update_data17:
	DECFSZ     R13+0, 1
	GOTO       L_update_data17
	DECFSZ     R12+0, 1
	GOTO       L_update_data17
	DECFSZ     R11+0, 1
	GOTO       L_update_data17
;source_file_PICmid_proj03.c,247 :: 		new_prog+=1;
	INCF       _new_prog+0, 1
;source_file_PICmid_proj03.c,248 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,249 :: 		case 3:
L_update_data18:
;source_file_PICmid_proj03.c,250 :: 		hr_disp   = horas_1;
	MOVF       _horas_1+0, 0
	MOVWF      _hr_disp+0
;source_file_PICmid_proj03.c,251 :: 		mn_disp   = minutos_1;
	MOVF       _minutos_1+0, 0
	MOVWF      _mn_disp+0
;source_file_PICmid_proj03.c,252 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,253 :: 		case 4:
L_update_data19:
;source_file_PICmid_proj03.c,254 :: 		delay_ms(741);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      10
	MOVWF      R12+0
	MOVLW      77
	MOVWF      R13+0
L_update_data20:
	DECFSZ     R13+0, 1
	GOTO       L_update_data20
	DECFSZ     R12+0, 1
	GOTO       L_update_data20
	DECFSZ     R11+0, 1
	GOTO       L_update_data20
;source_file_PICmid_proj03.c,255 :: 		new_prog+=1;
	INCF       _new_prog+0, 1
;source_file_PICmid_proj03.c,256 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,257 :: 		case 5:
L_update_data21:
;source_file_PICmid_proj03.c,258 :: 		hr_disp   = horas_2;
	MOVF       _horas_2+0, 0
	MOVWF      _hr_disp+0
;source_file_PICmid_proj03.c,259 :: 		mn_disp   = minutos_2;
	MOVF       _minutos_2+0, 0
	MOVWF      _mn_disp+0
;source_file_PICmid_proj03.c,260 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,261 :: 		case 6:
L_update_data22:
;source_file_PICmid_proj03.c,262 :: 		delay_ms(741);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      10
	MOVWF      R12+0
	MOVLW      77
	MOVWF      R13+0
L_update_data23:
	DECFSZ     R13+0, 1
	GOTO       L_update_data23
	DECFSZ     R12+0, 1
	GOTO       L_update_data23
	DECFSZ     R11+0, 1
	GOTO       L_update_data23
;source_file_PICmid_proj03.c,263 :: 		new_prog+=1;
	INCF       _new_prog+0, 1
;source_file_PICmid_proj03.c,264 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,265 :: 		case 7:
L_update_data24:
;source_file_PICmid_proj03.c,266 :: 		hr_disp   = horas_3;
	MOVF       _horas_3+0, 0
	MOVWF      _hr_disp+0
;source_file_PICmid_proj03.c,267 :: 		mn_disp   = minutos_3;
	MOVF       _minutos_3+0, 0
	MOVWF      _mn_disp+0
;source_file_PICmid_proj03.c,268 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,269 :: 		case 8:
L_update_data25:
;source_file_PICmid_proj03.c,270 :: 		delay_ms(741);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      10
	MOVWF      R12+0
	MOVLW      77
	MOVWF      R13+0
L_update_data26:
	DECFSZ     R13+0, 1
	GOTO       L_update_data26
	DECFSZ     R12+0, 1
	GOTO       L_update_data26
	DECFSZ     R11+0, 1
	GOTO       L_update_data26
;source_file_PICmid_proj03.c,271 :: 		new_prog=1;
	MOVLW      1
	MOVWF      _new_prog+0
;source_file_PICmid_proj03.c,272 :: 		break;
	GOTO       L_update_data14
;source_file_PICmid_proj03.c,274 :: 		} //end switch new_prog
L_update_data13:
	MOVF       _new_prog+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_update_data15
	MOVF       _new_prog+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_update_data16
	MOVF       _new_prog+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_update_data18
	MOVF       _new_prog+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_update_data19
	MOVF       _new_prog+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_update_data21
	MOVF       _new_prog+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_update_data22
	MOVF       _new_prog+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_update_data24
	MOVF       _new_prog+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_update_data25
L_update_data14:
;source_file_PICmid_proj03.c,277 :: 		} //end update_data
	RETURN
; end of _update_data

_read_bts:

;source_file_PICmid_proj03.c,282 :: 		void read_bts()
;source_file_PICmid_proj03.c,284 :: 		if(!plus)      plus_f      = 0x01;          //seta flag plus_f, se plus pressionado
	BTFSC      RA0_bit+0, 0
	GOTO       L_read_bts27
	BSF        _flagsA+0, 0
L_read_bts27:
;source_file_PICmid_proj03.c,285 :: 		if(!adj_watch) adj_watch_f = 0x01;          //seta flag adj_watch_f, se adj_watch pressionado
	BTFSC      RA1_bit+0, 1
	GOTO       L_read_bts28
	BSF        _flagsA+0, 1
L_read_bts28:
;source_file_PICmid_proj03.c,286 :: 		if(!adj_prog)  adj_prog_f  = 0x01;          //seta flag adj_prog_f, se adj_prog pressionado
	BTFSC      RA2_bit+0, 2
	GOTO       L_read_bts29
	BSF        _flagsA+0, 2
L_read_bts29:
;source_file_PICmid_proj03.c,288 :: 		if(plus && plus_f)                          //botão plus solto e flag setada?
	BTFSS      RA0_bit+0, 0
	GOTO       L_read_bts32
	BTFSS      _flagsA+0, 0
	GOTO       L_read_bts32
L__read_bts150:
;source_file_PICmid_proj03.c,290 :: 		plus_f = 0x00;                           //limpa flag
	BCF        _flagsA+0, 0
;source_file_PICmid_proj03.c,291 :: 		adj_count  = 0x00;                       //reinicia contador de ajuste
	CLRF       _adj_count+0
;source_file_PICmid_proj03.c,293 :: 		switch(adj_num)                          //verifica adj_num
	GOTO       L_read_bts33
;source_file_PICmid_proj03.c,295 :: 		case 1:                               //caso 1 incrementa a dezena das horas
L_read_bts35:
;source_file_PICmid_proj03.c,296 :: 		switch(new_prog)
	GOTO       L_read_bts36
;source_file_PICmid_proj03.c,298 :: 		case 1: horas_0  += 10; break;
L_read_bts38:
	MOVLW      10
	ADDWF      _horas_0+0, 1
	GOTO       L_read_bts37
;source_file_PICmid_proj03.c,299 :: 		case 3: horas_1  += 10; break;
L_read_bts39:
	MOVLW      10
	ADDWF      _horas_1+0, 1
	GOTO       L_read_bts37
;source_file_PICmid_proj03.c,300 :: 		case 5: horas_2  += 10; break;
L_read_bts40:
	MOVLW      10
	ADDWF      _horas_2+0, 1
	GOTO       L_read_bts37
;source_file_PICmid_proj03.c,301 :: 		case 7: horas_3  += 10; break;
L_read_bts41:
	MOVLW      10
	ADDWF      _horas_3+0, 1
	GOTO       L_read_bts37
;source_file_PICmid_proj03.c,303 :: 		} //end switch new_prog
L_read_bts36:
	MOVF       _new_prog+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts38
	MOVF       _new_prog+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts39
	MOVF       _new_prog+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts40
	MOVF       _new_prog+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts41
L_read_bts37:
;source_file_PICmid_proj03.c,304 :: 		break;
	GOTO       L_read_bts34
;source_file_PICmid_proj03.c,306 :: 		case 2:                               //caso 2 incrementa a unidade das horas
L_read_bts42:
;source_file_PICmid_proj03.c,307 :: 		switch(new_prog)
	GOTO       L_read_bts43
;source_file_PICmid_proj03.c,309 :: 		case 1: horas_0  += 1; break;
L_read_bts45:
	INCF       _horas_0+0, 1
	GOTO       L_read_bts44
;source_file_PICmid_proj03.c,310 :: 		case 3: horas_1  += 1; break;
L_read_bts46:
	INCF       _horas_1+0, 1
	GOTO       L_read_bts44
;source_file_PICmid_proj03.c,311 :: 		case 5: horas_2  += 1; break;
L_read_bts47:
	INCF       _horas_2+0, 1
	GOTO       L_read_bts44
;source_file_PICmid_proj03.c,312 :: 		case 7: horas_3  += 1; break;
L_read_bts48:
	INCF       _horas_3+0, 1
	GOTO       L_read_bts44
;source_file_PICmid_proj03.c,314 :: 		} //end switch new_prog
L_read_bts43:
	MOVF       _new_prog+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts45
	MOVF       _new_prog+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts46
	MOVF       _new_prog+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts47
	MOVF       _new_prog+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts48
L_read_bts44:
;source_file_PICmid_proj03.c,315 :: 		break;
	GOTO       L_read_bts34
;source_file_PICmid_proj03.c,317 :: 		case 3:                               //caso 3 incrementa a dezena dos minutos
L_read_bts49:
;source_file_PICmid_proj03.c,318 :: 		switch(new_prog)
	GOTO       L_read_bts50
;source_file_PICmid_proj03.c,320 :: 		case 1: minutos_0 += 10; break;
L_read_bts52:
	MOVLW      10
	ADDWF      _minutos_0+0, 1
	GOTO       L_read_bts51
;source_file_PICmid_proj03.c,321 :: 		case 3: minutos_1 += 10; break;
L_read_bts53:
	MOVLW      10
	ADDWF      _minutos_1+0, 1
	GOTO       L_read_bts51
;source_file_PICmid_proj03.c,322 :: 		case 5: minutos_2 += 10; break;
L_read_bts54:
	MOVLW      10
	ADDWF      _minutos_2+0, 1
	GOTO       L_read_bts51
;source_file_PICmid_proj03.c,323 :: 		case 7: minutos_3 += 10; break;
L_read_bts55:
	MOVLW      10
	ADDWF      _minutos_3+0, 1
	GOTO       L_read_bts51
;source_file_PICmid_proj03.c,325 :: 		} //end switch new_prog
L_read_bts50:
	MOVF       _new_prog+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts52
	MOVF       _new_prog+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts53
	MOVF       _new_prog+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts54
	MOVF       _new_prog+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts55
L_read_bts51:
;source_file_PICmid_proj03.c,326 :: 		break;
	GOTO       L_read_bts34
;source_file_PICmid_proj03.c,328 :: 		case 4:                               //caso 4 incrementa a unidade dos minutos
L_read_bts56:
;source_file_PICmid_proj03.c,329 :: 		switch(new_prog)
	GOTO       L_read_bts57
;source_file_PICmid_proj03.c,331 :: 		case 1: minutos_0 += 1; break;
L_read_bts59:
	INCF       _minutos_0+0, 1
	GOTO       L_read_bts58
;source_file_PICmid_proj03.c,332 :: 		case 3: minutos_1 += 1; break;
L_read_bts60:
	INCF       _minutos_1+0, 1
	GOTO       L_read_bts58
;source_file_PICmid_proj03.c,333 :: 		case 5: minutos_2 += 1; break;
L_read_bts61:
	INCF       _minutos_2+0, 1
	GOTO       L_read_bts58
;source_file_PICmid_proj03.c,334 :: 		case 7: minutos_3 += 1; break;
L_read_bts62:
	INCF       _minutos_3+0, 1
	GOTO       L_read_bts58
;source_file_PICmid_proj03.c,336 :: 		} //end switch new_prog
L_read_bts57:
	MOVF       _new_prog+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts59
	MOVF       _new_prog+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts60
	MOVF       _new_prog+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts61
	MOVF       _new_prog+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts62
L_read_bts58:
;source_file_PICmid_proj03.c,337 :: 		break;
	GOTO       L_read_bts34
;source_file_PICmid_proj03.c,339 :: 		} //end switch
L_read_bts33:
	MOVF       _adj_num+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts35
	MOVF       _adj_num+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts42
	MOVF       _adj_num+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts49
	MOVF       _adj_num+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_read_bts56
L_read_bts34:
;source_file_PICmid_proj03.c,341 :: 		delay_ms(50);                            //anti-bouncing
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_read_bts63:
	DECFSZ     R13+0, 1
	GOTO       L_read_bts63
	DECFSZ     R12+0, 1
	GOTO       L_read_bts63
	DECFSZ     R11+0, 1
	GOTO       L_read_bts63
	NOP
;source_file_PICmid_proj03.c,343 :: 		if(horas_0 > 23)   horas_0   = 0;        //se horas maior que 23, volta para 0
	MOVF       _horas_0+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts64
	CLRF       _horas_0+0
L_read_bts64:
;source_file_PICmid_proj03.c,344 :: 		if(minutos_0 > 59) minutos_0 = 0;        //se minutos maior que 59, volta para 0
	MOVF       _minutos_0+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts65
	CLRF       _minutos_0+0
L_read_bts65:
;source_file_PICmid_proj03.c,345 :: 		if(horas_1 > 23)   horas_1   = 0;        //se horas maior que 23, volta para 0
	MOVF       _horas_1+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts66
	CLRF       _horas_1+0
L_read_bts66:
;source_file_PICmid_proj03.c,346 :: 		if(minutos_1 > 59) minutos_1 = 0;        //se minutos maior que 59, volta para 0
	MOVF       _minutos_1+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts67
	CLRF       _minutos_1+0
L_read_bts67:
;source_file_PICmid_proj03.c,347 :: 		if(horas_2 > 23)   horas_2   = 0;        //se horas maior que 23, volta para 0
	MOVF       _horas_2+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts68
	CLRF       _horas_2+0
L_read_bts68:
;source_file_PICmid_proj03.c,348 :: 		if(minutos_2 > 59) minutos_2 = 0;        //se minutos maior que 59, volta para 0
	MOVF       _minutos_2+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts69
	CLRF       _minutos_2+0
L_read_bts69:
;source_file_PICmid_proj03.c,349 :: 		if(horas_3 > 23)   horas_3   = 0;        //se horas maior que 23, volta para 0
	MOVF       _horas_3+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts70
	CLRF       _horas_3+0
L_read_bts70:
;source_file_PICmid_proj03.c,350 :: 		if(minutos_3 > 59) minutos_3 = 0;        //se minutos maior que 59, volta para 0
	MOVF       _minutos_3+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts71
	CLRF       _minutos_3+0
L_read_bts71:
;source_file_PICmid_proj03.c,352 :: 		} //end if plus
L_read_bts32:
;source_file_PICmid_proj03.c,354 :: 		if(adj_watch && adj_watch_f)                //botão adj_watch solto e flag setada?
	BTFSS      RA1_bit+0, 1
	GOTO       L_read_bts74
	BTFSS      _flagsA+0, 1
	GOTO       L_read_bts74
L__read_bts149:
;source_file_PICmid_proj03.c,356 :: 		adj_watch_f = 0x00;                      //limpa flag
	BCF        _flagsA+0, 1
;source_file_PICmid_proj03.c,358 :: 		adj_num += 1;                            //incrementa adj_num
	INCF       _adj_num+0, 1
;source_file_PICmid_proj03.c,360 :: 		delay_ms(50);                            //anti-bouncing
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_read_bts75:
	DECFSZ     R13+0, 1
	GOTO       L_read_bts75
	DECFSZ     R12+0, 1
	GOTO       L_read_bts75
	DECFSZ     R11+0, 1
	GOTO       L_read_bts75
	NOP
;source_file_PICmid_proj03.c,363 :: 		if(adj_num > 4) adj_num = 0;             //se adj_num maior que 4, volta para 0
	MOVF       _adj_num+0, 0
	SUBLW      4
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts76
	CLRF       _adj_num+0
L_read_bts76:
;source_file_PICmid_proj03.c,366 :: 		} //end if adj_watch
L_read_bts74:
;source_file_PICmid_proj03.c,368 :: 		if(adj_prog && adj_prog_f)                  //botão adj_prog solto e flag setada?
	BTFSS      RA2_bit+0, 2
	GOTO       L_read_bts79
	BTFSS      _flagsA+0, 2
	GOTO       L_read_bts79
L__read_bts148:
;source_file_PICmid_proj03.c,370 :: 		adj_prog_f = 0x00;                       //limpa flag
	BCF        _flagsA+0, 2
;source_file_PICmid_proj03.c,373 :: 		new_prog += 1;                           //incrementa new_prog
	INCF       _new_prog+0, 1
;source_file_PICmid_proj03.c,374 :: 		run_prog += 1;                           //incrementa run_prog
	INCF       _run_prog+0, 1
;source_file_PICmid_proj03.c,376 :: 		delay_ms(50);                            //anti-boucing
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_read_bts80:
	DECFSZ     R13+0, 1
	GOTO       L_read_bts80
	DECFSZ     R12+0, 1
	GOTO       L_read_bts80
	DECFSZ     R11+0, 1
	GOTO       L_read_bts80
	NOP
;source_file_PICmid_proj03.c,378 :: 		if(new_prog > 8) new_prog = 1;
	MOVF       _new_prog+0, 0
	SUBLW      8
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts81
	MOVLW      1
	MOVWF      _new_prog+0
L_read_bts81:
;source_file_PICmid_proj03.c,379 :: 		if(run_prog > 2) run_prog = 1;
	MOVF       _run_prog+0, 0
	SUBLW      2
	BTFSC      STATUS+0, 0
	GOTO       L_read_bts82
	MOVLW      1
	MOVWF      _run_prog+0
L_read_bts82:
;source_file_PICmid_proj03.c,381 :: 		} //end if adj_prog
L_read_bts79:
;source_file_PICmid_proj03.c,384 :: 		} //end read_bts
	RETURN
; end of _read_bts

_multiplex:

;source_file_PICmid_proj03.c,389 :: 		void multiplex()
;source_file_PICmid_proj03.c,394 :: 		if(!dig_mil && control == 1)                //Dígito dos milhares desligado?
	BTFSC      RC7_bit+0, 7
	GOTO       L_multiplex85
	MOVF       multiplex_control_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_multiplex85
L__multiplex159:
;source_file_PICmid_proj03.c,396 :: 		control = 0x02;                          //Sim, control recebe o valor 2
	MOVLW      2
	MOVWF      multiplex_control_L0+0
;source_file_PICmid_proj03.c,397 :: 		dig_pts = 0x00;                          //Apaga dígito dos pontos
	BCF        RC3_bit+0, 3
;source_file_PICmid_proj03.c,398 :: 		dig_uni = 0x00;                          //Apaga dígito das unidades
	BCF        RC4_bit+0, 4
;source_file_PICmid_proj03.c,399 :: 		dig_dez = 0x00;                          //Apaga dígito das dezenas
	BCF        RC5_bit+0, 5
;source_file_PICmid_proj03.c,400 :: 		dig_cen = 0x00;                          //Apaga dígito das centenas
	BCF        RC6_bit+0, 6
;source_file_PICmid_proj03.c,401 :: 		PORTB   = 0x00;                          //Desliga PORTB
	CLRF       PORTB+0
;source_file_PICmid_proj03.c,402 :: 		mil = (hr_disp/10);                      //Calcula o dígito do milhar
	MOVLW      10
	MOVWF      R4+0
	MOVF       _hr_disp+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _mil+0
;source_file_PICmid_proj03.c,403 :: 		dig_mil = 0x01;                          //Ativa dígito dos milhares
	BSF        RC7_bit+0, 7
;source_file_PICmid_proj03.c,405 :: 		switch(new_prog)                         //verifica new_prog
	GOTO       L_multiplex86
;source_file_PICmid_proj03.c,407 :: 		case 2:
L_multiplex88:
;source_file_PICmid_proj03.c,408 :: 		case 4:
L_multiplex89:
;source_file_PICmid_proj03.c,409 :: 		case 6: PORTB = 0x73; break;          //caso 2/4/6, imprime "P"
L_multiplex90:
	MOVLW      115
	MOVWF      PORTB+0
	GOTO       L_multiplex87
;source_file_PICmid_proj03.c,410 :: 		case 8: PORTB = 0x74; break;          //caso 8    , imprime "h"
L_multiplex91:
	MOVLW      116
	MOVWF      PORTB+0
	GOTO       L_multiplex87
;source_file_PICmid_proj03.c,412 :: 		default:                              //demais casos
L_multiplex92:
;source_file_PICmid_proj03.c,413 :: 		if(adj_num != 1 || !blk)           //se adj_num diferente de 1 ou blk em low...
	MOVF       _adj_num+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__multiplex158
	BTFSS      _flagsA+0, 7
	GOTO       L__multiplex158
	GOTO       L_multiplex95
L__multiplex158:
;source_file_PICmid_proj03.c,414 :: 		PORTB = disp_cath(mil);          //...escreve o valor no display
	MOVF       _mil+0, 0
	MOVWF      FARG_disp_cath_num+0
	CALL       _disp_cath+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_multiplex96
L_multiplex95:
;source_file_PICmid_proj03.c,415 :: 		else PORTB = 0;                    //senão, limpa display
	CLRF       PORTB+0
L_multiplex96:
;source_file_PICmid_proj03.c,417 :: 		} //end switch
	GOTO       L_multiplex87
L_multiplex86:
	MOVF       _new_prog+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex88
	MOVF       _new_prog+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex89
	MOVF       _new_prog+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex90
	MOVF       _new_prog+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex91
	GOTO       L_multiplex92
L_multiplex87:
;source_file_PICmid_proj03.c,419 :: 		} //end dig mil
	GOTO       L_multiplex97
L_multiplex85:
;source_file_PICmid_proj03.c,421 :: 		else if(!dig_cen && control == 2)           //Dígito das centenas desligado?
	BTFSC      RC6_bit+0, 6
	GOTO       L_multiplex100
	MOVF       multiplex_control_L0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_multiplex100
L__multiplex157:
;source_file_PICmid_proj03.c,423 :: 		control = 0x03;                          //Sim, control recebe o valor 3
	MOVLW      3
	MOVWF      multiplex_control_L0+0
;source_file_PICmid_proj03.c,424 :: 		dig_pts = 0x00;                          //Apaga dígito dos pontos
	BCF        RC3_bit+0, 3
;source_file_PICmid_proj03.c,425 :: 		dig_uni = 0x00;                          //Apaga dígito das unidades
	BCF        RC4_bit+0, 4
;source_file_PICmid_proj03.c,426 :: 		dig_dez = 0x00;                          //Apaga dígito das dezenas
	BCF        RC5_bit+0, 5
;source_file_PICmid_proj03.c,427 :: 		dig_mil = 0x00;                          //Apaga dígito dos milhares
	BCF        RC7_bit+0, 7
;source_file_PICmid_proj03.c,428 :: 		PORTB   = 0x00;                          //Desliga PORTB
	CLRF       PORTB+0
;source_file_PICmid_proj03.c,429 :: 		cen = (hr_disp%10);                      //Calcula o dígito da centena
	MOVLW      10
	MOVWF      R4+0
	MOVF       _hr_disp+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _cen+0
;source_file_PICmid_proj03.c,430 :: 		dig_cen = 0x01;                          //Ativa dígito das centenas
	BSF        RC6_bit+0, 6
;source_file_PICmid_proj03.c,432 :: 		switch(new_prog)                         //verifica new_prog
	GOTO       L_multiplex101
;source_file_PICmid_proj03.c,434 :: 		case 2:
L_multiplex103:
;source_file_PICmid_proj03.c,435 :: 		case 4:
L_multiplex104:
;source_file_PICmid_proj03.c,436 :: 		case 6: PORTB = 0x50; break;          //caso 2/4/6, imprime "r"
L_multiplex105:
	MOVLW      80
	MOVWF      PORTB+0
	GOTO       L_multiplex102
;source_file_PICmid_proj03.c,437 :: 		case 8: PORTB = 0x5C; break;          //caso 8    , imprime "o"
L_multiplex106:
	MOVLW      92
	MOVWF      PORTB+0
	GOTO       L_multiplex102
;source_file_PICmid_proj03.c,439 :: 		default:                              //demais casos
L_multiplex107:
;source_file_PICmid_proj03.c,440 :: 		if(adj_num != 2 || !blk)           //se adj_num diferente de 2 ou blk em low...
	MOVF       _adj_num+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L__multiplex156
	BTFSS      _flagsA+0, 7
	GOTO       L__multiplex156
	GOTO       L_multiplex110
L__multiplex156:
;source_file_PICmid_proj03.c,441 :: 		PORTB = disp_cath(cen);          //...escreve o valor no display
	MOVF       _cen+0, 0
	MOVWF      FARG_disp_cath_num+0
	CALL       _disp_cath+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_multiplex111
L_multiplex110:
;source_file_PICmid_proj03.c,442 :: 		else PORTB = 0;                    //senão, limpa display
	CLRF       PORTB+0
L_multiplex111:
;source_file_PICmid_proj03.c,444 :: 		} //end switch
	GOTO       L_multiplex102
L_multiplex101:
	MOVF       _new_prog+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex103
	MOVF       _new_prog+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex104
	MOVF       _new_prog+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex105
	MOVF       _new_prog+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex106
	GOTO       L_multiplex107
L_multiplex102:
;source_file_PICmid_proj03.c,447 :: 		} //end dig cen
	GOTO       L_multiplex112
L_multiplex100:
;source_file_PICmid_proj03.c,449 :: 		else if(!dig_dez && control == 3)           //Dígito das dezenas desligado?
	BTFSC      RC5_bit+0, 5
	GOTO       L_multiplex115
	MOVF       multiplex_control_L0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_multiplex115
L__multiplex155:
;source_file_PICmid_proj03.c,451 :: 		control = 0x04;                          //Sim, control recebe o valor 4
	MOVLW      4
	MOVWF      multiplex_control_L0+0
;source_file_PICmid_proj03.c,452 :: 		dig_pts = 0x00;                          //Apaga dígito dos pontos
	BCF        RC3_bit+0, 3
;source_file_PICmid_proj03.c,453 :: 		dig_uni = 0x00;                          //Apaga dígito das unidades
	BCF        RC4_bit+0, 4
;source_file_PICmid_proj03.c,454 :: 		dig_cen = 0x00;                          //Apaga dígito das centenas
	BCF        RC6_bit+0, 6
;source_file_PICmid_proj03.c,455 :: 		dig_mil = 0x00;                          //Apaga dígito dos milhares
	BCF        RC7_bit+0, 7
;source_file_PICmid_proj03.c,456 :: 		PORTB   = 0x00;                          //Desliga PORTB
	CLRF       PORTB+0
;source_file_PICmid_proj03.c,457 :: 		dez = (mn_disp/10);                      //Calcula o dígito da dezena
	MOVLW      10
	MOVWF      R4+0
	MOVF       _mn_disp+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _dez+0
;source_file_PICmid_proj03.c,458 :: 		dig_dez = 0x01;                          //Ativa dígito das dezenas
	BSF        RC5_bit+0, 5
;source_file_PICmid_proj03.c,460 :: 		switch(new_prog)                         //verifica new_prog
	GOTO       L_multiplex116
;source_file_PICmid_proj03.c,462 :: 		case 2:
L_multiplex118:
;source_file_PICmid_proj03.c,463 :: 		case 4:
L_multiplex119:
;source_file_PICmid_proj03.c,464 :: 		case 6: PORTB = 0x5C; break;          //caso 2/4/6, imprime "o"
L_multiplex120:
	MOVLW      92
	MOVWF      PORTB+0
	GOTO       L_multiplex117
;source_file_PICmid_proj03.c,465 :: 		case 8: PORTB = 0x1C; break;          //caso 8    , imprime "u"
L_multiplex121:
	MOVLW      28
	MOVWF      PORTB+0
	GOTO       L_multiplex117
;source_file_PICmid_proj03.c,467 :: 		default:                              //demais casos
L_multiplex122:
;source_file_PICmid_proj03.c,468 :: 		if(adj_num != 3 || !blk)           //se adj_num diferente de 3 ou blk em low...
	MOVF       _adj_num+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__multiplex154
	BTFSS      _flagsA+0, 7
	GOTO       L__multiplex154
	GOTO       L_multiplex125
L__multiplex154:
;source_file_PICmid_proj03.c,469 :: 		PORTB = disp_cath(dez);          //...escreve o valor no display
	MOVF       _dez+0, 0
	MOVWF      FARG_disp_cath_num+0
	CALL       _disp_cath+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_multiplex126
L_multiplex125:
;source_file_PICmid_proj03.c,470 :: 		else PORTB = 0;                    //senão, limpa display
	CLRF       PORTB+0
L_multiplex126:
;source_file_PICmid_proj03.c,472 :: 		} //end switch
	GOTO       L_multiplex117
L_multiplex116:
	MOVF       _new_prog+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex118
	MOVF       _new_prog+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex119
	MOVF       _new_prog+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex120
	MOVF       _new_prog+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex121
	GOTO       L_multiplex122
L_multiplex117:
;source_file_PICmid_proj03.c,475 :: 		} //end dig dez
	GOTO       L_multiplex127
L_multiplex115:
;source_file_PICmid_proj03.c,477 :: 		else if(!dig_uni && control == 4)           //Dígito das unidades desligado?
	BTFSC      RC4_bit+0, 4
	GOTO       L_multiplex130
	MOVF       multiplex_control_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_multiplex130
L__multiplex153:
;source_file_PICmid_proj03.c,479 :: 		control = 0x05;                          //Sim, control recebe o valor 5
	MOVLW      5
	MOVWF      multiplex_control_L0+0
;source_file_PICmid_proj03.c,480 :: 		dig_pts = 0x00;                          //Apaga dígito dos pontos
	BCF        RC3_bit+0, 3
;source_file_PICmid_proj03.c,481 :: 		dig_dez = 0x00;                          //Apaga dígito das dezenas
	BCF        RC5_bit+0, 5
;source_file_PICmid_proj03.c,482 :: 		dig_cen = 0x00;                          //Apaga dígito das centenas
	BCF        RC6_bit+0, 6
;source_file_PICmid_proj03.c,483 :: 		dig_mil = 0x00;                          //Apaga dígito dos milhares
	BCF        RC7_bit+0, 7
;source_file_PICmid_proj03.c,484 :: 		PORTB   = 0x00;                          //Desliga PORTB
	CLRF       PORTB+0
;source_file_PICmid_proj03.c,485 :: 		uni = (mn_disp%10);                      //Calcula o dígito da unidade
	MOVLW      10
	MOVWF      R4+0
	MOVF       _mn_disp+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _uni+0
;source_file_PICmid_proj03.c,486 :: 		dig_uni = 0x01;                          //Ativa dígito das unidades
	BSF        RC4_bit+0, 4
;source_file_PICmid_proj03.c,488 :: 		switch(new_prog)                         //verifica new_prog
	GOTO       L_multiplex131
;source_file_PICmid_proj03.c,490 :: 		case 2: PORTB = disp_cath(1); break;
L_multiplex133:
	MOVLW      1
	MOVWF      FARG_disp_cath_num+0
	CALL       _disp_cath+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_multiplex132
;source_file_PICmid_proj03.c,491 :: 		case 4: PORTB = disp_cath(2); break;
L_multiplex134:
	MOVLW      2
	MOVWF      FARG_disp_cath_num+0
	CALL       _disp_cath+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_multiplex132
;source_file_PICmid_proj03.c,492 :: 		case 6: PORTB = disp_cath(3); break;
L_multiplex135:
	MOVLW      3
	MOVWF      FARG_disp_cath_num+0
	CALL       _disp_cath+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_multiplex132
;source_file_PICmid_proj03.c,493 :: 		case 8: PORTB = 0x50; break;          //caso 8    , imprime "r"
L_multiplex136:
	MOVLW      80
	MOVWF      PORTB+0
	GOTO       L_multiplex132
;source_file_PICmid_proj03.c,495 :: 		default:                              //demais casos
L_multiplex137:
;source_file_PICmid_proj03.c,496 :: 		if(adj_num != 4 || !blk)           //se adj_num diferente de 4 ou blk em low...
	MOVF       _adj_num+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L__multiplex152
	BTFSS      _flagsA+0, 7
	GOTO       L__multiplex152
	GOTO       L_multiplex140
L__multiplex152:
;source_file_PICmid_proj03.c,497 :: 		PORTB = disp_cath(uni);          //...escreve o valor no display
	MOVF       _uni+0, 0
	MOVWF      FARG_disp_cath_num+0
	CALL       _disp_cath+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	GOTO       L_multiplex141
L_multiplex140:
;source_file_PICmid_proj03.c,498 :: 		else PORTB = 0;                    //senão, limpa display
	CLRF       PORTB+0
L_multiplex141:
;source_file_PICmid_proj03.c,500 :: 		} //end switch
	GOTO       L_multiplex132
L_multiplex131:
	MOVF       _new_prog+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex133
	MOVF       _new_prog+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex134
	MOVF       _new_prog+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex135
	MOVF       _new_prog+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_multiplex136
	GOTO       L_multiplex137
L_multiplex132:
;source_file_PICmid_proj03.c,503 :: 		} //end dig uni
	GOTO       L_multiplex142
L_multiplex130:
;source_file_PICmid_proj03.c,506 :: 		else if(!dig_pts && control == 5)           //Dígito dos pontos desligado?
	BTFSC      RC3_bit+0, 3
	GOTO       L_multiplex145
	MOVF       multiplex_control_L0+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_multiplex145
L__multiplex151:
;source_file_PICmid_proj03.c,508 :: 		control = 0x01;                          //Sim, control recebe o valor 1
	MOVLW      1
	MOVWF      multiplex_control_L0+0
;source_file_PICmid_proj03.c,509 :: 		dig_uni = 0x00;                          //Apaga dígito das unidades
	BCF        RC4_bit+0, 4
;source_file_PICmid_proj03.c,510 :: 		dig_dez = 0x00;                          //Apaga dígito das dezenas
	BCF        RC5_bit+0, 5
;source_file_PICmid_proj03.c,511 :: 		dig_cen = 0x00;                          //Apaga dígito das centenas
	BCF        RC6_bit+0, 6
;source_file_PICmid_proj03.c,512 :: 		dig_mil = 0x00;                          //Apaga dígito dos milhares
	BCF        RC7_bit+0, 7
;source_file_PICmid_proj03.c,513 :: 		PORTB   = 0x00;                          //Desliga PORTB
	CLRF       PORTB+0
;source_file_PICmid_proj03.c,515 :: 		dig_pts = 0x01;                          //Ativa dígito dos pontos
	BSF        RC3_bit+0, 3
;source_file_PICmid_proj03.c,517 :: 		if(!debug_clk)                           //se debug_clk em low...
	BTFSC      RC0_bit+0, 0
	GOTO       L_multiplex146
;source_file_PICmid_proj03.c,518 :: 		PORTB = 0x10;                        //...escreve o valor no display (pontos acesos)
	MOVLW      16
	MOVWF      PORTB+0
	GOTO       L_multiplex147
L_multiplex146:
;source_file_PICmid_proj03.c,519 :: 		else  PORTB = 0;                         //senão, limpa display
	CLRF       PORTB+0
L_multiplex147:
;source_file_PICmid_proj03.c,521 :: 		} //end dig uni
L_multiplex145:
L_multiplex142:
L_multiplex127:
L_multiplex112:
L_multiplex97:
;source_file_PICmid_proj03.c,524 :: 		} //end multiplex
	RETURN
; end of _multiplex

_disp_cath:

;source_file_PICmid_proj03.c,529 :: 		char disp_cath(char num)
;source_file_PICmid_proj03.c,543 :: 		0x67};                 //BCD nove   '9'
	MOVLW      63
	MOVWF      disp_cath_segmento_L0+0
	MOVLW      6
	MOVWF      disp_cath_segmento_L0+1
	MOVLW      91
	MOVWF      disp_cath_segmento_L0+2
	MOVLW      79
	MOVWF      disp_cath_segmento_L0+3
	MOVLW      102
	MOVWF      disp_cath_segmento_L0+4
	MOVLW      109
	MOVWF      disp_cath_segmento_L0+5
	MOVLW      125
	MOVWF      disp_cath_segmento_L0+6
	MOVLW      7
	MOVWF      disp_cath_segmento_L0+7
	MOVLW      127
	MOVWF      disp_cath_segmento_L0+8
	MOVLW      103
	MOVWF      disp_cath_segmento_L0+9
;source_file_PICmid_proj03.c,546 :: 		cathode = segmento[num];                   //salva dado BCD em cathode
	MOVF       FARG_disp_cath_num+0, 0
	ADDLW      disp_cath_segmento_L0+0
	MOVWF      FSR
;source_file_PICmid_proj03.c,548 :: 		return(cathode);                           //retorna o número BCD
	MOVF       INDF+0, 0
	MOVWF      R0+0
;source_file_PICmid_proj03.c,550 :: 		} //end display
	RETURN
; end of _disp_cath

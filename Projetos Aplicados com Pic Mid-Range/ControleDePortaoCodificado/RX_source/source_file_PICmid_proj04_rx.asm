
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;source_file_PICmid_proj04_rx.c,32 :: 		void interrupt()
;source_file_PICmid_proj04_rx.c,34 :: 		rx_func(&comand, &value, &check);           //verifica comando e valor recebido
	MOVLW      _comand+0
	MOVWF      FARG_rx_func_cmd+0
	MOVLW      _value+0
	MOVWF      FARG_rx_func_val+0
	MOVLW      _check+0
	MOVWF      FARG_rx_func_ok+0
	CALL       _rx_func+0
;source_file_PICmid_proj04_rx.c,36 :: 		if(check)                                   //check verdadeiro?
	MOVF       _check+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt0
;source_file_PICmid_proj04_rx.c,39 :: 		if(comand == 'A')
	MOVF       _comand+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;source_file_PICmid_proj04_rx.c,41 :: 		RB0_bit = value;
	BTFSC      _value+0, 0
	GOTO       L__interrupt26
	BCF        RB0_bit+0, 0
	GOTO       L__interrupt27
L__interrupt26:
	BSF        RB0_bit+0, 0
L__interrupt27:
;source_file_PICmid_proj04_rx.c,42 :: 		flag_c = 1;
	BSF        _flag_c+0, BitPos(_flag_c+0)
;source_file_PICmid_proj04_rx.c,44 :: 		} //end if
L_interrupt1:
;source_file_PICmid_proj04_rx.c,48 :: 		} //end if ok
L_interrupt0:
;source_file_PICmid_proj04_rx.c,50 :: 		} //end interrupt
L__interrupt25:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;source_file_PICmid_proj04_rx.c,55 :: 		void main()
;source_file_PICmid_proj04_rx.c,57 :: 		CMCON = 0x07;                              //Desabilita comparadores
	MOVLW      7
	MOVWF      CMCON+0
;source_file_PICmid_proj04_rx.c,58 :: 		TRISB = 0xCE;                              //Configura RB0, RB4 e RB5 como saída
	MOVLW      206
	MOVWF      TRISB+0
;source_file_PICmid_proj04_rx.c,59 :: 		PORTB = 0xCE;                              //Inicializa PORTB
	MOVLW      206
	MOVWF      PORTB+0
;source_file_PICmid_proj04_rx.c,61 :: 		flag_c = 0x00;
	BCF        _flag_c+0, BitPos(_flag_c+0)
;source_file_PICmid_proj04_rx.c,63 :: 		RCIE_bit = 0x01;                           //habilita interrupção da recepção serial
	BSF        RCIE_bit+0, 5
;source_file_PICmid_proj04_rx.c,64 :: 		GIE_bit  = 0x01;                           //habilita interrupção global
	BSF        GIE_bit+0, 7
;source_file_PICmid_proj04_rx.c,65 :: 		PEIE_Bit = 0x01;                           //habilita interrupção dos periféricos
	BSF        PEIE_bit+0, 6
;source_file_PICmid_proj04_rx.c,67 :: 		UART1_Init(1200);                          //Inicializa UART1 com 1200 baud rate
	MOVLW      207
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;source_file_PICmid_proj04_rx.c,68 :: 		delay_ms(100);                             //aguarda 100ms
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;source_file_PICmid_proj04_rx.c,72 :: 		while(1)                                  //Loop Infinito
L_main3:
;source_file_PICmid_proj04_rx.c,75 :: 		if(RB0_bit && flag_c)
	BTFSS      RB0_bit+0, 0
	GOTO       L_main7
	BTFSS      _flag_c+0, BitPos(_flag_c+0)
	GOTO       L_main7
L__main24:
;source_file_PICmid_proj04_rx.c,77 :: 		flag_c = 0;
	BCF        _flag_c+0, BitPos(_flag_c+0)
;source_file_PICmid_proj04_rx.c,78 :: 		m_control += 1;
	INCF       _m_control+0, 1
;source_file_PICmid_proj04_rx.c,79 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
;source_file_PICmid_proj04_rx.c,81 :: 		if(m_control > 4) m_control = 1;
	MOVF       _m_control+0, 0
	SUBLW      4
	BTFSC      STATUS+0, 0
	GOTO       L_main9
	MOVLW      1
	MOVWF      _m_control+0
L_main9:
;source_file_PICmid_proj04_rx.c,83 :: 		} //end if value
L_main7:
;source_file_PICmid_proj04_rx.c,87 :: 		switch(m_control)
	GOTO       L_main10
;source_file_PICmid_proj04_rx.c,89 :: 		case 1:
L_main12:
;source_file_PICmid_proj04_rx.c,90 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;source_file_PICmid_proj04_rx.c,91 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;source_file_PICmid_proj04_rx.c,92 :: 		break;
	GOTO       L_main11
;source_file_PICmid_proj04_rx.c,93 :: 		case 2:
L_main13:
;source_file_PICmid_proj04_rx.c,94 :: 		RB4_bit = 0x01;
	BSF        RB4_bit+0, 4
;source_file_PICmid_proj04_rx.c,95 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;source_file_PICmid_proj04_rx.c,96 :: 		break;
	GOTO       L_main11
;source_file_PICmid_proj04_rx.c,97 :: 		case 3:
L_main14:
;source_file_PICmid_proj04_rx.c,98 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;source_file_PICmid_proj04_rx.c,99 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;source_file_PICmid_proj04_rx.c,100 :: 		break;
	GOTO       L_main11
;source_file_PICmid_proj04_rx.c,101 :: 		case 4:
L_main15:
;source_file_PICmid_proj04_rx.c,102 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;source_file_PICmid_proj04_rx.c,103 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;source_file_PICmid_proj04_rx.c,104 :: 		break;
	GOTO       L_main11
;source_file_PICmid_proj04_rx.c,107 :: 		} //end switch
L_main10:
	MOVF       _m_control+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _m_control+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _m_control+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _m_control+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main15
L_main11:
;source_file_PICmid_proj04_rx.c,109 :: 		} //end while
	GOTO       L_main3
;source_file_PICmid_proj04_rx.c,111 :: 		} //end main
	GOTO       $+0
; end of _main

_rx_func:

;source_file_PICmid_proj04_rx.c,120 :: 		void rx_func(char *cmd, char *val, char *ok)
;source_file_PICmid_proj04_rx.c,124 :: 		*ok = 0;                                    //bit de verificação
	MOVF       FARG_rx_func_ok+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;source_file_PICmid_proj04_rx.c,126 :: 		if(RCIF_bit)                                //houve interrupção na recepção serial?
	BTFSS      RCIF_bit+0, 5
	GOTO       L_rx_func16
;source_file_PICmid_proj04_rx.c,128 :: 		RCIF_bit = 0x00;                         //limpa flag
	BCF        RCIF_bit+0, 5
;source_file_PICmid_proj04_rx.c,130 :: 		buffer = Uart1_Read();                   //lê serial e armazena em buffer
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      rx_func_buffer_L0+0
;source_file_PICmid_proj04_rx.c,132 :: 		if(start)                                //se start verdadeiro
	MOVF       _start+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_rx_func17
;source_file_PICmid_proj04_rx.c,134 :: 		cnt++;                                //incrementa contador
	INCF       _cnt+0, 1
;source_file_PICmid_proj04_rx.c,136 :: 		if(cnt == 1) *cmd = buffer;           //atualiza cmd, se contador igual a 1
	MOVF       _cnt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_rx_func18
	MOVF       FARG_rx_func_cmd+0, 0
	MOVWF      FSR
	MOVF       rx_func_buffer_L0+0, 0
	MOVWF      INDF+0
L_rx_func18:
;source_file_PICmid_proj04_rx.c,138 :: 		if(cnt == 2) *val = buffer;           //atualiza val, se contador igual a 2
	MOVF       _cnt+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_rx_func19
	MOVF       FARG_rx_func_val+0, 0
	MOVWF      FSR
	MOVF       rx_func_buffer_L0+0, 0
	MOVWF      INDF+0
L_rx_func19:
;source_file_PICmid_proj04_rx.c,140 :: 		if(cnt == 3)                          //contador igual a 3?
	MOVF       _cnt+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_rx_func20
;source_file_PICmid_proj04_rx.c,143 :: 		start    = 0x00;                   //limpa start
	CLRF       _start+0
;source_file_PICmid_proj04_rx.c,145 :: 		if(checksum == ~(char)(*cmd + *val)) *ok = 1; //seta ok, se checksum estiver correto
	MOVF       FARG_rx_func_cmd+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_rx_func_val+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R0+0, 1
	COMF       R0+0, 0
	MOVWF      R1+0
	MOVF       rx_func_buffer_L0+0, 0
	XORWF      R1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_rx_func21
	MOVF       FARG_rx_func_ok+0, 0
	MOVWF      FSR
	MOVLW      1
	MOVWF      INDF+0
L_rx_func21:
;source_file_PICmid_proj04_rx.c,147 :: 		} //end if cnt 3
L_rx_func20:
;source_file_PICmid_proj04_rx.c,149 :: 		} //end if start
	GOTO       L_rx_func22
L_rx_func17:
;source_file_PICmid_proj04_rx.c,153 :: 		if(buffer == 0xFF)                    //buffer completo?
	MOVF       rx_func_buffer_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_rx_func23
;source_file_PICmid_proj04_rx.c,155 :: 		start = 0x01;                      //seta start
	MOVLW      1
	MOVWF      _start+0
;source_file_PICmid_proj04_rx.c,156 :: 		cnt   = 0x00;                      //reinicia contador
	CLRF       _cnt+0
;source_file_PICmid_proj04_rx.c,158 :: 		} //end if buffer
L_rx_func23:
;source_file_PICmid_proj04_rx.c,160 :: 		} //end else
L_rx_func22:
;source_file_PICmid_proj04_rx.c,162 :: 		} //end if RCIF
L_rx_func16:
;source_file_PICmid_proj04_rx.c,164 :: 		} //end rx_func
	RETURN
; end of _rx_func

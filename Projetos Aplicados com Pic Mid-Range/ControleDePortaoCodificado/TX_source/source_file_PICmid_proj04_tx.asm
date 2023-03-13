
_main:

;source_file_PICmid_proj04_tx.c,31 :: 		void main()
;source_file_PICmid_proj04_tx.c,33 :: 		CMCON = 0x07;                               //desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;source_file_PICmid_proj04_tx.c,34 :: 		TRISB = 0xFD;                               //configura RB2 como saída (TX)
	MOVLW      253
	MOVWF      TRISB+0
;source_file_PICmid_proj04_tx.c,35 :: 		UART1_Init(1200);                           //inicializa UART1 com 1200 baud rate
	MOVLW      207
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;source_file_PICmid_proj04_tx.c,36 :: 		delay_ms(100);                              //aguarda estabilizar
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	NOP
	NOP
;source_file_PICmid_proj04_tx.c,39 :: 		while(1)                                    //Loop Infinito
L_main1:
;source_file_PICmid_proj04_tx.c,41 :: 		cmd_code();                              //codifica o comando
	CALL       _cmd_code+0
;source_file_PICmid_proj04_tx.c,43 :: 		if(!RB0_bit) tx_func(key,1);             //se RB0 em LOW, envia comando key e dado 1
	BTFSC      RB0_bit+0, 0
	GOTO       L_main3
	MOVF       _key+0, 0
	MOVWF      FARG_tx_func_comand+0
	MOVLW      1
	MOVWF      FARG_tx_func_value+0
	CALL       _tx_func+0
	GOTO       L_main4
L_main3:
;source_file_PICmid_proj04_tx.c,44 :: 		else if(!RB1_bit) tx_func(key,1);        //se RB1 em LOW, envia comando key e dado 1
	BTFSC      RB1_bit+0, 1
	GOTO       L_main5
	MOVF       _key+0, 0
	MOVWF      FARG_tx_func_comand+0
	MOVLW      1
	MOVWF      FARG_tx_func_value+0
	CALL       _tx_func+0
	GOTO       L_main6
L_main5:
;source_file_PICmid_proj04_tx.c,45 :: 		else tx_func(key,0);                     //senão, envia comando key e dado 0
	MOVF       _key+0, 0
	MOVWF      FARG_tx_func_comand+0
	CLRF       FARG_tx_func_value+0
	CALL       _tx_func+0
L_main6:
L_main4:
;source_file_PICmid_proj04_tx.c,50 :: 		} //end while
	GOTO       L_main1
;source_file_PICmid_proj04_tx.c,52 :: 		} //end main
	GOTO       $+0
; end of _main

_tx_func:

;source_file_PICmid_proj04_tx.c,61 :: 		void tx_func(char comand, char value)
;source_file_PICmid_proj04_tx.c,64 :: 		UART1_Write(0xFF);                          //byte de start
	MOVLW      255
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;source_file_PICmid_proj04_tx.c,65 :: 		delay_ms(10);                               //aguarda
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_tx_func7:
	DECFSZ     R13+0, 1
	GOTO       L_tx_func7
	DECFSZ     R12+0, 1
	GOTO       L_tx_func7
	NOP
	NOP
;source_file_PICmid_proj04_tx.c,66 :: 		UART1_Write(comand);                        //envia comando
	MOVF       FARG_tx_func_comand+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;source_file_PICmid_proj04_tx.c,67 :: 		delay_ms(10);                               //aguarda
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_tx_func8:
	DECFSZ     R13+0, 1
	GOTO       L_tx_func8
	DECFSZ     R12+0, 1
	GOTO       L_tx_func8
	NOP
	NOP
;source_file_PICmid_proj04_tx.c,68 :: 		UART1_Write(value);                         //envia valor do dado
	MOVF       FARG_tx_func_value+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;source_file_PICmid_proj04_tx.c,69 :: 		delay_ms(10);                               //aguarda
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_tx_func9:
	DECFSZ     R13+0, 1
	GOTO       L_tx_func9
	DECFSZ     R12+0, 1
	GOTO       L_tx_func9
	NOP
	NOP
;source_file_PICmid_proj04_tx.c,70 :: 		UART1_Write(~(char)(comand+value));         //faz checksum
	MOVF       FARG_tx_func_value+0, 0
	ADDWF      FARG_tx_func_comand+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	COMF       FARG_UART1_Write_data_+0, 1
	CALL       _UART1_Write+0
;source_file_PICmid_proj04_tx.c,71 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_tx_func10:
	DECFSZ     R13+0, 1
	GOTO       L_tx_func10
	DECFSZ     R12+0, 1
	GOTO       L_tx_func10
	NOP
	NOP
;source_file_PICmid_proj04_tx.c,74 :: 		} //end tx_func
	RETURN
; end of _tx_func

_cmd_code:

;source_file_PICmid_proj04_tx.c,79 :: 		void cmd_code()
;source_file_PICmid_proj04_tx.c,81 :: 		if(RB7_bit) key.B7 = 0x01;
	BTFSS      RB7_bit+0, 7
	GOTO       L_cmd_code11
	BSF        _key+0, 7
	GOTO       L_cmd_code12
L_cmd_code11:
;source_file_PICmid_proj04_tx.c,82 :: 		else        key.B7 = 0x00;
	BCF        _key+0, 7
L_cmd_code12:
;source_file_PICmid_proj04_tx.c,84 :: 		if(RB6_bit) key.B6 = 0x01;
	BTFSS      RB6_bit+0, 6
	GOTO       L_cmd_code13
	BSF        _key+0, 6
	GOTO       L_cmd_code14
L_cmd_code13:
;source_file_PICmid_proj04_tx.c,85 :: 		else        key.B6 = 0x00;
	BCF        _key+0, 6
L_cmd_code14:
;source_file_PICmid_proj04_tx.c,87 :: 		if(RB5_bit) key.B5 = 0x01;
	BTFSS      RB5_bit+0, 5
	GOTO       L_cmd_code15
	BSF        _key+0, 5
	GOTO       L_cmd_code16
L_cmd_code15:
;source_file_PICmid_proj04_tx.c,88 :: 		else        key.B5 = 0x00;
	BCF        _key+0, 5
L_cmd_code16:
;source_file_PICmid_proj04_tx.c,90 :: 		if(RB4_bit) key.B4 = 0x01;
	BTFSS      RB4_bit+0, 4
	GOTO       L_cmd_code17
	BSF        _key+0, 4
	GOTO       L_cmd_code18
L_cmd_code17:
;source_file_PICmid_proj04_tx.c,91 :: 		else        key.B4 = 0x00;
	BCF        _key+0, 4
L_cmd_code18:
;source_file_PICmid_proj04_tx.c,93 :: 		if(RA3_bit) key.B3 = 0x01;
	BTFSS      RA3_bit+0, 3
	GOTO       L_cmd_code19
	BSF        _key+0, 3
	GOTO       L_cmd_code20
L_cmd_code19:
;source_file_PICmid_proj04_tx.c,94 :: 		else        key.B3 = 0x00;
	BCF        _key+0, 3
L_cmd_code20:
;source_file_PICmid_proj04_tx.c,96 :: 		if(RA2_bit) key.B2 = 0x01;
	BTFSS      RA2_bit+0, 2
	GOTO       L_cmd_code21
	BSF        _key+0, 2
	GOTO       L_cmd_code22
L_cmd_code21:
;source_file_PICmid_proj04_tx.c,97 :: 		else        key.B2 = 0x00;
	BCF        _key+0, 2
L_cmd_code22:
;source_file_PICmid_proj04_tx.c,99 :: 		if(RA1_bit) key.B1 = 0x01;
	BTFSS      RA1_bit+0, 1
	GOTO       L_cmd_code23
	BSF        _key+0, 1
	GOTO       L_cmd_code24
L_cmd_code23:
;source_file_PICmid_proj04_tx.c,100 :: 		else        key.B1 = 0x00;
	BCF        _key+0, 1
L_cmd_code24:
;source_file_PICmid_proj04_tx.c,102 :: 		if(RA0_bit) key.B0 = 0x01;
	BTFSS      RA0_bit+0, 0
	GOTO       L_cmd_code25
	BSF        _key+0, 0
	GOTO       L_cmd_code26
L_cmd_code25:
;source_file_PICmid_proj04_tx.c,103 :: 		else        key.B0 = 0x00;
	BCF        _key+0, 0
L_cmd_code26:
;source_file_PICmid_proj04_tx.c,106 :: 		} //end cmd_code
	RETURN
; end of _cmd_code

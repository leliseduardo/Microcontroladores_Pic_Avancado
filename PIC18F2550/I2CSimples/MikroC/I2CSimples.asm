
_main:

;I2CSimples.c,33 :: 		void main() {
;I2CSimples.c,35 :: 		ADCON1 = 0x0F; // Configura todas as portar que poderiam ser analógicas como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;I2CSimples.c,37 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;I2CSimples.c,38 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2CSimples.c,39 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2CSimples.c,40 :: 		lcd_out(1, 1, "EEPROM Externa");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_I2CSimples+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_I2CSimples+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2CSimples.c,42 :: 		I2C1_Init(400000);         // Inicializa a comunicação I2C
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;I2CSimples.c,43 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;I2CSimples.c,44 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,45 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,46 :: 		I2C1_Wr(39);               // Envia o valor que se quer gravar
	MOVLW       39
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,47 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;I2CSimples.c,49 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
;I2CSimples.c,51 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;I2CSimples.c,52 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,53 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,54 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;I2CSimples.c,55 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,56 :: 		memoria = I2C1_Rd(0u);     // Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoria+0 
;I2CSimples.c,57 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;I2CSimples.c,59 :: 		IntToStr(memoria, txt);
	MOVF        _memoria+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;I2CSimples.c,61 :: 		lcd_out(2, 1, txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2CSimples.c,64 :: 		while(1){
L_main1:
;I2CSimples.c,68 :: 		} // end Loop infinito
	GOTO        L_main1
;I2CSimples.c,70 :: 		} // end void main
	GOTO        $+0
; end of _main

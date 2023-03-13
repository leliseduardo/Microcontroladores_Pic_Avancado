
_novo_Arquivo:

;SDCard.c,14 :: 		void novo_Arquivo(){
;SDCard.c,16 :: 		Mmc_Fat_Assign(&nomearquivo, 0xA0);          //Cria arquivo para escrita
	MOVLW       _nomearquivo+0
	MOVWF       FARG_Mmc_Fat_Assign_filename+0 
	MOVLW       hi_addr(_nomearquivo+0)
	MOVWF       FARG_Mmc_Fat_Assign_filename+1 
	MOVLW       160
	MOVWF       FARG_Mmc_Fat_Assign_file_cre_attr+0 
	CALL        _Mmc_Fat_Assign+0, 0
;SDCard.c,17 :: 		Mmc_Fat_Rewrite();                        //Limpa arquivo para escrever novo dado
	CALL        _Mmc_Fat_Rewrite+0, 0
;SDCard.c,19 :: 		Lcd_Out(2, 1, "Ok");                        //mensagem de status
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_SDCard+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_SDCard+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SDCard.c,21 :: 		conteudoarquivo[0] = 42/10 + 48;            //escreve o número 4 na posição 0 da string
	MOVLW       52
	MOVWF       _conteudoarquivo+0 
;SDCard.c,22 :: 		conteudoarquivo[1] = 42%10 + 48;            //escreve o número 2 na posição 1 da string
	MOVLW       50
	MOVWF       _conteudoarquivo+1 
;SDCard.c,24 :: 		Mmc_Fat_Write(conteudoarquivo, TAMANHO-1); //escreve no cartão
	MOVLW       _conteudoarquivo+0
	MOVWF       FARG_Mmc_Fat_Write_fdata+0 
	MOVLW       hi_addr(_conteudoarquivo+0)
	MOVWF       FARG_Mmc_Fat_Write_fdata+1 
	MOVLW       23
	MOVWF       FARG_Mmc_Fat_Write_data_len+0 
	MOVLW       0
	MOVWF       FARG_Mmc_Fat_Write_data_len+1 
	CALL        _Mmc_Fat_Write+0, 0
;SDCard.c,26 :: 		} // end void novo_Arquivo
	RETURN      0
; end of _novo_Arquivo

_start_SD:

;SDCard.c,28 :: 		void start_SD(){
;SDCard.c,31 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SDCard.c,34 :: 		if (Mmc_Fat_Init() == 0)
	CALL        _Mmc_Fat_Init+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_start_SD0
;SDCard.c,37 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SDCard.c,39 :: 		Lcd_Out(1, 1, "SD Start!");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SDCard+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SDCard+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SDCard.c,41 :: 		novo_Arquivo();
	CALL        _novo_Arquivo+0, 0
;SDCard.c,43 :: 		}
	GOTO        L_start_SD1
L_start_SD0:
;SDCard.c,47 :: 		Lcd_Out(1, 1, "SD Error!");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SDCard+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SDCard+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SDCard.c,48 :: 		}
L_start_SD1:
;SDCard.c,50 :: 		delay_ms(1000);   //aguarda...
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_start_SD2:
	DECFSZ      R13, 1, 1
	BRA         L_start_SD2
	DECFSZ      R12, 1, 1
	BRA         L_start_SD2
	DECFSZ      R11, 1, 1
	BRA         L_start_SD2
	NOP
;SDCard.c,52 :: 		} // end void start_SD
	RETURN      0
; end of _start_SD

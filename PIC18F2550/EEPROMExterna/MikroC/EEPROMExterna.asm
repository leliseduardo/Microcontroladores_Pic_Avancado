
_main:

;EEPROMExterna.c,43 :: 		void main() {
;EEPROMExterna.c,45 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;EEPROMExterna.c,47 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;EEPROMExterna.c,48 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExterna.c,49 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExterna.c,50 :: 		lcd_out(1, 2, "Velho");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_EEPROMExterna+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_EEPROMExterna+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExterna.c,51 :: 		lcd_out(1, 10, "Novo");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_EEPROMExterna+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_EEPROMExterna+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExterna.c,53 :: 		I2C1_Init(400000);         // Inicializa a comunicação I2C
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;EEPROMExterna.c,54 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExterna.c,55 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,56 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,57 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;EEPROMExterna.c,58 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,59 :: 		memoriaVelha = I2C1_Rd(0u);// Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaVelha+0 
;EEPROMExterna.c,60 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExterna.c,63 :: 		while(1){
L_main0:
;EEPROMExterna.c,65 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;EEPROMExterna.c,67 :: 		if(!incremento){
	BTFSC       RC0_bit+0, 0 
	GOTO        L_main2
;EEPROMExterna.c,69 :: 		memoriaNova += 0x01;
	INCF        _memoriaNova+0, 1 
;EEPROMExterna.c,70 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExterna.c,71 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,72 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,73 :: 		I2C1_Wr(memoriaNova);               // Envia o valor que se quer gravar
	MOVF        _memoriaNova+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,74 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExterna.c,75 :: 		delay_ms(250);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;EEPROMExterna.c,77 :: 		} // end if !incremento
L_main2:
;EEPROMExterna.c,79 :: 		if(!decremento){
	BTFSC       RC1_bit+0, 1 
	GOTO        L_main4
;EEPROMExterna.c,81 :: 		memoriaNova -= 0x01;
	DECF        _memoriaNova+0, 1 
;EEPROMExterna.c,82 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExterna.c,83 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,84 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,85 :: 		I2C1_Wr(memoriaNova);               // Envia o valor que se quer gravar
	MOVF        _memoriaNova+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna.c,86 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExterna.c,87 :: 		delay_ms(250);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;EEPROMExterna.c,89 :: 		} // end if !decremento
L_main4:
;EEPROMExterna.c,91 :: 		} // end Loop infinito
	GOTO        L_main0
;EEPROMExterna.c,93 :: 		} // end void main
	GOTO        $+0
; end of _main

_imprime_Display:

;EEPROMExterna.c,97 :: 		void imprime_Display(){
;EEPROMExterna.c,101 :: 		cenVelho = memoriaVelha/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _memoriaVelha+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cenVelho_L0+0 
;EEPROMExterna.c,102 :: 		dezVelho = (memoriaVelha%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _memoriaVelha+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dezVelho_L0+0 
;EEPROMExterna.c,103 :: 		uniVelho = memoriaVelha%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _memoriaVelha+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uniVelho_L0+0 
;EEPROMExterna.c,105 :: 		cenNovo = memoriaNova/100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cenNovo_L0+0 
;EEPROMExterna.c,106 :: 		dezNovo = (memoriaNova%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dezNovo_L0+0 
;EEPROMExterna.c,107 :: 		uniNovo = memoriaNova%10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uniNovo_L0+0 
;EEPROMExterna.c,109 :: 		lcd_chr(2, 3, cenVelho + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cenVelho_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExterna.c,110 :: 		lcd_chr_cp(dezVelho + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dezVelho_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna.c,111 :: 		lcd_chr_cp(uniVelho + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uniVelho_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna.c,113 :: 		lcd_chr(2, 11, cenNovo + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cenNovo_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExterna.c,114 :: 		lcd_chr_cp(dezNovo + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dezNovo_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna.c,115 :: 		lcd_chr_cp(uniNovo + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uniNovo_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna.c,117 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

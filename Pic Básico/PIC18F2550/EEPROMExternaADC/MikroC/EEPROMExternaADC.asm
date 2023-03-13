
_main:

;EEPROMExternaADC.c,47 :: 		void main() {
;EEPROMExternaADC.c,49 :: 		ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;EEPROMExternaADC.c,50 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;EEPROMExternaADC.c,52 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;EEPROMExternaADC.c,53 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExternaADC.c,54 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExternaADC.c,55 :: 		lcd_out(1, 2, "Valor 16 bits");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_EEPROMExternaADC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_EEPROMExternaADC+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExternaADC.c,57 :: 		I2C1_Init(400000);         // Inicializa a comunicação I2C
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;EEPROMExternaADC.c,59 :: 		EEPROM_Leitura16bits();
	CALL        _EEPROM_Leitura16bits+0, 0
;EEPROMExternaADC.c,62 :: 		while(1){
L_main0:
;EEPROMExternaADC.c,64 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;EEPROMExternaADC.c,66 :: 		memoriaNova = adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaNova+0 
	MOVF        R1, 0 
	MOVWF       _memoriaNova+1 
;EEPROMExternaADC.c,68 :: 		EEPROM_Escreve16bits();
	CALL        _EEPROM_Escreve16bits+0, 0
;EEPROMExternaADC.c,86 :: 		} // end Loop infinito
	GOTO        L_main0
;EEPROMExternaADC.c,88 :: 		} // end void main
	GOTO        $+0
; end of _main

_EEPROM_Escreve16bits:

;EEPROMExternaADC.c,91 :: 		void EEPROM_Escreve16bits(){
;EEPROMExternaADC.c,93 :: 		memoriaH = memoriaNova >> 0x08;
	MOVF        _memoriaNova+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _memoriaNova+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _memoriaH+0 
;EEPROMExternaADC.c,94 :: 		memoriaL = memoriaNova % 256;
	MOVLW       0
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	MOVF        _memoriaNova+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _memoriaL+0 
;EEPROMExternaADC.c,96 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaADC.c,97 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,98 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,99 :: 		I2C1_Wr(memoriaH);               // Envia o valor que se quer gravar
	MOVF        _memoriaH+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,100 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaADC.c,101 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Escreve16bits2:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Escreve16bits2
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Escreve16bits2
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Escreve16bits2
;EEPROMExternaADC.c,102 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaADC.c,103 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,104 :: 		I2C1_Wr(0x06);             // Envia a posição de memória a ser escrita
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,105 :: 		I2C1_Wr(memoriaL);               // Envia o valor que se quer gravar
	MOVF        _memoriaL+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,106 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaADC.c,107 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Escreve16bits3:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Escreve16bits3
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Escreve16bits3
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Escreve16bits3
;EEPROMExternaADC.c,109 :: 		} // end void EEPROM_Escreve16bits
	RETURN      0
; end of _EEPROM_Escreve16bits

_EEPROM_Leitura16bits:

;EEPROMExternaADC.c,111 :: 		void EEPROM_Leitura16bits(){
;EEPROMExternaADC.c,113 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaADC.c,114 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,115 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,116 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;EEPROMExternaADC.c,117 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,118 :: 		memoriaH = I2C1_Rd(0u); // Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaH+0 
;EEPROMExternaADC.c,119 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaADC.c,120 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Leitura16bits4:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits4
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits4
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits4
;EEPROMExternaADC.c,121 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaADC.c,122 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,123 :: 		I2C1_Wr(0x06);             // Envia a posição de memória a ser escrita
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,124 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;EEPROMExternaADC.c,125 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaADC.c,126 :: 		memoriaL = I2C1_Rd(0u);// Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaL+0 
;EEPROMExternaADC.c,127 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaADC.c,128 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Leitura16bits5:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits5
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits5
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits5
;EEPROMExternaADC.c,130 :: 		memoriaVelha = (memoriaH<<8) + memoriaL;
	MOVF        _memoriaH+0, 0 
	MOVWF       _memoriaVelha+1 
	CLRF        _memoriaVelha+0 
	MOVF        _memoriaL+0, 0 
	ADDWF       _memoriaVelha+0, 1 
	MOVLW       0
	ADDWFC      _memoriaVelha+1, 1 
;EEPROMExternaADC.c,132 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_EEPROM_Leitura16bits6:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits6
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits6
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits6
;EEPROMExternaADC.c,134 :: 		} // end void EEPROM_Leitura16bits
	RETURN      0
; end of _EEPROM_Leitura16bits

_imprime_Display:

;EEPROMExternaADC.c,137 :: 		void imprime_Display(){
;EEPROMExternaADC.c,141 :: 		mil = (memoriaNova%10000)/1000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	MOVF        _memoriaNova+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_mil_L0+0 
;EEPROMExternaADC.c,142 :: 		cen = (memoriaNova%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	MOVF        _memoriaNova+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen_L0+0 
;EEPROMExternaADC.c,143 :: 		dez = (memoriaNova%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	MOVF        _memoriaNova+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez_L0+0 
;EEPROMExternaADC.c,144 :: 		uni = memoriaNova%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	MOVF        _memoriaNova+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni_L0+0 
;EEPROMExternaADC.c,146 :: 		mil2 = (memoriaVelha%10000)/1000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _memoriaVelha+0, 0 
	MOVWF       R0 
	MOVF        _memoriaVelha+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_mil2_L0+0 
;EEPROMExternaADC.c,147 :: 		cen2 = (memoriaVelha%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _memoriaVelha+0, 0 
	MOVWF       R0 
	MOVF        _memoriaVelha+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen2_L0+0 
;EEPROMExternaADC.c,148 :: 		dez2 = (memoriaVelha%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _memoriaVelha+0, 0 
	MOVWF       R0 
	MOVF        _memoriaVelha+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez2_L0+0 
;EEPROMExternaADC.c,149 :: 		uni2 = memoriaVelha%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _memoriaVelha+0, 0 
	MOVWF       R0 
	MOVF        _memoriaVelha+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni2_L0+0 
;EEPROMExternaADC.c,151 :: 		lcd_chr(2, 2, mil + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_mil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExternaADC.c,152 :: 		lcd_chr_cp(cen + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaADC.c,153 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaADC.c,154 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaADC.c,156 :: 		lcd_chr(2, 10, mil2 + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_mil2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExternaADC.c,157 :: 		lcd_chr_cp(cen2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_cen2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaADC.c,158 :: 		lcd_chr_cp(dez2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaADC.c,159 :: 		lcd_chr_cp(uni2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaADC.c,161 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

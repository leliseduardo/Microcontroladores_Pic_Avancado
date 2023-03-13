
_main:

;EEPROMExternaVoltimetro.c,49 :: 		void main() {
;EEPROMExternaVoltimetro.c,51 :: 		ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;EEPROMExternaVoltimetro.c,52 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;EEPROMExternaVoltimetro.c,54 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;EEPROMExternaVoltimetro.c,55 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExternaVoltimetro.c,56 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExternaVoltimetro.c,58 :: 		I2C1_Init(400000);         // Inicializa a comunicação I2C
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;EEPROMExternaVoltimetro.c,60 :: 		EEPROM_Leitura16bits();
	CALL        _EEPROM_Leitura16bits+0, 0
;EEPROMExternaVoltimetro.c,61 :: 		imprime_Max_Min();
	CALL        _imprime_Max_Min+0, 0
;EEPROMExternaVoltimetro.c,62 :: 		delay_ms(2000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
;EEPROMExternaVoltimetro.c,63 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExternaVoltimetro.c,66 :: 		while(1){
L_main1:
;EEPROMExternaVoltimetro.c,68 :: 		adc = adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;EEPROMExternaVoltimetro.c,70 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;EEPROMExternaVoltimetro.c,72 :: 		if(!botao){
	BTFSC       RC0_bit+0, 0 
	GOTO        L_main3
;EEPROMExternaVoltimetro.c,74 :: 		lcd_out(2,1, "CLR");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_EEPROMExternaVoltimetro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_EEPROMExternaVoltimetro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExternaVoltimetro.c,75 :: 		valorMaximo = 0x00;
	CLRF        _valorMaximo+0 
	CLRF        _valorMaximo+1 
;EEPROMExternaVoltimetro.c,76 :: 		valorMinimo = 500;
	MOVLW       244
	MOVWF       _valorMinimo+0 
	MOVLW       1
	MOVWF       _valorMinimo+1 
;EEPROMExternaVoltimetro.c,77 :: 		EEPROM_Escreve16bits(0x05, valorMaximo);
	MOVLW       5
	MOVWF       FARG_EEPROM_Escreve16bits_endereco+0 
	CLRF        FARG_EEPROM_Escreve16bits_dado+0 
	CLRF        FARG_EEPROM_Escreve16bits_dado+1 
	CALL        _EEPROM_Escreve16bits+0, 0
;EEPROMExternaVoltimetro.c,78 :: 		EEPROM_Escreve16bits(0x07, valorMinimo);
	MOVLW       7
	MOVWF       FARG_EEPROM_Escreve16bits_endereco+0 
	MOVF        _valorMinimo+0, 0 
	MOVWF       FARG_EEPROM_Escreve16bits_dado+0 
	MOVF        _valorMinimo+1, 0 
	MOVWF       FARG_EEPROM_Escreve16bits_dado+1 
	CALL        _EEPROM_Escreve16bits+0, 0
;EEPROMExternaVoltimetro.c,79 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
;EEPROMExternaVoltimetro.c,80 :: 		lcd_out(2,1, "   ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_EEPROMExternaVoltimetro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_EEPROMExternaVoltimetro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExternaVoltimetro.c,82 :: 		} // end if !incremento
L_main3:
;EEPROMExternaVoltimetro.c,86 :: 		} // end Loop infinito
	GOTO        L_main1
;EEPROMExternaVoltimetro.c,88 :: 		} // end void main
	GOTO        $+0
; end of _main

_EEPROM_Escreve16bits:

;EEPROMExternaVoltimetro.c,91 :: 		void EEPROM_Escreve16bits(unsigned char endereco, unsigned dado){
;EEPROMExternaVoltimetro.c,93 :: 		memoriaH = dado >> 0x08;
	MOVF        FARG_EEPROM_Escreve16bits_dado+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       _memoriaH+0 
;EEPROMExternaVoltimetro.c,94 :: 		memoriaL = dado % 256;
	MOVLW       255
	ANDWF       FARG_EEPROM_Escreve16bits_dado+0, 0 
	MOVWF       R0 
	MOVF        FARG_EEPROM_Escreve16bits_dado+1, 0 
	MOVWF       R1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _memoriaL+0 
;EEPROMExternaVoltimetro.c,96 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaVoltimetro.c,97 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,98 :: 		I2C1_Wr(endereco);             // Envia a posição de memória a ser escrita
	MOVF        FARG_EEPROM_Escreve16bits_endereco+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,99 :: 		I2C1_Wr(memoriaH);               // Envia o valor que se quer gravar
	MOVF        _memoriaH+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,100 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaVoltimetro.c,101 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Escreve16bits5:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Escreve16bits5
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Escreve16bits5
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Escreve16bits5
;EEPROMExternaVoltimetro.c,102 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaVoltimetro.c,103 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,104 :: 		I2C1_Wr(endereco);  // Envia a posição de memória a ser escrita
	MOVF        FARG_EEPROM_Escreve16bits_endereco+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,105 :: 		I2C1_Wr(memoriaL);         // Envia o valor que se quer gravar
	MOVF        _memoriaL+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,106 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaVoltimetro.c,107 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Escreve16bits6:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Escreve16bits6
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Escreve16bits6
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Escreve16bits6
;EEPROMExternaVoltimetro.c,109 :: 		} // end void EEPROM_Escreve16bits
	RETURN      0
; end of _EEPROM_Escreve16bits

_EEPROM_Leitura16bits:

;EEPROMExternaVoltimetro.c,111 :: 		void EEPROM_Leitura16bits(){
;EEPROMExternaVoltimetro.c,113 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaVoltimetro.c,114 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,115 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,116 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;EEPROMExternaVoltimetro.c,117 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,118 :: 		memoriaH = I2C1_Rd(0u); // Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaH+0 
;EEPROMExternaVoltimetro.c,119 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaVoltimetro.c,120 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Leitura16bits7:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits7
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits7
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits7
;EEPROMExternaVoltimetro.c,121 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaVoltimetro.c,122 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,123 :: 		I2C1_Wr(0x06);             // Envia a posição de memória a ser escrita
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,124 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;EEPROMExternaVoltimetro.c,125 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,126 :: 		memoriaL = I2C1_Rd(0u);// Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaL+0 
;EEPROMExternaVoltimetro.c,127 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaVoltimetro.c,128 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Leitura16bits8:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits8
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits8
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits8
;EEPROMExternaVoltimetro.c,130 :: 		valorMaximo = (memoriaH<<8) + memoriaL;
	MOVF        _memoriaH+0, 0 
	MOVWF       _valorMaximo+1 
	CLRF        _valorMaximo+0 
	MOVF        _memoriaL+0, 0 
	ADDWF       _valorMaximo+0, 1 
	MOVLW       0
	ADDWFC      _valorMaximo+1, 1 
;EEPROMExternaVoltimetro.c,132 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaVoltimetro.c,133 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,134 :: 		I2C1_Wr(0x07);             // Envia a posição de memória a ser escrita
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,135 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;EEPROMExternaVoltimetro.c,136 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,137 :: 		memoriaH = I2C1_Rd(0u); // Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaH+0 
;EEPROMExternaVoltimetro.c,138 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaVoltimetro.c,139 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Leitura16bits9:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits9
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits9
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits9
;EEPROMExternaVoltimetro.c,140 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExternaVoltimetro.c,141 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escreita  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,142 :: 		I2C1_Wr(0x08);             // Envia a posição de memória a ser escrita
	MOVLW       8
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,143 :: 		I2C1_Repeated_Start();     // Reinicia o I2C
	CALL        _I2C1_Repeated_Start+0, 0
;EEPROMExternaVoltimetro.c,144 :: 		I2C1_Wr(0xA1);             // Envia um byte para o I2C contendo o endereço e configurando leitura
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExternaVoltimetro.c,145 :: 		memoriaL = I2C1_Rd(0u);// Le o dado e armazena na variável memoria
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoriaL+0 
;EEPROMExternaVoltimetro.c,146 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;EEPROMExternaVoltimetro.c,147 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Leitura16bits10:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits10
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits10
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits10
;EEPROMExternaVoltimetro.c,149 :: 		valorMinimo = (memoriaH<<8) + memoriaL;
	MOVF        _memoriaH+0, 0 
	MOVWF       _valorMinimo+1 
	CLRF        _valorMinimo+0 
	MOVF        _memoriaL+0, 0 
	ADDWF       _valorMinimo+0, 1 
	MOVLW       0
	ADDWFC      _valorMinimo+1, 1 
;EEPROMExternaVoltimetro.c,151 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_EEPROM_Leitura16bits11:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Leitura16bits11
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Leitura16bits11
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Leitura16bits11
;EEPROMExternaVoltimetro.c,153 :: 		} // end void EEPROM_Leitura16bits
	RETURN      0
; end of _EEPROM_Leitura16bits

_imprime_Display:

;EEPROMExternaVoltimetro.c,156 :: 		void imprime_Display(){
;EEPROMExternaVoltimetro.c,160 :: 		valor = calcula_Tensao(adc);
	MOVF        _adc+0, 0 
	MOVWF       FARG_calcula_Tensao_n+0 
	MOVF        _adc+1, 0 
	MOVWF       FARG_calcula_Tensao_n+1 
	CALL        _calcula_Tensao+0, 0
	MOVF        R0, 0 
	MOVWF       _valor+0 
	MOVF        R1, 0 
	MOVWF       _valor+1 
;EEPROMExternaVoltimetro.c,162 :: 		if(valor > valorMaximo){
	MOVF        R1, 0 
	SUBWF       _valorMaximo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__imprime_Display14
	MOVF        R0, 0 
	SUBWF       _valorMaximo+0, 0 
L__imprime_Display14:
	BTFSC       STATUS+0, 0 
	GOTO        L_imprime_Display12
;EEPROMExternaVoltimetro.c,163 :: 		valorMaximo = valor;
	MOVF        _valor+0, 0 
	MOVWF       _valorMaximo+0 
	MOVF        _valor+1, 0 
	MOVWF       _valorMaximo+1 
;EEPROMExternaVoltimetro.c,164 :: 		EEPROM_Escreve16bits(0x05, valorMaximo);
	MOVLW       5
	MOVWF       FARG_EEPROM_Escreve16bits_endereco+0 
	MOVF        _valor+0, 0 
	MOVWF       FARG_EEPROM_Escreve16bits_dado+0 
	MOVF        _valor+1, 0 
	MOVWF       FARG_EEPROM_Escreve16bits_dado+1 
	CALL        _EEPROM_Escreve16bits+0, 0
;EEPROMExternaVoltimetro.c,165 :: 		}
L_imprime_Display12:
;EEPROMExternaVoltimetro.c,166 :: 		if(valor < valorMinimo){
	MOVF        _valorMinimo+1, 0 
	SUBWF       _valor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__imprime_Display15
	MOVF        _valorMinimo+0, 0 
	SUBWF       _valor+0, 0 
L__imprime_Display15:
	BTFSC       STATUS+0, 0 
	GOTO        L_imprime_Display13
;EEPROMExternaVoltimetro.c,167 :: 		valorMinimo = valor;
	MOVF        _valor+0, 0 
	MOVWF       _valorMinimo+0 
	MOVF        _valor+1, 0 
	MOVWF       _valorMinimo+1 
;EEPROMExternaVoltimetro.c,168 :: 		EEPROM_Escreve16bits(0x07, valorMinimo);
	MOVLW       7
	MOVWF       FARG_EEPROM_Escreve16bits_endereco+0 
	MOVF        _valor+0, 0 
	MOVWF       FARG_EEPROM_Escreve16bits_dado+0 
	MOVF        _valor+1, 0 
	MOVWF       FARG_EEPROM_Escreve16bits_dado+1 
	CALL        _EEPROM_Escreve16bits+0, 0
;EEPROMExternaVoltimetro.c,169 :: 		}
L_imprime_Display13:
;EEPROMExternaVoltimetro.c,171 :: 		lcd_out(1, 2, "Valor 16 bits");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_EEPROMExternaVoltimetro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_EEPROMExternaVoltimetro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExternaVoltimetro.c,173 :: 		mil = (valor%10000)/1000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_mil_L0+0 
;EEPROMExternaVoltimetro.c,174 :: 		cen = (valor%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen_L0+0 
;EEPROMExternaVoltimetro.c,175 :: 		dez = (valor%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dez_L0+0 
;EEPROMExternaVoltimetro.c,176 :: 		uni = valor%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valor+0, 0 
	MOVWF       R0 
	MOVF        _valor+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni_L0+0 
;EEPROMExternaVoltimetro.c,178 :: 		lcd_chr(2, 6, mil + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_mil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExternaVoltimetro.c,179 :: 		lcd_chr_cp(cen + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,180 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,181 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,182 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,184 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_imprime_Max_Min:

;EEPROMExternaVoltimetro.c,187 :: 		void imprime_Max_Min(){
;EEPROMExternaVoltimetro.c,191 :: 		lcd_out(1, 2, "Max");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_EEPROMExternaVoltimetro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_EEPROMExternaVoltimetro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExternaVoltimetro.c,192 :: 		lcd_out(1, 10, "Min");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_EEPROMExternaVoltimetro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_EEPROMExternaVoltimetro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExternaVoltimetro.c,194 :: 		mil = (valorMaximo%10000)/1000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _valorMaximo+0, 0 
	MOVWF       R0 
	MOVF        _valorMaximo+1, 0 
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
	MOVWF       imprime_Max_Min_mil_L0+0 
;EEPROMExternaVoltimetro.c,195 :: 		cen = (valorMaximo%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _valorMaximo+0, 0 
	MOVWF       R0 
	MOVF        _valorMaximo+1, 0 
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
	MOVWF       imprime_Max_Min_cen_L0+0 
;EEPROMExternaVoltimetro.c,196 :: 		dez = (valorMaximo%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valorMaximo+0, 0 
	MOVWF       R0 
	MOVF        _valorMaximo+1, 0 
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
	MOVWF       imprime_Max_Min_dez_L0+0 
;EEPROMExternaVoltimetro.c,197 :: 		uni = valorMaximo%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valorMaximo+0, 0 
	MOVWF       R0 
	MOVF        _valorMaximo+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Max_Min_uni_L0+0 
;EEPROMExternaVoltimetro.c,199 :: 		mil2 = (valorMinimo%10000)/1000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _valorMinimo+0, 0 
	MOVWF       R0 
	MOVF        _valorMinimo+1, 0 
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
	MOVWF       imprime_Max_Min_mil2_L0+0 
;EEPROMExternaVoltimetro.c,200 :: 		cen2 = (valorMinimo%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _valorMinimo+0, 0 
	MOVWF       R0 
	MOVF        _valorMinimo+1, 0 
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
	MOVWF       imprime_Max_Min_cen2_L0+0 
;EEPROMExternaVoltimetro.c,201 :: 		dez2 = (valorMinimo%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valorMinimo+0, 0 
	MOVWF       R0 
	MOVF        _valorMinimo+1, 0 
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
	MOVWF       imprime_Max_Min_dez2_L0+0 
;EEPROMExternaVoltimetro.c,202 :: 		uni2 = valorMinimo%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _valorMinimo+0, 0 
	MOVWF       R0 
	MOVF        _valorMinimo+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Max_Min_uni2_L0+0 
;EEPROMExternaVoltimetro.c,204 :: 		lcd_chr(2, 2, mil + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Max_Min_mil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExternaVoltimetro.c,205 :: 		lcd_chr_cp(cen + 0x30);
	MOVLW       48
	ADDWF       imprime_Max_Min_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,206 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,207 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Max_Min_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,208 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Max_Min_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,210 :: 		lcd_chr(2, 10, mil2 + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Max_Min_mil2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExternaVoltimetro.c,211 :: 		lcd_chr_cp(cen2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Max_Min_cen2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,212 :: 		lcd_chr_cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,213 :: 		lcd_chr_cp(dez2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Max_Min_dez2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,214 :: 		lcd_chr_cp(uni2 + 0x30);
	MOVLW       48
	ADDWF       imprime_Max_Min_uni2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExternaVoltimetro.c,216 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Max_Min

_calcula_Tensao:

;EEPROMExternaVoltimetro.c,218 :: 		unsigned calcula_Tensao(int n){
;EEPROMExternaVoltimetro.c,222 :: 		tensao = ((n * 500.0) / 1023.0);
	MOVF        FARG_calcula_Tensao_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_calcula_Tensao_n+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
;EEPROMExternaVoltimetro.c,224 :: 		return (unsigned)tensao;
	CALL        _Double2Word+0, 0
;EEPROMExternaVoltimetro.c,226 :: 		} // end unsigned calcula_Tensao
	RETURN      0
; end of _calcula_Tensao

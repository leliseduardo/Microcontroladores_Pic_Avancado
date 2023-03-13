
_main:

;EEPROMExterna16Bits.c,40 :: 		void main() {
;EEPROMExterna16Bits.c,42 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;EEPROMExterna16Bits.c,44 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;EEPROMExterna16Bits.c,45 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExterna16Bits.c,46 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;EEPROMExterna16Bits.c,47 :: 		lcd_out(1, 2, "Valor 16 bits");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_EEPROMExterna16Bits+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_EEPROMExterna16Bits+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;EEPROMExterna16Bits.c,49 :: 		I2C1_Init(400000);         // Inicializa a comunicação I2C
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;EEPROMExterna16Bits.c,52 :: 		while(1){
L_main0:
;EEPROMExterna16Bits.c,54 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;EEPROMExterna16Bits.c,56 :: 		if(!incremento){
	BTFSC       RC0_bit+0, 0 
	GOTO        L_main2
;EEPROMExterna16Bits.c,58 :: 		memoriaNova += 0x01;
	INFSNZ      _memoriaNova+0, 1 
	INCF        _memoriaNova+1, 1 
;EEPROMExterna16Bits.c,59 :: 		EEPROM_Escreve16bits();
	CALL        _EEPROM_Escreve16bits+0, 0
;EEPROMExterna16Bits.c,61 :: 		} // end if !incremento
L_main2:
;EEPROMExterna16Bits.c,63 :: 		if(!decremento){
	BTFSC       RC1_bit+0, 1 
	GOTO        L_main3
;EEPROMExterna16Bits.c,65 :: 		memoriaNova -= 0x01;
	MOVLW       1
	SUBWF       _memoriaNova+0, 1 
	MOVLW       0
	SUBWFB      _memoriaNova+1, 1 
;EEPROMExterna16Bits.c,66 :: 		EEPROM_Escreve16bits();
	CALL        _EEPROM_Escreve16bits+0, 0
;EEPROMExterna16Bits.c,68 :: 		} // end if !decremento
L_main3:
;EEPROMExterna16Bits.c,70 :: 		} // end Loop infinito
	GOTO        L_main0
;EEPROMExterna16Bits.c,72 :: 		} // end void main
	GOTO        $+0
; end of _main

_EEPROM_Escreve16bits:

;EEPROMExterna16Bits.c,75 :: 		void EEPROM_Escreve16bits(){
;EEPROMExterna16Bits.c,77 :: 		memoriaH = memoriaNova >> 0x08;
	MOVF        _memoriaNova+1, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _memoriaNova+1, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _memoriaH+0 
;EEPROMExterna16Bits.c,78 :: 		memoriaL = memoriaNova % 256;
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
;EEPROMExterna16Bits.c,80 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExterna16Bits.c,81 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna16Bits.c,82 :: 		I2C1_Wr(0x05);             // Envia a posição de memória a ser escrita
	MOVLW       5
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna16Bits.c,83 :: 		I2C1_Wr(memoriaH);               // Envia o valor que se quer gravar
	MOVF        _memoriaH+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna16Bits.c,84 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExterna16Bits.c,85 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_EEPROM_Escreve16bits4:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROM_Escreve16bits4
	DECFSZ      R12, 1, 1
	BRA         L_EEPROM_Escreve16bits4
	DECFSZ      R11, 1, 1
	BRA         L_EEPROM_Escreve16bits4
;EEPROMExterna16Bits.c,86 :: 		I2C1_Start();              // Inicializa o I2C
	CALL        _I2C1_Start+0, 0
;EEPROMExterna16Bits.c,87 :: 		I2C1_Wr(0xA0);             // Envia um byte para o I2C contendo o endereço e configurando escrita (endereço da memória + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna16Bits.c,88 :: 		I2C1_Wr(0x06);             // Envia a posição de memória a ser escrita
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna16Bits.c,89 :: 		I2C1_Wr(memoriaL);               // Envia o valor que se quer gravar
	MOVF        _memoriaL+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;EEPROMExterna16Bits.c,90 :: 		I2C1_Stop();               // Para o I2C
	CALL        _I2C1_Stop+0, 0
;EEPROMExterna16Bits.c,91 :: 		delay_ms(100);
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
;EEPROMExterna16Bits.c,93 :: 		} // end void EEPROM_Escreve16bits
	RETURN      0
; end of _EEPROM_Escreve16bits

_imprime_Display:

;EEPROMExterna16Bits.c,96 :: 		void imprime_Display(){
;EEPROMExterna16Bits.c,100 :: 		dezmil = memoriaNova/10000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        _memoriaNova+0, 0 
	MOVWF       R0 
	MOVF        _memoriaNova+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dezmil_L0+0 
;EEPROMExterna16Bits.c,101 :: 		mil = (memoriaNova%10000)/1000;
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
;EEPROMExterna16Bits.c,102 :: 		cen = (memoriaNova%1000)/100;
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
;EEPROMExterna16Bits.c,103 :: 		dez = (memoriaNova%100)/10;
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
;EEPROMExterna16Bits.c,104 :: 		uni = memoriaNova%10;
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
;EEPROMExterna16Bits.c,106 :: 		lcd_chr(2, 10, dezmil + 0x30);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_dezmil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;EEPROMExterna16Bits.c,107 :: 		lcd_chr_cp(mil + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_mil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna16Bits.c,108 :: 		lcd_chr_cp(cen + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna16Bits.c,109 :: 		lcd_chr_cp(dez + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna16Bits.c,110 :: 		lcd_chr_cp(uni + 0x30);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;EEPROMExterna16Bits.c,112 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

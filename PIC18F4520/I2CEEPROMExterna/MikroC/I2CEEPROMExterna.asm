
_main:

;I2CEEPROMExterna.c,51 :: 		void main() {
;I2CEEPROMExterna.c,53 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderia ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;I2CEEPROMExterna.c,54 :: 		TRISB = 0xFF; // Configura todo o portb como entrada digital
	MOVLW       255
	MOVWF       TRISB+0 
;I2CEEPROMExterna.c,55 :: 		PORTB = 0xFF; // Inicia todo o portb em High
	MOVLW       255
	MOVWF       PORTB+0 
;I2CEEPROMExterna.c,58 :: 		I2C1_Init(100000);         // initialize I2C communication
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;I2CEEPROMExterna.c,59 :: 		I2C1_Start();              // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;I2CEEPROMExterna.c,60 :: 		I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,61 :: 		I2C1_Wr(2);
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,63 :: 		I2C1_Stop();               // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;I2CEEPROMExterna.c,64 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	NOP
	NOP
;I2CEEPROMExterna.c,67 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;I2CEEPROMExterna.c,68 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2CEEPROMExterna.c,69 :: 		lcd_CMD(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2CEEPROMExterna.c,71 :: 		if(!enter){
	BTFSC       RB7_bit+0, 7 
	GOTO        L_main1
;I2CEEPROMExterna.c,73 :: 		leitura_EEPROM();
	CALL        _leitura_EEPROM+0, 0
;I2CEEPROMExterna.c,74 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
	NOP
;I2CEEPROMExterna.c,76 :: 		} // end if enter
L_main1:
;I2CEEPROMExterna.c,79 :: 		while(1){
L_main3:
;I2CEEPROMExterna.c,81 :: 		if(!mais) flagMais = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_main5
	MOVLW       1
	MOVWF       _flagMais+0 
L_main5:
;I2CEEPROMExterna.c,82 :: 		if(!menos) flagMenos = 0x01;
	BTFSC       RB5_bit+0, 5 
	GOTO        L_main6
	MOVLW       1
	MOVWF       _flagMenos+0 
L_main6:
;I2CEEPROMExterna.c,83 :: 		if(!enter) flagEnter = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_main7
	MOVLW       1
	MOVWF       _flagEnter+0 
L_main7:
;I2CEEPROMExterna.c,85 :: 		if(mais && flagMais){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_main10
	MOVF        _flagMais+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
L__main21:
;I2CEEPROMExterna.c,87 :: 		flagMais = 0x00;
	CLRF        _flagMais+0 
;I2CEEPROMExterna.c,88 :: 		cont++;
	INCF        _cont+0, 1 
;I2CEEPROMExterna.c,90 :: 		} // end if mais && flagMais
L_main10:
;I2CEEPROMExterna.c,92 :: 		if(menos && flagMenos){
	BTFSS       RB5_bit+0, 5 
	GOTO        L_main13
	MOVF        _flagMenos+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
L__main20:
;I2CEEPROMExterna.c,94 :: 		flagMenos = 0x00;
	CLRF        _flagMenos+0 
;I2CEEPROMExterna.c,95 :: 		cont--;
	DECF        _cont+0, 1 
;I2CEEPROMExterna.c,97 :: 		} // end if mais && flagMais
L_main13:
;I2CEEPROMExterna.c,99 :: 		if(enter && flagEnter){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_main16
	MOVF        _flagEnter+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
L__main19:
;I2CEEPROMExterna.c,101 :: 		flagEnter = 0x00;
	CLRF        _flagEnter+0 
;I2CEEPROMExterna.c,102 :: 		escrita_EEPROM(cont);
	MOVF        _cont+0, 0 
	MOVWF       FARG_escrita_EEPROM_info+0 
	CALL        _escrita_EEPROM+0, 0
;I2CEEPROMExterna.c,103 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	NOP
	NOP
;I2CEEPROMExterna.c,105 :: 		} // end if mais && flagMais
L_main16:
;I2CEEPROMExterna.c,107 :: 		IntToSTR(cont, txt);
	MOVF        _cont+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;I2CEEPROMExterna.c,109 :: 		lcd_out(1, 5, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2CEEPROMExterna.c,111 :: 		} // end loop infinito
	GOTO        L_main3
;I2CEEPROMExterna.c,113 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_EEPROM:

;I2CEEPROMExterna.c,115 :: 		void leitura_EEPROM(){
;I2CEEPROMExterna.c,117 :: 		I2C1_Start();              // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;I2CEEPROMExterna.c,118 :: 		I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,119 :: 		I2C1_Wr(2);                // send byte (data address)
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,120 :: 		I2C1_Repeated_Start();     // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;I2CEEPROMExterna.c,121 :: 		I2C1_Wr(0xA3);             // send byte (device address + R)
	MOVLW       163
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,122 :: 		memoria = I2C1_Rd(0u);       // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _memoria+0 
;I2CEEPROMExterna.c,123 :: 		I2C1_Stop();               // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;I2CEEPROMExterna.c,125 :: 		cont = memoria;
	MOVF        _memoria+0, 0 
	MOVWF       _cont+0 
;I2CEEPROMExterna.c,127 :: 		} // end void leitura_EEPROM
	RETURN      0
; end of _leitura_EEPROM

_escrita_EEPROM:

;I2CEEPROMExterna.c,129 :: 		void escrita_EEPROM(unsigned short info){
;I2CEEPROMExterna.c,131 :: 		I2C1_Init(100000);         // initialize I2C communication
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;I2CEEPROMExterna.c,132 :: 		I2C1_Start();              // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;I2CEEPROMExterna.c,133 :: 		I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,134 :: 		I2C1_Wr(2);                // send byte (address of EEPROM location)
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,135 :: 		I2C1_Wr(info);             // send data (data to be written)
	MOVF        FARG_escrita_EEPROM_info+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CEEPROMExterna.c,136 :: 		I2C1_Stop();               // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;I2CEEPROMExterna.c,138 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_escrita_EEPROM18:
	DECFSZ      R13, 1, 1
	BRA         L_escrita_EEPROM18
	DECFSZ      R12, 1, 1
	BRA         L_escrita_EEPROM18
	NOP
	NOP
;I2CEEPROMExterna.c,140 :: 		} // end void escrita_EEPROM
	RETURN      0
; end of _escrita_EEPROM

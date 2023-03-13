
_main:

;I2CSimples.c,31 :: 		void main() {
;I2CSimples.c,33 :: 		TRISB = 0x00; // Configura todo o portb como saída digital
	CLRF        TRISB+0 
;I2CSimples.c,34 :: 		PORTB = 0x00; // Inicia todo o portb em Low
	CLRF        PORTB+0 
;I2CSimples.c,36 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;I2CSimples.c,37 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2CSimples.c,38 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;I2CSimples.c,40 :: 		I2C1_Init(100000);         // initialize I2C communication
	MOVLW       10
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;I2CSimples.c,41 :: 		I2C1_Start();              // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;I2CSimples.c,42 :: 		I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,43 :: 		I2C1_Wr(2);                // send byte (address of EEPROM location)
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,44 :: 		I2C1_Wr(0xAB);             // send data (data to be written)
	MOVLW       171
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,45 :: 		I2C1_Stop();               // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;I2CSimples.c,47 :: 		Delay_100ms();
	CALL        _Delay_100ms+0, 0
;I2CSimples.c,49 :: 		I2C1_Start();              // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;I2CSimples.c,50 :: 		I2C1_Wr(0xA2);             // send byte via I2C  (device address + W)
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,51 :: 		I2C1_Wr(2);                // send byte (data address)
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,52 :: 		I2C1_Repeated_Start();     // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;I2CSimples.c,53 :: 		I2C1_Wr(0xA3);             // send byte (device address + R)
	MOVLW       163
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;I2CSimples.c,54 :: 		info = I2C1_Rd(0u);       // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _info+0 
;I2CSimples.c,55 :: 		I2C1_Stop();               // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;I2CSimples.c,57 :: 		IntToStr(info, txt);
	MOVF        _info+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;I2CSimples.c,59 :: 		lcd_out(1, 7, txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;I2CSimples.c,60 :: 		}
	GOTO        $+0
; end of _main

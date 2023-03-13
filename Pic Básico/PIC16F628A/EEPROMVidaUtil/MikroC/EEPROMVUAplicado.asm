
_main:

;EEPROMVUAplicado.c,18 :: 		void main() {
;EEPROMVUAplicado.c,20 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;EEPROMVUAplicado.c,21 :: 		TRISA = 0x03;
	MOVLW      3
	MOVWF      TRISA+0
;EEPROMVUAplicado.c,22 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;EEPROMVUAplicado.c,23 :: 		PORTA = 0x03;
	MOVLW      3
	MOVWF      PORTA+0
;EEPROMVUAplicado.c,24 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;EEPROMVUAplicado.c,26 :: 		ultimoDado = ultimoGravado();
	CALL       _ultimoGravado+0
	MOVF       R0+0, 0
	MOVWF      _ultimoDado+0
	MOVF       R0+1, 0
	MOVWF      _ultimoDado+1
;EEPROMVUAplicado.c,28 :: 		soma = ultimoDado;
	MOVF       R0+0, 0
	MOVWF      _soma+0
	MOVF       R0+1, 0
	MOVWF      _soma+1
;EEPROMVUAplicado.c,29 :: 		PORTB = display[soma];
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;EEPROMVUAplicado.c,31 :: 		while(1){
L_main0:
;EEPROMVUAplicado.c,33 :: 		if(s1 == 0){
	BTFSC      RA0_bit+0, 0
	GOTO       L_main2
;EEPROMVUAplicado.c,34 :: 		anodo = display[soma];
	MOVF       _soma+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _anodo+0
;EEPROMVUAplicado.c,36 :: 		PORTB = anodo;
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;EEPROMVUAplicado.c,38 :: 		soma++;
	INCF       _soma+0, 1
	BTFSC      STATUS+0, 2
	INCF       _soma+1, 1
;EEPROMVUAplicado.c,40 :: 		if(soma > 9){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _soma+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVF       _soma+0, 0
	SUBLW      9
L__main31:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;EEPROMVUAplicado.c,41 :: 		ajudai = 9;
	MOVLW      9
	MOVWF      _ajudai+0
	MOVLW      0
	MOVWF      _ajudai+1
;EEPROMVUAplicado.c,42 :: 		soma = 0;
	CLRF       _soma+0
	CLRF       _soma+1
;EEPROMVUAplicado.c,43 :: 		}
L_main3:
;EEPROMVUAplicado.c,45 :: 		delay_ms(250);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;EEPROMVUAplicado.c,46 :: 		}
L_main2:
;EEPROMVUAplicado.c,48 :: 		if(s2 == 0){
	BTFSC      RA1_bit+0, 1
	GOTO       L_main5
;EEPROMVUAplicado.c,49 :: 		if(ajudai == 9){
	MOVLW      0
	XORWF      _ajudai+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVLW      9
	XORWF      _ajudai+0, 0
L__main32:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;EEPROMVUAplicado.c,50 :: 		salvaMemoria(9);
	MOVLW      9
	MOVWF      FARG_salvaMemoria_dado+0
	CALL       _salvaMemoria+0
;EEPROMVUAplicado.c,51 :: 		ajudai = 0;
	CLRF       _ajudai+0
	CLRF       _ajudai+1
;EEPROMVUAplicado.c,52 :: 		}
	GOTO       L_main7
L_main6:
;EEPROMVUAplicado.c,54 :: 		salvaMemoria(soma-1);
	DECF       _soma+0, 0
	MOVWF      FARG_salvaMemoria_dado+0
	CALL       _salvaMemoria+0
L_main7:
;EEPROMVUAplicado.c,56 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	NOP
	NOP
;EEPROMVUAplicado.c,57 :: 		}
L_main5:
;EEPROMVUAplicado.c,60 :: 		}
	GOTO       L_main0
;EEPROMVUAplicado.c,62 :: 		}
	GOTO       $+0
; end of _main

_varreduraMemoria:

;EEPROMVUAplicado.c,64 :: 		unsigned int varreduraMemoria(){
;EEPROMVUAplicado.c,68 :: 		unsigned int cont = 0;
	CLRF       varreduraMemoria_cont_L0+0
	CLRF       varreduraMemoria_cont_L0+1
;EEPROMVUAplicado.c,70 :: 		for(i=0; i <= 128; i++){
	CLRF       varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
L_varreduraMemoria9:
	MOVF       varreduraMemoria_i_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria33
	MOVF       varreduraMemoria_i_L0+0, 0
	SUBLW      128
L__varreduraMemoria33:
	BTFSS      STATUS+0, 0
	GOTO       L_varreduraMemoria10
;EEPROMVUAplicado.c,72 :: 		if(i < 128){
	MOVLW      0
	SUBWF      varreduraMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria34
	MOVLW      128
	SUBWF      varreduraMemoria_i_L0+0, 0
L__varreduraMemoria34:
	BTFSC      STATUS+0, 0
	GOTO       L_varreduraMemoria12
;EEPROMVUAplicado.c,73 :: 		end = EEPROM_Read(i);
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
;EEPROMVUAplicado.c,75 :: 		if(end == 0xFF){
	MOVF       R0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria13
;EEPROMVUAplicado.c,76 :: 		if(i == 0){
	MOVLW      0
	XORWF      varreduraMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria35
	MOVLW      0
	XORWF      varreduraMemoria_i_L0+0, 0
L__varreduraMemoria35:
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria14
;EEPROMVUAplicado.c,77 :: 		aux = i;
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_i_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
;EEPROMVUAplicado.c,78 :: 		i = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
;EEPROMVUAplicado.c,79 :: 		}
	GOTO       L_varreduraMemoria15
L_varreduraMemoria14:
;EEPROMVUAplicado.c,80 :: 		else if(i == 127){
	MOVLW      0
	XORWF      varreduraMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria36
	MOVLW      127
	XORWF      varreduraMemoria_i_L0+0, 0
L__varreduraMemoria36:
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria16
;EEPROMVUAplicado.c,81 :: 		aux = i;
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_i_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
;EEPROMVUAplicado.c,82 :: 		i = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
;EEPROMVUAplicado.c,83 :: 		}
	GOTO       L_varreduraMemoria17
L_varreduraMemoria16:
;EEPROMVUAplicado.c,84 :: 		else if(EEPROM_Read(i+1) == 0xFF){
	INCF       varreduraMemoria_i_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria18
;EEPROMVUAplicado.c,85 :: 		aux = i;
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_i_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
;EEPROMVUAplicado.c,86 :: 		i = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
;EEPROMVUAplicado.c,87 :: 		}
L_varreduraMemoria18:
L_varreduraMemoria17:
L_varreduraMemoria15:
;EEPROMVUAplicado.c,88 :: 		}
L_varreduraMemoria13:
;EEPROMVUAplicado.c,89 :: 		}
	GOTO       L_varreduraMemoria19
L_varreduraMemoria12:
;EEPROMVUAplicado.c,91 :: 		cont = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_cont_L0+0
	CLRF       varreduraMemoria_cont_L0+1
L_varreduraMemoria19:
;EEPROMVUAplicado.c,70 :: 		for(i=0; i <= 128; i++){
	INCF       varreduraMemoria_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       varreduraMemoria_i_L0+1, 1
;EEPROMVUAplicado.c,92 :: 		}
	GOTO       L_varreduraMemoria9
L_varreduraMemoria10:
;EEPROMVUAplicado.c,94 :: 		if(cont == 128)
	MOVLW      0
	XORWF      varreduraMemoria_cont_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria37
	MOVLW      128
	XORWF      varreduraMemoria_cont_L0+0, 0
L__varreduraMemoria37:
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria20
;EEPROMVUAplicado.c,95 :: 		aux = cont;
	MOVF       varreduraMemoria_cont_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_cont_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
L_varreduraMemoria20:
;EEPROMVUAplicado.c,97 :: 		return aux;
	MOVF       varreduraMemoria_aux_L0+0, 0
	MOVWF      R0+0
	MOVF       varreduraMemoria_aux_L0+1, 0
	MOVWF      R0+1
;EEPROMVUAplicado.c,98 :: 		}
	RETURN
; end of _varreduraMemoria

_salvaMemoria:

;EEPROMVUAplicado.c,100 :: 		void salvaMemoria(unsigned char dado){
;EEPROMVUAplicado.c,104 :: 		end = varreduraMemoria();    // Recebe o ultimo endereço gravado
	CALL       _varreduraMemoria+0
	MOVF       R0+0, 0
	MOVWF      salvaMemoria_end_L0+0
	MOVF       R0+1, 0
	MOVWF      salvaMemoria_end_L0+1
;EEPROMVUAplicado.c,106 :: 		if(end == 128){
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__salvaMemoria38
	MOVLW      128
	XORWF      R0+0, 0
L__salvaMemoria38:
	BTFSS      STATUS+0, 2
	GOTO       L_salvaMemoria21
;EEPROMVUAplicado.c,107 :: 		apagaMemoria();
	CALL       _apagaMemoria+0
;EEPROMVUAplicado.c,108 :: 		end = 0;
	CLRF       salvaMemoria_end_L0+0
	CLRF       salvaMemoria_end_L0+1
;EEPROMVUAplicado.c,109 :: 		}
L_salvaMemoria21:
;EEPROMVUAplicado.c,111 :: 		EEPROM_Write(end, dado); // grava o dado no endereço
	MOVF       salvaMemoria_end_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_salvaMemoria_dado+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;EEPROMVUAplicado.c,113 :: 		delay_ms(25);  // Tempo de gravação
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_salvaMemoria22:
	DECFSZ     R13+0, 1
	GOTO       L_salvaMemoria22
	DECFSZ     R12+0, 1
	GOTO       L_salvaMemoria22
	NOP
;EEPROMVUAplicado.c,114 :: 		}
	RETURN
; end of _salvaMemoria

_apagaMemoria:

;EEPROMVUAplicado.c,116 :: 		void apagaMemoria(){
;EEPROMVUAplicado.c,120 :: 		for(i=0; i < 128; i++){
	CLRF       apagaMemoria_i_L0+0
	CLRF       apagaMemoria_i_L0+1
L_apagaMemoria23:
	MOVLW      0
	SUBWF      apagaMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__apagaMemoria39
	MOVLW      128
	SUBWF      apagaMemoria_i_L0+0, 0
L__apagaMemoria39:
	BTFSC      STATUS+0, 0
	GOTO       L_apagaMemoria24
;EEPROMVUAplicado.c,121 :: 		EEPROM_Write(i, 0xFF);
	MOVF       apagaMemoria_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      255
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;EEPROMVUAplicado.c,122 :: 		delay_ms(25);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_apagaMemoria26:
	DECFSZ     R13+0, 1
	GOTO       L_apagaMemoria26
	DECFSZ     R12+0, 1
	GOTO       L_apagaMemoria26
	NOP
;EEPROMVUAplicado.c,120 :: 		for(i=0; i < 128; i++){
	INCF       apagaMemoria_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       apagaMemoria_i_L0+1, 1
;EEPROMVUAplicado.c,123 :: 		}
	GOTO       L_apagaMemoria23
L_apagaMemoria24:
;EEPROMVUAplicado.c,124 :: 		}
	RETURN
; end of _apagaMemoria

_ultimoGravado:

;EEPROMVUAplicado.c,126 :: 		unsigned int ultimoGravado(){
;EEPROMVUAplicado.c,131 :: 		end = varreduraMemoria();
	CALL       _varreduraMemoria+0
	MOVF       R0+0, 0
	MOVWF      ultimoGravado_end_L0+0
	MOVF       R0+1, 0
	MOVWF      ultimoGravado_end_L0+1
;EEPROMVUAplicado.c,133 :: 		if(end == 0)
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ultimoGravado40
	MOVLW      0
	XORWF      R0+0, 0
L__ultimoGravado40:
	BTFSS      STATUS+0, 2
	GOTO       L_ultimoGravado27
;EEPROMVUAplicado.c,134 :: 		aux = 0;
	CLRF       ultimoGravado_aux_L0+0
	CLRF       ultimoGravado_aux_L0+1
	GOTO       L_ultimoGravado28
L_ultimoGravado27:
;EEPROMVUAplicado.c,135 :: 		else if(end == 128)
	MOVLW      0
	XORWF      ultimoGravado_end_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ultimoGravado41
	MOVLW      128
	XORWF      ultimoGravado_end_L0+0, 0
L__ultimoGravado41:
	BTFSS      STATUS+0, 2
	GOTO       L_ultimoGravado29
;EEPROMVUAplicado.c,136 :: 		aux = 127;
	MOVLW      127
	MOVWF      ultimoGravado_aux_L0+0
	MOVLW      0
	MOVWF      ultimoGravado_aux_L0+1
	GOTO       L_ultimoGravado30
L_ultimoGravado29:
;EEPROMVUAplicado.c,138 :: 		aux = end - 1;
	MOVLW      1
	SUBWF      ultimoGravado_end_L0+0, 0
	MOVWF      ultimoGravado_aux_L0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      ultimoGravado_end_L0+1, 0
	MOVWF      ultimoGravado_aux_L0+1
L_ultimoGravado30:
L_ultimoGravado28:
;EEPROMVUAplicado.c,140 :: 		aux = EEPROM_Read(aux);
	MOVF       ultimoGravado_aux_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ultimoGravado_aux_L0+0
	CLRF       ultimoGravado_aux_L0+1
;EEPROMVUAplicado.c,142 :: 		return aux;
	MOVF       ultimoGravado_aux_L0+0, 0
	MOVWF      R0+0
	MOVF       ultimoGravado_aux_L0+1, 0
	MOVWF      R0+1
;EEPROMVUAplicado.c,143 :: 		}
	RETURN
; end of _ultimoGravado

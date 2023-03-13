
_main:

;EEPROMVidaUtil.c,9 :: 		void main() {
;EEPROMVidaUtil.c,11 :: 		ultimoDado = ultimoGravado();
	CALL       _ultimoGravado+0
	MOVF       R0+0, 0
	MOVWF      _ultimoDado+0
	MOVF       R0+1, 0
	MOVWF      _ultimoDado+1
;EEPROMVidaUtil.c,13 :: 		while(1){
L_main0:
;EEPROMVidaUtil.c,15 :: 		salvaMemoria(8);
	MOVLW      8
	MOVWF      FARG_salvaMemoria_dado+0
	CALL       _salvaMemoria+0
;EEPROMVidaUtil.c,17 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;EEPROMVidaUtil.c,19 :: 		}
	GOTO       L_main0
;EEPROMVidaUtil.c,21 :: 		}
	GOTO       $+0
; end of _main

_varreduraMemoria:

;EEPROMVidaUtil.c,23 :: 		unsigned int varreduraMemoria(){
;EEPROMVidaUtil.c,27 :: 		unsigned int cont = 0;
	CLRF       varreduraMemoria_cont_L0+0
	CLRF       varreduraMemoria_cont_L0+1
;EEPROMVidaUtil.c,29 :: 		for(i=0; i <= 128; i++){
	CLRF       varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
L_varreduraMemoria3:
	MOVF       varreduraMemoria_i_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria23
	MOVF       varreduraMemoria_i_L0+0, 0
	SUBLW      128
L__varreduraMemoria23:
	BTFSS      STATUS+0, 0
	GOTO       L_varreduraMemoria4
;EEPROMVidaUtil.c,31 :: 		if(i < 128){
	MOVLW      0
	SUBWF      varreduraMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria24
	MOVLW      128
	SUBWF      varreduraMemoria_i_L0+0, 0
L__varreduraMemoria24:
	BTFSC      STATUS+0, 0
	GOTO       L_varreduraMemoria6
;EEPROMVidaUtil.c,32 :: 		end = EEPROM_Read(i);
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
;EEPROMVidaUtil.c,34 :: 		if(end == 0xFF){
	MOVF       R0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria7
;EEPROMVidaUtil.c,35 :: 		if(i == 0){
	MOVLW      0
	XORWF      varreduraMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria25
	MOVLW      0
	XORWF      varreduraMemoria_i_L0+0, 0
L__varreduraMemoria25:
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria8
;EEPROMVidaUtil.c,36 :: 		aux = i;
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_i_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
;EEPROMVidaUtil.c,37 :: 		i = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
;EEPROMVidaUtil.c,38 :: 		}
	GOTO       L_varreduraMemoria9
L_varreduraMemoria8:
;EEPROMVidaUtil.c,39 :: 		else if(i == 127){
	MOVLW      0
	XORWF      varreduraMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria26
	MOVLW      127
	XORWF      varreduraMemoria_i_L0+0, 0
L__varreduraMemoria26:
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria10
;EEPROMVidaUtil.c,40 :: 		aux = i;
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_i_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
;EEPROMVidaUtil.c,41 :: 		i = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
;EEPROMVidaUtil.c,42 :: 		}
	GOTO       L_varreduraMemoria11
L_varreduraMemoria10:
;EEPROMVidaUtil.c,43 :: 		else if(EEPROM_Read(i+1) == 0xFF){
	INCF       varreduraMemoria_i_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria12
;EEPROMVidaUtil.c,44 :: 		aux = i;
	MOVF       varreduraMemoria_i_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_i_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
;EEPROMVidaUtil.c,45 :: 		i = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_i_L0+0
	CLRF       varreduraMemoria_i_L0+1
;EEPROMVidaUtil.c,46 :: 		}
L_varreduraMemoria12:
L_varreduraMemoria11:
L_varreduraMemoria9:
;EEPROMVidaUtil.c,47 :: 		}
L_varreduraMemoria7:
;EEPROMVidaUtil.c,48 :: 		}
	GOTO       L_varreduraMemoria13
L_varreduraMemoria6:
;EEPROMVidaUtil.c,50 :: 		cont = 128;
	MOVLW      128
	MOVWF      varreduraMemoria_cont_L0+0
	CLRF       varreduraMemoria_cont_L0+1
L_varreduraMemoria13:
;EEPROMVidaUtil.c,29 :: 		for(i=0; i <= 128; i++){
	INCF       varreduraMemoria_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       varreduraMemoria_i_L0+1, 1
;EEPROMVidaUtil.c,51 :: 		}
	GOTO       L_varreduraMemoria3
L_varreduraMemoria4:
;EEPROMVidaUtil.c,53 :: 		if(cont == 128)
	MOVLW      0
	XORWF      varreduraMemoria_cont_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__varreduraMemoria27
	MOVLW      128
	XORWF      varreduraMemoria_cont_L0+0, 0
L__varreduraMemoria27:
	BTFSS      STATUS+0, 2
	GOTO       L_varreduraMemoria14
;EEPROMVidaUtil.c,54 :: 		aux = cont;
	MOVF       varreduraMemoria_cont_L0+0, 0
	MOVWF      varreduraMemoria_aux_L0+0
	MOVF       varreduraMemoria_cont_L0+1, 0
	MOVWF      varreduraMemoria_aux_L0+1
L_varreduraMemoria14:
;EEPROMVidaUtil.c,56 :: 		return aux;
	MOVF       varreduraMemoria_aux_L0+0, 0
	MOVWF      R0+0
	MOVF       varreduraMemoria_aux_L0+1, 0
	MOVWF      R0+1
;EEPROMVidaUtil.c,57 :: 		}
	RETURN
; end of _varreduraMemoria

_salvaMemoria:

;EEPROMVidaUtil.c,59 :: 		void salvaMemoria(unsigned char dado){
;EEPROMVidaUtil.c,63 :: 		end = varreduraMemoria();    // Recebe o ultimo endereço gravado
	CALL       _varreduraMemoria+0
	MOVF       R0+0, 0
	MOVWF      salvaMemoria_end_L0+0
	MOVF       R0+1, 0
	MOVWF      salvaMemoria_end_L0+1
;EEPROMVidaUtil.c,65 :: 		if(end == 128){
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__salvaMemoria28
	MOVLW      128
	XORWF      R0+0, 0
L__salvaMemoria28:
	BTFSS      STATUS+0, 2
	GOTO       L_salvaMemoria15
;EEPROMVidaUtil.c,66 :: 		apagaMemoria();
	CALL       _apagaMemoria+0
;EEPROMVidaUtil.c,67 :: 		end = 0;
	CLRF       salvaMemoria_end_L0+0
	CLRF       salvaMemoria_end_L0+1
;EEPROMVidaUtil.c,68 :: 		}
L_salvaMemoria15:
;EEPROMVidaUtil.c,70 :: 		EEPROM_Write(end, dado); // grava o dado no endereço
	MOVF       salvaMemoria_end_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_salvaMemoria_dado+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;EEPROMVidaUtil.c,72 :: 		delay_ms(25);  // Tempo de gravação
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_salvaMemoria16:
	DECFSZ     R13+0, 1
	GOTO       L_salvaMemoria16
	DECFSZ     R12+0, 1
	GOTO       L_salvaMemoria16
	NOP
;EEPROMVidaUtil.c,73 :: 		}
	RETURN
; end of _salvaMemoria

_apagaMemoria:

;EEPROMVidaUtil.c,75 :: 		void apagaMemoria(){
;EEPROMVidaUtil.c,79 :: 		for(i=0; i < 128; i++){
	CLRF       apagaMemoria_i_L0+0
	CLRF       apagaMemoria_i_L0+1
L_apagaMemoria17:
	MOVLW      0
	SUBWF      apagaMemoria_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__apagaMemoria29
	MOVLW      128
	SUBWF      apagaMemoria_i_L0+0, 0
L__apagaMemoria29:
	BTFSC      STATUS+0, 0
	GOTO       L_apagaMemoria18
;EEPROMVidaUtil.c,80 :: 		EEPROM_Write(i, 0xFF);
	MOVF       apagaMemoria_i_L0+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVLW      255
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;EEPROMVidaUtil.c,81 :: 		delay_ms(25);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_apagaMemoria20:
	DECFSZ     R13+0, 1
	GOTO       L_apagaMemoria20
	DECFSZ     R12+0, 1
	GOTO       L_apagaMemoria20
	NOP
;EEPROMVidaUtil.c,79 :: 		for(i=0; i < 128; i++){
	INCF       apagaMemoria_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       apagaMemoria_i_L0+1, 1
;EEPROMVidaUtil.c,82 :: 		}
	GOTO       L_apagaMemoria17
L_apagaMemoria18:
;EEPROMVidaUtil.c,83 :: 		}
	RETURN
; end of _apagaMemoria

_ultimoGravado:

;EEPROMVidaUtil.c,85 :: 		unsigned int ultimoGravado(){
;EEPROMVidaUtil.c,90 :: 		end = varreduraMemoria();
	CALL       _varreduraMemoria+0
	MOVF       R0+0, 0
	MOVWF      ultimoGravado_end_L0+0
	MOVF       R0+1, 0
	MOVWF      ultimoGravado_end_L0+1
;EEPROMVidaUtil.c,92 :: 		if(end == 128)
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ultimoGravado30
	MOVLW      128
	XORWF      R0+0, 0
L__ultimoGravado30:
	BTFSS      STATUS+0, 2
	GOTO       L_ultimoGravado21
;EEPROMVidaUtil.c,93 :: 		aux = 127;
	MOVLW      127
	MOVWF      ultimoGravado_aux_L0+0
	MOVLW      0
	MOVWF      ultimoGravado_aux_L0+1
	GOTO       L_ultimoGravado22
L_ultimoGravado21:
;EEPROMVidaUtil.c,95 :: 		aux = end - 1;
	MOVLW      1
	SUBWF      ultimoGravado_end_L0+0, 0
	MOVWF      ultimoGravado_aux_L0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      ultimoGravado_end_L0+1, 0
	MOVWF      ultimoGravado_aux_L0+1
L_ultimoGravado22:
;EEPROMVidaUtil.c,97 :: 		return aux;
	MOVF       ultimoGravado_aux_L0+0, 0
	MOVWF      R0+0
	MOVF       ultimoGravado_aux_L0+1, 0
	MOVWF      R0+1
;EEPROMVidaUtil.c,98 :: 		}
	RETURN
; end of _ultimoGravado


_main:

;EEPROMSimples.c,13 :: 		void main() {
;EEPROMSimples.c,15 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;EEPROMSimples.c,16 :: 		TRISA = 0x03; // Seleciona RA0 e RA1 como entradas digitais e o resto como saída digital
	MOVLW      3
	MOVWF      TRISA+0
;EEPROMSimples.c,17 :: 		TRISB = 0x00; // Seleciona todo portb como saída digital
	CLRF       TRISB+0
;EEPROMSimples.c,18 :: 		PORTA = 0x03; // Inicia RA0 e RA1 em nível alto, e o resto em nível baixo
	MOVLW      3
	MOVWF      PORTA+0
;EEPROMSimples.c,19 :: 		PORTB = 0x00; // Inicia todo o portb com nível lógico baixo
	CLRF       PORTB+0
;EEPROMSimples.c,21 :: 		cont = EEPROM_Read(0x00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _cont+0
	CLRF       _cont+1
;EEPROMSimples.c,23 :: 		while(1){
L_main0:
;EEPROMSimples.c,25 :: 		contador();
	CALL       _contador+0
;EEPROMSimples.c,27 :: 		if(!s2){
	BTFSC      RA1_bit+0, 1
	GOTO       L_main2
;EEPROMSimples.c,28 :: 		escreveMemoria();
	CALL       _escreveMemoria+0
;EEPROMSimples.c,30 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;EEPROMSimples.c,31 :: 		}
L_main2:
;EEPROMSimples.c,33 :: 		anodo = display[cont];
	MOVF       _cont+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _anodo+0
;EEPROMSimples.c,35 :: 		PORTB = anodo;
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;EEPROMSimples.c,37 :: 		}
	GOTO       L_main0
;EEPROMSimples.c,38 :: 		}
	GOTO       $+0
; end of _main

_contador:

;EEPROMSimples.c,40 :: 		void contador(){
;EEPROMSimples.c,42 :: 		if(!s1){
	BTFSC      RA0_bit+0, 0
	GOTO       L_contador4
;EEPROMSimples.c,43 :: 		cont++;
	INCF       _cont+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cont+1, 1
;EEPROMSimples.c,45 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_contador5:
	DECFSZ     R13+0, 1
	GOTO       L_contador5
	DECFSZ     R12+0, 1
	GOTO       L_contador5
	DECFSZ     R11+0, 1
	GOTO       L_contador5
	NOP
;EEPROMSimples.c,46 :: 		}
L_contador4:
;EEPROMSimples.c,48 :: 		if(cont > 9)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cont+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__contador9
	MOVF       _cont+0, 0
	SUBLW      9
L__contador9:
	BTFSC      STATUS+0, 0
	GOTO       L_contador6
;EEPROMSimples.c,49 :: 		cont = 0;
	CLRF       _cont+0
	CLRF       _cont+1
L_contador6:
;EEPROMSimples.c,50 :: 		}
	RETURN
; end of _contador

_escreveMemoria:

;EEPROMSimples.c,52 :: 		void escreveMemoria(){
;EEPROMSimples.c,54 :: 		EEPROM_Write(0x00, cont);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       _cont+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;EEPROMSimples.c,55 :: 		delay_ms(25);
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_escreveMemoria7:
	DECFSZ     R13+0, 1
	GOTO       L_escreveMemoria7
	DECFSZ     R12+0, 1
	GOTO       L_escreveMemoria7
	NOP
;EEPROMSimples.c,57 :: 		led1 = 0x01;
	BSF        RA2_bit+0, 2
;EEPROMSimples.c,58 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_escreveMemoria8:
	DECFSZ     R13+0, 1
	GOTO       L_escreveMemoria8
	DECFSZ     R12+0, 1
	GOTO       L_escreveMemoria8
	DECFSZ     R11+0, 1
	GOTO       L_escreveMemoria8
	NOP
	NOP
;EEPROMSimples.c,59 :: 		led1 = 0x00;
	BCF        RA2_bit+0, 2
;EEPROMSimples.c,60 :: 		}
	RETURN
; end of _escreveMemoria

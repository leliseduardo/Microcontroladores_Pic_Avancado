
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SensorGeral.c,37 :: 		void interrupt(){
;SensorGeral.c,39 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;SensorGeral.c,41 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;SensorGeral.c,43 :: 		baseTempo++;
	INCF       _baseTempo+0, 1
;SensorGeral.c,45 :: 		if(baseTempo == 0x04){ // A cada 66ms x 4 = 262ms, o conversor AD é lido
	MOVF       _baseTempo+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;SensorGeral.c,47 :: 		baseTempo = 0x00;
	CLRF       _baseTempo+0
;SensorGeral.c,48 :: 		adc = adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc+0
	MOVF       R0+1, 0
	MOVWF      _adc+1
;SensorGeral.c,50 :: 		} // end if baseTempo == 0x04
L_interrupt1:
;SensorGeral.c,52 :: 		} // end T0IF_bit
L_interrupt0:
;SensorGeral.c,54 :: 		} // end void interrupt
L__interrupt21:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SensorGeral.c,56 :: 		void main() {
;SensorGeral.c,59 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;SensorGeral.c,60 :: 		ANSEL = 0x11; // Fosc/8 e configura apenas AN0 como entrada analógica
	MOVLW      17
	MOVWF      ANSEL+0
;SensorGeral.c,61 :: 		ADCON0 = 0x01; // Seleciona o canal AN0 como entrada analógica e habilita o conversor AD
	MOVLW      1
	MOVWF      ADCON0+0
;SensorGeral.c,63 :: 		INTCON = 0xA0; // Habilita interrupção global e a interrupção por overflow do timer0
	MOVLW      160
	MOVWF      INTCON+0
;SensorGeral.c,64 :: 		OPTION_REG = 0x07; // Habilita os pull-ups internos, timer0 incrementa com ciclo de maquina e configura o prescale em 1:256
	MOVLW      7
	MOVWF      OPTION_REG+0
;SensorGeral.c,65 :: 		TRISIO = 0x1F; // Ou 0b0001 1111, configura apenas GP5 como saída, o resto como entrada
	MOVLW      31
	MOVWF      TRISIO+0
;SensorGeral.c,67 :: 		saida = 0x00;
	BCF        GP5_bit+0, 5
;SensorGeral.c,70 :: 		while(1){
L_main2:
;SensorGeral.c,72 :: 		if(!digital1) pulso_Saida(0x01);
	BTFSC      GP1_bit+0, 1
	GOTO       L_main4
	MOVLW      1
	MOVWF      FARG_pulso_Saida_n+0
	MOVLW      0
	MOVWF      FARG_pulso_Saida_n+1
	CALL       _pulso_Saida+0
L_main4:
;SensorGeral.c,73 :: 		if(!digital2) pulso_Saida(0x02);
	BTFSC      GP2_bit+0, 2
	GOTO       L_main5
	MOVLW      2
	MOVWF      FARG_pulso_Saida_n+0
	MOVLW      0
	MOVWF      FARG_pulso_Saida_n+1
	CALL       _pulso_Saida+0
L_main5:
;SensorGeral.c,74 :: 		if(!digital3) pulso_Saida(0x03);
	BTFSC      GP3_bit+0, 3
	GOTO       L_main6
	MOVLW      3
	MOVWF      FARG_pulso_Saida_n+0
	MOVLW      0
	MOVWF      FARG_pulso_Saida_n+1
	CALL       _pulso_Saida+0
L_main6:
;SensorGeral.c,75 :: 		if(!digital4) pulso_Saida(0x04);
	BTFSC      GP4_bit+0, 4
	GOTO       L_main7
	MOVLW      4
	MOVWF      FARG_pulso_Saida_n+0
	MOVLW      0
	MOVWF      FARG_pulso_Saida_n+1
	CALL       _pulso_Saida+0
L_main7:
;SensorGeral.c,77 :: 		switch(adc){
	GOTO       L_main8
;SensorGeral.c,79 :: 		case 0:
L_main10:
;SensorGeral.c,80 :: 		case 512: pulso_Saida(5);
L_main11:
	MOVLW      5
	MOVWF      FARG_pulso_Saida_n+0
	MOVLW      0
	MOVWF      FARG_pulso_Saida_n+1
	CALL       _pulso_Saida+0
;SensorGeral.c,81 :: 		break;
	GOTO       L_main9
;SensorGeral.c,82 :: 		case 877:
L_main12:
;SensorGeral.c,83 :: 		case 955:
L_main13:
;SensorGeral.c,84 :: 		case 1023: pulso_Saida(6);
L_main14:
	MOVLW      6
	MOVWF      FARG_pulso_Saida_n+0
	MOVLW      0
	MOVWF      FARG_pulso_Saida_n+1
	CALL       _pulso_Saida+0
;SensorGeral.c,85 :: 		break;
	GOTO       L_main9
;SensorGeral.c,87 :: 		} // end switch adc
L_main8:
	MOVLW      0
	XORWF      _adc+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVLW      0
	XORWF      _adc+0, 0
L__main22:
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _adc+1, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      0
	XORWF      _adc+0, 0
L__main23:
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _adc+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main24
	MOVLW      109
	XORWF      _adc+0, 0
L__main24:
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _adc+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main25
	MOVLW      187
	XORWF      _adc+0, 0
L__main25:
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _adc+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVLW      255
	XORWF      _adc+0, 0
L__main26:
	BTFSC      STATUS+0, 2
	GOTO       L_main14
L_main9:
;SensorGeral.c,89 :: 		} // end Loop infinito
	GOTO       L_main2
;SensorGeral.c,91 :: 		} // end void main
	GOTO       $+0
; end of _main

_pulso_Saida:

;SensorGeral.c,94 :: 		void pulso_Saida(int n){
;SensorGeral.c,98 :: 		for(i = 0x00; i < n; i++){
	CLRF       R1+0
L_pulso_Saida15:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_pulso_Saida_n+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pulso_Saida27
	MOVF       FARG_pulso_Saida_n+0, 0
	SUBWF      R1+0, 0
L__pulso_Saida27:
	BTFSC      STATUS+0, 0
	GOTO       L_pulso_Saida16
;SensorGeral.c,100 :: 		saida = 0x01;
	BSF        GP5_bit+0, 5
;SensorGeral.c,101 :: 		delay_ms(30);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_pulso_Saida18:
	DECFSZ     R13+0, 1
	GOTO       L_pulso_Saida18
	DECFSZ     R12+0, 1
	GOTO       L_pulso_Saida18
;SensorGeral.c,102 :: 		saida = 0x00;
	BCF        GP5_bit+0, 5
;SensorGeral.c,103 :: 		delay_ms(30);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_pulso_Saida19:
	DECFSZ     R13+0, 1
	GOTO       L_pulso_Saida19
	DECFSZ     R12+0, 1
	GOTO       L_pulso_Saida19
;SensorGeral.c,98 :: 		for(i = 0x00; i < n; i++){
	INCF       R1+0, 1
;SensorGeral.c,105 :: 		} // end for i = 0x00; i < n; i++
	GOTO       L_pulso_Saida15
L_pulso_Saida16:
;SensorGeral.c,107 :: 		delay_ms(250);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_pulso_Saida20:
	DECFSZ     R13+0, 1
	GOTO       L_pulso_Saida20
	DECFSZ     R12+0, 1
	GOTO       L_pulso_Saida20
	DECFSZ     R11+0, 1
	GOTO       L_pulso_Saida20
	NOP
	NOP
;SensorGeral.c,109 :: 		} // end void pulso_Saida
	RETURN
; end of _pulso_Saida

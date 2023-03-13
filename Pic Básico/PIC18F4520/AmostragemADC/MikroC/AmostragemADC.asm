
_main:

;AmostragemADC.c,39 :: 		void main() {
;AmostragemADC.c,43 :: 		ADCON0 = 0x01; // Habilita AN0 como canal analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;AmostragemADC.c,44 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão de VSS à VDD e configura apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;AmostragemADC.c,45 :: 		ADCON2 = 0b000000110; // Configura o tempo de amostragem como 4MHz/64 e o tempo de retenção 0
	MOVLW       6
	MOVWF       ADCON2+0 
;AmostragemADC.c,49 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;AmostragemADC.c,50 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;AmostragemADC.c,51 :: 		LATB = 0x00; // Inicia todas as saídas digitais do portb em Low
	CLRF        LATB+0 
;AmostragemADC.c,55 :: 		while(1){
L_main0:
;AmostragemADC.c,57 :: 		adc = adc_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;AmostragemADC.c,59 :: 		if(adc > 512) saida = 0x01;
	MOVLW       128
	XORLW       2
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main4
	MOVF        R0, 0 
	SUBLW       0
L__main4:
	BTFSC       STATUS+0, 0 
	GOTO        L_main2
	BSF         LATB0_bit+0, 0 
	GOTO        L_main3
L_main2:
;AmostragemADC.c,61 :: 		else saida = 0x00;
	BCF         LATB0_bit+0, 0 
L_main3:
;AmostragemADC.c,62 :: 		} // end while
	GOTO        L_main0
;AmostragemADC.c,63 :: 		} // end void main
	GOTO        $+0
; end of _main

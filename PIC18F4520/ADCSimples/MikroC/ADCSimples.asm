
_main:

;ADCSimples.c,10 :: 		void main() {
;ADCSimples.c,12 :: 		INTCON2 = 0x7F; // Ou 0b0111 1111, habilita os pull-ups internos do portb
	MOVLW       127
	MOVWF       INTCON2+0 
;ADCSimples.c,13 :: 		ADCON0 = 0x01; // Configura AN0 como canal analógico e ativa o conversor AC
	MOVLW       1
	MOVWF       ADCON0+0 
;ADCSimples.c,14 :: 		ADCON1 = 0x0E; // Configura o intervalo de tensão analógica igual ao da fonte (VSS até VDD) e configura apenas AN0 como porta
	MOVLW       14
	MOVWF       ADCON1+0 
;ADCSimples.c,16 :: 		TRISA = 0xFF; // Configura todo porta como entrada. Para uma porta analógica funcionar, ela deve ser conf. como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;ADCSimples.c,17 :: 		TRISB = 0x00; // Configura todo portb como saída digital
	CLRF        TRISB+0 
;ADCSimples.c,18 :: 		LATB = 0x00; // Inicia todo o portb em Low
	CLRF        LATB+0 
;ADCSimples.c,20 :: 		while(1){
L_main0:
;ADCSimples.c,22 :: 		LATB = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       LATB+0 
;ADCSimples.c,23 :: 		} // end while
	GOTO        L_main0
;ADCSimples.c,24 :: 		} // end void main
	GOTO        $+0
; end of _main


_main:

;DetectorFrequencias.c,10 :: 		void main() {
;DetectorFrequencias.c,12 :: 		ADCON1 = 0x0F; // Configura todos os pinos que pdoeriam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;DetectorFrequencias.c,13 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;DetectorFrequencias.c,14 :: 		LATB = 0xFE; // Inicia LATB0 em Low
	MOVLW       254
	MOVWF       LATB+0 
;DetectorFrequencias.c,16 :: 		T3CON = 0x83; // Configura com 16 bits, prescale 1:1, clock externo e habilita o timer3
	MOVLW       131
	MOVWF       T3CON+0 
;DetectorFrequencias.c,18 :: 		while(1){
L_main0:
;DetectorFrequencias.c,20 :: 		if(TMR3IF_bit){
	BTFSS       TMR3IF_bit+0, 1 
	GOTO        L_main2
;DetectorFrequencias.c,22 :: 		TMR3IF_bit = 0x00;
	BCF         TMR3IF_bit+0, 1 
;DetectorFrequencias.c,24 :: 		led = ~led;
	BTG         LATB0_bit+0, 0 
;DetectorFrequencias.c,26 :: 		} // end if TMR3IF_bit
L_main2:
;DetectorFrequencias.c,30 :: 		} // end loop infinito
	GOTO        L_main0
;DetectorFrequencias.c,32 :: 		} // end void main
	GOTO        $+0
; end of _main

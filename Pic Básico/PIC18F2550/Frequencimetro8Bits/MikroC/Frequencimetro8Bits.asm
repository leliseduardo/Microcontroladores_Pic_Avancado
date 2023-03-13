
_main:

;Frequencimetro8Bits.c,19 :: 		void main() {
;Frequencimetro8Bits.c,21 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Frequencimetro8Bits.c,22 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;Frequencimetro8Bits.c,23 :: 		PORTB = 0xFE; // Inicia todas as entradas digiais em High
	MOVLW       254
	MOVWF       PORTB+0 
;Frequencimetro8Bits.c,24 :: 		LATB0_bit = 0x00; // Inicia a saída LATB0 em Low
	BCF         LATB0_bit+0, 0 
;Frequencimetro8Bits.c,25 :: 		T0CON = 0xE8; // Habilita o timer0, configura com 8 bits, incrementa pelo clock no pino T0CLK, incrementa na borda de subida, não associa
	MOVLW       232
	MOVWF       T0CON+0 
;Frequencimetro8Bits.c,27 :: 		TMR0L = 0x00;
	CLRF        TMR0L+0 
;Frequencimetro8Bits.c,30 :: 		while(1){
L_main0:
;Frequencimetro8Bits.c,32 :: 		frequencia = TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       _frequencia+0 
	MOVLW       0
	MOVWF       _frequencia+1 
;Frequencimetro8Bits.c,34 :: 		if(frequencia < 100) out = 0x01;
	MOVLW       0
	SUBWF       _frequencia+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main5
	MOVLW       100
	SUBWF       _frequencia+0, 0 
L__main5:
	BTFSC       STATUS+0, 0 
	GOTO        L_main2
	BSF         LATB0_bit+0, 0 
	GOTO        L_main3
L_main2:
;Frequencimetro8Bits.c,35 :: 		else out = 0x00;
	BCF         LATB0_bit+0, 0 
L_main3:
;Frequencimetro8Bits.c,37 :: 		TMR0L = 0x00;
	CLRF        TMR0L+0 
;Frequencimetro8Bits.c,39 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;Frequencimetro8Bits.c,41 :: 		} // end Looop infinito
	GOTO        L_main0
;Frequencimetro8Bits.c,43 :: 		} // end void main
	GOTO        $+0
; end of _main

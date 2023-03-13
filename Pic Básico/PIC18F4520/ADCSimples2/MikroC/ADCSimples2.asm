
_main:

;ADCSimples2.c,9 :: 		void main() {
;ADCSimples2.c,11 :: 		ADCON0 = 0x01; // Configura AN0 como canal analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;ADCSimples2.c,12 :: 		ADCON1 = 0x0E; // Configura os limites de tensão como os limites da fonte (VSS à VDD) e configura apenas AN0 como analógica e o
	MOVLW       14
	MOVWF       ADCON1+0 
;ADCSimples2.c,15 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;ADCSimples2.c,16 :: 		TRISB = 0x00; // Configura todo portb como saída
	CLRF        TRISB+0 
;ADCSimples2.c,17 :: 		TRISC = 0xFC; // Configura apensa RC0 e RC1 como saída
	MOVLW       252
	MOVWF       TRISC+0 
;ADCSimples2.c,18 :: 		LATB = 0x00; // Inicia todo portb em Low
	CLRF        LATB+0 
;ADCSimples2.c,19 :: 		LATC = 0x00; // Inicia RC0 e RC1 em Low
	CLRF        LATC+0 
;ADCSimples2.c,21 :: 		while(1){ // Loop infinito
L_main0:
;ADCSimples2.c,23 :: 		switch(ADC_Read(0)){
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	GOTO        L_main2
;ADCSimples2.c,25 :: 		case 0: LATB = 0b00000000; LATC = 0x00; break;
L_main4:
	CLRF        LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,26 :: 		case 100: LATB = 0b00000001; LATC = 0x00; break;
L_main5:
	MOVLW       1
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,27 :: 		case 200: LATB = 0b00000011; LATC = 0x00; break;
L_main6:
	MOVLW       3
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,28 :: 		case 300: LATB = 0b00000111; LATC = 0x00; break;
L_main7:
	MOVLW       7
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,29 :: 		case 400: LATB = 0b00001111; LATC = 0x00; break;
L_main8:
	MOVLW       15
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,30 :: 		case 500: LATB = 0b00011111; LATC = 0x00; break;
L_main9:
	MOVLW       31
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,31 :: 		case 600: LATB = 0b00111111; LATC = 0x00; break;
L_main10:
	MOVLW       63
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,32 :: 		case 700: LATB = 0b01111111; LATC = 0x00; break;
L_main11:
	MOVLW       127
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,33 :: 		case 800: LATB = 0b11111111; LATC = 0x00; break;
L_main12:
	MOVLW       255
	MOVWF       LATB+0 
	CLRF        LATC+0 
	GOTO        L_main3
;ADCSimples2.c,34 :: 		case 900: LATB = 0b11111111; LATC = 0x01; break;
L_main13:
	MOVLW       255
	MOVWF       LATB+0 
	MOVLW       1
	MOVWF       LATC+0 
	GOTO        L_main3
;ADCSimples2.c,35 :: 		case 1000: LATB = 0b11111111; LATC = 0x03; break;
L_main14:
	MOVLW       255
	MOVWF       LATB+0 
	MOVLW       3
	MOVWF       LATC+0 
	GOTO        L_main3
;ADCSimples2.c,36 :: 		} // end switch
L_main2:
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main15
	MOVLW       0
	XORWF       R0, 0 
L__main15:
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVLW       100
	XORWF       R0, 0 
L__main16:
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVLW       200
	XORWF       R0, 0 
L__main17:
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVLW       44
	XORWF       R0, 0 
L__main18:
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVLW       144
	XORWF       R0, 0 
L__main19:
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main20
	MOVLW       244
	XORWF       R0, 0 
L__main20:
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__main21
	MOVLW       88
	XORWF       R0, 0 
L__main21:
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__main22
	MOVLW       188
	XORWF       R0, 0 
L__main22:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        R1, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVLW       32
	XORWF       R0, 0 
L__main23:
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        R1, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main24
	MOVLW       132
	XORWF       R0, 0 
L__main24:
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVF        R1, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main25
	MOVLW       232
	XORWF       R0, 0 
L__main25:
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
L_main3:
;ADCSimples2.c,37 :: 		} // end loop
	GOTO        L_main0
;ADCSimples2.c,38 :: 		}
	GOTO        $+0
; end of _main

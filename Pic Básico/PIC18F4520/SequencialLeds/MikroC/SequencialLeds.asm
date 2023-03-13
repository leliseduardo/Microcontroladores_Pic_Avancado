
_main:

;SequencialLeds.c,12 :: 		void main() {
;SequencialLeds.c,14 :: 		ADCON1 = 0x0F; // Ou 0b0000 1111, que configura todas as portas que podem ser entradas analógicas, como portas digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;SequencialLeds.c,16 :: 		TRISB = 0x00; // Configura todo o portb como saída digital
	CLRF        TRISB+0 
;SequencialLeds.c,17 :: 		LATB = 0x00; // Leds iniciam desligados
	CLRF        LATB+0 
;SequencialLeds.c,19 :: 		while(1){
L_main0:
;SequencialLeds.c,21 :: 		LATB = controle; // LATB é o registrador que inicia o estado do portb. É o registrador equivalente ao PORTB da família pic 16f e 12f
	MOVF        _controle+0, 0 
	MOVWF       LATB+0 
;SequencialLeds.c,22 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;SequencialLeds.c,24 :: 		controle = controle << 0x01; // o comando << represente shift-left que, no caso, move todos os bits de cont 1(0x01) bit para esquerda
	MOVF        _controle+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       _controle+0 
;SequencialLeds.c,26 :: 		if(controle == 0x00) controle = 0x01;
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
	MOVLW       1
	MOVWF       _controle+0 
L_main3:
;SequencialLeds.c,27 :: 		}
	GOTO        L_main0
;SequencialLeds.c,28 :: 		}
	GOTO        $+0
; end of _main


_main:

;BotaoLed.c,22 :: 		void main() {
;BotaoLed.c,24 :: 		ADCON1 = 0x0F; // Configura todas as portas que podem ser analógicas, como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;BotaoLed.c,25 :: 		INTCON2 = 0x7F; // Ou 0b0111 1111, que habilita os pull-ups internos no portb
	MOVLW       127
	MOVWF       INTCON2+0 
;BotaoLed.c,27 :: 		TRISB = 0xFE; // Ou 0b1111 1110, que configura apenas RB0 como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;BotaoLed.c,29 :: 		led = 0x00;
	BCF         LATB0_bit+0, 0 
;BotaoLed.c,31 :: 		while(1){
L_main0:
;BotaoLed.c,33 :: 		if(!bot){
	BTFSC       RB1_bit+0, 1 
	GOTO        L_main2
;BotaoLed.c,35 :: 		led = 0x01;
	BSF         LATB0_bit+0, 0 
;BotaoLed.c,36 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;BotaoLed.c,37 :: 		led = 0x00;
	BCF         LATB0_bit+0, 0 
;BotaoLed.c,38 :: 		}
L_main2:
;BotaoLed.c,39 :: 		}
	GOTO        L_main0
;BotaoLed.c,40 :: 		}
	GOTO        $+0
; end of _main

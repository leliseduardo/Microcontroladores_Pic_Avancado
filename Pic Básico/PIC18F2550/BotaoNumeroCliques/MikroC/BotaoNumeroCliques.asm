
_main:

;BotaoNumeroCliques.c,14 :: 		void main() {
;BotaoNumeroCliques.c,16 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;BotaoNumeroCliques.c,17 :: 		TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;BotaoNumeroCliques.c,18 :: 		PORTB = 0xFE; // Inicia todas as entradas digiais em High
	MOVLW       254
	MOVWF       PORTB+0 
;BotaoNumeroCliques.c,19 :: 		LATB0_bit = 0x00; // Inicia a sa�da LATB0 em Low
	BCF         LATB0_bit+0, 0 
;BotaoNumeroCliques.c,20 :: 		T0CON = 0xF8; // Habilita o timer0, configura com 8 bits, incrementa pelo clock no pino T0CLK, incrementa na borda de descida, n�o associa
	MOVLW       248
	MOVWF       T0CON+0 
;BotaoNumeroCliques.c,22 :: 		TMR0L = 250; // Inicia em 250 para contagem de 6, isto �, 6 cliques do bot�o. Quando o timer0 est� configurado com 8 bits, inicia-se somente
	MOVLW       250
	MOVWF       TMR0L+0 
;BotaoNumeroCliques.c,26 :: 		while(1){
L_main0:
;BotaoNumeroCliques.c,28 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_main2
;BotaoNumeroCliques.c,30 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;BotaoNumeroCliques.c,31 :: 		TMR0L = 250;
	MOVLW       250
	MOVWF       TMR0L+0 
;BotaoNumeroCliques.c,33 :: 		out = ~out;
	BTG         LATB0_bit+0, 0 
;BotaoNumeroCliques.c,35 :: 		} // end if TMR0IF_bit
L_main2:
;BotaoNumeroCliques.c,37 :: 		} // end Looop infinito
	GOTO        L_main0
;BotaoNumeroCliques.c,39 :: 		} // end void main
	GOTO        $+0
; end of _main

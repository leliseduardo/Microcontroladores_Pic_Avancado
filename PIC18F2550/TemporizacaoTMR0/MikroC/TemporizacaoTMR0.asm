
_main:

;TemporizacaoTMR0.c,37 :: 		void main() {
;TemporizacaoTMR0.c,39 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;TemporizacaoTMR0.c,40 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;TemporizacaoTMR0.c,41 :: 		PORTB = 0xFE; // Inicia todas as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;TemporizacaoTMR0.c,42 :: 		led = 0x00; // Inicia LATB0 em Low
	BCF         LATB0_bit+0, 0 
;TemporizacaoTMR0.c,44 :: 		T0CON = 0x84; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler de 1:32
	MOVLW       132
	MOVWF       T0CON+0 
;TemporizacaoTMR0.c,45 :: 		TMR0L = 0xEE; // Inicia <TMR0H::TMR0L> para contar 31250
	MOVLW       238
	MOVWF       TMR0L+0 
;TemporizacaoTMR0.c,46 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;TemporizacaoTMR0.c,49 :: 		while(1){
L_main0:
;TemporizacaoTMR0.c,51 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_main2
;TemporizacaoTMR0.c,53 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;TemporizacaoTMR0.c,54 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;TemporizacaoTMR0.c,55 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;TemporizacaoTMR0.c,56 :: 		led = ~led;
	BTG         LATB0_bit+0, 0 
;TemporizacaoTMR0.c,58 :: 		} // end if TMR0IF_bit
L_main2:
;TemporizacaoTMR0.c,60 :: 		} // end Loop infinito
	GOTO        L_main0
;TemporizacaoTMR0.c,62 :: 		} // end void main
	GOTO        $+0
; end of _main


_interrupt:

;TMR0Simples.c,28 :: 		void interrupt(){
;TMR0Simples.c,30 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;TMR0Simples.c,32 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;TMR0Simples.c,33 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;TMR0Simples.c,35 :: 		out = ~out;
	BTG         LATB0_bit+0, 0 
;TMR0Simples.c,37 :: 		} // end TMR0IF_bit
L_interrupt0:
;TMR0Simples.c,39 :: 		} // end void interrupt
L__interrupt3:
	RETFIE      1
; end of _interrupt

_main:

;TMR0Simples.c,41 :: 		void main() {
;TMR0Simples.c,43 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser digitais como analógicos
	MOVLW       15
	MOVWF       ADCON1+0 
;TMR0Simples.c,44 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;TMR0Simples.c,45 :: 		out = 0x01; // Inicia LATB0 em Low
	BSF         LATB0_bit+0, 0 
;TMR0Simples.c,47 :: 		INTCON = 0xA0; // Habilita a interrupção global e a interrupção por overflow do timer0
	MOVLW       160
	MOVWF       INTCON+0 
;TMR0Simples.c,49 :: 		T0CON = 0xC0; // Habilita o timer0, configura com 8 bits, incrementa com ciclo de máquina e prescaler 1:2
	MOVLW       192
	MOVWF       T0CON+0 
;TMR0Simples.c,50 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;TMR0Simples.c,53 :: 		while(1){
L_main1:
;TMR0Simples.c,57 :: 		} // end loop infinito
	GOTO        L_main1
;TMR0Simples.c,59 :: 		} // end void main
	GOTO        $+0
; end of _main


_interrupt:

;PrecisaoTimers.c,21 :: 		void interrupt(){
;PrecisaoTimers.c,23 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;PrecisaoTimers.c,25 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;PrecisaoTimers.c,27 :: 		cont -= 256;
	MOVF        _cont+0, 0 
	MOVWF       R1 
	MOVF        _cont+1, 0 
	MOVWF       R2 
	MOVF        _cont+2, 0 
	MOVWF       R3 
	MOVF        _cont+3, 0 
	MOVWF       R4 
	MOVLW       0
	SUBWF       R1, 1 
	MOVLW       1
	SUBWFB      R2, 1 
	MOVLW       0
	SUBWFB      R3, 1 
	SUBWFB      R4, 1 
	MOVF        R1, 0 
	MOVWF       _cont+0 
	MOVF        R2, 0 
	MOVWF       _cont+1 
	MOVF        R3, 0 
	MOVWF       _cont+2 
	MOVF        R4, 0 
	MOVWF       _cont+3 
;PrecisaoTimers.c,29 :: 		if(cont <= 0){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt5
	MOVF        R3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt5
	MOVF        R2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt5
	MOVF        R1, 0 
	SUBLW       0
L__interrupt5:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;PrecisaoTimers.c,31 :: 		cont += 15625;
	MOVLW       9
	ADDWF       _cont+0, 1 
	MOVLW       61
	ADDWFC      _cont+1, 1 
	MOVLW       0
	ADDWFC      _cont+2, 1 
	ADDWFC      _cont+3, 1 
;PrecisaoTimers.c,33 :: 		Led = ~Led;
	BTG         LATB0_bit+0, 0 
;PrecisaoTimers.c,35 :: 		} // end if cont <=0
L_interrupt1:
;PrecisaoTimers.c,37 :: 		} // end if TMR0IF_bit
L_interrupt0:
;PrecisaoTimers.c,39 :: 		} // end void interrupt
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;PrecisaoTimers.c,41 :: 		void main() {
;PrecisaoTimers.c,45 :: 		INTCON = 0xA0; // Habilita a interrupção global e a interrupção por overflow do timer0
	MOVLW       160
	MOVWF       INTCON+0 
;PrecisaoTimers.c,48 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;PrecisaoTimers.c,49 :: 		T08BIT_bit = 0x01; // Configura o timer0 com 8 bits
	BSF         T08BIT_bit+0, 6 
;PrecisaoTimers.c,50 :: 		T0CS_bit = 0x00; // Configura o incremento do timer0 com o ciclo de máquina
	BCF         T0CS_bit+0, 5 
;PrecisaoTimers.c,51 :: 		PSA_bit = 0x00; // Associa o prescaler ao Timer0
	BCF         PSA_bit+0, 3 
;PrecisaoTimers.c,52 :: 		T0PS1_bit = 0x00; // Configura o prescaler como 1:64
	BCF         T0PS1_bit+0, 1 
;PrecisaoTimers.c,54 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;PrecisaoTimers.c,55 :: 		TRISB = 0xFE; // Configura apenas RB0_bit como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;PrecisaoTimers.c,56 :: 		PORTB = 0xFE; // Inicia as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;PrecisaoTimers.c,57 :: 		Led = 0x00; // Inicia LATB0 em Low
	BCF         LATB0_bit+0, 0 
;PrecisaoTimers.c,59 :: 		while(1); // Loop infinito apenas aguarda a interrupção
L_main2:
	GOTO        L_main2
;PrecisaoTimers.c,61 :: 		}
	GOTO        $+0
; end of _main

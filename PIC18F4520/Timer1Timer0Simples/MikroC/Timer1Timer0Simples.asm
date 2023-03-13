
_interrupt:

;Timer1Timer0Simples.c,40 :: 		void interrupt(){
;Timer1Timer0Simples.c,42 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;Timer1Timer0Simples.c,44 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;Timer1Timer0Simples.c,45 :: 		TMR1L = 0x00;
	CLRF        TMR1L+0 
;Timer1Timer0Simples.c,46 :: 		TMR1H = 0x00;
	CLRF        TMR1H+0 
;Timer1Timer0Simples.c,48 :: 		outT1 = ~outT1;
	BTG         LATB6_bit+0, 6 
;Timer1Timer0Simples.c,50 :: 		} // end if TMR1IF_bit
L_interrupt0:
;Timer1Timer0Simples.c,52 :: 		} // end void interrupt
L__interrupt4:
	RETFIE      1
; end of _interrupt

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;Timer1Timer0Simples.c,54 :: 		void interrupt_low(){
;Timer1Timer0Simples.c,56 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt_low1
;Timer1Timer0Simples.c,58 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;Timer1Timer0Simples.c,59 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer1Timer0Simples.c,60 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer1Timer0Simples.c,62 :: 		outT0 = ~outT0;
	BTG         LATB7_bit+0, 7 
;Timer1Timer0Simples.c,64 :: 		} // end if TMR0IF_bit
L_interrupt_low1:
;Timer1Timer0Simples.c,66 :: 		} // end void interrupt_low
L__interrupt_low5:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _interrupt_low

_main:

;Timer1Timer0Simples.c,69 :: 		void main() {
;Timer1Timer0Simples.c,74 :: 		IPEN_bit = 0x01; // Habilita as interrupções por nível de prioridade
	BSF         IPEN_bit+0, 7 
;Timer1Timer0Simples.c,77 :: 		INTCON = 0xE0; // Habilita a interrupção global, a interrupção por periféricos com nível de interrupção e habilita a interrupção
	MOVLW       224
	MOVWF       INTCON+0 
;Timer1Timer0Simples.c,81 :: 		TMR0IP_bit = 0x00; // Configura a interrupção do timer0 com baixa prioridade
	BCF         TMR0IP_bit+0, 2 
;Timer1Timer0Simples.c,84 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;Timer1Timer0Simples.c,85 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;Timer1Timer0Simples.c,86 :: 		T0CS_bit = 0x00; // Configura o incremento do timer0 com o ciclo de máquina
	BCF         T0CS_bit+0, 5 
;Timer1Timer0Simples.c,87 :: 		PSA_bit = 0x01; // Não associa o timer0 ao prescaler, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
	BSF         PSA_bit+0, 3 
;Timer1Timer0Simples.c,90 :: 		TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para contagem de 50000
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer1Timer0Simples.c,91 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer1Timer0Simples.c,94 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
	BSF         TMR1IE_bit+0, 0 
;Timer1Timer0Simples.c,97 :: 		T1CON = 0x81; // Configura o timer1 com 16 bits e habilita o timer1. Flags setadas: RD16 e TMR1ON
	MOVLW       129
	MOVWF       T1CON+0 
;Timer1Timer0Simples.c,100 :: 		TMR1IP_bit = 0x01; // Configura a interrupção do timer1 com alta prioridade
	BSF         TMR1IP_bit+0, 0 
;Timer1Timer0Simples.c,103 :: 		TMR1L = 0x00; // Inicia a contagem do timer1 em 0, para contagem de 65536
	CLRF        TMR1L+0 
;Timer1Timer0Simples.c,104 :: 		TMR1H = 0x00;
	CLRF        TMR1H+0 
;Timer1Timer0Simples.c,106 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Timer1Timer0Simples.c,107 :: 		TRISB = 0x3F; // Configura RB6 e RB7 como saídas digitais, o resto como entrada
	MOVLW       63
	MOVWF       TRISB+0 
;Timer1Timer0Simples.c,108 :: 		outT1 = 0x00; // Inicia LATB6 em Low
	BCF         LATB6_bit+0, 6 
;Timer1Timer0Simples.c,109 :: 		outT0 = 0x00; // Inicia LATB7 em Low
	BCF         LATB7_bit+0, 7 
;Timer1Timer0Simples.c,112 :: 		while(1){
L_main2:
;Timer1Timer0Simples.c,116 :: 		} // end while
	GOTO        L_main2
;Timer1Timer0Simples.c,118 :: 		} // end void mais
	GOTO        $+0
; end of _main


_interrupt:

;NivelPrioridadeSimples.c,38 :: 		void interrupt(){ // Função para interrupções de prioridade alta
;NivelPrioridadeSimples.c,40 :: 		if(INT1IF_bit){
	BTFSS       INT1IF_bit+0, 0 
	GOTO        L_interrupt0
;NivelPrioridadeSimples.c,42 :: 		INT1IF_bit = 0x00;
	BCF         INT1IF_bit+0, 0 
;NivelPrioridadeSimples.c,44 :: 		outInt1 = ~outInt1;
	BTG         LATB6_bit+0, 6 
;NivelPrioridadeSimples.c,46 :: 		} // end if INT1IF_bit
L_interrupt0:
;NivelPrioridadeSimples.c,48 :: 		} // end void interrupt
L__interrupt4:
	RETFIE      1
; end of _interrupt

_interrupt_low:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;NivelPrioridadeSimples.c,50 :: 		void interrupt_low(){ // Função para interrupções de prioridade baixa
;NivelPrioridadeSimples.c,52 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt_low1
;NivelPrioridadeSimples.c,54 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;NivelPrioridadeSimples.c,55 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;NivelPrioridadeSimples.c,56 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;NivelPrioridadeSimples.c,58 :: 		outT0 = ~outT0;
	BTG         LATB7_bit+0, 7 
;NivelPrioridadeSimples.c,60 :: 		} // end if TOIF_bit
L_interrupt_low1:
;NivelPrioridadeSimples.c,62 :: 		} // end void interrupt_low
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

;NivelPrioridadeSimples.c,65 :: 		void main() {
;NivelPrioridadeSimples.c,70 :: 		IPEN_bit = 0x01; // Habilita as interrupções por nível de prioridade (alta e baixa)
	BSF         IPEN_bit+0, 7 
;NivelPrioridadeSimples.c,73 :: 		INTCON = 0xE0; // Habilita a interrupção global, habilita a interrupção por nível dos periféricos e habilita a interrupção do timer0
	MOVLW       224
	MOVWF       INTCON+0 
;NivelPrioridadeSimples.c,76 :: 		INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
	BSF         INTEDG1_bit+0, 5 
;NivelPrioridadeSimples.c,77 :: 		TMR0IP_bit = 0x00; // Configura a interrupção do timer0 com baixa prioridade
	BCF         TMR0IP_bit+0, 2 
;NivelPrioridadeSimples.c,80 :: 		INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
	BSF         INT1IE_bit+0, 3 
;NivelPrioridadeSimples.c,81 :: 		INT1IP_bit = 0x01; // Configura a interrupção externa INT1 com prioridade alta
	BSF         INT1IP_bit+0, 6 
;NivelPrioridadeSimples.c,84 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;NivelPrioridadeSimples.c,85 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;NivelPrioridadeSimples.c,86 :: 		T0CS_bit = 0x00; // Configura o timer0 para incrementar através do ciclo de máquina
	BCF         T0CS_bit+0, 5 
;NivelPrioridadeSimples.c,87 :: 		PSA_bit = 0x01; // Não associa o timer0 ao prescaler, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
	BSF         PSA_bit+0, 3 
;NivelPrioridadeSimples.c,90 :: 		TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para uma contagem de 50000
	MOVLW       176
	MOVWF       TMR0L+0 
;NivelPrioridadeSimples.c,91 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;NivelPrioridadeSimples.c,93 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;NivelPrioridadeSimples.c,94 :: 		TRISB = 0x3F; // Configura RB6 e RB7 como saídas digitais, o resto como entrada
	MOVLW       63
	MOVWF       TRISB+0 
;NivelPrioridadeSimples.c,95 :: 		outInt1 = 0x00; // Inicia LATB6 em Low
	BCF         LATB6_bit+0, 6 
;NivelPrioridadeSimples.c,96 :: 		outT0 = 0x00; // Inicia LATB7 em Low
	BCF         LATB7_bit+0, 7 
;NivelPrioridadeSimples.c,99 :: 		while(1){
L_main2:
;NivelPrioridadeSimples.c,103 :: 		} // end while
	GOTO        L_main2
;NivelPrioridadeSimples.c,105 :: 		} // end void mais
	GOTO        $+0
; end of _main

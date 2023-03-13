
_interrupt:

;Timer0Simples.c,33 :: 		void interrupt(){
;Timer0Simples.c,35 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;Timer0Simples.c,37 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;Timer0Simples.c,38 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer0Simples.c,39 :: 		TMR0H = 0x03C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer0Simples.c,41 :: 		cont++;
	INCF        _cont+0, 1 
;Timer0Simples.c,43 :: 		if(cont == 0x0A){
	MOVF        _cont+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;Timer0Simples.c,45 :: 		cont = 0x00;
	CLRF        _cont+0 
;Timer0Simples.c,47 :: 		outT0 = ~outT0;
	BTG         LATB7_bit+0, 7 
;Timer0Simples.c,48 :: 		} // end if
L_interrupt1:
;Timer0Simples.c,50 :: 		} // end if
L_interrupt0:
;Timer0Simples.c,51 :: 		} // end void interrupt
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;Timer0Simples.c,53 :: 		void main() {
;Timer0Simples.c,56 :: 		INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção por overflow do timer0
	MOVLW       160
	MOVWF       INTCON+0 
;Timer0Simples.c,59 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;Timer0Simples.c,60 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16bits
	BCF         T08BIT_bit+0, 6 
;Timer0Simples.c,61 :: 		T0CS_bit = 0x00; // Configura o timer0 para incrementar com o ciclo de máquina
	BCF         T0CS_bit+0, 5 
;Timer0Simples.c,62 :: 		PSA_bit = 0x01; // Não associa o prescaler ao timer0, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
	BSF         PSA_bit+0, 3 
;Timer0Simples.c,65 :: 		TMR0L = 0xB0; // Inicia a contagem do timer0, configurado para 16its, em 15536, para uma contagem de 50.000
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer0Simples.c,66 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer0Simples.c,68 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Timer0Simples.c,69 :: 		TRISB = 0x3F; // Configura RB6 e RB7 como saídas digitais
	MOVLW       63
	MOVWF       TRISB+0 
;Timer0Simples.c,70 :: 		outP = 0x01; // Inicia LATB6 em High
	BSF         LATB6_bit+0, 6 
;Timer0Simples.c,71 :: 		outT0 = 0x00; // Inicia LATB7 em Low
	BCF         LATB7_bit+0, 7 
;Timer0Simples.c,74 :: 		while(1){
L_main2:
;Timer0Simples.c,76 :: 		outP = ~outP;
	BTG         LATB6_bit+0, 6 
;Timer0Simples.c,77 :: 		delay_ms(500);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;Timer0Simples.c,78 :: 		} // end while
	GOTO        L_main2
;Timer0Simples.c,80 :: 		} // end void main
	GOTO        $+0
; end of _main

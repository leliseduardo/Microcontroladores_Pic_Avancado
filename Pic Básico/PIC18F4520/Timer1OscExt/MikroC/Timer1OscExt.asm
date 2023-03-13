
_interrupt:

;Timer1OscExt.c,30 :: 		void interrupt(){
;Timer1OscExt.c,32 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;Timer1OscExt.c,34 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;Timer1OscExt.c,35 :: 		TMR1L = 0x0C;
	MOVLW       12
	MOVWF       TMR1L+0 
;Timer1OscExt.c,36 :: 		TMR1H = 0xFE;
	MOVLW       254
	MOVWF       TMR1H+0 
;Timer1OscExt.c,38 :: 		outT1 = ~outT1;
	BTG         LATB7_bit+0, 7 
;Timer1OscExt.c,40 :: 		} // end if TMR1IF_bit
L_interrupt0:
;Timer1OscExt.c,42 :: 		} // end void interrupt
L__interrupt3:
	RETFIE      1
; end of _interrupt

_main:

;Timer1OscExt.c,45 :: 		void main() {
;Timer1OscExt.c,49 :: 		IPEN_bit = 0x00;
	BCF         IPEN_bit+0, 7 
;Timer1OscExt.c,52 :: 		INTCON = 0xC0; // Habilita a interrupção global e a interrupção por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;Timer1OscExt.c,55 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
	BSF         TMR1IE_bit+0, 0 
;Timer1OscExt.c,58 :: 		T1CON = 0x83; // Configura o timer1 com 16 bits, habilita o timer1, configura clock síncrono e configura o incremento por clock externo
	MOVLW       131
	MOVWF       T1CON+0 
;Timer1OscExt.c,61 :: 		TMR1L = 0x0C;
	MOVLW       12
	MOVWF       TMR1L+0 
;Timer1OscExt.c,62 :: 		TMR1H = 0xFE;
	MOVLW       254
	MOVWF       TMR1H+0 
;Timer1OscExt.c,64 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Timer1OscExt.c,65 :: 		TRISB = 0x7F; // Configura apenas RB7 como saída digital, o resto como entrada, pois não serão usados
	MOVLW       127
	MOVWF       TRISB+0 
;Timer1OscExt.c,66 :: 		outT1 = 0x00; // Inicia LATB7 em Low
	BCF         LATB7_bit+0, 7 
;Timer1OscExt.c,70 :: 		while(1){
L_main1:
;Timer1OscExt.c,74 :: 		} // end while
	GOTO        L_main1
;Timer1OscExt.c,76 :: 		} // end void mais
	GOTO        $+0
; end of _main

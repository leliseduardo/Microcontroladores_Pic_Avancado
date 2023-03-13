
_interrupt:

;Timer0IntExt.c,40 :: 		void interrupt(){
;Timer0IntExt.c,42 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;Timer0IntExt.c,44 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;Timer0IntExt.c,45 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer0IntExt.c,46 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer0IntExt.c,48 :: 		cont++;
	INCF        _cont+0, 1 
;Timer0IntExt.c,50 :: 		if(cont == 0x0A){
	MOVF        _cont+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;Timer0IntExt.c,52 :: 		cont = 0x00;
	CLRF        _cont+0 
;Timer0IntExt.c,54 :: 		outT0 = ~outT0;
	BTG         LATB7_bit+0, 7 
;Timer0IntExt.c,55 :: 		} // end if
L_interrupt1:
;Timer0IntExt.c,56 :: 		} // end if
L_interrupt0:
;Timer0IntExt.c,58 :: 		if(INT1IF_bit){
	BTFSS       INT1IF_bit+0, 0 
	GOTO        L_interrupt2
;Timer0IntExt.c,60 :: 		INT1IF_bit = 0x00;
	BCF         INT1IF_bit+0, 0 
;Timer0IntExt.c,62 :: 		outInt1 = ~outInt1;
	BTG         LATB6_bit+0, 6 
;Timer0IntExt.c,63 :: 		}
L_interrupt2:
;Timer0IntExt.c,65 :: 		} // end void interrupt
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;Timer0IntExt.c,67 :: 		void main() {
;Timer0IntExt.c,71 :: 		INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção por overflow do timer0
	MOVLW       160
	MOVWF       INTCON+0 
;Timer0IntExt.c,74 :: 		INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
	BSF         INTEDG1_bit+0, 5 
;Timer0IntExt.c,77 :: 		INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
	BSF         INT1IE_bit+0, 3 
;Timer0IntExt.c,80 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;Timer0IntExt.c,81 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;Timer0IntExt.c,82 :: 		T0CS_bit = 0x00; // Configura o timer0 para incrementar a partir do ciclo de máquina
	BCF         T0CS_bit+0, 5 
;Timer0IntExt.c,83 :: 		PSA_bit = 0x01; // Não associa o prescaler ao timer0, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
	BSF         PSA_bit+0, 3 
;Timer0IntExt.c,86 :: 		TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para uma contagem de 50000
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer0IntExt.c,87 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer0IntExt.c,89 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Timer0IntExt.c,90 :: 		TRISB = 0x3F; // Ou 0b00111111, que configura LATB6 e LATB7 como saídas digitais e o resto como entrada
	MOVLW       63
	MOVWF       TRISB+0 
;Timer0IntExt.c,91 :: 		outInt1 = 0x00; // Inicia LATB6 em Low
	BCF         LATB6_bit+0, 6 
;Timer0IntExt.c,92 :: 		outT0 = 0x00; // Inicia LATB7 em Low
	BCF         LATB7_bit+0, 7 
;Timer0IntExt.c,95 :: 		while(1){
L_main3:
;Timer0IntExt.c,98 :: 		} // end while
	GOTO        L_main3
;Timer0IntExt.c,99 :: 		} // end void main
	GOTO        $+0
; end of _main

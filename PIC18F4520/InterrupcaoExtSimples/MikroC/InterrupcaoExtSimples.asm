
_interrupt:

;InterrupcaoExtSimples.c,23 :: 		void interrupt(){
;InterrupcaoExtSimples.c,25 :: 		if(INT0IF_bit){
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;InterrupcaoExtSimples.c,27 :: 		INT0IF_bit = 0x00;
	BCF         INT0IF_bit+0, 1 
;InterrupcaoExtSimples.c,29 :: 		out = ~out;
	BTG         LATB7_bit+0, 7 
;InterrupcaoExtSimples.c,30 :: 		}
L_interrupt0:
;InterrupcaoExtSimples.c,31 :: 		}
L__interrupt3:
	RETFIE      1
; end of _interrupt

_main:

;InterrupcaoExtSimples.c,33 :: 		void main() {
;InterrupcaoExtSimples.c,36 :: 		INTCON = 0x90; // Ou 0b10010000, habilita a interrupção global e habilita a interrupção externa INT0
	MOVLW       144
	MOVWF       INTCON+0 
;InterrupcaoExtSimples.c,37 :: 		INTEDG0_bit = 0x00; // Configura a interrupção externa do INT0 por borda de descida
	BCF         INTEDG0_bit+0, 6 
;InterrupcaoExtSimples.c,38 :: 		TRISB = 0x7F; // Ou 0b01111111, que configura apenas RB7 como saída digital
	MOVLW       127
	MOVWF       TRISB+0 
;InterrupcaoExtSimples.c,39 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;InterrupcaoExtSimples.c,41 :: 		out = 0x00;
	BCF         LATB7_bit+0, 7 
;InterrupcaoExtSimples.c,44 :: 		while(1){
L_main1:
;InterrupcaoExtSimples.c,47 :: 		} // end while
	GOTO        L_main1
;InterrupcaoExtSimples.c,49 :: 		} // end void mais
	GOTO        $+0
; end of _main

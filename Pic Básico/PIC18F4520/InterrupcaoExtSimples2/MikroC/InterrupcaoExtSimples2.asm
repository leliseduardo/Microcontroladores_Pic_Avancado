
_interrupt:

;InterrupcaoExtSimples2.c,17 :: 		void interrupt(){
;InterrupcaoExtSimples2.c,19 :: 		if(INT0IF_bit){
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;InterrupcaoExtSimples2.c,21 :: 		INT0IF_bit = 0x00;
	BCF         INT0IF_bit+0, 1 
;InterrupcaoExtSimples2.c,23 :: 		out0 = ~out0;
	BTG         LATB5_bit+0, 5 
;InterrupcaoExtSimples2.c,24 :: 		}
L_interrupt0:
;InterrupcaoExtSimples2.c,26 :: 		if(INT2IF_bit){
	BTFSS       INT2IF_bit+0, 1 
	GOTO        L_interrupt1
;InterrupcaoExtSimples2.c,28 :: 		INT2IF_bit = 0x00;
	BCF         INT2IF_bit+0, 1 
;InterrupcaoExtSimples2.c,30 :: 		out2 = ~out2;
	BTG         LATB7_bit+0, 7 
;InterrupcaoExtSimples2.c,31 :: 		}
L_interrupt1:
;InterrupcaoExtSimples2.c,33 :: 		if(INT1IF_bit){
	BTFSS       INT1IF_bit+0, 0 
	GOTO        L_interrupt2
;InterrupcaoExtSimples2.c,35 :: 		INT1IF_bit = 0x00;
	BCF         INT1IF_bit+0, 0 
;InterrupcaoExtSimples2.c,37 :: 		out1 = ~out1;
	BTG         LATB6_bit+0, 6 
;InterrupcaoExtSimples2.c,38 :: 		}
L_interrupt2:
;InterrupcaoExtSimples2.c,39 :: 		}
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;InterrupcaoExtSimples2.c,41 :: 		void main() {
;InterrupcaoExtSimples2.c,44 :: 		INTCON = 0x90; // Ou 0b10010000, habilita a interrupção global e habilita a interrupção externa INT0
	MOVLW       144
	MOVWF       INTCON+0 
;InterrupcaoExtSimples2.c,47 :: 		INTEDG0_bit = 0x00; // Configura a interrupção externa INT0 por borda de descida
	BCF         INTEDG0_bit+0, 6 
;InterrupcaoExtSimples2.c,48 :: 		INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
	BSF         INTEDG1_bit+0, 5 
;InterrupcaoExtSimples2.c,49 :: 		INTEDG2_bit = 0x00; // Configura a interrupção externa INT2 por borda de descida
	BCF         INTEDG2_bit+0, 4 
;InterrupcaoExtSimples2.c,52 :: 		INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
	BSF         INT1IE_bit+0, 3 
;InterrupcaoExtSimples2.c,53 :: 		INT2IE_bit = 0x01; // Habilita a interrupção externa INT2
	BSF         INT2IE_bit+0, 4 
;InterrupcaoExtSimples2.c,55 :: 		ADCON1 = 0x0F; // Configura todos os pinos que podem ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;InterrupcaoExtSimples2.c,57 :: 		TRISB = 0x1F; // Configura RB5, RB6 e RB7 como saídas digitais
	MOVLW       31
	MOVWF       TRISB+0 
;InterrupcaoExtSimples2.c,59 :: 		out0 = 0x00;
	BCF         LATB5_bit+0, 5 
;InterrupcaoExtSimples2.c,60 :: 		out1 = 0x00;
	BCF         LATB6_bit+0, 6 
;InterrupcaoExtSimples2.c,61 :: 		out2 = 0x00;
	BCF         LATB7_bit+0, 7 
;InterrupcaoExtSimples2.c,64 :: 		while(1){
L_main3:
;InterrupcaoExtSimples2.c,67 :: 		} // end while
	GOTO        L_main3
;InterrupcaoExtSimples2.c,69 :: 		} // end void main
	GOTO        $+0
; end of _main

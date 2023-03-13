
_main:

;OscInterno4ou8MHz.c,17 :: 		void main() {
;OscInterno4ou8MHz.c,19 :: 		ADCON1 = 0x0F; // Configura todas as portas que podem ser analógicas, como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;OscInterno4ou8MHz.c,20 :: 		INTCON2 = 0x7F; // Habilita os pull-ups internos do portb
	MOVLW       127
	MOVWF       INTCON2+0 
;OscInterno4ou8MHz.c,21 :: 		OSCCON = 0x70; // Ou 0b0111 0000, configura o oscilador interno para 8MHz
	MOVLW       112
	MOVWF       OSCCON+0 
;OscInterno4ou8MHz.c,23 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;OscInterno4ou8MHz.c,25 :: 		led = 0x00;
	BCF         LATB0_bit+0, 0 
;OscInterno4ou8MHz.c,27 :: 		while(1){
L_main0:
;OscInterno4ou8MHz.c,29 :: 		led = 0x01;
	BSF         LATB0_bit+0, 0 
;OscInterno4ou8MHz.c,30 :: 		osc();
	CALL        _osc+0, 0
;OscInterno4ou8MHz.c,31 :: 		led = 0x00;
	BCF         LATB0_bit+0, 0 
;OscInterno4ou8MHz.c,32 :: 		osc();
	CALL        _osc+0, 0
;OscInterno4ou8MHz.c,33 :: 		}
	GOTO        L_main0
;OscInterno4ou8MHz.c,34 :: 		}
	GOTO        $+0
; end of _main

_osc:

;OscInterno4ou8MHz.c,36 :: 		void osc(){
;OscInterno4ou8MHz.c,40 :: 		for(i = 255; i; i--){
	MOVLW       255
	MOVWF       R0 
L_osc2:
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_osc3
;OscInterno4ou8MHz.c,42 :: 		if(!bot) IRCF0_bit = ~IRCF0_bit; // Caso o botao seja pressionado, o registrador OSCCON muda de 0x70 para 0x60, mas isso é feito
	BTFSC       RB1_bit+0, 1 
	GOTO        L_osc5
	BTG         IRCF0_bit+0, 4 
L_osc5:
;OscInterno4ou8MHz.c,46 :: 		for(j = 255; j; j--);
	MOVLW       255
	MOVWF       R1 
L_osc6:
	MOVF        R1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_osc7
	DECF        R1, 1 
	GOTO        L_osc6
L_osc7:
;OscInterno4ou8MHz.c,40 :: 		for(i = 255; i; i--){
	DECF        R0, 1 
;OscInterno4ou8MHz.c,47 :: 		}
	GOTO        L_osc2
L_osc3:
;OscInterno4ou8MHz.c,48 :: 		}
	RETURN      0
; end of _osc

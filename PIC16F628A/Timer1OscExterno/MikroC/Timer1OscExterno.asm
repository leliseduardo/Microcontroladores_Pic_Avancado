
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Timer1OscExterno.c,30 :: 		void interrupt(){
;Timer1OscExterno.c,32 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt0
;Timer1OscExterno.c,34 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;Timer1OscExterno.c,35 :: 		TMR1H = 0xFE;
	MOVLW      254
	MOVWF      TMR1H+0
;Timer1OscExterno.c,36 :: 		TMR1L = 0x66;
	MOVLW      102
	MOVWF      TMR1L+0
;Timer1OscExterno.c,38 :: 		led = ~led;
	MOVLW      1
	XORWF      RB0_bit+0, 1
;Timer1OscExterno.c,39 :: 		}
L_interrupt0:
;Timer1OscExterno.c,40 :: 		}
L__interrupt3:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Timer1OscExterno.c,42 :: 		void main() {
;Timer1OscExterno.c,44 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;Timer1OscExterno.c,46 :: 		T1CON = 0x3F; // Configura o prescaler em 1:8
	MOVLW      63
	MOVWF      T1CON+0
;Timer1OscExterno.c,51 :: 		TMR1H = 0xFE; // Inicializa o TMR1 em 65126(decimal), para incrementar 410 vezes
	MOVLW      254
	MOVWF      TMR1H+0
;Timer1OscExterno.c,52 :: 		TMR1L = 0x66;
	MOVLW      102
	MOVWF      TMR1L+0
;Timer1OscExterno.c,54 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;Timer1OscExterno.c,55 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;Timer1OscExterno.c,56 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1
	BSF        TMR1IE_bit+0, 0
;Timer1OscExterno.c,58 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída
	MOVLW      254
	MOVWF      TRISB+0
;Timer1OscExterno.c,59 :: 		led = 0x00; // Inicia led em Low
	BCF        RB0_bit+0, 0
;Timer1OscExterno.c,61 :: 		while(1){
L_main1:
;Timer1OscExterno.c,64 :: 		}
	GOTO       L_main1
;Timer1OscExterno.c,65 :: 		}
	GOTO       $+0
; end of _main

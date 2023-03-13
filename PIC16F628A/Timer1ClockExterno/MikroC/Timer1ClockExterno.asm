
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Timer1ClockExterno.c,30 :: 		void interrupt(){
;Timer1ClockExterno.c,32 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt0
;Timer1ClockExterno.c,34 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;Timer1ClockExterno.c,35 :: 		TMR1H = 0xFE;
	MOVLW      254
	MOVWF      TMR1H+0
;Timer1ClockExterno.c,36 :: 		TMR1L = 0x66;
	MOVLW      102
	MOVWF      TMR1L+0
;Timer1ClockExterno.c,38 :: 		cont++;
	INCF       _cont+0, 1
;Timer1ClockExterno.c,40 :: 		if(cont == 0x03){
	MOVF       _cont+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;Timer1ClockExterno.c,42 :: 		cont = 0x00;
	CLRF       _cont+0
;Timer1ClockExterno.c,43 :: 		led = ~led;
	MOVLW      1
	XORWF      RB0_bit+0, 1
;Timer1ClockExterno.c,44 :: 		}
L_interrupt1:
;Timer1ClockExterno.c,45 :: 		}
L_interrupt0:
;Timer1ClockExterno.c,46 :: 		}
L__interrupt4:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Timer1ClockExterno.c,48 :: 		void main() {
;Timer1ClockExterno.c,50 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;Timer1ClockExterno.c,52 :: 		T1CON = 0x03; // Configura o prescaler em 1:1
	MOVLW      3
	MOVWF      T1CON+0
;Timer1ClockExterno.c,56 :: 		TMR1H = 0xFE; // Inicializa o TMR1 em 65126(decimal), para incrementar 410 vezes
	MOVLW      254
	MOVWF      TMR1H+0
;Timer1ClockExterno.c,57 :: 		TMR1L = 0x66;
	MOVLW      102
	MOVWF      TMR1L+0
;Timer1ClockExterno.c,59 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;Timer1ClockExterno.c,60 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;Timer1ClockExterno.c,61 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1
	BSF        TMR1IE_bit+0, 0
;Timer1ClockExterno.c,63 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída
	MOVLW      254
	MOVWF      TRISB+0
;Timer1ClockExterno.c,64 :: 		led = 0x00; // Inicia led em Low
	BCF        RB0_bit+0, 0
;Timer1ClockExterno.c,66 :: 		while(1){
L_main2:
;Timer1ClockExterno.c,69 :: 		}
	GOTO       L_main2
;Timer1ClockExterno.c,70 :: 		}
	GOTO       $+0
; end of _main

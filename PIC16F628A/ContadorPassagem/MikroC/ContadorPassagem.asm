
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;ContadorPassagem.c,6 :: 		void interrupt(){
;ContadorPassagem.c,8 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;ContadorPassagem.c,10 :: 		INTF_bit = 0x00;
	BCF        INTF_bit+0, 1
;ContadorPassagem.c,12 :: 		cont++;
	INCF       _cont+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cont+1, 1
;ContadorPassagem.c,13 :: 		if(cont > 9)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cont+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt5
	MOVF       _cont+0, 0
	SUBLW      9
L__interrupt5:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
;ContadorPassagem.c,14 :: 		cont = 0;
	CLRF       _cont+0
	CLRF       _cont+1
L_interrupt1:
;ContadorPassagem.c,16 :: 		escreveDisplay(cont);
	MOVF       _cont+0, 0
	MOVWF      FARG_escreveDisplay_num+0
	MOVF       _cont+1, 0
	MOVWF      FARG_escreveDisplay_num+1
	CALL       _escreveDisplay+0
;ContadorPassagem.c,17 :: 		}
L_interrupt0:
;ContadorPassagem.c,18 :: 		}
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

;ContadorPassagem.c,20 :: 		void main() {
;ContadorPassagem.c,22 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;ContadorPassagem.c,24 :: 		GIE_bit = 0x01; // Ativa a interrupção global
	BSF        GIE_bit+0, 7
;ContadorPassagem.c,25 :: 		PEIE_bit = 0x00; // Desativa a interrupção por periferios
	BCF        PEIE_bit+0, 6
;ContadorPassagem.c,26 :: 		INTE_bit = 0x01; // Ativa a interrupção externa no pino RB0/INT
	BSF        INTE_bit+0, 4
;ContadorPassagem.c,27 :: 		INTEDG_bit = 0x01;// Interrupção por borda de subida
	BSF        INTEDG_bit+0, 6
;ContadorPassagem.c,29 :: 		TRISA = 0xFF; // Ou 0b00000010, que configura apenas RA1 como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;ContadorPassagem.c,30 :: 		TRISB = 0x01; // Configura apenas RB0 como entrada digital
	MOVLW      1
	MOVWF      TRISB+0
;ContadorPassagem.c,31 :: 		PORTA = 0xFF; // Inicia apenas RA1 em high
	MOVLW      255
	MOVWF      PORTA+0
;ContadorPassagem.c,32 :: 		PORTB = 0x7F; // Ou 0b01111111, inicia o portb de tal forma que apareça zero no display
	MOVLW      127
	MOVWF      PORTB+0
;ContadorPassagem.c,35 :: 		while(1){
L_main2:
;ContadorPassagem.c,38 :: 		}
	GOTO       L_main2
;ContadorPassagem.c,39 :: 		}
	GOTO       $+0
; end of _main

_escreveDisplay:

;ContadorPassagem.c,41 :: 		void escreveDisplay(int num){
;ContadorPassagem.c,43 :: 		int anodo[] = {0x7F, 0x0D, 0xB7, 0x9F, 0xCD, 0xDB, 0xF9, 0x0F, 0xFF, 0xCF};
	MOVLW      127
	MOVWF      escreveDisplay_anodo_L0+0
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+1
	MOVLW      13
	MOVWF      escreveDisplay_anodo_L0+2
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+3
	MOVLW      183
	MOVWF      escreveDisplay_anodo_L0+4
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+5
	MOVLW      159
	MOVWF      escreveDisplay_anodo_L0+6
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+7
	MOVLW      205
	MOVWF      escreveDisplay_anodo_L0+8
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+9
	MOVLW      219
	MOVWF      escreveDisplay_anodo_L0+10
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+11
	MOVLW      249
	MOVWF      escreveDisplay_anodo_L0+12
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+13
	MOVLW      15
	MOVWF      escreveDisplay_anodo_L0+14
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+15
	MOVLW      255
	MOVWF      escreveDisplay_anodo_L0+16
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+17
	MOVLW      207
	MOVWF      escreveDisplay_anodo_L0+18
	MOVLW      0
	MOVWF      escreveDisplay_anodo_L0+19
;ContadorPassagem.c,47 :: 		aux = anodo[num];
	MOVF       FARG_escreveDisplay_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_escreveDisplay_num+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      escreveDisplay_anodo_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;ContadorPassagem.c,49 :: 		PORTB = aux;
;ContadorPassagem.c,50 :: 		}
	RETURN
; end of _escreveDisplay

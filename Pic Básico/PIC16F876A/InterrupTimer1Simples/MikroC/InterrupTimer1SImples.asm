
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;InterrupTimer1SImples.c,28 :: 		void interrupt(){
;InterrupTimer1SImples.c,29 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt0
;InterrupTimer1SImples.c,31 :: 		TMR1IF_bit = 0x00; // Zera a variável de interrupção(overflow)
	BCF        TMR1IF_bit+0, 0
;InterrupTimer1SImples.c,32 :: 		TMR1L = 0x18; // Reinicia a contagem do contador do timer1 em 64536
	MOVLW      24
	MOVWF      TMR1L+0
;InterrupTimer1SImples.c,33 :: 		TMR1H = 0xFC;
	MOVLW      252
	MOVWF      TMR1H+0
;InterrupTimer1SImples.c,35 :: 		RC4_bit = 0x00;
	BCF        RC4_bit+0, 4
;InterrupTimer1SImples.c,37 :: 		aux++;
	INCF       _aux+0, 1
;InterrupTimer1SImples.c,39 :: 		if(aux == 50){
	MOVF       _aux+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;InterrupTimer1SImples.c,41 :: 		aux = 0x00;
	CLRF       _aux+0
;InterrupTimer1SImples.c,43 :: 		RC4_bit = 0x01;
	BSF        RC4_bit+0, 4
;InterrupTimer1SImples.c,44 :: 		RC5_bit = ~RC5_bit;
	MOVLW      32
	XORWF      RC5_bit+0, 1
;InterrupTimer1SImples.c,45 :: 		}
L_interrupt1:
;InterrupTimer1SImples.c,46 :: 		}
L_interrupt0:
;InterrupTimer1SImples.c,47 :: 		}
L__interrupt2:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;InterrupTimer1SImples.c,49 :: 		void main() {
;InterrupTimer1SImples.c,51 :: 		CMCON = 0x07;  // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;InterrupTimer1SImples.c,52 :: 		T1CON = 0x31;  // Ou 0b00110001, que configura o prescaler em 1:8 e habilita o timer 1
	MOVLW      49
	MOVWF      T1CON+0
;InterrupTimer1SImples.c,53 :: 		TMR1L = 0x18;  // Inicia o contador do timer1 em 64536, para que o timer1 (de 16 bits), conte até 1000 somente
	MOVLW      24
	MOVWF      TMR1L+0
;InterrupTimer1SImples.c,54 :: 		TMR1H = 0xFC;
	MOVLW      252
	MOVWF      TMR1H+0
;InterrupTimer1SImples.c,56 :: 		GIE_bit = 0x01; // Habilita a interrupção global;
	BSF        GIE_bit+0, 7
;InterrupTimer1SImples.c,57 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;InterrupTimer1SImples.c,58 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção por overflow do timer1
	BSF        TMR1IE_bit+0, 0
;InterrupTimer1SImples.c,60 :: 		TRISC = 0xCF; // Ou 0b11001111, que configura apenas RC4 e RC5 como saídas digitais
	MOVLW      207
	MOVWF      TRISC+0
;InterrupTimer1SImples.c,61 :: 		RC4_bit = 0x00; // RC4 inicia em low
	BCF        RC4_bit+0, 4
;InterrupTimer1SImples.c,62 :: 		RC5_bit = 0x00; // RC5 inicia em low
	BCF        RC5_bit+0, 5
;InterrupTimer1SImples.c,64 :: 		}
	GOTO       $+0
; end of _main

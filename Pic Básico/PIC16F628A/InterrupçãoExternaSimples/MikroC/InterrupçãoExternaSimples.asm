
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;InterrupçãoExternaSimples.c,12 :: 		void interrupt(){
;InterrupçãoExternaSimples.c,14 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;InterrupçãoExternaSimples.c,16 :: 		INTF_bit = 0x00;
	BCF        INTF_bit+0, 1
;InterrupçãoExternaSimples.c,18 :: 		control = ~control;
	MOVLW
	XORWF      _control+0, 1
;InterrupçãoExternaSimples.c,20 :: 		ledAzul = control;
	BTFSC      _control+0, BitPos(_control+0)
	GOTO       L__interrupt7
	BCF        RA1_bit+0, 1
	GOTO       L__interrupt8
L__interrupt7:
	BSF        RA1_bit+0, 1
L__interrupt8:
;InterrupçãoExternaSimples.c,21 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_interrupt1:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt1
	DECFSZ     R12+0, 1
	GOTO       L_interrupt1
	DECFSZ     R11+0, 1
	GOTO       L_interrupt1
	NOP
	NOP
;InterrupçãoExternaSimples.c,22 :: 		}
L_interrupt0:
;InterrupçãoExternaSimples.c,23 :: 		}
L__interrupt6:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;InterrupçãoExternaSimples.c,25 :: 		void main() {
;InterrupçãoExternaSimples.c,29 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;InterrupçãoExternaSimples.c,31 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;InterrupçãoExternaSimples.c,32 :: 		PEIE_bit = 0x00; // Desabilita a interrupção por periféricos
	BCF        PEIE_bit+0, 6
;InterrupçãoExternaSimples.c,33 :: 		INTE_bit = 0x01; // Habilita a interrupção externa no pino RB0/INT
	BSF        INTE_bit+0, 4
;InterrupçãoExternaSimples.c,34 :: 		INTEDG_bit = 0x00; // Habilita a interrupção externa em borda de descida, isto é, quando o botão em RB0 descer de 5v para 0v
	BCF        INTEDG_bit+0, 6
;InterrupçãoExternaSimples.c,36 :: 		TRISA = 0xFC; // Ou 0b11111100, que configura apenas RA0 e RA1 como saídas digitais, o resto como entrada
	MOVLW      252
	MOVWF      TRISA+0
;InterrupçãoExternaSimples.c,37 :: 		TRISB = 0xFF; // Ou 0b11111111, que configura todo portb como entrada digital
	MOVLW      255
	MOVWF      TRISB+0
;InterrupçãoExternaSimples.c,38 :: 		PORTA = 0xFC; // Ou 0b11111100, que inicia apenas RA0 e RA1 cem Low, o resto em High
	MOVLW      252
	MOVWF      PORTA+0
;InterrupçãoExternaSimples.c,39 :: 		PORTB = 0xFF; // Ou 0b11111111, que inicia todo o portb em High
	MOVLW      255
	MOVWF      PORTB+0
;InterrupçãoExternaSimples.c,43 :: 		control = 0x00;
	BCF        _control+0, BitPos(_control+0)
;InterrupçãoExternaSimples.c,47 :: 		while(1){
L_main2:
;InterrupçãoExternaSimples.c,49 :: 		ledAmarelo = 0x01;
	BSF        RA0_bit+0, 0
;InterrupçãoExternaSimples.c,50 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
;InterrupçãoExternaSimples.c,51 :: 		ledAmarelo = 0x00;
	BCF        RA0_bit+0, 0
;InterrupçãoExternaSimples.c,52 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;InterrupçãoExternaSimples.c,53 :: 		}
	GOTO       L_main2
;InterrupçãoExternaSimples.c,54 :: 		}
	GOTO       $+0
; end of _main

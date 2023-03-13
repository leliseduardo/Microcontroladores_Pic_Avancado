
_main:

;SPISimples.c,13 :: 		void main() {
;SPISimples.c,15 :: 		TRISC = 0x00; // Configura todo o portc como saída digital
	CLRF        TRISC+0 
;SPISimples.c,16 :: 		LATC0_bit = 0x01; // Inicia LATC0 em High
	BSF         LATC0_bit+0, 0 
;SPISimples.c,18 :: 		SSPSTAT = 0x00;
	CLRF        SSPSTAT+0 
;SPISimples.c,19 :: 		SSPEN_bit = 0x01; // Configura o SPI como mestre e o clock em Fosc/4
	BSF         SSPEN_bit+0, 5 
;SPISimples.c,21 :: 		while(1){
L_main0:
;SPISimples.c,23 :: 		SSPBUF = cont++;
	MOVF        _cont+0, 0 
	MOVWF       SSPBUF+0 
	INCF        _cont+0, 1 
;SPISimples.c,25 :: 		delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;SPISimples.c,27 :: 		}
	GOTO        L_main0
;SPISimples.c,29 :: 		}
	GOTO        $+0
; end of _main

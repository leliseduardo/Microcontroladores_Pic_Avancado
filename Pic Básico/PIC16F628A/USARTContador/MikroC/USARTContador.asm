
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;USARTContador.c,20 :: 		void interrupt(){
;USARTContador.c,22 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;USARTContador.c,24 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;USARTContador.c,26 :: 		cont++;
	INCF       _cont+0, 1
;USARTContador.c,28 :: 		if(cont == 0x0A){ // Se cont = 10(decimal) = 0x0A. Se Overflow = 66ms, os leds alternam a cada 66ms x 10 = 660ms
	MOVF       _cont+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;USARTContador.c,30 :: 		cont = 0x00;
	CLRF       _cont+0
;USARTContador.c,31 :: 		led1 = ~led1;
	MOVLW      1
	XORWF      RA0_bit+0, 1
;USARTContador.c,32 :: 		led2 = ~led2;
	MOVLW      2
	XORWF      RA1_bit+0, 1
;USARTContador.c,33 :: 		}
L_interrupt1:
;USARTContador.c,34 :: 		}
L_interrupt0:
;USARTContador.c,35 :: 		}
L__interrupt11:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;USARTContador.c,37 :: 		void main() {
;USARTContador.c,41 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;USARTContador.c,42 :: 		OPTION_REG = 0x87; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:256, associado ao timer0
	MOVLW      135
	MOVWF      OPTION_REG+0
;USARTContador.c,43 :: 		INTCON = 0xE0; // Habilita a interrupção global, a interrupção por periféricos e habilita a interrupção pelo timer0
	MOVLW      224
	MOVWF      INTCON+0
;USARTContador.c,47 :: 		SPBRG = 0x19; // Ou 25(decimal), para um baud rate de 9600. Esse valor equivale ao cálculo para Osc 4MHz, com a USART configurada
	MOVLW      25
	MOVWF      SPBRG+0
;USARTContador.c,50 :: 		TXEN_bit = 0x01; // Habilita transmissão
	BSF        TXEN_bit+0, 5
;USARTContador.c,51 :: 		SYNC_bit = 0x00; // Configura no modo assíncrono
	BCF        SYNC_bit+0, 4
;USARTContador.c,52 :: 		BRGH_bit = 0x01; // Configura o baud rate de alta velocidade
	BSF        BRGH_bit+0, 2
;USARTContador.c,55 :: 		SPEN_bit = 0x01; // Habilita a porta serial
	BSF        SPEN_bit+0, 7
;USARTContador.c,56 :: 		CREN_bit = 0x01; // Habilita a recepção contínua
	BSF        CREN_bit+0, 4
;USARTContador.c,59 :: 		RCIE_bit = 0x01; // Habilita a interrupçâo por recepção da USART. Isto é, ocorre a interrup. quando a serial recebe dados
	BSF        RCIE_bit+0, 5
;USARTContador.c,61 :: 		RCIF_bit = 0x00; // Limpa a flag de interrupção por recepção da USART
	BCF        RCIF_bit+0, 5
;USARTContador.c,63 :: 		TRISA = 0xFC; // Configura apenas RA0 e RA1 como saídas digitais
	MOVLW      252
	MOVWF      TRISA+0
;USARTContador.c,64 :: 		TRISB = 0xFB; // Configura apenas RB2 (TX) como saída digital
	MOVLW      251
	MOVWF      TRISB+0
;USARTContador.c,65 :: 		PORTB = 0xFB; // Inicia apenas RB2 (TX) em Low
	MOVLW      251
	MOVWF      PORTB+0
;USARTContador.c,66 :: 		led1 = 0x00; // Inicia led1 (RA0) em Low
	BCF        RA0_bit+0, 0
;USARTContador.c,67 :: 		led2 = 0x01; // Inicia led2 (RA1) em High
	BSF        RA1_bit+0, 1
;USARTContador.c,69 :: 		auxBotao = 0x00;
	BCF        _auxBotao+0, BitPos(_auxBotao+0)
;USARTContador.c,71 :: 		imprimeContagem();
	CALL       _imprimeContagem+0
;USARTContador.c,73 :: 		while(1){
L_main2:
;USARTContador.c,75 :: 		if(!bot) auxBotao = 0x01;
	BTFSC      RA2_bit+0, 2
	GOTO       L_main4
	BSF        _auxBotao+0, BitPos(_auxBotao+0)
L_main4:
;USARTContador.c,77 :: 		if(bot && auxBotao){
	BTFSS      RA2_bit+0, 2
	GOTO       L_main7
	BTFSS      _auxBotao+0, BitPos(_auxBotao+0)
	GOTO       L_main7
L__main10:
;USARTContador.c,79 :: 		auxBotao = 0x00;
	BCF        _auxBotao+0, BitPos(_auxBotao+0)
;USARTContador.c,81 :: 		valor++;
	INCF       _valor+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valor+1, 1
;USARTContador.c,82 :: 		numero(valor);
	MOVF       _valor+0, 0
	MOVWF      FARG_numero_num+0
	MOVF       _valor+1, 0
	MOVWF      FARG_numero_num+1
	CALL       _numero+0
;USARTContador.c,83 :: 		}
L_main7:
;USARTContador.c,84 :: 		}
	GOTO       L_main2
;USARTContador.c,85 :: 		}
	GOTO       $+0
; end of _main

_imprimeContagem:

;USARTContador.c,87 :: 		void imprimeContagem(){
;USARTContador.c,89 :: 		TXREG = 'C';
	MOVLW      67
	MOVWF      TXREG+0
;USARTContador.c,90 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,91 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTContador.c,92 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,93 :: 		TXREG = 'n';
	MOVLW      110
	MOVWF      TXREG+0
;USARTContador.c,94 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,95 :: 		TXREG = 't';
	MOVLW      116
	MOVWF      TXREG+0
;USARTContador.c,96 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,97 :: 		TXREG = 'a';
	MOVLW      97
	MOVWF      TXREG+0
;USARTContador.c,98 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,99 :: 		TXREG = 'g';
	MOVLW      103
	MOVWF      TXREG+0
;USARTContador.c,100 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,101 :: 		TXREG = 'e';
	MOVLW      101
	MOVWF      TXREG+0
;USARTContador.c,102 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,103 :: 		TXREG = 'm';
	MOVLW      109
	MOVWF      TXREG+0
;USARTContador.c,104 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,105 :: 		TXREG = ':';
	MOVLW      58
	MOVWF      TXREG+0
;USARTContador.c,106 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,107 :: 		TXREG = texto[0];
	MOVF       _texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      TXREG+0
;USARTContador.c,108 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,109 :: 		TXREG = texto[1];
	INCF       _texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      TXREG+0
;USARTContador.c,110 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,111 :: 		TXREG = texto[2];
	MOVLW      2
	ADDWF      _texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      TXREG+0
;USARTContador.c,112 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,113 :: 		TXREG = texto[3];
	MOVLW      3
	ADDWF      _texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      TXREG+0
;USARTContador.c,114 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,115 :: 		TXREG = 0x0D;
	MOVLW      13
	MOVWF      TXREG+0
;USARTContador.c,116 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,117 :: 		TXREG = 0x0A;
	MOVLW      10
	MOVWF      TXREG+0
;USARTContador.c,118 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTContador.c,119 :: 		}
	RETURN
; end of _imprimeContagem

_bufferTeste:

;USARTContador.c,122 :: 		void bufferTeste(){
;USARTContador.c,124 :: 		while(!TRMT_bit);
L_bufferTeste8:
	BTFSC      TRMT_bit+0, 1
	GOTO       L_bufferTeste9
	GOTO       L_bufferTeste8
L_bufferTeste9:
;USARTContador.c,125 :: 		}
	RETURN
; end of _bufferTeste

_numero:

;USARTContador.c,127 :: 		void numero(int num){
;USARTContador.c,129 :: 		texto[0] = (num/1000) + '0';
	MOVF       _texto+0, 0
	MOVWF      FLOC__numero+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FARG_numero_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_numero_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__numero+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;USARTContador.c,130 :: 		texto[1] = (num%1000)/100 + '0';
	INCF       _texto+0, 0
	MOVWF      FLOC__numero+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FARG_numero_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_numero_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__numero+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;USARTContador.c,131 :: 		texto[2] = (num%100)/10 + '0';
	MOVLW      2
	ADDWF      _texto+0, 0
	MOVWF      FLOC__numero+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_numero_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_numero_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__numero+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;USARTContador.c,132 :: 		texto[3] = (num%10) + '0';
	MOVLW      3
	ADDWF      _texto+0, 0
	MOVWF      FLOC__numero+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_numero_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_numero_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__numero+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;USARTContador.c,134 :: 		imprimeContagem();
	CALL       _imprimeContagem+0
;USARTContador.c,135 :: 		}
	RETURN
; end of _numero

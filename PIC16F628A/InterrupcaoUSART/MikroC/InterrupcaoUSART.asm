
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;InterrupcaoUSART.c,63 :: 		void interrupt(){
;InterrupcaoUSART.c,65 :: 		if(RCIF_bit){
	BTFSS      RCIF_bit+0, 5
	GOTO       L_interrupt0
;InterrupcaoUSART.c,67 :: 		RCIF_bit = 0x00;
	BCF        RCIF_bit+0, 5
;InterrupcaoUSART.c,69 :: 		if(FERR_bit || OERR_bit){ // Verifica se há algum erro, se houver
	BTFSC      FERR_bit+0, 2
	GOTO       L__interrupt10
	BTFSC      OERR_bit+0, 1
	GOTO       L__interrupt10
	GOTO       L_interrupt3
L__interrupt10:
;InterrupcaoUSART.c,71 :: 		CREN_bit = 0x00; // Desabilita a recepção contínua para tentar corrigir algum erro
	BCF        CREN_bit+0, 4
;InterrupcaoUSART.c,72 :: 		CREN_bit = 0x01; // Habilita a recpção contínua novamente
	BSF        CREN_bit+0, 4
;InterrupcaoUSART.c,74 :: 		asm retfie; // Código em assembly para sair da interrupção, caso tenha sido necessário corrigir algum erro
	RETFIE
;InterrupcaoUSART.c,75 :: 		}
L_interrupt3:
;InterrupcaoUSART.c,77 :: 		eco();
	CALL       _eco+0
;InterrupcaoUSART.c,78 :: 		}
L_interrupt0:
;InterrupcaoUSART.c,80 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt4
;InterrupcaoUSART.c,82 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;InterrupcaoUSART.c,84 :: 		cont++;
	INCF       _cont+0, 1
;InterrupcaoUSART.c,86 :: 		if(cont == 0x0A){ // Se cont = 10(decimal) = 0x0A. Se Overflow = 66ms, os leds alternam a cada 66ms x 10 = 660ms
	MOVF       _cont+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;InterrupcaoUSART.c,88 :: 		cont = 0x00;
	CLRF       _cont+0
;InterrupcaoUSART.c,89 :: 		led1 = ~led1;
	MOVLW      1
	XORWF      RA0_bit+0, 1
;InterrupcaoUSART.c,90 :: 		led2 = ~led2;
	MOVLW      2
	XORWF      RA1_bit+0, 1
;InterrupcaoUSART.c,91 :: 		}
L_interrupt5:
;InterrupcaoUSART.c,92 :: 		}
L_interrupt4:
;InterrupcaoUSART.c,93 :: 		}
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

;InterrupcaoUSART.c,95 :: 		void main() {
;InterrupcaoUSART.c,99 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;InterrupcaoUSART.c,100 :: 		OPTION_REG = 0x87; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:256, associado ao timer0
	MOVLW      135
	MOVWF      OPTION_REG+0
;InterrupcaoUSART.c,101 :: 		INTCON = 0xE0; // Habilita a interrupção global, a interrupção por periféricos e habilita a interrupção pelo timer0
	MOVLW      224
	MOVWF      INTCON+0
;InterrupcaoUSART.c,105 :: 		SPBRG = 0x19; // Ou 25(decimal), para um baud rate de 9600. Esse valor equivale ao cálculo para Osc 4MHz, com a USART configurada
	MOVLW      25
	MOVWF      SPBRG+0
;InterrupcaoUSART.c,108 :: 		TXEN_bit = 0x01; // Habilita transmissão
	BSF        TXEN_bit+0, 5
;InterrupcaoUSART.c,109 :: 		SYNC_bit = 0x00; // Configura no modo assíncrono
	BCF        SYNC_bit+0, 4
;InterrupcaoUSART.c,110 :: 		BRGH_bit = 0x01; // Configura o baud rate de alta velocidade
	BSF        BRGH_bit+0, 2
;InterrupcaoUSART.c,113 :: 		SPEN_bit = 0x01; // Habilita a porta serial
	BSF        SPEN_bit+0, 7
;InterrupcaoUSART.c,114 :: 		CREN_bit = 0x01; // Habilita a recepção contínua
	BSF        CREN_bit+0, 4
;InterrupcaoUSART.c,117 :: 		RCIE_bit = 0x01; // Habilita a interrupçâo por recepção da USART. Isto é, ocorre a interrup. quando a serial recebe dados
	BSF        RCIE_bit+0, 5
;InterrupcaoUSART.c,119 :: 		RCIF_bit = 0x00; // Limpa a flag de interrupção por recepção da USART
	BCF        RCIF_bit+0, 5
;InterrupcaoUSART.c,121 :: 		TRISA = 0xFC; // Configura apenas RA0 e RA1 como saídas digitais
	MOVLW      252
	MOVWF      TRISA+0
;InterrupcaoUSART.c,122 :: 		TRISB = 0xFB; // Configura apenas RB2 (TX) como saída digital
	MOVLW      251
	MOVWF      TRISB+0
;InterrupcaoUSART.c,123 :: 		PORTB = 0xFB; // Inicia apenas RB2 (TX) em Low
	MOVLW      251
	MOVWF      PORTB+0
;InterrupcaoUSART.c,124 :: 		led1 = 0x00; // Inicia led1 (RA0) em Low
	BCF        RA0_bit+0, 0
;InterrupcaoUSART.c,125 :: 		led2 = 0x01; // Inicia led2 (RA1) em High
	BSF        RA1_bit+0, 1
;InterrupcaoUSART.c,127 :: 		textoInicio();
	CALL       _textoInicio+0
;InterrupcaoUSART.c,129 :: 		while(1){
L_main6:
;InterrupcaoUSART.c,132 :: 		}
	GOTO       L_main6
;InterrupcaoUSART.c,133 :: 		}
	GOTO       $+0
; end of _main

_textoInicio:

;InterrupcaoUSART.c,135 :: 		void textoInicio(){
;InterrupcaoUSART.c,137 :: 		TXREG = 'H';
	MOVLW      72
	MOVWF      TXREG+0
;InterrupcaoUSART.c,138 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,139 :: 		TXREG = 'e';
	MOVLW      101
	MOVWF      TXREG+0
;InterrupcaoUSART.c,140 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,141 :: 		TXREG = 'l';
	MOVLW      108
	MOVWF      TXREG+0
;InterrupcaoUSART.c,142 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,143 :: 		TXREG = 'l';
	MOVLW      108
	MOVWF      TXREG+0
;InterrupcaoUSART.c,144 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,145 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;InterrupcaoUSART.c,146 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,147 :: 		TXREG = ' ';
	MOVLW      32
	MOVWF      TXREG+0
;InterrupcaoUSART.c,148 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,149 :: 		TXREG = 'W';
	MOVLW      87
	MOVWF      TXREG+0
;InterrupcaoUSART.c,150 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,151 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;InterrupcaoUSART.c,152 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,153 :: 		TXREG = 'r';
	MOVLW      114
	MOVWF      TXREG+0
;InterrupcaoUSART.c,154 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,155 :: 		TXREG = 'l';
	MOVLW      108
	MOVWF      TXREG+0
;InterrupcaoUSART.c,156 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,157 :: 		TXREG = 'd';
	MOVLW      100
	MOVWF      TXREG+0
;InterrupcaoUSART.c,158 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,159 :: 		TXREG = '!';
	MOVLW      33
	MOVWF      TXREG+0
;InterrupcaoUSART.c,160 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,161 :: 		TXREG = 0x0D;
	MOVLW      13
	MOVWF      TXREG+0
;InterrupcaoUSART.c,162 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,163 :: 		TXREG = 0x0A;
	MOVLW      10
	MOVWF      TXREG+0
;InterrupcaoUSART.c,164 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,165 :: 		}
	RETURN
; end of _textoInicio

_eco:

;InterrupcaoUSART.c,167 :: 		void eco(){
;InterrupcaoUSART.c,169 :: 		TXREG = 'D';
	MOVLW      68
	MOVWF      TXREG+0
;InterrupcaoUSART.c,170 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,171 :: 		TXREG = 'i';
	MOVLW      105
	MOVWF      TXREG+0
;InterrupcaoUSART.c,172 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,173 :: 		TXREG = 'g';
	MOVLW      103
	MOVWF      TXREG+0
;InterrupcaoUSART.c,174 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,175 :: 		TXREG = 'i';
	MOVLW      105
	MOVWF      TXREG+0
;InterrupcaoUSART.c,176 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,177 :: 		TXREG = 't';
	MOVLW      116
	MOVWF      TXREG+0
;InterrupcaoUSART.c,178 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,179 :: 		TXREG = 'a';
	MOVLW      97
	MOVWF      TXREG+0
;InterrupcaoUSART.c,180 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,181 :: 		TXREG = 'd';
	MOVLW      100
	MOVWF      TXREG+0
;InterrupcaoUSART.c,182 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,183 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;InterrupcaoUSART.c,184 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,185 :: 		TXREG = ':';
	MOVLW      58
	MOVWF      TXREG+0
;InterrupcaoUSART.c,186 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,187 :: 		TXREG = ' ';
	MOVLW      32
	MOVWF      TXREG+0
;InterrupcaoUSART.c,188 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,189 :: 		TXREG = RCREG;
	MOVF       RCREG+0, 0
	MOVWF      TXREG+0
;InterrupcaoUSART.c,190 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,191 :: 		TXREG = 0x0D;
	MOVLW      13
	MOVWF      TXREG+0
;InterrupcaoUSART.c,192 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,193 :: 		TXREG = 0x0A;
	MOVLW      10
	MOVWF      TXREG+0
;InterrupcaoUSART.c,194 :: 		bufferTeste();
	CALL       _bufferTeste+0
;InterrupcaoUSART.c,195 :: 		}
	RETURN
; end of _eco

_bufferTeste:

;InterrupcaoUSART.c,197 :: 		void bufferTeste(){
;InterrupcaoUSART.c,199 :: 		while(!TRMT_bit);
L_bufferTeste8:
	BTFSC      TRMT_bit+0, 1
	GOTO       L_bufferTeste9
	GOTO       L_bufferTeste8
L_bufferTeste9:
;InterrupcaoUSART.c,200 :: 		}
	RETURN
; end of _bufferTeste

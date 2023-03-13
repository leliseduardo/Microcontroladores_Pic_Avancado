
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;USARTMotor.c,21 :: 		void interrupt(){
;USARTMotor.c,23 :: 		if(RCIF_bit){
	BTFSS      RCIF_bit+0, 5
	GOTO       L_interrupt0
;USARTMotor.c,25 :: 		RCIF_bit = 0x00;
	BCF        RCIF_bit+0, 5
;USARTMotor.c,27 :: 		if(FERR_bit || OERR_bit){ // Verifica se há algum erro, se houver
	BTFSC      FERR_bit+0, 2
	GOTO       L__interrupt20
	BTFSC      OERR_bit+0, 1
	GOTO       L__interrupt20
	GOTO       L_interrupt3
L__interrupt20:
;USARTMotor.c,29 :: 		CREN_bit = 0x00; // Desabilita a recepção contínua para tentar corrigir algum erro
	BCF        CREN_bit+0, 4
;USARTMotor.c,30 :: 		CREN_bit = 0x01; // Habilita a recpção contínua novamente
	BSF        CREN_bit+0, 4
;USARTMotor.c,32 :: 		asm retfie; // Código em assembly para sair da interrupção, caso tenha sido necessário corrigir algum erro
	RETFIE
;USARTMotor.c,33 :: 		}
L_interrupt3:
;USARTMotor.c,35 :: 		eco();
	CALL       _eco+0
;USARTMotor.c,36 :: 		}
L_interrupt0:
;USARTMotor.c,38 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt4
;USARTMotor.c,40 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;USARTMotor.c,42 :: 		cont++;
	INCF       _cont+0, 1
;USARTMotor.c,44 :: 		if(cont == 0x0A){ // Se cont = 10(decimal) = 0x0A. Se Overflow = 66ms, os leds alternam a cada 66ms x 10 = 660ms
	MOVF       _cont+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;USARTMotor.c,46 :: 		cont = 0x00;
	CLRF       _cont+0
;USARTMotor.c,47 :: 		led1 = ~led1;
	MOVLW      1
	XORWF      RA0_bit+0, 1
;USARTMotor.c,48 :: 		led2 = ~led2;
	MOVLW      2
	XORWF      RA1_bit+0, 1
;USARTMotor.c,49 :: 		}
L_interrupt5:
;USARTMotor.c,50 :: 		}
L_interrupt4:
;USARTMotor.c,51 :: 		}
L__interrupt23:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;USARTMotor.c,53 :: 		void main() {
;USARTMotor.c,57 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;USARTMotor.c,58 :: 		OPTION_REG = 0x87; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:256, associado ao timer0
	MOVLW      135
	MOVWF      OPTION_REG+0
;USARTMotor.c,59 :: 		INTCON = 0xE0; // Habilita a interrupção global, a interrupção por periféricos e habilita a interrupção pelo timer0
	MOVLW      224
	MOVWF      INTCON+0
;USARTMotor.c,63 :: 		SPBRG = 0x19; // Ou 25(decimal), para um baud rate de 9600. Esse valor equivale ao cálculo para Osc 4MHz, com a USART configurada
	MOVLW      25
	MOVWF      SPBRG+0
;USARTMotor.c,66 :: 		TXEN_bit = 0x01; // Habilita transmissão
	BSF        TXEN_bit+0, 5
;USARTMotor.c,67 :: 		SYNC_bit = 0x00; // Configura no modo assíncrono
	BCF        SYNC_bit+0, 4
;USARTMotor.c,68 :: 		BRGH_bit = 0x01; // Configura o baud rate de alta velocidade
	BSF        BRGH_bit+0, 2
;USARTMotor.c,71 :: 		SPEN_bit = 0x01; // Habilita a porta serial
	BSF        SPEN_bit+0, 7
;USARTMotor.c,72 :: 		CREN_bit = 0x01; // Habilita a recepção contínua
	BSF        CREN_bit+0, 4
;USARTMotor.c,75 :: 		RCIE_bit = 0x01; // Habilita a interrupçâo por recepção da USART. Isto é, ocorre a interrup. quando a serial recebe dados
	BSF        RCIE_bit+0, 5
;USARTMotor.c,77 :: 		RCIF_bit = 0x00; // Limpa a flag de interrupção por recepção da USART
	BCF        RCIF_bit+0, 5
;USARTMotor.c,79 :: 		TRISA = 0xF8; // Configura apenas RA0, RA1 e RA2 como saídas digitais
	MOVLW      248
	MOVWF      TRISA+0
;USARTMotor.c,80 :: 		TRISB = 0xFB; // Configura apenas RB2 (TX) como saída digital
	MOVLW      251
	MOVWF      TRISB+0
;USARTMotor.c,81 :: 		PORTB = 0xFB; // Inicia apenas RB2 (TX) em Low
	MOVLW      251
	MOVWF      PORTB+0
;USARTMotor.c,82 :: 		led1 = 0x00; // Inicia led1 (RA0) em Low
	BCF        RA0_bit+0, 0
;USARTMotor.c,83 :: 		led2 = 0x01; // Inicia led2 (RA1) em High
	BSF        RA1_bit+0, 1
;USARTMotor.c,84 :: 		motor = 0x00;
	BCF        RA2_bit+0, 2
;USARTMotor.c,86 :: 		ligaMotor = 0x00;
	BCF        _ligaMotor+0, BitPos(_ligaMotor+0)
;USARTMotor.c,87 :: 		desligaMotor = 0x00;
	BCF        _desligaMotor+0, BitPos(_desligaMotor+0)
;USARTMotor.c,89 :: 		textoInicio();
	CALL       _textoInicio+0
;USARTMotor.c,91 :: 		while(1){
L_main6:
;USARTMotor.c,93 :: 		if(RCREG == 'k' && !ligaMotor){
	MOVF       RCREG+0, 0
	XORLW      107
	BTFSS      STATUS+0, 2
	GOTO       L_main10
	BTFSC      _ligaMotor+0, BitPos(_ligaMotor+0)
	GOTO       L_main10
L__main22:
;USARTMotor.c,95 :: 		desligaMotor = 0x00;
	BCF        _desligaMotor+0, BitPos(_desligaMotor+0)
;USARTMotor.c,96 :: 		ligaMotor = 0x01;
	BSF        _ligaMotor+0, BitPos(_ligaMotor+0)
;USARTMotor.c,98 :: 		motorLigado();
	CALL       _motorLigado+0
;USARTMotor.c,99 :: 		}
	GOTO       L_main11
L_main10:
;USARTMotor.c,100 :: 		else if(ligaMotor) motor = 0x01;
	BTFSS      _ligaMotor+0, BitPos(_ligaMotor+0)
	GOTO       L_main12
	BSF        RA2_bit+0, 2
L_main12:
L_main11:
;USARTMotor.c,102 :: 		if(RCREG == 'q' && !desligaMotor){
	MOVF       RCREG+0, 0
	XORLW      113
	BTFSS      STATUS+0, 2
	GOTO       L_main15
	BTFSC      _desligaMotor+0, BitPos(_desligaMotor+0)
	GOTO       L_main15
L__main21:
;USARTMotor.c,104 :: 		ligaMotor = 0x00;
	BCF        _ligaMotor+0, BitPos(_ligaMotor+0)
;USARTMotor.c,105 :: 		desligaMotor = 0x01;
	BSF        _desligaMotor+0, BitPos(_desligaMotor+0)
;USARTMotor.c,107 :: 		motorDesligado();
	CALL       _motorDesligado+0
;USARTMotor.c,108 :: 		}
	GOTO       L_main16
L_main15:
;USARTMotor.c,109 :: 		else if(desligaMotor) motor = 0x00;
	BTFSS      _desligaMotor+0, BitPos(_desligaMotor+0)
	GOTO       L_main17
	BCF        RA2_bit+0, 2
L_main17:
L_main16:
;USARTMotor.c,110 :: 		}
	GOTO       L_main6
;USARTMotor.c,111 :: 		}
	GOTO       $+0
; end of _main

_textoInicio:

;USARTMotor.c,113 :: 		void textoInicio(){
;USARTMotor.c,115 :: 		TXREG = 'H';
	MOVLW      72
	MOVWF      TXREG+0
;USARTMotor.c,116 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,117 :: 		TXREG = 'e';
	MOVLW      101
	MOVWF      TXREG+0
;USARTMotor.c,118 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,119 :: 		TXREG = 'l';
	MOVLW      108
	MOVWF      TXREG+0
;USARTMotor.c,120 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,121 :: 		TXREG = 'l';
	MOVLW      108
	MOVWF      TXREG+0
;USARTMotor.c,122 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,123 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,124 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,125 :: 		TXREG = ' ';
	MOVLW      32
	MOVWF      TXREG+0
;USARTMotor.c,126 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,127 :: 		TXREG = 'W';
	MOVLW      87
	MOVWF      TXREG+0
;USARTMotor.c,128 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,129 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,130 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,131 :: 		TXREG = 'r';
	MOVLW      114
	MOVWF      TXREG+0
;USARTMotor.c,132 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,133 :: 		TXREG = 'l';
	MOVLW      108
	MOVWF      TXREG+0
;USARTMotor.c,134 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,135 :: 		TXREG = 'd';
	MOVLW      100
	MOVWF      TXREG+0
;USARTMotor.c,136 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,137 :: 		TXREG = '!';
	MOVLW      33
	MOVWF      TXREG+0
;USARTMotor.c,138 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,139 :: 		TXREG = 0x0D;
	MOVLW      13
	MOVWF      TXREG+0
;USARTMotor.c,140 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,141 :: 		TXREG = 0x0A;
	MOVLW      10
	MOVWF      TXREG+0
;USARTMotor.c,142 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,143 :: 		}
	RETURN
; end of _textoInicio

_eco:

;USARTMotor.c,145 :: 		void eco(){
;USARTMotor.c,147 :: 		TXREG = 'D';
	MOVLW      68
	MOVWF      TXREG+0
;USARTMotor.c,148 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,149 :: 		TXREG = 'i';
	MOVLW      105
	MOVWF      TXREG+0
;USARTMotor.c,150 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,151 :: 		TXREG = 'g';
	MOVLW      103
	MOVWF      TXREG+0
;USARTMotor.c,152 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,153 :: 		TXREG = 'i';
	MOVLW      105
	MOVWF      TXREG+0
;USARTMotor.c,154 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,155 :: 		TXREG = 't';
	MOVLW      116
	MOVWF      TXREG+0
;USARTMotor.c,156 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,157 :: 		TXREG = 'a';
	MOVLW      97
	MOVWF      TXREG+0
;USARTMotor.c,158 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,159 :: 		TXREG = 'd';
	MOVLW      100
	MOVWF      TXREG+0
;USARTMotor.c,160 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,161 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,162 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,163 :: 		TXREG = ':';
	MOVLW      58
	MOVWF      TXREG+0
;USARTMotor.c,164 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,165 :: 		TXREG = ' ';
	MOVLW      32
	MOVWF      TXREG+0
;USARTMotor.c,166 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,167 :: 		TXREG = RCREG;
	MOVF       RCREG+0, 0
	MOVWF      TXREG+0
;USARTMotor.c,168 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,169 :: 		TXREG = 0x0D;
	MOVLW      13
	MOVWF      TXREG+0
;USARTMotor.c,170 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,171 :: 		TXREG = 0x0A;
	MOVLW      10
	MOVWF      TXREG+0
;USARTMotor.c,172 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,173 :: 		}
	RETURN
; end of _eco

_bufferTeste:

;USARTMotor.c,175 :: 		void bufferTeste(){
;USARTMotor.c,177 :: 		while(!TRMT_bit);
L_bufferTeste18:
	BTFSC      TRMT_bit+0, 1
	GOTO       L_bufferTeste19
	GOTO       L_bufferTeste18
L_bufferTeste19:
;USARTMotor.c,178 :: 		}
	RETURN
; end of _bufferTeste

_motorLigado:

;USARTMotor.c,180 :: 		void motorLigado(){
;USARTMotor.c,182 :: 		TXREG = 'M';
	MOVLW      77
	MOVWF      TXREG+0
;USARTMotor.c,183 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,184 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,185 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,186 :: 		TXREG = 't';
	MOVLW      116
	MOVWF      TXREG+0
;USARTMotor.c,187 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,188 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,189 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,190 :: 		TXREG = 'r';
	MOVLW      114
	MOVWF      TXREG+0
;USARTMotor.c,191 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,192 :: 		TXREG = ' ';
	MOVLW      32
	MOVWF      TXREG+0
;USARTMotor.c,193 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,194 :: 		TXREG = 'L';
	MOVLW      76
	MOVWF      TXREG+0
;USARTMotor.c,195 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,196 :: 		TXREG = 'i';
	MOVLW      105
	MOVWF      TXREG+0
;USARTMotor.c,197 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,198 :: 		TXREG = 'g';
	MOVLW      103
	MOVWF      TXREG+0
;USARTMotor.c,199 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,200 :: 		TXREG = 'a';
	MOVLW      97
	MOVWF      TXREG+0
;USARTMotor.c,201 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,202 :: 		TXREG = 'd';
	MOVLW      100
	MOVWF      TXREG+0
;USARTMotor.c,203 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,204 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,205 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,206 :: 		TXREG = '!';
	MOVLW      33
	MOVWF      TXREG+0
;USARTMotor.c,207 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,208 :: 		TXREG = 0x0D;
	MOVLW      13
	MOVWF      TXREG+0
;USARTMotor.c,209 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,210 :: 		TXREG = 0x0A;
	MOVLW      10
	MOVWF      TXREG+0
;USARTMotor.c,211 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,212 :: 		}
	RETURN
; end of _motorLigado

_motorDesligado:

;USARTMotor.c,214 :: 		void motorDesligado(){
;USARTMotor.c,216 :: 		TXREG = 'M';
	MOVLW      77
	MOVWF      TXREG+0
;USARTMotor.c,217 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,218 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,219 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,220 :: 		TXREG = 't';
	MOVLW      116
	MOVWF      TXREG+0
;USARTMotor.c,221 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,222 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,223 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,224 :: 		TXREG = 'r';
	MOVLW      114
	MOVWF      TXREG+0
;USARTMotor.c,225 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,226 :: 		TXREG = ' ';
	MOVLW      32
	MOVWF      TXREG+0
;USARTMotor.c,227 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,228 :: 		TXREG = 'd';
	MOVLW      100
	MOVWF      TXREG+0
;USARTMotor.c,229 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,230 :: 		TXREG = 'e';
	MOVLW      101
	MOVWF      TXREG+0
;USARTMotor.c,231 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,232 :: 		TXREG = 's';
	MOVLW      115
	MOVWF      TXREG+0
;USARTMotor.c,233 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,234 :: 		TXREG = 'l';
	MOVLW      108
	MOVWF      TXREG+0
;USARTMotor.c,235 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,236 :: 		TXREG = 'i';
	MOVLW      105
	MOVWF      TXREG+0
;USARTMotor.c,237 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,238 :: 		TXREG = 'g';
	MOVLW      103
	MOVWF      TXREG+0
;USARTMotor.c,239 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,240 :: 		TXREG = 'a';
	MOVLW      97
	MOVWF      TXREG+0
;USARTMotor.c,241 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,242 :: 		TXREG = 'd';
	MOVLW      100
	MOVWF      TXREG+0
;USARTMotor.c,243 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,244 :: 		TXREG = 'o';
	MOVLW      111
	MOVWF      TXREG+0
;USARTMotor.c,245 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,246 :: 		TXREG = '!';
	MOVLW      33
	MOVWF      TXREG+0
;USARTMotor.c,247 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,248 :: 		TXREG = 0x0D;
	MOVLW      13
	MOVWF      TXREG+0
;USARTMotor.c,249 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,250 :: 		TXREG = 0x0A;
	MOVLW      10
	MOVWF      TXREG+0
;USARTMotor.c,251 :: 		bufferTeste();
	CALL       _bufferTeste+0
;USARTMotor.c,252 :: 		}
	RETURN
; end of _motorDesligado

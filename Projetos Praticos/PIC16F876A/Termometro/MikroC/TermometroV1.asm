
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TermometroV1.c,50 :: 		void interrupt(){
;TermometroV1.c,52 :: 		if(TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;TermometroV1.c,54 :: 		TMR0IF_bit = 0x00;                   // Limpa flag de interrupção do timer0
	BCF        TMR0IF_bit+0, 2
;TermometroV1.c,55 :: 		TMR0 = 0xB2;                         // Reinicia valor de TMR0
	MOVLW      178
	MOVWF      TMR0+0
;TermometroV1.c,59 :: 		if(!disp1 && control == 0x00){                        // Liga display 1, das dezenas
	BTFSC      RB3_bit+0, 3
	GOTO       L_interrupt3
	MOVF       _control+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
L__interrupt31:
;TermometroV1.c,61 :: 		disp2 = 0x00;                      // Desliga display 2
	BCF        RB1_bit+0, 1
;TermometroV1.c,62 :: 		PORTB = 0x00;                      // Limpa PORTB
	CLRF       PORTB+0
;TermometroV1.c,63 :: 		PORTC = 0x00;                      // Limpa PORTC
	CLRF       PORTC+0
;TermometroV1.c,64 :: 		disp1 = 0x01;                      // Liga display 1
	BSF        RB3_bit+0, 3
;TermometroV1.c,65 :: 		display(dezena);                   // Envia número a ser exibido no display
	MOVF       _dezena+0, 0
	MOVWF      FARG_display_n+0
	CALL       _display+0
;TermometroV1.c,66 :: 		control = 0x01;                    // Seta variável de controle
	MOVLW      1
	MOVWF      _control+0
;TermometroV1.c,68 :: 		} // end if
	GOTO       L_interrupt4
L_interrupt3:
;TermometroV1.c,69 :: 		else if(!disp2 && control == 0x01){
	BTFSC      RB1_bit+0, 1
	GOTO       L_interrupt7
	MOVF       _control+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
L__interrupt30:
;TermometroV1.c,71 :: 		disp1 = 0x00;                      // Desliga display 1
	BCF        RB3_bit+0, 3
;TermometroV1.c,72 :: 		PORTB = 0x00;                      // Limpa PORTB
	CLRF       PORTB+0
;TermometroV1.c,73 :: 		PORTC = 0x00;                      // Limpa PORTC
	CLRF       PORTC+0
;TermometroV1.c,74 :: 		disp2 = 0x01;                      // Liga display 2
	BSF        RB1_bit+0, 1
;TermometroV1.c,75 :: 		display(unidade);                  // Envia número a ser exibido no display
	MOVF       _unidade+0, 0
	MOVWF      FARG_display_n+0
	CALL       _display+0
;TermometroV1.c,76 :: 		control = 0x00;                       // Limpa variável de controle
	CLRF       _control+0
;TermometroV1.c,78 :: 		} // end if
L_interrupt7:
L_interrupt4:
;TermometroV1.c,80 :: 		} // end if TMR0IF_bit
L_interrupt0:
;TermometroV1.c,82 :: 		} // end void interrupt
L__interrupt33:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;TermometroV1.c,85 :: 		void main() {
;TermometroV1.c,88 :: 		CMCON = 0x07;                             // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;TermometroV1.c,90 :: 		TRISB = 0x15;                             // Ou 0b00010101, configura todos os pinos que serão utilizados como saídas digitais
	MOVLW      21
	MOVWF      TRISB+0
;TermometroV1.c,91 :: 		TRISC = 0x0F;                             // Ou 0b00001111, configura o primeiro nibble como saída digital
	MOVLW      15
	MOVWF      TRISC+0
;TermometroV1.c,92 :: 		TRISA = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;TermometroV1.c,94 :: 		OPTION_REG = 0x85;                        // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:64
	MOVLW      133
	MOVWF      OPTION_REG+0
;TermometroV1.c,95 :: 		INTCON = 0xA0;                            // Habilita a interrupção global e a interrupção do timer0
	MOVLW      160
	MOVWF      INTCON+0
;TermometroV1.c,96 :: 		TMR0 = 0xB2;                              // Inicializa TMR0 = B2h = 178d, para contagem de 78 e overflow de 5ms
	MOVLW      178
	MOVWF      TMR0+0
;TermometroV1.c,97 :: 		disp1 = 0x00;                             // Inicia display 1 desligado
	BCF        RB3_bit+0, 3
;TermometroV1.c,98 :: 		disp2 = 0x00;                             // Inicia display 2 desligado
	BCF        RB1_bit+0, 1
;TermometroV1.c,100 :: 		ADCON0 = 0x41;                            // Habilita o conversor AD
	MOVLW      65
	MOVWF      ADCON0+0
;TermometroV1.c,101 :: 		ADCON1 = 0x4E;                            // Configura apenas AN0 como entrada analógica, com a conversão no intervalo entre as tensões da fonte
	MOVLW      78
	MOVWF      ADCON1+0
;TermometroV1.c,105 :: 		while(1){
L_main8:
;TermometroV1.c,107 :: 		celsius();
	CALL       _celsius+0
;TermometroV1.c,109 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;TermometroV1.c,111 :: 		} // end loop infinito
	GOTO       L_main8
;TermometroV1.c,113 :: 		} // end void main
	GOTO       $+0
; end of _main

_celsius:

;TermometroV1.c,118 :: 		void celsius(){
;TermometroV1.c,121 :: 		mediaMovel = adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _mediaMovel+0
	MOVF       R0+1, 0
	MOVWF      _mediaMovel+1
	CLRF       _mediaMovel+2
	CLRF       _mediaMovel+3
;TermometroV1.c,123 :: 		temperatura = ((mediaMovel * 500) / 1024);
	MOVF       _mediaMovel+0, 0
	MOVWF      R0+0
	MOVF       _mediaMovel+1, 0
	MOVWF      R0+1
	MOVF       _mediaMovel+2, 0
	MOVWF      R0+2
	MOVF       _mediaMovel+3, 0
	MOVWF      R0+3
	MOVLW      244
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       R0+0, 0
	MOVWF      R5+0
	MOVF       R0+1, 0
	MOVWF      R5+1
	MOVF       R0+2, 0
	MOVWF      R5+2
	MOVF       R0+3, 0
	MOVWF      R5+3
	MOVF       R4+0, 0
L__celsius34:
	BTFSC      STATUS+0, 2
	GOTO       L__celsius35
	RRF        R5+3, 1
	RRF        R5+2, 1
	RRF        R5+1, 1
	RRF        R5+0, 1
	BCF        R5+3, 7
	BTFSC      R5+3, 6
	BSF        R5+3, 7
	ADDLW      255
	GOTO       L__celsius34
L__celsius35:
	MOVF       R5+0, 0
	MOVWF      _temperatura+0
	MOVF       R5+1, 0
	MOVWF      _temperatura+1
	MOVF       R5+2, 0
	MOVWF      _temperatura+2
	MOVF       R5+3, 0
	MOVWF      _temperatura+3
;TermometroV1.c,125 :: 		if((temperatura > ultimaTemperatura + 1) || (temperatura < ultimaTemperatura - 1)){
	MOVF       _ultimaTemperatura+0, 0
	MOVWF      R1+0
	MOVF       _ultimaTemperatura+1, 0
	MOVWF      R1+1
	MOVF       _ultimaTemperatura+2, 0
	MOVWF      R1+2
	MOVF       _ultimaTemperatura+3, 0
	MOVWF      R1+3
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
	BTFSC      STATUS+0, 2
	INCF       R1+2, 1
	BTFSC      STATUS+0, 2
	INCF       R1+3, 1
	MOVLW      128
	XORWF      R1+3, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R5+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius36
	MOVF       R5+2, 0
	SUBWF      R1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius36
	MOVF       R5+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius36
	MOVF       R5+0, 0
	SUBWF      R1+0, 0
L__celsius36:
	BTFSS      STATUS+0, 0
	GOTO       L__celsius32
	MOVLW      1
	MOVWF      R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       _ultimaTemperatura+0, 0
	MOVWF      R4+0
	MOVF       _ultimaTemperatura+1, 0
	MOVWF      R4+1
	MOVF       _ultimaTemperatura+2, 0
	MOVWF      R4+2
	MOVF       _ultimaTemperatura+3, 0
	MOVWF      R4+3
	MOVF       R0+0, 0
	SUBWF      R4+0, 1
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+1, 0
	SUBWF      R4+1, 1
	MOVF       R0+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+2, 0
	SUBWF      R4+2, 1
	MOVF       R0+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+3, 0
	SUBWF      R4+3, 1
	MOVLW      128
	XORWF      _temperatura+3, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      R4+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius37
	MOVF       R4+2, 0
	SUBWF      _temperatura+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius37
	MOVF       R4+1, 0
	SUBWF      _temperatura+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius37
	MOVF       R4+0, 0
	SUBWF      _temperatura+0, 0
L__celsius37:
	BTFSS      STATUS+0, 0
	GOTO       L__celsius32
	GOTO       L_celsius13
L__celsius32:
;TermometroV1.c,127 :: 		ultimaTemperatura = temperatura;
	MOVF       _temperatura+0, 0
	MOVWF      _ultimaTemperatura+0
	MOVF       _temperatura+1, 0
	MOVWF      _ultimaTemperatura+1
	MOVF       _temperatura+2, 0
	MOVWF      _ultimaTemperatura+2
	MOVF       _temperatura+3, 0
	MOVWF      _ultimaTemperatura+3
;TermometroV1.c,129 :: 		if(temperatura > 99){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _temperatura+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius38
	MOVF       _temperatura+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius38
	MOVF       _temperatura+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius38
	MOVF       _temperatura+0, 0
	SUBLW      99
L__celsius38:
	BTFSC      STATUS+0, 0
	GOTO       L_celsius14
;TermometroV1.c,131 :: 		dezena = 0x09;
	MOVLW      9
	MOVWF      _dezena+0
;TermometroV1.c,132 :: 		unidade = 0x09;
	MOVLW      9
	MOVWF      _unidade+0
;TermometroV1.c,134 :: 		}
	GOTO       L_celsius15
L_celsius14:
;TermometroV1.c,135 :: 		else if(temperatura < 1){
	MOVLW      128
	XORWF      _temperatura+3, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius39
	MOVLW      0
	SUBWF      _temperatura+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius39
	MOVLW      0
	SUBWF      _temperatura+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__celsius39
	MOVLW      1
	SUBWF      _temperatura+0, 0
L__celsius39:
	BTFSC      STATUS+0, 0
	GOTO       L_celsius16
;TermometroV1.c,137 :: 		dezena = 0x00;
	CLRF       _dezena+0
;TermometroV1.c,138 :: 		unidade = 0x00;
	CLRF       _unidade+0
;TermometroV1.c,139 :: 		}
	GOTO       L_celsius17
L_celsius16:
;TermometroV1.c,142 :: 		dezena = temperatura / 10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _temperatura+0, 0
	MOVWF      R0+0
	MOVF       _temperatura+1, 0
	MOVWF      R0+1
	MOVF       _temperatura+2, 0
	MOVWF      R0+2
	MOVF       _temperatura+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _dezena+0
;TermometroV1.c,143 :: 		unidade = temperatura % 10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _temperatura+0, 0
	MOVWF      R0+0
	MOVF       _temperatura+1, 0
	MOVWF      R0+1
	MOVF       _temperatura+2, 0
	MOVWF      R0+2
	MOVF       _temperatura+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _unidade+0
;TermometroV1.c,145 :: 		}
L_celsius17:
L_celsius15:
;TermometroV1.c,147 :: 		} // end if
L_celsius13:
;TermometroV1.c,150 :: 		} // end void celsius
	RETURN
; end of _celsius

_display:

;TermometroV1.c,192 :: 		void display(unsigned short n){
;TermometroV1.c,194 :: 		switch(n){
	GOTO       L_display18
;TermometroV1.c,196 :: 		case 0: RC4_bit = 0x01;
L_display20:
	BSF        RC4_bit+0, 4
;TermometroV1.c,197 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,198 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,199 :: 		RC7_bit = 0x01;
	BSF        RC7_bit+0, 7
;TermometroV1.c,200 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;TermometroV1.c,201 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;TermometroV1.c,202 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;TermometroV1.c,203 :: 		break;
	GOTO       L_display19
;TermometroV1.c,204 :: 		case 1: RC4_bit = 0x00;
L_display21:
	BCF        RC4_bit+0, 4
;TermometroV1.c,205 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,206 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,207 :: 		RC7_bit = 0x00;
	BCF        RC7_bit+0, 7
;TermometroV1.c,208 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;TermometroV1.c,209 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;TermometroV1.c,210 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;TermometroV1.c,211 :: 		break;
	GOTO       L_display19
;TermometroV1.c,212 :: 		case 2: RC4_bit = 0x01;
L_display22:
	BSF        RC4_bit+0, 4
;TermometroV1.c,213 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,214 :: 		RC6_bit = 0x00;
	BCF        RC6_bit+0, 6
;TermometroV1.c,215 :: 		RC7_bit = 0x01;
	BSF        RC7_bit+0, 7
;TermometroV1.c,216 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;TermometroV1.c,217 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;TermometroV1.c,218 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;TermometroV1.c,219 :: 		break;
	GOTO       L_display19
;TermometroV1.c,220 :: 		case 3: RC4_bit = 0x01;
L_display23:
	BSF        RC4_bit+0, 4
;TermometroV1.c,221 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,222 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,223 :: 		RC7_bit = 0x01;
	BSF        RC7_bit+0, 7
;TermometroV1.c,224 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;TermometroV1.c,225 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;TermometroV1.c,226 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;TermometroV1.c,227 :: 		break;
	GOTO       L_display19
;TermometroV1.c,228 :: 		case 4: RC4_bit = 0x00;
L_display24:
	BCF        RC4_bit+0, 4
;TermometroV1.c,229 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,230 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,231 :: 		RC7_bit = 0x00;
	BCF        RC7_bit+0, 7
;TermometroV1.c,232 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;TermometroV1.c,233 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;TermometroV1.c,234 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;TermometroV1.c,235 :: 		break;
	GOTO       L_display19
;TermometroV1.c,236 :: 		case 5: RC4_bit = 0x01;
L_display25:
	BSF        RC4_bit+0, 4
;TermometroV1.c,237 :: 		RC5_bit = 0x00;
	BCF        RC5_bit+0, 5
;TermometroV1.c,238 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,239 :: 		RC7_bit = 0x01;
	BSF        RC7_bit+0, 7
;TermometroV1.c,240 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;TermometroV1.c,241 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;TermometroV1.c,242 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;TermometroV1.c,243 :: 		break;
	GOTO       L_display19
;TermometroV1.c,244 :: 		case 6: RC4_bit = 0x01;
L_display26:
	BSF        RC4_bit+0, 4
;TermometroV1.c,245 :: 		RC5_bit = 0x00;
	BCF        RC5_bit+0, 5
;TermometroV1.c,246 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,247 :: 		RC7_bit = 0x01;
	BSF        RC7_bit+0, 7
;TermometroV1.c,248 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;TermometroV1.c,249 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;TermometroV1.c,250 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;TermometroV1.c,251 :: 		break;
	GOTO       L_display19
;TermometroV1.c,252 :: 		case 7: RC4_bit = 0x01;
L_display27:
	BSF        RC4_bit+0, 4
;TermometroV1.c,253 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,254 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,255 :: 		RC7_bit = 0x00;
	BCF        RC7_bit+0, 7
;TermometroV1.c,256 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;TermometroV1.c,257 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;TermometroV1.c,258 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;TermometroV1.c,259 :: 		break;
	GOTO       L_display19
;TermometroV1.c,260 :: 		case 8: RC4_bit = 0x01;
L_display28:
	BSF        RC4_bit+0, 4
;TermometroV1.c,261 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,262 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,263 :: 		RC7_bit = 0x01;
	BSF        RC7_bit+0, 7
;TermometroV1.c,264 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;TermometroV1.c,265 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;TermometroV1.c,266 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;TermometroV1.c,267 :: 		break;
	GOTO       L_display19
;TermometroV1.c,268 :: 		case 9: RC4_bit = 0x01;
L_display29:
	BSF        RC4_bit+0, 4
;TermometroV1.c,269 :: 		RC5_bit = 0x01;
	BSF        RC5_bit+0, 5
;TermometroV1.c,270 :: 		RC6_bit = 0x01;
	BSF        RC6_bit+0, 6
;TermometroV1.c,271 :: 		RC7_bit = 0x00;
	BCF        RC7_bit+0, 7
;TermometroV1.c,272 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;TermometroV1.c,273 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;TermometroV1.c,274 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;TermometroV1.c,275 :: 		break;
	GOTO       L_display19
;TermometroV1.c,277 :: 		} // end switch
L_display18:
	MOVF       FARG_display_n+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_display20
	MOVF       FARG_display_n+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_display21
	MOVF       FARG_display_n+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_display22
	MOVF       FARG_display_n+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_display23
	MOVF       FARG_display_n+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_display24
	MOVF       FARG_display_n+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_display25
	MOVF       FARG_display_n+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_display26
	MOVF       FARG_display_n+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_display27
	MOVF       FARG_display_n+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_display28
	MOVF       FARG_display_n+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_display29
L_display19:
;TermometroV1.c,279 :: 		} // end void display
	RETURN
; end of _display

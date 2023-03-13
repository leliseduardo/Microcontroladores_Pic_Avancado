
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;PulsoCapturaCPP.c,59 :: 		void interrupt(){
;PulsoCapturaCPP.c,61 :: 		if(CCP1IF_bit && CCP1CON.B0){
	BTFSS      CCP1IF_bit+0, 2
	GOTO       L_interrupt2
	BTFSS      CCP1CON+0, 0
	GOTO       L_interrupt2
L__interrupt9:
;PulsoCapturaCPP.c,63 :: 		CCP1IF_bit = 0x00; // Zera a flag de interrupção
	BCF        CCP1IF_bit+0, 2
;PulsoCapturaCPP.c,64 :: 		TMR1H = 0x00; // Inicia TMR1 em 0
	CLRF       TMR1H+0
;PulsoCapturaCPP.c,65 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;PulsoCapturaCPP.c,66 :: 		CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
	BCF        CCP1IE_bit+0, 2
;PulsoCapturaCPP.c,67 :: 		CCP1CON = 0x04; // Configura a captura em borda de descida
	MOVLW      4
	MOVWF      CCP1CON+0
;PulsoCapturaCPP.c,68 :: 		CCP1IE_bit = 0x01; // Liga a interrupão do modulo ccp
	BSF        CCP1IE_bit+0, 2
;PulsoCapturaCPP.c,69 :: 		TMR1ON_bit = 0x01; // Liga a contagem do timer1
	BSF        TMR1ON_bit+0, 0
;PulsoCapturaCPP.c,70 :: 		}
	GOTO       L_interrupt3
L_interrupt2:
;PulsoCapturaCPP.c,72 :: 		CCP1IF_bit = 0x00; // Zera a flag de interrupção
	BCF        CCP1IF_bit+0, 2
;PulsoCapturaCPP.c,73 :: 		TMR1ON_bit = 0x00; // Desliga a contagem do timer1
	BCF        TMR1ON_bit+0, 0
;PulsoCapturaCPP.c,74 :: 		CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
	BCF        CCP1IE_bit+0, 2
;PulsoCapturaCPP.c,75 :: 		CCP1CON = 0x05; // Configura a captura em borda de subida
	MOVLW      5
	MOVWF      CCP1CON+0
;PulsoCapturaCPP.c,76 :: 		CCP1IE_bit = 0x01; // Liga a interrupção do modulo ccp
	BSF        CCP1IE_bit+0, 2
;PulsoCapturaCPP.c,77 :: 		tmrH = TMR1H; // Iguala o neeble mais significativo do timer 1 a tempoH
	MOVF       TMR1H+0, 0
	MOVWF      _tmrH+0
;PulsoCapturaCPP.c,78 :: 		tmrL = TMR1L; // Iguala o neeble menos significativo do timer 1 a tempoL
	MOVF       TMR1L+0, 0
	MOVWF      _tmrL+0
;PulsoCapturaCPP.c,79 :: 		}
L_interrupt3:
;PulsoCapturaCPP.c,80 :: 		}
L__interrupt10:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;PulsoCapturaCPP.c,82 :: 		void main() {
;PulsoCapturaCPP.c,84 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;PulsoCapturaCPP.c,85 :: 		INTCON = 0xC0; // Hablita a interrupção global e por periféricos
	MOVLW      192
	MOVWF      INTCON+0
;PulsoCapturaCPP.c,86 :: 		TMR1IE_bit = 0x00; // Desabilita a interrupção do timer 1
	BCF        TMR1IE_bit+0, 0
;PulsoCapturaCPP.c,87 :: 		CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo cpp
	BSF        CCP1IE_bit+0, 2
;PulsoCapturaCPP.c,88 :: 		CCP1CON = 0x05; // Configura o modo de captura por borda de subida
	MOVLW      5
	MOVWF      CCP1CON+0
;PulsoCapturaCPP.c,91 :: 		T1CKPS1_bit = 0x00; // Configura o prescaler como 1:1
	BCF        T1CKPS1_bit+0, 5
;PulsoCapturaCPP.c,92 :: 		T1CKPS0_bit = 0x00; // Configura o prescaler como 1:1
	BCF        T1CKPS0_bit+0, 4
;PulsoCapturaCPP.c,93 :: 		TMR1CS_bit = 0x00; // Configura clock interno, e não clock externo a partir do pino RB6
	BCF        TMR1CS_bit+0, 1
;PulsoCapturaCPP.c,94 :: 		TMR1ON_bit = 0x00; // Para a contagem do timer 1
	BCF        TMR1ON_bit+0, 0
;PulsoCapturaCPP.c,96 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;PulsoCapturaCPP.c,97 :: 		TRISB = 0x09; // Ou 0b00001001, que configura apenas RB0 e RB3 como entradas digitais
	MOVLW      9
	MOVWF      TRISB+0
;PulsoCapturaCPP.c,98 :: 		PORTA = 0xFF; // Inicia todo o porta em High
	MOVLW      255
	MOVWF      PORTA+0
;PulsoCapturaCPP.c,99 :: 		PORTB = 0x00; // Inicia todo o portb em Low
	CLRF       PORTB+0
;PulsoCapturaCPP.c,101 :: 		lcd_init(); // Inicia lcd
	CALL       _Lcd_Init+0
;PulsoCapturaCPP.c,102 :: 		lcd_cmd(_LCD_CURSOR_OFF); // Desliga cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PulsoCapturaCPP.c,103 :: 		lcd_cmd(_LCD_CLEAR); // Apaga caracteres display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;PulsoCapturaCPP.c,104 :: 		lcd_out(1,1,"Modo captura"); // Escreve na primeira linha
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_PulsoCapturaCPP+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PulsoCapturaCPP.c,105 :: 		lcd_out(2,14,"us"); // Coloca a unidade do valos lido, no final da segunda linha
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_PulsoCapturaCPP+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PulsoCapturaCPP.c,106 :: 		delay_ms(100); // Atraso de inicialização do display
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
	NOP
;PulsoCapturaCPP.c,108 :: 		while(1){
L_main6:
;PulsoCapturaCPP.c,110 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	NOP
	NOP
;PulsoCapturaCPP.c,112 :: 		tempoH = (tmrH << 8) + tmrL; // Faz tempoH = 0b tmrH tmrL, sendo tmrH o mais sig, e o tmrL o menos sig.
	MOVF       _tmrH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       _tmrL+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _tempoH+0
	MOVF       R0+1, 0
	MOVWF      _tempoH+1
;PulsoCapturaCPP.c,114 :: 		IntToStr(tempoH, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;PulsoCapturaCPP.c,116 :: 		lcd_out(2,8,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;PulsoCapturaCPP.c,117 :: 		}
	GOTO       L_main6
;PulsoCapturaCPP.c,118 :: 		}
	GOTO       $+0
; end of _main


_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;ModoCaptura.c,48 :: 		void interrupt(){
;ModoCaptura.c,50 :: 		if(CCP1IF_bit){
	BTFSS      CCP1IF_bit+0, 2
	GOTO       L_interrupt0
;ModoCaptura.c,52 :: 		if(!flag0.B0){ // Se o bit 0 de flag0 for zero
	BTFSC      _flag0+0, 0
	GOTO       L_interrupt1
;ModoCaptura.c,54 :: 		tempo1 = (CCPR1H << 8) + CCPR1L;
	MOVF       CCPR1H+0, 0
	MOVWF      _tempo1+1
	CLRF       _tempo1+0
	MOVF       CCPR1L+0, 0
	ADDWF      _tempo1+0, 1
	BTFSC      STATUS+0, 0
	INCF       _tempo1+1, 1
;ModoCaptura.c,56 :: 		flag0.B0 = 0x01; // bit 0 de flag0 = 1
	BSF        _flag0+0, 0
;ModoCaptura.c,57 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;ModoCaptura.c,60 :: 		tempo2 = (CCPR1H << 8) + CCPR1L;
	MOVF       CCPR1H+0, 0
	MOVWF      _tempo2+1
	CLRF       _tempo2+0
	MOVF       CCPR1L+0, 0
	ADDWF      _tempo2+0, 1
	BTFSC      STATUS+0, 0
	INCF       _tempo2+1, 1
;ModoCaptura.c,62 :: 		flag0.B0 = 0x00;
	BCF        _flag0+0, 0
;ModoCaptura.c,64 :: 		flag0.B1 = 0x01;
	BSF        _flag0+0, 1
;ModoCaptura.c,65 :: 		}
L_interrupt2:
;ModoCaptura.c,67 :: 		CCP1IE_bit = 0x00;
	BCF        CCP1IE_bit+0, 2
;ModoCaptura.c,68 :: 		CCP1CON.B0 = ~CCP1CON.B0;
	MOVLW      1
	XORWF      CCP1CON+0, 1
;ModoCaptura.c,69 :: 		CCP1IE_bit = 0x01;
	BSF        CCP1IE_bit+0, 2
;ModoCaptura.c,71 :: 		CCP1IF_bit = 0x00;
	BCF        CCP1IF_bit+0, 2
;ModoCaptura.c,72 :: 		}
L_interrupt0:
;ModoCaptura.c,73 :: 		}
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;ModoCaptura.c,75 :: 		void main() {
;ModoCaptura.c,77 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;ModoCaptura.c,78 :: 		T1CON = 0x01; // Configura o prescaler em 1:1 e habilita o timer 1
	MOVLW      1
	MOVWF      T1CON+0
;ModoCaptura.c,79 :: 		CCP1CON = 0x05; // Configura o modo de captura para borda de subida
	MOVLW      5
	MOVWF      CCP1CON+0
;ModoCaptura.c,80 :: 		CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo ccp1 que, no caso, utiliza o modo de captura
	BSF        CCP1IE_bit+0, 2
;ModoCaptura.c,81 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;ModoCaptura.c,82 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;ModoCaptura.c,84 :: 		TRISA = 0xFF; // Todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;ModoCaptura.c,85 :: 		TRISB = 0x09; // Apenas RB0 e RB3 (CCP1) como entradas digitais
	MOVLW      9
	MOVWF      TRISB+0
;ModoCaptura.c,86 :: 		PORTA = 0xFF; // Inicia todo porta em High
	MOVLW      255
	MOVWF      PORTA+0
;ModoCaptura.c,87 :: 		PORTB = 0x09; // Inicia apenas RB0 e RB3 em High
	MOVLW      9
	MOVWF      PORTB+0
;ModoCaptura.c,89 :: 		lcd_init(); // Inicia o lcd
	CALL       _Lcd_Init+0
;ModoCaptura.c,90 :: 		lcd_cmd(_LCD_CURSOR_OFF); // Desliga o cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ModoCaptura.c,91 :: 		lcd_cmd(_LCD_CLEAR); // Limpa a tela
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;ModoCaptura.c,92 :: 		lcd_out(1,1,texto); // Escreve um texto na primeira linha
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _texto+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ModoCaptura.c,94 :: 		while(1){
L_main3:
;ModoCaptura.c,96 :: 		tempo2 = tempo2 - tempo1;
	MOVF       _tempo1+0, 0
	SUBWF      _tempo2+0, 0
	MOVWF      R0+0
	MOVF       _tempo1+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _tempo2+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _tempo2+0
	MOVF       R0+1, 0
	MOVWF      _tempo2+1
;ModoCaptura.c,98 :: 		IntToStr(tempo2, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;ModoCaptura.c,100 :: 		lcd_out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;ModoCaptura.c,102 :: 		flag0.B1 = 0x00;
	BCF        _flag0+0, 1
;ModoCaptura.c,103 :: 		}
	GOTO       L_main3
;ModoCaptura.c,104 :: 		}
	GOTO       $+0
; end of _main

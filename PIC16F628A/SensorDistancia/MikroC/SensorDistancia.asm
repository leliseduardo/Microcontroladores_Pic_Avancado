
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SensorDistancia.c,30 :: 		void interrupt(){
;SensorDistancia.c,32 :: 		if(CCP1IF_bit && CCP1CON.B0){
	BTFSS      CCP1IF_bit+0, 2
	GOTO       L_interrupt2
	BTFSS      CCP1CON+0, 0
	GOTO       L_interrupt2
L__interrupt10:
;SensorDistancia.c,34 :: 		CCP1IF_bit = 0x00; // Zera a flag de interrupção
	BCF        CCP1IF_bit+0, 2
;SensorDistancia.c,35 :: 		TMR1H = 0x00; // Inicia TMR1 em 0
	CLRF       TMR1H+0
;SensorDistancia.c,36 :: 		TMR1L = 0x00;
	CLRF       TMR1L+0
;SensorDistancia.c,37 :: 		CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
	BCF        CCP1IE_bit+0, 2
;SensorDistancia.c,38 :: 		CCP1CON = 0x04; // Configura a captura em borda de descida
	MOVLW      4
	MOVWF      CCP1CON+0
;SensorDistancia.c,39 :: 		CCP1IE_bit = 0x01; // Liga a interrupão do modulo ccp
	BSF        CCP1IE_bit+0, 2
;SensorDistancia.c,40 :: 		TMR1ON_bit = 0x01; // Liga a contagem do timer1
	BSF        TMR1ON_bit+0, 0
;SensorDistancia.c,41 :: 		}
	GOTO       L_interrupt3
L_interrupt2:
;SensorDistancia.c,43 :: 		CCP1IF_bit = 0x00; // Zera a flag de interrupção
	BCF        CCP1IF_bit+0, 2
;SensorDistancia.c,44 :: 		TMR1ON_bit = 0x00; // Desliga a contagem do timer1
	BCF        TMR1ON_bit+0, 0
;SensorDistancia.c,45 :: 		CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
	BCF        CCP1IE_bit+0, 2
;SensorDistancia.c,46 :: 		CCP1CON = 0x05; // Configura a captura em borda de subida
	MOVLW      5
	MOVWF      CCP1CON+0
;SensorDistancia.c,47 :: 		CCP1IE_bit = 0x01; // Liga a interrupção do modulo ccp
	BSF        CCP1IE_bit+0, 2
;SensorDistancia.c,48 :: 		tmrH = CCPR1H; // Iguala o neeble mais significativo do timer 1 a tempoH
	MOVF       CCPR1H+0, 0
	MOVWF      _tmrH+0
;SensorDistancia.c,49 :: 		tmrL = CCPR1L; // Iguala o neeble menos significativo do timer 1 a tempoL
	MOVF       CCPR1L+0, 0
	MOVWF      _tmrL+0
;SensorDistancia.c,50 :: 		}
L_interrupt3:
;SensorDistancia.c,51 :: 		}
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

;SensorDistancia.c,53 :: 		void main() {
;SensorDistancia.c,55 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;SensorDistancia.c,56 :: 		INTCON = 0xC0; // Hablita a interrupção global e por periféricos
	MOVLW      192
	MOVWF      INTCON+0
;SensorDistancia.c,57 :: 		TMR1IE_bit = 0x00; // Desabilita a interrupção do timer 1
	BCF        TMR1IE_bit+0, 0
;SensorDistancia.c,58 :: 		CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo cpp
	BSF        CCP1IE_bit+0, 2
;SensorDistancia.c,59 :: 		CCP1CON = 0x05; // Configura o modo de captura por borda de subida
	MOVLW      5
	MOVWF      CCP1CON+0
;SensorDistancia.c,62 :: 		T1CKPS1_bit = 0x00; // Configura o prescaler como 1:1
	BCF        T1CKPS1_bit+0, 5
;SensorDistancia.c,63 :: 		T1CKPS0_bit = 0x00; // Configura o prescaler como 1:1
	BCF        T1CKPS0_bit+0, 4
;SensorDistancia.c,64 :: 		TMR1CS_bit = 0x00; // Configura clock interno, e não clock externo a partir do pino RB6
	BCF        TMR1CS_bit+0, 1
;SensorDistancia.c,65 :: 		TMR1ON_bit = 0x00; // Para a contagem do timer 1
	BCF        TMR1ON_bit+0, 0
;SensorDistancia.c,67 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;SensorDistancia.c,68 :: 		TRISB = 0x09; // Ou 0b00001001, que configura apenas RB0 e RB3 como entradas digitais
	MOVLW      9
	MOVWF      TRISB+0
;SensorDistancia.c,69 :: 		PORTA = 0xFF; // Inicia todo o porta em High
	MOVLW      255
	MOVWF      PORTA+0
;SensorDistancia.c,70 :: 		PORTB = 0x00; // Inicia todo o portb em Low
	CLRF       PORTB+0
;SensorDistancia.c,72 :: 		lcd_init(); // Inicia lcd
	CALL       _Lcd_Init+0
;SensorDistancia.c,73 :: 		lcd_cmd(_LCD_CURSOR_OFF); // Desliga cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;SensorDistancia.c,74 :: 		lcd_cmd(_LCD_CLEAR); // Apaga caracteres display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;SensorDistancia.c,75 :: 		lcd_out(1,1,"Distancia"); // Escreve na primeira linha
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_SensorDistancia+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;SensorDistancia.c,76 :: 		lcd_out(2,14,"cm"); // Coloca a unidade do valos lido, no final da segunda linha
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_SensorDistancia+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;SensorDistancia.c,77 :: 		delay_ms(100); // Atraso de inicialização do display
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
;SensorDistancia.c,79 :: 		while(1){
L_main6:
;SensorDistancia.c,81 :: 		trigger();
	CALL       _trigger+0
;SensorDistancia.c,83 :: 		delay_ms(100);
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
;SensorDistancia.c,85 :: 		tempoH = (tmrH << 8) + tmrL; // Faz tempoH = 0b tmrH tmrL, sendo tmrH o mais sig, e o tmrL o menos sig.
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
;SensorDistancia.c,87 :: 		distancia = tempoH / 58;
	MOVLW      58
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _distancia+0
;SensorDistancia.c,89 :: 		IntToStr(distancia, txt);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;SensorDistancia.c,91 :: 		lcd_out(2,8,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;SensorDistancia.c,92 :: 		}
	GOTO       L_main6
;SensorDistancia.c,93 :: 		}
	GOTO       $+0
; end of _main

_trigger:

;SensorDistancia.c,95 :: 		void trigger(){
;SensorDistancia.c,97 :: 		trig = 0x01;
	BSF        RB0_bit+0, 0
;SensorDistancia.c,98 :: 		delay_ms(10);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_trigger9:
	DECFSZ     R13+0, 1
	GOTO       L_trigger9
	DECFSZ     R12+0, 1
	GOTO       L_trigger9
	NOP
	NOP
;SensorDistancia.c,99 :: 		trig = 0x00;
	BCF        RB0_bit+0, 0
;SensorDistancia.c,100 :: 		}
	RETURN
; end of _trigger

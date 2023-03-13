
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Timer0Timer1.c,25 :: 		void interrupt(){
;Timer0Timer1.c,27 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;Timer0Timer1.c,29 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;Timer0Timer1.c,30 :: 		TMR0 = 0x06;
	MOVLW      6
	MOVWF      TMR0+0
;Timer0Timer1.c,32 :: 		cont1++;
	INCF       _cont1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cont1+1, 1
;Timer0Timer1.c,34 :: 		if(cont1 == 500){
	MOVF       _cont1+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt10
	MOVLW      244
	XORWF      _cont1+0, 0
L__interrupt10:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;Timer0Timer1.c,36 :: 		cont1 = 0x00;
	CLRF       _cont1+0
	CLRF       _cont1+1
;Timer0Timer1.c,38 :: 		luzLcd = ~luzLcd;
	MOVLW      8
	XORWF      RB3_bit+0, 1
;Timer0Timer1.c,39 :: 		}
L_interrupt1:
;Timer0Timer1.c,40 :: 		}
L_interrupt0:
;Timer0Timer1.c,42 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt2
;Timer0Timer1.c,44 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;Timer0Timer1.c,45 :: 		TMR1H = 0xCF;
	MOVLW      207
	MOVWF      TMR1H+0
;Timer0Timer1.c,46 :: 		TMR1L = 0x2C;
	MOVLW      44
	MOVWF      TMR1L+0
;Timer0Timer1.c,48 :: 		cont2++;
	INCF       _cont2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cont2+1, 1
;Timer0Timer1.c,50 :: 		if(cont2 == 10){
	MOVLW      0
	XORWF      _cont2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt11
	MOVLW      10
	XORWF      _cont2+0, 0
L__interrupt11:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;Timer0Timer1.c,52 :: 		cont2 = 0;
	CLRF       _cont2+0
	CLRF       _cont2+1
;Timer0Timer1.c,54 :: 		change = ~change;
	MOVLW
	XORWF      _change+0, 1
;Timer0Timer1.c,55 :: 		}
L_interrupt3:
;Timer0Timer1.c,56 :: 		}
L_interrupt2:
;Timer0Timer1.c,57 :: 		}
L__interrupt9:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Timer0Timer1.c,79 :: 		void main() {
;Timer0Timer1.c,81 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;Timer0Timer1.c,82 :: 		T1CON = 0x31; // Configura o prescaler do timer1 para 1:8 e ativa o timer1
	MOVLW      49
	MOVWF      T1CON+0
;Timer0Timer1.c,83 :: 		OPTION_REG = 0x81; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:4
	MOVLW      129
	MOVWF      OPTION_REG+0
;Timer0Timer1.c,84 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;Timer0Timer1.c,85 :: 		PEIE_bit = 0x01; // Habilita a interrupção por perifericos
	BSF        PEIE_bit+0, 6
;Timer0Timer1.c,86 :: 		T0IE_bit = 0x01; // Habilita a interrupção do timer0
	BSF        T0IE_bit+0, 5
;Timer0Timer1.c,87 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção do timer1
	BSF        TMR1IE_bit+0, 0
;Timer0Timer1.c,89 :: 		TMR0 = 0x06; // Inicia a contagem do timer0 em 6
	MOVLW      6
	MOVWF      TMR0+0
;Timer0Timer1.c,90 :: 		TMR1H = 0xCF; // Inicia a contagem do timer1 em 53036
	MOVLW      207
	MOVWF      TMR1H+0
;Timer0Timer1.c,91 :: 		TMR1L = 0x2C;
	MOVLW      44
	MOVWF      TMR1L+0
;Timer0Timer1.c,92 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;Timer0Timer1.c,93 :: 		TRISB = 0x00; // COnfigura todo portb como saída digital
	CLRF       TRISB+0
;Timer0Timer1.c,94 :: 		PORTA = 0xFF; // Inicia todo porta em High
	MOVLW      255
	MOVWF      PORTA+0
;Timer0Timer1.c,95 :: 		PORTB = 0x00; // Inicia todo portb em Low
	CLRF       PORTB+0
;Timer0Timer1.c,97 :: 		change = 0x00;
	BCF        _change+0, BitPos(_change+0)
;Timer0Timer1.c,99 :: 		lcd_init();
	CALL       _Lcd_Init+0
;Timer0Timer1.c,100 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Timer0Timer1.c,101 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Timer0Timer1.c,102 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
	NOP
;Timer0Timer1.c,104 :: 		while(1){
L_main5:
;Timer0Timer1.c,106 :: 		if(!change)
	BTFSC      _change+0, BitPos(_change+0)
	GOTO       L_main7
;Timer0Timer1.c,107 :: 		lcd_out(1,2,txt1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _txt1+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main8
L_main7:
;Timer0Timer1.c,109 :: 		lcd_out(1,2,txt2);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _txt2+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main8:
;Timer0Timer1.c,110 :: 		}
	GOTO       L_main5
;Timer0Timer1.c,111 :: 		}
	GOTO       $+0
; end of _main

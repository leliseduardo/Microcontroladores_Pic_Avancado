
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;GeradorPwmProg.c,55 :: 		void interrupt(){
;GeradorPwmProg.c,58 :: 		if(TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;GeradorPwmProg.c,60 :: 		TMR0IF_bit = 0x00;
	BCF        TMR0IF_bit+0, 2
;GeradorPwmProg.c,61 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;GeradorPwmProg.c,63 :: 		if(col1 && control == 0x01){
	BTFSS      RB1_bit+0, 1
	GOTO       L_interrupt3
	MOVF       _control+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
L__interrupt44:
;GeradorPwmProg.c,64 :: 		col1 = 0x00;
	BCF        RB1_bit+0, 1
;GeradorPwmProg.c,65 :: 		col2 = 0x01;
	BSF        RB2_bit+0, 2
;GeradorPwmProg.c,66 :: 		col3 = 0x01;
	BSF        RB3_bit+0, 3
;GeradorPwmProg.c,67 :: 		control = 0x02;
	MOVLW      2
	MOVWF      _control+0
;GeradorPwmProg.c,69 :: 		if(!lina)
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt4
;GeradorPwmProg.c,70 :: 		guardaNum(1);
	MOVLW      1
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt5
L_interrupt4:
;GeradorPwmProg.c,71 :: 		else if(!linb)
	BTFSC      RB5_bit+0, 5
	GOTO       L_interrupt6
;GeradorPwmProg.c,72 :: 		guardaNum(4);
	MOVLW      4
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt7
L_interrupt6:
;GeradorPwmProg.c,73 :: 		else if(!linc)
	BTFSC      RB6_bit+0, 6
	GOTO       L_interrupt8
;GeradorPwmProg.c,74 :: 		guardaNum(7);
	MOVLW      7
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt9
L_interrupt8:
;GeradorPwmProg.c,75 :: 		else if(!lind)
	BTFSC      RB7_bit+0, 7
	GOTO       L_interrupt10
;GeradorPwmProg.c,76 :: 		aux = 1;
	MOVLW      1
	MOVWF      _aux+0
L_interrupt10:
L_interrupt9:
L_interrupt7:
L_interrupt5:
;GeradorPwmProg.c,78 :: 		}
	GOTO       L_interrupt11
L_interrupt3:
;GeradorPwmProg.c,79 :: 		else if(col2 && control == 0x02){
	BTFSS      RB2_bit+0, 2
	GOTO       L_interrupt14
	MOVF       _control+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt14
L__interrupt43:
;GeradorPwmProg.c,80 :: 		col1 = 0x01;
	BSF        RB1_bit+0, 1
;GeradorPwmProg.c,81 :: 		col2 = 0x00;
	BCF        RB2_bit+0, 2
;GeradorPwmProg.c,82 :: 		col3 = 0x01;
	BSF        RB3_bit+0, 3
;GeradorPwmProg.c,83 :: 		control = 0x03;
	MOVLW      3
	MOVWF      _control+0
;GeradorPwmProg.c,85 :: 		if(!lina)
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt15
;GeradorPwmProg.c,86 :: 		guardaNum(2);
	MOVLW      2
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt16
L_interrupt15:
;GeradorPwmProg.c,87 :: 		else if(!linb)
	BTFSC      RB5_bit+0, 5
	GOTO       L_interrupt17
;GeradorPwmProg.c,88 :: 		guardaNum(5);
	MOVLW      5
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt18
L_interrupt17:
;GeradorPwmProg.c,89 :: 		else if(!linc)
	BTFSC      RB6_bit+0, 6
	GOTO       L_interrupt19
;GeradorPwmProg.c,90 :: 		guardaNum(8);
	MOVLW      8
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt20
L_interrupt19:
;GeradorPwmProg.c,91 :: 		else if(!lind)
	BTFSC      RB7_bit+0, 7
	GOTO       L_interrupt21
;GeradorPwmProg.c,92 :: 		guardaNum(0);
	CLRF       FARG_guardaNum_num+0
	CLRF       FARG_guardaNum_num+1
	CALL       _guardaNum+0
L_interrupt21:
L_interrupt20:
L_interrupt18:
L_interrupt16:
;GeradorPwmProg.c,94 :: 		}
	GOTO       L_interrupt22
L_interrupt14:
;GeradorPwmProg.c,95 :: 		else if(col3 && control == 0x03){
	BTFSS      RB3_bit+0, 3
	GOTO       L_interrupt25
	MOVF       _control+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt25
L__interrupt42:
;GeradorPwmProg.c,96 :: 		col1 = 0x01;
	BSF        RB1_bit+0, 1
;GeradorPwmProg.c,97 :: 		col2 = 0x01;
	BSF        RB2_bit+0, 2
;GeradorPwmProg.c,98 :: 		col3 = 0x00;
	BCF        RB3_bit+0, 3
;GeradorPwmProg.c,99 :: 		control = 0x01;
	MOVLW      1
	MOVWF      _control+0
;GeradorPwmProg.c,101 :: 		if(!lina)
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt26
;GeradorPwmProg.c,102 :: 		guardaNum(3);
	MOVLW      3
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt27
L_interrupt26:
;GeradorPwmProg.c,103 :: 		else if(!linb)
	BTFSC      RB5_bit+0, 5
	GOTO       L_interrupt28
;GeradorPwmProg.c,104 :: 		guardaNum(6);
	MOVLW      6
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt29
L_interrupt28:
;GeradorPwmProg.c,105 :: 		else if(!linc)
	BTFSC      RB6_bit+0, 6
	GOTO       L_interrupt30
;GeradorPwmProg.c,106 :: 		guardaNum(9);
	MOVLW      9
	MOVWF      FARG_guardaNum_num+0
	MOVLW      0
	MOVWF      FARG_guardaNum_num+1
	CALL       _guardaNum+0
	GOTO       L_interrupt31
L_interrupt30:
;GeradorPwmProg.c,107 :: 		else if(!lind)
	BTFSC      RB7_bit+0, 7
	GOTO       L_interrupt32
;GeradorPwmProg.c,108 :: 		dutyHalf(50);
	MOVLW      50
	MOVWF      FARG_dutyHalf_duty+0
	MOVLW      0
	MOVWF      FARG_dutyHalf_duty+1
	CALL       _dutyHalf+0
L_interrupt32:
L_interrupt31:
L_interrupt29:
L_interrupt27:
;GeradorPwmProg.c,110 :: 		}
L_interrupt25:
L_interrupt22:
L_interrupt11:
;GeradorPwmProg.c,111 :: 		}
L_interrupt0:
;GeradorPwmProg.c,112 :: 		}
L__interrupt45:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;GeradorPwmProg.c,114 :: 		void main() {
;GeradorPwmProg.c,116 :: 		CMCON = 0x07; // Desativa os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;GeradorPwmProg.c,117 :: 		OPTION_REG = 0x87; // Desativa os pull-ups internos e configura o prescaler para 1:128
	MOVLW      135
	MOVWF      OPTION_REG+0
;GeradorPwmProg.c,118 :: 		GIE_bit = 0x01; // Ativa a interrupção global
	BSF        GIE_bit+0, 7
;GeradorPwmProg.c,119 :: 		PEIE_bit = 0x01; // Ativa a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;GeradorPwmProg.c,120 :: 		TMR0IE_bit = 0x01; // Ativa a interrupção do timer0 por estouro
	BSF        TMR0IE_bit+0, 5
;GeradorPwmProg.c,121 :: 		TMR0 = 0x00;
	CLRF       TMR0+0
;GeradorPwmProg.c,123 :: 		TRISB = 0xF0; // Faz o primeiro nibble do portb ser entrada
	MOVLW      240
	MOVWF      TRISB+0
;GeradorPwmProg.c,124 :: 		TRISC = 0xFB; // Apenas ccp1 como saída
	MOVLW      251
	MOVWF      TRISC+0
;GeradorPwmProg.c,125 :: 		TRISD = 0x03; // Apenas RD0 e RD1 como entrada
	MOVLW      3
	MOVWF      TRISD+0
;GeradorPwmProg.c,126 :: 		PORTB = 0x0F; // Inicia o primeiro nibble do portb em High
	MOVLW      15
	MOVWF      PORTB+0
;GeradorPwmProg.c,132 :: 		PWM1_Init(2000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;GeradorPwmProg.c,136 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;GeradorPwmProg.c,137 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;GeradorPwmProg.c,138 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;GeradorPwmProg.c,139 :: 		Lcd_Out(1, 4, "Ajuste de PWM");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_GeradorPwmProg+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;GeradorPwmProg.c,143 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;GeradorPwmProg.c,145 :: 		while(1){
L_main33:
;GeradorPwmProg.c,147 :: 		escreve;
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_GeradorPwmProg+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      48
	ADDWF      _dezena+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	MOVLW      48
	ADDWF      _unidade+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;GeradorPwmProg.c,149 :: 		if(aux == 1){
	MOVF       _aux+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main35
;GeradorPwmProg.c,150 :: 		numero = concatenaNum(dezena, unidade);
	MOVF       _dezena+0, 0
	MOVWF      FARG_concatenaNum_dez+0
	CLRF       FARG_concatenaNum_dez+1
	MOVF       _unidade+0, 0
	MOVWF      FARG_concatenaNum_uni+0
	CLRF       FARG_concatenaNum_uni+1
	CALL       _concatenaNum+0
	MOVF       R0+0, 0
	MOVWF      _numero+0
;GeradorPwmProg.c,152 :: 		guardaNume = 0;
	CLRF       _guardaNume+0
;GeradorPwmProg.c,153 :: 		}
L_main35:
;GeradorPwmProg.c,155 :: 		PWM1_Set_Duty((numero*255)/100);
	MOVF       _numero+0, 0
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;GeradorPwmProg.c,156 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	DECFSZ     R11+0, 1
	GOTO       L_main36
;GeradorPwmProg.c,157 :: 		}
	GOTO       L_main33
;GeradorPwmProg.c,158 :: 		}
	GOTO       $+0
; end of _main

_guardaNum:

;GeradorPwmProg.c,160 :: 		void guardaNum(unsigned num){
;GeradorPwmProg.c,162 :: 		if(guardaNume == 0){
	MOVF       _guardaNume+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_guardaNum37
;GeradorPwmProg.c,163 :: 		dezena = num;
	MOVF       FARG_guardaNum_num+0, 0
	MOVWF      _dezena+0
;GeradorPwmProg.c,164 :: 		delay_ms(300);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_guardaNum38:
	DECFSZ     R13+0, 1
	GOTO       L_guardaNum38
	DECFSZ     R12+0, 1
	GOTO       L_guardaNum38
	DECFSZ     R11+0, 1
	GOTO       L_guardaNum38
	NOP
;GeradorPwmProg.c,165 :: 		guardaNume = 1;
	MOVLW      1
	MOVWF      _guardaNume+0
;GeradorPwmProg.c,166 :: 		}
	GOTO       L_guardaNum39
L_guardaNum37:
;GeradorPwmProg.c,168 :: 		unidade = num;
	MOVF       FARG_guardaNum_num+0, 0
	MOVWF      _unidade+0
;GeradorPwmProg.c,169 :: 		delay_ms(300);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_guardaNum40:
	DECFSZ     R13+0, 1
	GOTO       L_guardaNum40
	DECFSZ     R12+0, 1
	GOTO       L_guardaNum40
	DECFSZ     R11+0, 1
	GOTO       L_guardaNum40
	NOP
;GeradorPwmProg.c,170 :: 		}
L_guardaNum39:
;GeradorPwmProg.c,171 :: 		}
	RETURN
; end of _guardaNum

_concatenaNum:

;GeradorPwmProg.c,173 :: 		char concatenaNum(unsigned dez, unsigned uni){
;GeradorPwmProg.c,177 :: 		num = (dez*10) + uni;
	MOVF       FARG_concatenaNum_dez+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       FARG_concatenaNum_uni+0, 0
	ADDWF      R0+0, 1
;GeradorPwmProg.c,179 :: 		aux = 0;
	CLRF       _aux+0
;GeradorPwmProg.c,181 :: 		return num;
;GeradorPwmProg.c,182 :: 		}
	RETURN
; end of _concatenaNum

_dutyHalf:

;GeradorPwmProg.c,184 :: 		void dutyHalf(unsigned duty){
;GeradorPwmProg.c,185 :: 		numero = duty;
	MOVF       FARG_dutyHalf_duty+0, 0
	MOVWF      _numero+0
;GeradorPwmProg.c,186 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_dutyHalf41:
	DECFSZ     R13+0, 1
	GOTO       L_dutyHalf41
	DECFSZ     R12+0, 1
	GOTO       L_dutyHalf41
	DECFSZ     R11+0, 1
	GOTO       L_dutyHalf41
;GeradorPwmProg.c,187 :: 		dezena = 5;
	MOVLW      5
	MOVWF      _dezena+0
;GeradorPwmProg.c,188 :: 		unidade = 0;
	CLRF       _unidade+0
;GeradorPwmProg.c,189 :: 		}
	RETURN
; end of _dutyHalf

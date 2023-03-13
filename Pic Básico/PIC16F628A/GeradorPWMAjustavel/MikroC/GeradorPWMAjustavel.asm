
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;GeradorPWMAjustavel.c,30 :: 		void interrupt(){
;GeradorPWMAjustavel.c,32 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;GeradorPWMAjustavel.c,34 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;GeradorPWMAjustavel.c,35 :: 		TMR0 = 0x64;
	MOVLW      100
	MOVWF      TMR0+0
;GeradorPWMAjustavel.c,37 :: 		cont++;
	INCF       _cont+0, 1
;GeradorPWMAjustavel.c,39 :: 		if(cont == 0x02){
	MOVF       _cont+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;GeradorPWMAjustavel.c,41 :: 		cont = 0x00;
	CLRF       _cont+0
;GeradorPWMAjustavel.c,43 :: 		if(!aumentaDuty)
	BTFSC      RA0_bit+0, 0
	GOTO       L_interrupt2
;GeradorPWMAjustavel.c,44 :: 		duty++;
	INCF       _duty+0, 1
L_interrupt2:
;GeradorPWMAjustavel.c,45 :: 		if(!diminuiDuty)
	BTFSC      RA1_bit+0, 1
	GOTO       L_interrupt3
;GeradorPWMAjustavel.c,46 :: 		duty--;
	DECF       _duty+0, 1
L_interrupt3:
;GeradorPWMAjustavel.c,47 :: 		}
L_interrupt1:
;GeradorPWMAjustavel.c,48 :: 		}
L_interrupt0:
;GeradorPWMAjustavel.c,49 :: 		}
L__interrupt8:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;GeradorPWMAjustavel.c,51 :: 		void main() {
;GeradorPWMAjustavel.c,53 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;GeradorPWMAjustavel.c,54 :: 		OPTION_REG = 0x86; // Desabilita os pull-ups internos e configura o prescaler para 1:128
	MOVLW      134
	MOVWF      OPTION_REG+0
;GeradorPWMAjustavel.c,55 :: 		INTCON = 0XA0; // Habilita a interrupção global e habilita a interrupção pelo timer0
	MOVLW      160
	MOVWF      INTCON+0
;GeradorPWMAjustavel.c,56 :: 		TMR0 = 0x64; // Inicia a contagem em 100 decimal, logo, o tempo de overflow = 1us x 128 x 156 = 19.9ms
	MOVLW      100
	MOVWF      TMR0+0
;GeradorPWMAjustavel.c,58 :: 		TRISA = 0xFF; // Configura todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;GeradorPWMAjustavel.c,59 :: 		TRISB = 0x01; // Configura apenas RB0 como entrada digital
	MOVLW      1
	MOVWF      TRISB+0
;GeradorPWMAjustavel.c,60 :: 		PORTA = 0xFF; // Inicia todo porta em High
	MOVLW      255
	MOVWF      PORTA+0
;GeradorPWMAjustavel.c,61 :: 		PORTB = 0x00; // Inicia todo portb em Low
	CLRF       PORTB+0
;GeradorPWMAjustavel.c,63 :: 		lcd_init();
	CALL       _Lcd_Init+0
;GeradorPWMAjustavel.c,64 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;GeradorPWMAjustavel.c,65 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;GeradorPWMAjustavel.c,66 :: 		lcd_out(1,1,texto);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _texto+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;GeradorPWMAjustavel.c,67 :: 		delay_ms(100);
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
;GeradorPWMAjustavel.c,69 :: 		PWM1_Init(freq);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;GeradorPWMAjustavel.c,70 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;GeradorPWMAjustavel.c,71 :: 		PWM1_Set_Duty(duty);
	MOVF       _duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;GeradorPWMAjustavel.c,73 :: 		while(1){
L_main5:
;GeradorPWMAjustavel.c,75 :: 		PWM1_Set_Duty(duty);
	MOVF       _duty+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;GeradorPWMAjustavel.c,77 :: 		IntToStr(duty, txt);
	MOVF       _duty+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;GeradorPWMAjustavel.c,79 :: 		lcd_out(2,2, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;GeradorPWMAjustavel.c,81 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
	NOP
;GeradorPWMAjustavel.c,82 :: 		}
	GOTO       L_main5
;GeradorPWMAjustavel.c,83 :: 		}
	GOTO       $+0
; end of _main

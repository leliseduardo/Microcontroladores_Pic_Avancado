
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SensorPassagemModulado.c,42 :: 		void interrupt(){
;SensorPassagemModulado.c,44 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;SensorPassagemModulado.c,46 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;SensorPassagemModulado.c,47 :: 		TMR0 = 0x06;
	MOVLW      6
	MOVWF      TMR0+0
;SensorPassagemModulado.c,49 :: 		ledIR = ~ledIR;
	MOVLW      4
	XORWF      RB2_bit+0, 1
;SensorPassagemModulado.c,50 :: 		}
L_interrupt0:
;SensorPassagemModulado.c,52 :: 		if(CCP1IF_bit){
	BTFSS      CCP1IF_bit+0, 2
	GOTO       L_interrupt1
;SensorPassagemModulado.c,54 :: 		CCP1IF_bit = 0x00;
	BCF        CCP1IF_bit+0, 2
;SensorPassagemModulado.c,56 :: 		if(!flag0.B0){
	BTFSC      _flag0+0, 0
	GOTO       L_interrupt2
;SensorPassagemModulado.c,58 :: 		tempo1 = (CCPR1H << 8) + CCPR1L;
	MOVF       CCPR1H+0, 0
	MOVWF      _tempo1+1
	CLRF       _tempo1+0
	MOVF       CCPR1L+0, 0
	ADDWF      _tempo1+0, 1
	BTFSC      STATUS+0, 0
	INCF       _tempo1+1, 1
;SensorPassagemModulado.c,60 :: 		flag0.B0 = 0x01;
	BSF        _flag0+0, 0
;SensorPassagemModulado.c,61 :: 		}
	GOTO       L_interrupt3
L_interrupt2:
;SensorPassagemModulado.c,64 :: 		tempo2 = (CCPR1H << 8) + CCPR1L;
	MOVF       CCPR1H+0, 0
	MOVWF      _tempo2+1
	CLRF       _tempo2+0
	MOVF       CCPR1L+0, 0
	ADDWF      _tempo2+0, 1
	BTFSC      STATUS+0, 0
	INCF       _tempo2+1, 1
;SensorPassagemModulado.c,66 :: 		flag0.B0 = 0x00;
	BCF        _flag0+0, 0
;SensorPassagemModulado.c,68 :: 		}
L_interrupt3:
;SensorPassagemModulado.c,69 :: 		}
L_interrupt1:
;SensorPassagemModulado.c,70 :: 		}
L__interrupt12:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SensorPassagemModulado.c,72 :: 		void main() {
;SensorPassagemModulado.c,74 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;SensorPassagemModulado.c,75 :: 		T1CON = 0x01; // Configura o prescaler para 1:1 e habilita o contador do timer1 (TMR1)
	MOVLW      1
	MOVWF      T1CON+0
;SensorPassagemModulado.c,76 :: 		CCP1CON = 0x07; // Habilita o modo captura com prescaler de 16, isto é, 16 bordas de subida para captura
	MOVLW      7
	MOVWF      CCP1CON+0
;SensorPassagemModulado.c,77 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;SensorPassagemModulado.c,78 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;SensorPassagemModulado.c,79 :: 		CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo cpp, no caso, no modo captura
	BSF        CCP1IE_bit+0, 2
;SensorPassagemModulado.c,80 :: 		OPTION_REG = 0x80; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:2
	MOVLW      128
	MOVWF      OPTION_REG+0
;SensorPassagemModulado.c,81 :: 		T0IE_bit = 0x01; // Habilita a interrupção do tmr0
	BSF        T0IE_bit+0, 5
;SensorPassagemModulado.c,82 :: 		TMR0 = 0x06; // Inicia a contagem do tmr0 em 6, o que faze ele contar até 250, pois 256 - 6 = 250
	MOVLW      6
	MOVWF      TMR0+0
;SensorPassagemModulado.c,85 :: 		TRISA = 0xFF; // Configura o todo porta como entrada digital
	MOVLW      255
	MOVWF      TRISA+0
;SensorPassagemModulado.c,86 :: 		TRISB = 0xF9; // Configura apenas RB1 e RB2 como saídas digitais
	MOVLW      249
	MOVWF      TRISB+0
;SensorPassagemModulado.c,87 :: 		PORTA = 0xFF; // Inicia todo porta em High
	MOVLW      255
	MOVWF      PORTA+0
;SensorPassagemModulado.c,88 :: 		PORTB = 0xF0; // Inicia o primeiro neeble em High e o segundo em Low
	MOVLW      240
	MOVWF      PORTB+0
;SensorPassagemModulado.c,90 :: 		while(1){
L_main4:
;SensorPassagemModulado.c,92 :: 		tempo2 = abs(tempo2 - tempo1); // Modulo da subtração
	MOVF       _tempo1+0, 0
	SUBWF      _tempo2+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       _tempo1+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _tempo2+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	MOVWF      _tempo2+0
	MOVF       R0+1, 0
	MOVWF      _tempo2+1
;SensorPassagemModulado.c,94 :: 		tempo2 = (tempo2) >> 4; // Divide por 16
	MOVLW      4
	MOVWF      R2+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R2+0, 0
L__main13:
	BTFSC      STATUS+0, 2
	GOTO       L__main14
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+1, 7
	ADDLW      255
	GOTO       L__main13
L__main14:
	MOVF       R4+0, 0
	MOVWF      _tempo2+0
	MOVF       R4+1, 0
	MOVWF      _tempo2+1
;SensorPassagemModulado.c,96 :: 		frequencia = 1 / (tempo2 * 1E-6);
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
	CALL       _Word2Double+0
	MOVLW      189
	MOVWF      R4+0
	MOVLW      55
	MOVWF      R4+1
	MOVLW      6
	MOVWF      R4+2
	MOVLW      107
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      0
	MOVWF      R0+2
	MOVLW      127
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	CALL       _Double2Longword+0
	MOVF       R0+0, 0
	MOVWF      _frequencia+0
	MOVF       R0+1, 0
	MOVWF      _frequencia+1
	MOVF       R0+2, 0
	MOVWF      _frequencia+2
	MOVF       R0+3, 0
	MOVWF      _frequencia+3
;SensorPassagemModulado.c,98 :: 		if(frequencia > 950 && frequencia < 1050)
	MOVF       R0+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       R0+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       R0+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       R0+0, 0
	SUBLW      182
L__main15:
	BTFSC      STATUS+0, 0
	GOTO       L_main8
	MOVLW      0
	SUBWF      _frequencia+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      0
	SUBWF      _frequencia+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      4
	SUBWF      _frequencia+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      26
	SUBWF      _frequencia+0, 0
L__main16:
	BTFSC      STATUS+0, 0
	GOTO       L_main8
L__main11:
;SensorPassagemModulado.c,99 :: 		ledBarreira = 0x00;
	BCF        RB1_bit+0, 1
	GOTO       L_main9
L_main8:
;SensorPassagemModulado.c,101 :: 		ledBarreira = 0x01;
	BSF        RB1_bit+0, 1
L_main9:
;SensorPassagemModulado.c,103 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	NOP
	NOP
;SensorPassagemModulado.c,104 :: 		}
	GOTO       L_main4
;SensorPassagemModulado.c,105 :: 		}
	GOTO       $+0
; end of _main

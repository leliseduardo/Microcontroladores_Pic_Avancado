
_main:

;Contador0a99.c,7 :: 		void main() {
;Contador0a99.c,9 :: 		CMCON = 0x07; // Desabilita os comparadores analogicos internos
	MOVLW      7
	MOVWF      CMCON+0
;Contador0a99.c,10 :: 		TRISB = 0X00; // Ou 0b00000000 Seleciona todo o portb como saída digital
	CLRF       TRISB+0
;Contador0a99.c,11 :: 		PORTB = 0X00; // Inicia todo o portb com nivel logico baixo
	CLRF       PORTB+0
;Contador0a99.c,14 :: 		while(1){
L_main0:
;Contador0a99.c,16 :: 		contUnidades++;
	INCF       _contUnidades+0, 1
;Contador0a99.c,18 :: 		unidades(contUnidades);
	MOVF       _contUnidades+0, 0
	MOVWF      FARG_unidades_contUnidades+0
	CALL       _unidades+0
;Contador0a99.c,19 :: 		dezenas(contDezenas);
	MOVF       _contDezenas+0, 0
	MOVWF      FARG_dezenas_contDezenas+0
	CALL       _dezenas+0
;Contador0a99.c,21 :: 		if(contUnidades == 10){
	MOVF       _contUnidades+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;Contador0a99.c,22 :: 		contDezenas++;
	INCF       _contDezenas+0, 1
;Contador0a99.c,23 :: 		contUnidades = 0;
	CLRF       _contUnidades+0
;Contador0a99.c,25 :: 		if(contDezenas == 10)
	MOVF       _contDezenas+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;Contador0a99.c,26 :: 		contDezenas = 0;
	CLRF       _contDezenas+0
L_main3:
;Contador0a99.c,28 :: 		unidades(contUnidades);
	MOVF       _contUnidades+0, 0
	MOVWF      FARG_unidades_contUnidades+0
	CALL       _unidades+0
;Contador0a99.c,29 :: 		dezenas(contDezenas);
	MOVF       _contDezenas+0, 0
	MOVWF      FARG_dezenas_contDezenas+0
	CALL       _dezenas+0
;Contador0a99.c,31 :: 		}
L_main2:
;Contador0a99.c,33 :: 		delay_ms(300);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      157
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;Contador0a99.c,35 :: 		}
	GOTO       L_main0
;Contador0a99.c,37 :: 		}
	GOTO       $+0
; end of _main

_unidades:

;Contador0a99.c,39 :: 		void unidades(char contUnidades){
;Contador0a99.c,41 :: 		switch(contDezenas){
	GOTO       L_unidades5
;Contador0a99.c,42 :: 		case 0:
L_unidades7:
;Contador0a99.c,43 :: 		RB0_bit = 0x00;
	BCF        RB0_bit+0, 0
;Contador0a99.c,44 :: 		RB1_bit = 0x00;
	BCF        RB1_bit+0, 1
;Contador0a99.c,45 :: 		RB2_bit = 0x00;
	BCF        RB2_bit+0, 2
;Contador0a99.c,46 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,47 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,48 :: 		case 1:
L_unidades8:
;Contador0a99.c,49 :: 		RB0_bit = 0x01;
	BSF        RB0_bit+0, 0
;Contador0a99.c,50 :: 		RB1_bit = 0x00;
	BCF        RB1_bit+0, 1
;Contador0a99.c,51 :: 		RB2_bit = 0x00;
	BCF        RB2_bit+0, 2
;Contador0a99.c,52 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,53 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,54 :: 		case 2:
L_unidades9:
;Contador0a99.c,55 :: 		RB0_bit = 0x00;
	BCF        RB0_bit+0, 0
;Contador0a99.c,56 :: 		RB1_bit = 0x01;
	BSF        RB1_bit+0, 1
;Contador0a99.c,57 :: 		RB2_bit = 0x00;
	BCF        RB2_bit+0, 2
;Contador0a99.c,58 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,59 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,60 :: 		case 3:
L_unidades10:
;Contador0a99.c,61 :: 		RB0_bit = 0x01;
	BSF        RB0_bit+0, 0
;Contador0a99.c,62 :: 		RB1_bit = 0x01;
	BSF        RB1_bit+0, 1
;Contador0a99.c,63 :: 		RB2_bit = 0x00;
	BCF        RB2_bit+0, 2
;Contador0a99.c,64 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,65 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,66 :: 		case 4:
L_unidades11:
;Contador0a99.c,67 :: 		RB0_bit = 0x00;
	BCF        RB0_bit+0, 0
;Contador0a99.c,68 :: 		RB1_bit = 0x00;
	BCF        RB1_bit+0, 1
;Contador0a99.c,69 :: 		RB2_bit = 0x01;
	BSF        RB2_bit+0, 2
;Contador0a99.c,70 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,71 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,72 :: 		case 5:
L_unidades12:
;Contador0a99.c,73 :: 		RB0_bit = 0x01;
	BSF        RB0_bit+0, 0
;Contador0a99.c,74 :: 		RB1_bit = 0x00;
	BCF        RB1_bit+0, 1
;Contador0a99.c,75 :: 		RB2_bit = 0x01;
	BSF        RB2_bit+0, 2
;Contador0a99.c,76 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,77 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,78 :: 		case 6:
L_unidades13:
;Contador0a99.c,79 :: 		RB0_bit = 0x00;
	BCF        RB0_bit+0, 0
;Contador0a99.c,80 :: 		RB1_bit = 0x01;
	BSF        RB1_bit+0, 1
;Contador0a99.c,81 :: 		RB2_bit = 0x01;
	BSF        RB2_bit+0, 2
;Contador0a99.c,82 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,83 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,84 :: 		case 7:
L_unidades14:
;Contador0a99.c,85 :: 		RB0_bit = 0x01;
	BSF        RB0_bit+0, 0
;Contador0a99.c,86 :: 		RB1_bit = 0x01;
	BSF        RB1_bit+0, 1
;Contador0a99.c,87 :: 		RB2_bit = 0x01;
	BSF        RB2_bit+0, 2
;Contador0a99.c,88 :: 		RB3_bit = 0x00;
	BCF        RB3_bit+0, 3
;Contador0a99.c,89 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,90 :: 		case 8:
L_unidades15:
;Contador0a99.c,91 :: 		RB0_bit = 0x00;
	BCF        RB0_bit+0, 0
;Contador0a99.c,92 :: 		RB1_bit = 0x00;
	BCF        RB1_bit+0, 1
;Contador0a99.c,93 :: 		RB2_bit = 0x00;
	BCF        RB2_bit+0, 2
;Contador0a99.c,94 :: 		RB3_bit = 0x01;
	BSF        RB3_bit+0, 3
;Contador0a99.c,95 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,96 :: 		case 9:
L_unidades16:
;Contador0a99.c,97 :: 		RB0_bit = 0x01;
	BSF        RB0_bit+0, 0
;Contador0a99.c,98 :: 		RB1_bit = 0x00;
	BCF        RB1_bit+0, 1
;Contador0a99.c,99 :: 		RB2_bit = 0x00;
	BCF        RB2_bit+0, 2
;Contador0a99.c,100 :: 		RB3_bit = 0x01;
	BSF        RB3_bit+0, 3
;Contador0a99.c,101 :: 		break;
	GOTO       L_unidades6
;Contador0a99.c,102 :: 		}
L_unidades5:
	MOVF       _contDezenas+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_unidades7
	MOVF       _contDezenas+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_unidades8
	MOVF       _contDezenas+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_unidades9
	MOVF       _contDezenas+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_unidades10
	MOVF       _contDezenas+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_unidades11
	MOVF       _contDezenas+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_unidades12
	MOVF       _contDezenas+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_unidades13
	MOVF       _contDezenas+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_unidades14
	MOVF       _contDezenas+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_unidades15
	MOVF       _contDezenas+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_unidades16
L_unidades6:
;Contador0a99.c,104 :: 		}
	RETURN
; end of _unidades

_dezenas:

;Contador0a99.c,106 :: 		void dezenas(char contDezenas){
;Contador0a99.c,108 :: 		switch(contUnidades){
	GOTO       L_dezenas17
;Contador0a99.c,109 :: 		case 0:
L_dezenas19:
;Contador0a99.c,110 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;Contador0a99.c,111 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;Contador0a99.c,112 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;Contador0a99.c,113 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,114 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,115 :: 		case 1:
L_dezenas20:
;Contador0a99.c,116 :: 		RB4_bit = 0x01;
	BSF        RB4_bit+0, 4
;Contador0a99.c,117 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;Contador0a99.c,118 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;Contador0a99.c,119 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,120 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,121 :: 		case 2:
L_dezenas21:
;Contador0a99.c,122 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;Contador0a99.c,123 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;Contador0a99.c,124 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;Contador0a99.c,125 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,126 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,127 :: 		case 3:
L_dezenas22:
;Contador0a99.c,128 :: 		RB4_bit = 0x01;
	BSF        RB4_bit+0, 4
;Contador0a99.c,129 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;Contador0a99.c,130 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;Contador0a99.c,131 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,132 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,133 :: 		case 4:
L_dezenas23:
;Contador0a99.c,134 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;Contador0a99.c,135 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;Contador0a99.c,136 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;Contador0a99.c,137 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,138 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,139 :: 		case 5:
L_dezenas24:
;Contador0a99.c,140 :: 		RB4_bit = 0x01;
	BSF        RB4_bit+0, 4
;Contador0a99.c,141 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;Contador0a99.c,142 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;Contador0a99.c,143 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,144 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,145 :: 		case 6:
L_dezenas25:
;Contador0a99.c,146 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;Contador0a99.c,147 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;Contador0a99.c,148 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;Contador0a99.c,149 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,150 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,151 :: 		case 7:
L_dezenas26:
;Contador0a99.c,152 :: 		RB4_bit = 0x01;
	BSF        RB4_bit+0, 4
;Contador0a99.c,153 :: 		RB5_bit = 0x01;
	BSF        RB5_bit+0, 5
;Contador0a99.c,154 :: 		RB6_bit = 0x01;
	BSF        RB6_bit+0, 6
;Contador0a99.c,155 :: 		RB7_bit = 0x00;
	BCF        RB7_bit+0, 7
;Contador0a99.c,156 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,157 :: 		case 8:
L_dezenas27:
;Contador0a99.c,158 :: 		RB4_bit = 0x00;
	BCF        RB4_bit+0, 4
;Contador0a99.c,159 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;Contador0a99.c,160 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;Contador0a99.c,161 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;Contador0a99.c,162 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,163 :: 		case 9:
L_dezenas28:
;Contador0a99.c,164 :: 		RB4_bit = 0x01;
	BSF        RB4_bit+0, 4
;Contador0a99.c,165 :: 		RB5_bit = 0x00;
	BCF        RB5_bit+0, 5
;Contador0a99.c,166 :: 		RB6_bit = 0x00;
	BCF        RB6_bit+0, 6
;Contador0a99.c,167 :: 		RB7_bit = 0x01;
	BSF        RB7_bit+0, 7
;Contador0a99.c,168 :: 		break;
	GOTO       L_dezenas18
;Contador0a99.c,169 :: 		}
L_dezenas17:
	MOVF       _contUnidades+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas19
	MOVF       _contUnidades+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas20
	MOVF       _contUnidades+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas21
	MOVF       _contUnidades+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas22
	MOVF       _contUnidades+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas23
	MOVF       _contUnidades+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas24
	MOVF       _contUnidades+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas25
	MOVF       _contUnidades+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas26
	MOVF       _contUnidades+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas27
	MOVF       _contUnidades+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_dezenas28
L_dezenas18:
;Contador0a99.c,171 :: 		}
	RETURN
; end of _dezenas

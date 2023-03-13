
_main:

;VoltimetroSimples.c,87 :: 		void main() {
;VoltimetroSimples.c,89 :: 		INTCON2 = 0x7F; // Ou 0b0111 1111, que habilita os pull-ups internos do portb
	MOVLW       127
	MOVWF       INTCON2+0 
;VoltimetroSimples.c,90 :: 		ADCON0 = 0x01; // Configura AN0 como canal analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;VoltimetroSimples.c,91 :: 		ADCON1 = 0x0E; // Configura o intervalo de leitura no pino AD, entre as tensões da fonte (VSS à VDD). Ainda, configura apenas AN0 como
	MOVLW       14
	MOVWF       ADCON1+0 
;VoltimetroSimples.c,93 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;VoltimetroSimples.c,94 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;VoltimetroSimples.c,95 :: 		LATB = 0x00; // Inicia RB0 em Low
	CLRF        LATB+0 
;VoltimetroSimples.c,97 :: 		while(1){
L_main0:
;VoltimetroSimples.c,99 :: 		volts(12);
	MOVLW       12
	MOVWF       FARG_volts_volt+0 
	MOVLW       0
	MOVWF       FARG_volts_volt+1 
	CALL        _volts+0, 0
;VoltimetroSimples.c,100 :: 		}
	GOTO        L_main0
;VoltimetroSimples.c,101 :: 		}
	GOTO        $+0
; end of _main

_volts:

;VoltimetroSimples.c,103 :: 		void volts(unsigned volt){
;VoltimetroSimples.c,107 :: 		if(!bot) flag.B0 = 0x01;
	BTFSC       RB1_bit+0, 1 
	GOTO        L_volts2
	BSF         _flag+0, 0 
L_volts2:
;VoltimetroSimples.c,109 :: 		if(bot && flag.B0){
	BTFSS       RB1_bit+0, 1 
	GOTO        L_volts5
	BTFSS       _flag+0, 0 
	GOTO        L_volts5
L__volts11:
;VoltimetroSimples.c,111 :: 		flag.B0 = 0x00;
	BCF         _flag+0, 0 
;VoltimetroSimples.c,113 :: 		aux = 1024/volt;
	MOVF        FARG_volts_volt+0, 0 
	MOVWF       R4 
	MOVF        FARG_volts_volt+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R0 
	MOVLW       4
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _aux+0 
	MOVF        R1, 0 
	MOVWF       _aux+1 
;VoltimetroSimples.c,115 :: 		adc = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;VoltimetroSimples.c,117 :: 		tensao = adc / aux;
	MOVF        _aux+0, 0 
	MOVWF       R4 
	MOVF        _aux+1, 0 
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _tensao+0 
	MOVF        R1, 0 
	MOVWF       _tensao+1 
;VoltimetroSimples.c,119 :: 		for(i = 0x00; i <= tensao; i++){
	CLRF        volts_i_L0+0 
	CLRF        volts_i_L0+1 
L_volts6:
	MOVF        volts_i_L0+1, 0 
	SUBWF       _tensao+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__volts12
	MOVF        volts_i_L0+0, 0 
	SUBWF       _tensao+0, 0 
L__volts12:
	BTFSS       STATUS+0, 0 
	GOTO        L_volts7
;VoltimetroSimples.c,121 :: 		led = 0x01;
	BSF         LATB0_bit+0, 0 
;VoltimetroSimples.c,122 :: 		delay_ms(300);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_volts9:
	DECFSZ      R13, 1, 1
	BRA         L_volts9
	DECFSZ      R12, 1, 1
	BRA         L_volts9
	DECFSZ      R11, 1, 1
	BRA         L_volts9
;VoltimetroSimples.c,123 :: 		led = 0x00;
	BCF         LATB0_bit+0, 0 
;VoltimetroSimples.c,124 :: 		delay_ms(300);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       134
	MOVWF       R12, 0
	MOVLW       153
	MOVWF       R13, 0
L_volts10:
	DECFSZ      R13, 1, 1
	BRA         L_volts10
	DECFSZ      R12, 1, 1
	BRA         L_volts10
	DECFSZ      R11, 1, 1
	BRA         L_volts10
;VoltimetroSimples.c,119 :: 		for(i = 0x00; i <= tensao; i++){
	INFSNZ      volts_i_L0+0, 1 
	INCF        volts_i_L0+1, 1 
;VoltimetroSimples.c,125 :: 		}
	GOTO        L_volts6
L_volts7:
;VoltimetroSimples.c,126 :: 		}
L_volts5:
;VoltimetroSimples.c,127 :: 		}
	RETURN      0
; end of _volts

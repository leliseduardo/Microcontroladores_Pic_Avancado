
_main:

;TecladoAnalogico.c,115 :: 		void main() {
;TecladoAnalogico.c,117 :: 		ADCON0 = 0x01; // Configura AN0 como canal analógico e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;TecladoAnalogico.c,118 :: 		ADCON1 = 0x0E; // Configura o intervalo de tensão como as tensões da fonte (VSS e VDD) e configura apenas AN0 como porta analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;TecladoAnalogico.c,120 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;TecladoAnalogico.c,121 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital
	MOVLW       254
	MOVWF       TRISB+0 
;TecladoAnalogico.c,122 :: 		led = 0x00; // Inicia RB0 em Low
	BCF         LATB0_bit+0, 0 
;TecladoAnalogico.c,124 :: 		while(1){
L_main0:
;TecladoAnalogico.c,126 :: 		leBotao();
	CALL        _leBotao+0, 0
;TecladoAnalogico.c,128 :: 		if(flagAux){
	BTFSS       _flag1+0, 7 
	GOTO        L_main2
;TecladoAnalogico.c,130 :: 		for(i = 0x00; i < pisca; i++){
	CLRF        _i+0 
L_main3:
	MOVF        _pisca+0, 0 
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;TecladoAnalogico.c,132 :: 		led = 0x01;
	BSF         LATB0_bit+0, 0 
;TecladoAnalogico.c,133 :: 		delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
;TecladoAnalogico.c,134 :: 		led = 0x00;
	BCF         LATB0_bit+0, 0 
;TecladoAnalogico.c,135 :: 		delay_ms(200);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
;TecladoAnalogico.c,130 :: 		for(i = 0x00; i < pisca; i++){
	INCF        _i+0, 1 
;TecladoAnalogico.c,136 :: 		}
	GOTO        L_main3
L_main4:
;TecladoAnalogico.c,138 :: 		flag0 = 0x00;
	CLRF        _flag0+0 
;TecladoAnalogico.c,139 :: 		flag1 = 0x00;
	CLRF        _flag1+0 
;TecladoAnalogico.c,140 :: 		flag2 = 0x00;
	CLRF        _flag2+0 
;TecladoAnalogico.c,141 :: 		flag3 = 0x00;
	CLRF        _flag3+0 
;TecladoAnalogico.c,142 :: 		}
L_main2:
;TecladoAnalogico.c,143 :: 		}
	GOTO        L_main0
;TecladoAnalogico.c,144 :: 		}
	GOTO        $+0
; end of _main

_leBotao:

;TecladoAnalogico.c,146 :: 		void leBotao(){
;TecladoAnalogico.c,148 :: 		adc = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;TecladoAnalogico.c,150 :: 		if(adc > 94 && adc < 108 ) bot1 = 0x01;
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao142
	MOVF        R0, 0 
	SUBLW       94
L__leBotao142:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao10
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao143
	MOVLW       108
	SUBWF       _adc+0, 0 
L__leBotao143:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao10
L__leBotao141:
	BSF         _flag0+0, 0 
	GOTO        L_leBotao11
L_leBotao10:
;TecladoAnalogico.c,151 :: 		else if(adc > 108 && adc < 132 ) bot2 = 0x01; // Intervalos de 10 a menos a 10 a mais do que o valor AD de cada botão
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao144
	MOVF        _adc+0, 0 
	SUBLW       108
L__leBotao144:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao14
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao145
	MOVLW       132
	SUBWF       _adc+0, 0 
L__leBotao145:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao14
L__leBotao140:
	BSF         _flag0+0, 1 
	GOTO        L_leBotao15
L_leBotao14:
;TecladoAnalogico.c,152 :: 		else if(adc > 132 && adc < 162 ) bot3 = 0x01; // ou 20 a menos a 20 a mais
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao146
	MOVF        _adc+0, 0 
	SUBLW       132
L__leBotao146:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao18
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao147
	MOVLW       162
	SUBWF       _adc+0, 0 
L__leBotao147:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao18
L__leBotao139:
	BSF         _flag0+0, 2 
	GOTO        L_leBotao19
L_leBotao18:
;TecladoAnalogico.c,153 :: 		else if(adc > 162 && adc < 208 ) bot4 = 0x01;
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao148
	MOVF        _adc+0, 0 
	SUBLW       162
L__leBotao148:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao22
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao149
	MOVLW       208
	SUBWF       _adc+0, 0 
L__leBotao149:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao22
L__leBotao138:
	BSF         _flag0+0, 3 
	GOTO        L_leBotao23
L_leBotao22:
;TecladoAnalogico.c,154 :: 		else if(adc > 244 && adc < 284 ) bot5 = 0x01;
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao150
	MOVF        _adc+0, 0 
	SUBLW       244
L__leBotao150:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao26
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao151
	MOVLW       28
	SUBWF       _adc+0, 0 
L__leBotao151:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao26
L__leBotao137:
	BSF         _flag0+0, 4 
	GOTO        L_leBotao27
L_leBotao26:
;TecladoAnalogico.c,155 :: 		else if(adc > 328 && adc < 368 ) bot6 = 0x01;
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao152
	MOVF        _adc+0, 0 
	SUBLW       72
L__leBotao152:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao30
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao153
	MOVLW       112
	SUBWF       _adc+0, 0 
L__leBotao153:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao30
L__leBotao136:
	BSF         _flag0+0, 5 
	GOTO        L_leBotao31
L_leBotao30:
;TecladoAnalogico.c,156 :: 		else if(adc > 389 && adc < 429 ) bot7 = 0x01;
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao154
	MOVF        _adc+0, 0 
	SUBLW       133
L__leBotao154:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao34
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao155
	MOVLW       173
	SUBWF       _adc+0, 0 
L__leBotao155:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao34
L__leBotao135:
	BSF         _flag0+0, 6 
	GOTO        L_leBotao35
L_leBotao34:
;TecladoAnalogico.c,157 :: 		else if(adc > 494 && adc < 534 ) bot8 = 0x01;
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao156
	MOVF        _adc+0, 0 
	SUBLW       238
L__leBotao156:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao38
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao157
	MOVLW       22
	SUBWF       _adc+0, 0 
L__leBotao157:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao38
L__leBotao134:
	BSF         _flag0+0, 7 
	GOTO        L_leBotao39
L_leBotao38:
;TecladoAnalogico.c,158 :: 		else if(adc > 568 && adc < 608 ) bot9 = 0x01;
	MOVLW       128
	XORLW       2
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao158
	MOVF        _adc+0, 0 
	SUBLW       56
L__leBotao158:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao42
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao159
	MOVLW       96
	SUBWF       _adc+0, 0 
L__leBotao159:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao42
L__leBotao133:
	BSF         _flag1+0, 0 
	GOTO        L_leBotao43
L_leBotao42:
;TecladoAnalogico.c,159 :: 		else if(adc > 678 && adc < 718 ) bot10 = 0x01;
	MOVLW       128
	XORLW       2
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao160
	MOVF        _adc+0, 0 
	SUBLW       166
L__leBotao160:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao46
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao161
	MOVLW       206
	SUBWF       _adc+0, 0 
L__leBotao161:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao46
L__leBotao132:
	BSF         _flag1+0, 1 
	GOTO        L_leBotao47
L_leBotao46:
;TecladoAnalogico.c,160 :: 		else if(adc > 768 && adc < 808 ) bot11 = 0x01;
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao162
	MOVF        _adc+0, 0 
	SUBLW       0
L__leBotao162:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao50
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao163
	MOVLW       40
	SUBWF       _adc+0, 0 
L__leBotao163:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao50
L__leBotao131:
	BSF         _flag1+0, 2 
	GOTO        L_leBotao51
L_leBotao50:
;TecladoAnalogico.c,161 :: 		else if(adc > 820 && adc < 860 ) bot12 = 0x01;
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao164
	MOVF        _adc+0, 0 
	SUBLW       52
L__leBotao164:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao54
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao165
	MOVLW       92
	SUBWF       _adc+0, 0 
L__leBotao165:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao54
L__leBotao130:
	BSF         _flag1+0, 3 
	GOTO        L_leBotao55
L_leBotao54:
;TecladoAnalogico.c,162 :: 		else if(adc > 871 && adc < 911 ) bot13 = 0x01;
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao166
	MOVF        _adc+0, 0 
	SUBLW       103
L__leBotao166:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao58
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao167
	MOVLW       143
	SUBWF       _adc+0, 0 
L__leBotao167:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao58
L__leBotao129:
	BSF         _flag1+0, 4 
	GOTO        L_leBotao59
L_leBotao58:
;TecladoAnalogico.c,163 :: 		else if(adc > 912 && adc < 952 ) bot14 = 0x01;
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao168
	MOVF        _adc+0, 0 
	SUBLW       144
L__leBotao168:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao62
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao169
	MOVLW       184
	SUBWF       _adc+0, 0 
L__leBotao169:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao62
L__leBotao128:
	BSF         _flag1+0, 5 
	GOTO        L_leBotao63
L_leBotao62:
;TecladoAnalogico.c,164 :: 		else if(adc > 959 && adc < 999 ) bot15 = 0x01;
	MOVLW       128
	XORLW       3
	MOVWF       R0 
	MOVLW       128
	XORWF       _adc+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao170
	MOVF        _adc+0, 0 
	SUBLW       191
L__leBotao170:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao66
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao171
	MOVLW       231
	SUBWF       _adc+0, 0 
L__leBotao171:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao66
L__leBotao127:
	BSF         _flag1+0, 6 
L_leBotao66:
L_leBotao63:
L_leBotao59:
L_leBotao55:
L_leBotao51:
L_leBotao47:
L_leBotao43:
L_leBotao39:
L_leBotao35:
L_leBotao31:
L_leBotao27:
L_leBotao23:
L_leBotao19:
L_leBotao15:
L_leBotao11:
;TecladoAnalogico.c,166 :: 		if(adc < 94 && bot1){     // Confirma que o botão está solto
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao172
	MOVLW       94
	SUBWF       _adc+0, 0 
L__leBotao172:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao69
	BTFSS       _flag0+0, 0 
	GOTO        L_leBotao69
L__leBotao126:
;TecladoAnalogico.c,168 :: 		flagAux = 0x01; // Esta flag confirma que algum botão foi pressionado, e entra faz entrar na rotina que faz o led piscar, no loop inf.
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,169 :: 		pisca = 0x01;
	MOVLW       1
	MOVWF       _pisca+0 
;TecladoAnalogico.c,170 :: 		s1 = 0x01;  // Coloca o mnemônico auxiliar S1 em 0x01, para o caso de querer usar um botão específico para uma função específica
	BSF         _flag2+0, 0 
;TecladoAnalogico.c,171 :: 		bot1 = 0x00;
	BCF         _flag0+0, 0 
;TecladoAnalogico.c,172 :: 		}
L_leBotao69:
;TecladoAnalogico.c,173 :: 		if(adc < 108 && bot2){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao173
	MOVLW       108
	SUBWF       _adc+0, 0 
L__leBotao173:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao72
	BTFSS       _flag0+0, 1 
	GOTO        L_leBotao72
L__leBotao125:
;TecladoAnalogico.c,175 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,176 :: 		pisca = 0x02; // Pisca definira o numero de piscadas. Quanto maio o botão, maior o número de piscadas
	MOVLW       2
	MOVWF       _pisca+0 
;TecladoAnalogico.c,177 :: 		s2 = 0x01;
	BSF         _flag2+0, 1 
;TecladoAnalogico.c,178 :: 		bot2 = 0x00;
	BCF         _flag0+0, 1 
;TecladoAnalogico.c,179 :: 		}
L_leBotao72:
;TecladoAnalogico.c,180 :: 		if(adc < 132 && bot3){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao174
	MOVLW       132
	SUBWF       _adc+0, 0 
L__leBotao174:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao75
	BTFSS       _flag0+0, 2 
	GOTO        L_leBotao75
L__leBotao124:
;TecladoAnalogico.c,182 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,183 :: 		pisca = 0x03;
	MOVLW       3
	MOVWF       _pisca+0 
;TecladoAnalogico.c,184 :: 		s3 = 0x01;
	BSF         _flag2+0, 2 
;TecladoAnalogico.c,185 :: 		bot3 = 0x00;
	BCF         _flag0+0, 2 
;TecladoAnalogico.c,186 :: 		}
L_leBotao75:
;TecladoAnalogico.c,187 :: 		if(adc < 162 && bot4){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao175
	MOVLW       162
	SUBWF       _adc+0, 0 
L__leBotao175:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao78
	BTFSS       _flag0+0, 3 
	GOTO        L_leBotao78
L__leBotao123:
;TecladoAnalogico.c,189 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,190 :: 		pisca = 0x04;
	MOVLW       4
	MOVWF       _pisca+0 
;TecladoAnalogico.c,191 :: 		s4 = 0x01;
	BSF         _flag2+0, 3 
;TecladoAnalogico.c,192 :: 		bot4 = 0x00;
	BCF         _flag0+0, 3 
;TecladoAnalogico.c,193 :: 		}
L_leBotao78:
;TecladoAnalogico.c,194 :: 		if(adc < 244 && bot5){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao176
	MOVLW       244
	SUBWF       _adc+0, 0 
L__leBotao176:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao81
	BTFSS       _flag0+0, 4 
	GOTO        L_leBotao81
L__leBotao122:
;TecladoAnalogico.c,196 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,197 :: 		pisca = 0x05;
	MOVLW       5
	MOVWF       _pisca+0 
;TecladoAnalogico.c,198 :: 		s5 = 0x01;
	BSF         _flag2+0, 4 
;TecladoAnalogico.c,199 :: 		bot5 = 0x00;
	BCF         _flag0+0, 4 
;TecladoAnalogico.c,200 :: 		}
L_leBotao81:
;TecladoAnalogico.c,201 :: 		if(adc < 328 && bot6){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao177
	MOVLW       72
	SUBWF       _adc+0, 0 
L__leBotao177:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao84
	BTFSS       _flag0+0, 5 
	GOTO        L_leBotao84
L__leBotao121:
;TecladoAnalogico.c,203 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,204 :: 		pisca = 0x06;
	MOVLW       6
	MOVWF       _pisca+0 
;TecladoAnalogico.c,205 :: 		s6 = 0x01;
	BSF         _flag2+0, 5 
;TecladoAnalogico.c,206 :: 		bot6 = 0x00;
	BCF         _flag0+0, 5 
;TecladoAnalogico.c,207 :: 		}
L_leBotao84:
;TecladoAnalogico.c,208 :: 		if(adc < 389 && bot7){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao178
	MOVLW       133
	SUBWF       _adc+0, 0 
L__leBotao178:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao87
	BTFSS       _flag0+0, 6 
	GOTO        L_leBotao87
L__leBotao120:
;TecladoAnalogico.c,210 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,211 :: 		pisca = 0x07;
	MOVLW       7
	MOVWF       _pisca+0 
;TecladoAnalogico.c,212 :: 		s7 = 0x01;
	BSF         _flag2+0, 6 
;TecladoAnalogico.c,213 :: 		bot7 = 0x00;
	BCF         _flag0+0, 6 
;TecladoAnalogico.c,214 :: 		}
L_leBotao87:
;TecladoAnalogico.c,215 :: 		if(adc < 494 && bot8){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao179
	MOVLW       238
	SUBWF       _adc+0, 0 
L__leBotao179:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao90
	BTFSS       _flag0+0, 7 
	GOTO        L_leBotao90
L__leBotao119:
;TecladoAnalogico.c,217 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,218 :: 		pisca = 0x08;
	MOVLW       8
	MOVWF       _pisca+0 
;TecladoAnalogico.c,219 :: 		s8 = 0x01;
	BSF         _flag2+0, 7 
;TecladoAnalogico.c,220 :: 		bot8 = 0x00;
	BCF         _flag0+0, 7 
;TecladoAnalogico.c,221 :: 		}
L_leBotao90:
;TecladoAnalogico.c,222 :: 		if(adc < 568 && bot9){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao180
	MOVLW       56
	SUBWF       _adc+0, 0 
L__leBotao180:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao93
	BTFSS       _flag1+0, 0 
	GOTO        L_leBotao93
L__leBotao118:
;TecladoAnalogico.c,224 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,225 :: 		pisca = 0x09;
	MOVLW       9
	MOVWF       _pisca+0 
;TecladoAnalogico.c,226 :: 		s9 = 0x01;
	BSF         _flag3+0, 0 
;TecladoAnalogico.c,227 :: 		bot9 = 0x00;
	BCF         _flag1+0, 0 
;TecladoAnalogico.c,228 :: 		}
L_leBotao93:
;TecladoAnalogico.c,229 :: 		if(adc < 678 && bot10){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao181
	MOVLW       166
	SUBWF       _adc+0, 0 
L__leBotao181:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao96
	BTFSS       _flag1+0, 1 
	GOTO        L_leBotao96
L__leBotao117:
;TecladoAnalogico.c,231 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,232 :: 		pisca = 0x0A;
	MOVLW       10
	MOVWF       _pisca+0 
;TecladoAnalogico.c,233 :: 		s10 = 0x01;
	BSF         _flag3+0, 1 
;TecladoAnalogico.c,234 :: 		bot10 = 0x00;
	BCF         _flag1+0, 1 
;TecladoAnalogico.c,235 :: 		}
L_leBotao96:
;TecladoAnalogico.c,236 :: 		if(adc < 768 && bot11){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao182
	MOVLW       0
	SUBWF       _adc+0, 0 
L__leBotao182:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao99
	BTFSS       _flag1+0, 2 
	GOTO        L_leBotao99
L__leBotao116:
;TecladoAnalogico.c,238 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,239 :: 		pisca = 0x0B;
	MOVLW       11
	MOVWF       _pisca+0 
;TecladoAnalogico.c,240 :: 		s11 = 0x01;
	BSF         _flag3+0, 2 
;TecladoAnalogico.c,241 :: 		bot11 = 0x00;
	BCF         _flag1+0, 2 
;TecladoAnalogico.c,242 :: 		}
L_leBotao99:
;TecladoAnalogico.c,243 :: 		if(adc < 820 && bot12){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao183
	MOVLW       52
	SUBWF       _adc+0, 0 
L__leBotao183:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao102
	BTFSS       _flag1+0, 3 
	GOTO        L_leBotao102
L__leBotao115:
;TecladoAnalogico.c,245 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,246 :: 		pisca = 0x0C;
	MOVLW       12
	MOVWF       _pisca+0 
;TecladoAnalogico.c,247 :: 		s12 = 0x01;
	BSF         _flag3+0, 3 
;TecladoAnalogico.c,248 :: 		bot12 = 0x00;
	BCF         _flag1+0, 3 
;TecladoAnalogico.c,249 :: 		}
L_leBotao102:
;TecladoAnalogico.c,250 :: 		if(adc < 871 && bot13){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao184
	MOVLW       103
	SUBWF       _adc+0, 0 
L__leBotao184:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao105
	BTFSS       _flag1+0, 4 
	GOTO        L_leBotao105
L__leBotao114:
;TecladoAnalogico.c,252 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,253 :: 		pisca = 0x0D;
	MOVLW       13
	MOVWF       _pisca+0 
;TecladoAnalogico.c,254 :: 		s13 = 0x01;
	BSF         _flag3+0, 4 
;TecladoAnalogico.c,255 :: 		bot13 = 0x00;
	BCF         _flag1+0, 4 
;TecladoAnalogico.c,256 :: 		}
L_leBotao105:
;TecladoAnalogico.c,257 :: 		if(adc < 912 && bot14){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao185
	MOVLW       144
	SUBWF       _adc+0, 0 
L__leBotao185:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao108
	BTFSS       _flag1+0, 5 
	GOTO        L_leBotao108
L__leBotao113:
;TecladoAnalogico.c,259 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,260 :: 		pisca = 0x0E;
	MOVLW       14
	MOVWF       _pisca+0 
;TecladoAnalogico.c,261 :: 		s14 = 0x01;
	BSF         _flag3+0, 5 
;TecladoAnalogico.c,262 :: 		bot14 = 0x00;
	BCF         _flag1+0, 5 
;TecladoAnalogico.c,263 :: 		}
L_leBotao108:
;TecladoAnalogico.c,264 :: 		if(adc < 959 && bot15){
	MOVLW       128
	XORWF       _adc+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__leBotao186
	MOVLW       191
	SUBWF       _adc+0, 0 
L__leBotao186:
	BTFSC       STATUS+0, 0 
	GOTO        L_leBotao111
	BTFSS       _flag1+0, 6 
	GOTO        L_leBotao111
L__leBotao112:
;TecladoAnalogico.c,266 :: 		flagAux = 0x01;
	BSF         _flag1+0, 7 
;TecladoAnalogico.c,267 :: 		pisca = 0x0F;
	MOVLW       15
	MOVWF       _pisca+0 
;TecladoAnalogico.c,268 :: 		s15 = 0x01;
	BSF         _flag3+0, 6 
;TecladoAnalogico.c,269 :: 		bot15 = 0x00;
	BCF         _flag1+0, 6 
;TecladoAnalogico.c,270 :: 		}
L_leBotao111:
;TecladoAnalogico.c,271 :: 		}
	RETURN      0
; end of _leBotao

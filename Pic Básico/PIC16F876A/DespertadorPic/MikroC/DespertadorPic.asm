
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;DespertadorPic.c,66 :: 		void interrupt(){
;DespertadorPic.c,68 :: 		if(INTF_bit){
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;DespertadorPic.c,70 :: 		INTF_bit = 0x00;
	BCF        INTF_bit+0, 1
;DespertadorPic.c,72 :: 		flag.B3 = ~flag.B3;
	MOVLW      8
	XORWF      _flag+0, 1
;DespertadorPic.c,74 :: 		if(flag.B3) ledAlarme = 0x01;
	BTFSS      _flag+0, 3
	GOTO       L_interrupt1
	BSF        RA2_bit+0, 2
	GOTO       L_interrupt2
L_interrupt1:
;DespertadorPic.c,75 :: 		else ledAlarme = 0x00;
	BCF        RA2_bit+0, 2
L_interrupt2:
;DespertadorPic.c,76 :: 		}
L_interrupt0:
;DespertadorPic.c,78 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt3
;DespertadorPic.c,80 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;DespertadorPic.c,82 :: 		if(flag.B3){
	BTFSS      _flag+0, 3
	GOTO       L_interrupt4
;DespertadorPic.c,83 :: 		if(minuAlarme == minu && horaAlarme == hora)
	MOVF       _minuAlarme+0, 0
	XORWF      _minu+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
	MOVF       _horaAlarme+0, 0
	XORWF      _hora+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
L__interrupt86:
;DespertadorPic.c,84 :: 		buzzer = 0x01;
	BSF        RA1_bit+0, 1
	GOTO       L_interrupt8
L_interrupt7:
;DespertadorPic.c,86 :: 		buzzer = 0x00;
	BCF        RA1_bit+0, 1
L_interrupt8:
;DespertadorPic.c,87 :: 		}
	GOTO       L_interrupt9
L_interrupt4:
;DespertadorPic.c,89 :: 		buzzer = 0x00;
	BCF        RA1_bit+0, 1
L_interrupt9:
;DespertadorPic.c,91 :: 		if(!flag.B2){
	BTFSC      _flag+0, 2
	GOTO       L_interrupt10
;DespertadorPic.c,92 :: 		if(!mil && control == 0x01){
	BTFSC      RB1_bit+0, 1
	GOTO       L_interrupt13
	MOVF       _control+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt13
L__interrupt85:
;DespertadorPic.c,94 :: 		cent = 0x00;
	BCF        RB2_bit+0, 2
;DespertadorPic.c,95 :: 		dez = 0x00;
	BCF        RB3_bit+0, 3
;DespertadorPic.c,96 :: 		uni = 0x00;
	BCF        RB4_bit+0, 4
;DespertadorPic.c,97 :: 		control = 0x02;
	MOVLW      2
	MOVWF      _control+0
;DespertadorPic.c,98 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,99 :: 		milesimo = (hora%100)/10; // Ex: 22 % 100 = 22, 22 / 10 = 2. Logo, milesimo = 2
	MOVLW      100
	MOVWF      R4+0
	MOVF       _hora+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _milesimo+0
	CLRF       _milesimo+1
;DespertadorPic.c,100 :: 		mil = 0x01;
	BSF        RB1_bit+0, 1
;DespertadorPic.c,101 :: 		PORTC = display(milesimo);
	MOVF       _milesimo+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _milesimo+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,102 :: 		}
	GOTO       L_interrupt14
L_interrupt13:
;DespertadorPic.c,103 :: 		else if(!cent && control == 0x02){
	BTFSC      RB2_bit+0, 2
	GOTO       L_interrupt17
	MOVF       _control+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt17
L__interrupt84:
;DespertadorPic.c,105 :: 		mil = 0x00;
	BCF        RB1_bit+0, 1
;DespertadorPic.c,106 :: 		dez = 0x00;
	BCF        RB3_bit+0, 3
;DespertadorPic.c,107 :: 		uni = 0x00;
	BCF        RB4_bit+0, 4
;DespertadorPic.c,108 :: 		control = 0x03;
	MOVLW      3
	MOVWF      _control+0
;DespertadorPic.c,109 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,110 :: 		centena = hora%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _hora+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _centena+0
	CLRF       _centena+1
;DespertadorPic.c,111 :: 		cent = 0x01;
	BSF        RB2_bit+0, 2
;DespertadorPic.c,112 :: 		PORTC = display(centena);
	MOVF       _centena+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _centena+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,113 :: 		}
	GOTO       L_interrupt18
L_interrupt17:
;DespertadorPic.c,114 :: 		else if(!dez && control == 0x03){
	BTFSC      RB3_bit+0, 3
	GOTO       L_interrupt21
	MOVF       _control+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt21
L__interrupt83:
;DespertadorPic.c,116 :: 		mil = 0x00;
	BCF        RB1_bit+0, 1
;DespertadorPic.c,117 :: 		cent = 0x00;
	BCF        RB2_bit+0, 2
;DespertadorPic.c,118 :: 		uni = 0x00;
	BCF        RB4_bit+0, 4
;DespertadorPic.c,119 :: 		control = 0x04;
	MOVLW      4
	MOVWF      _control+0
;DespertadorPic.c,120 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,121 :: 		dezena = (minu%100)/10;
	MOVLW      100
	MOVWF      R4+0
	MOVF       _minu+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _dezena+0
	CLRF       _dezena+1
;DespertadorPic.c,122 :: 		dez = 0x01;
	BSF        RB3_bit+0, 3
;DespertadorPic.c,123 :: 		PORTC = display(dezena);
	MOVF       _dezena+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _dezena+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,124 :: 		}
	GOTO       L_interrupt22
L_interrupt21:
;DespertadorPic.c,125 :: 		else if(!uni && control == 0x04){
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt25
	MOVF       _control+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt25
L__interrupt82:
;DespertadorPic.c,127 :: 		mil = 0x00;
	BCF        RB1_bit+0, 1
;DespertadorPic.c,128 :: 		cent = 0x00;
	BCF        RB2_bit+0, 2
;DespertadorPic.c,129 :: 		dez = 0x00;
	BCF        RB3_bit+0, 3
;DespertadorPic.c,130 :: 		control = 0x01;
	MOVLW      1
	MOVWF      _control+0
;DespertadorPic.c,131 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,132 :: 		unidade = minu%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _minu+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _unidade+0
	CLRF       _unidade+1
;DespertadorPic.c,133 :: 		uni = 0x01;
	BSF        RB4_bit+0, 4
;DespertadorPic.c,134 :: 		PORTC = display(unidade);
	MOVF       _unidade+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _unidade+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,135 :: 		}
L_interrupt25:
L_interrupt22:
L_interrupt18:
L_interrupt14:
;DespertadorPic.c,136 :: 		}
L_interrupt10:
;DespertadorPic.c,137 :: 		if(flag.B2){
	BTFSS      _flag+0, 2
	GOTO       L_interrupt26
;DespertadorPic.c,138 :: 		if(!mil && control == 0x01){
	BTFSC      RB1_bit+0, 1
	GOTO       L_interrupt29
	MOVF       _control+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt29
L__interrupt81:
;DespertadorPic.c,140 :: 		cent = 0x00;
	BCF        RB2_bit+0, 2
;DespertadorPic.c,141 :: 		dez = 0x00;
	BCF        RB3_bit+0, 3
;DespertadorPic.c,142 :: 		uni = 0x00;
	BCF        RB4_bit+0, 4
;DespertadorPic.c,143 :: 		control = 0x02;
	MOVLW      2
	MOVWF      _control+0
;DespertadorPic.c,144 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,145 :: 		milesimo = (horaAlarme%100)/10; // Ex: 22 % 100 = 22, 22 / 10 = 2. Logo, milesimo = 2
	MOVLW      100
	MOVWF      R4+0
	MOVF       _horaAlarme+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _milesimo+0
	CLRF       _milesimo+1
;DespertadorPic.c,146 :: 		mil = 0x01;
	BSF        RB1_bit+0, 1
;DespertadorPic.c,147 :: 		PORTC = display(milesimo);
	MOVF       _milesimo+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _milesimo+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,148 :: 		}
	GOTO       L_interrupt30
L_interrupt29:
;DespertadorPic.c,149 :: 		else if(!cent && control == 0x02){
	BTFSC      RB2_bit+0, 2
	GOTO       L_interrupt33
	MOVF       _control+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt33
L__interrupt80:
;DespertadorPic.c,151 :: 		mil = 0x00;
	BCF        RB1_bit+0, 1
;DespertadorPic.c,152 :: 		dez = 0x00;
	BCF        RB3_bit+0, 3
;DespertadorPic.c,153 :: 		uni = 0x00;
	BCF        RB4_bit+0, 4
;DespertadorPic.c,154 :: 		control = 0x03;
	MOVLW      3
	MOVWF      _control+0
;DespertadorPic.c,155 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,156 :: 		centena = horaAlarme%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _horaAlarme+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _centena+0
	CLRF       _centena+1
;DespertadorPic.c,157 :: 		cent = 0x01;
	BSF        RB2_bit+0, 2
;DespertadorPic.c,158 :: 		PORTC = display(centena);
	MOVF       _centena+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _centena+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,159 :: 		}
	GOTO       L_interrupt34
L_interrupt33:
;DespertadorPic.c,160 :: 		else if(!dez && control == 0x03){
	BTFSC      RB3_bit+0, 3
	GOTO       L_interrupt37
	MOVF       _control+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt37
L__interrupt79:
;DespertadorPic.c,162 :: 		mil = 0x00;
	BCF        RB1_bit+0, 1
;DespertadorPic.c,163 :: 		cent = 0x00;
	BCF        RB2_bit+0, 2
;DespertadorPic.c,164 :: 		uni = 0x00;
	BCF        RB4_bit+0, 4
;DespertadorPic.c,165 :: 		control = 0x04;
	MOVLW      4
	MOVWF      _control+0
;DespertadorPic.c,166 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,167 :: 		dezena = (minuAlarme%100)/10;
	MOVLW      100
	MOVWF      R4+0
	MOVF       _minuAlarme+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _dezena+0
	CLRF       _dezena+1
;DespertadorPic.c,168 :: 		dez = 0x01;
	BSF        RB3_bit+0, 3
;DespertadorPic.c,169 :: 		PORTC = display(dezena);
	MOVF       _dezena+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _dezena+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,170 :: 		}
	GOTO       L_interrupt38
L_interrupt37:
;DespertadorPic.c,171 :: 		else if(!uni && control == 0x04){
	BTFSC      RB4_bit+0, 4
	GOTO       L_interrupt41
	MOVF       _control+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt41
L__interrupt78:
;DespertadorPic.c,173 :: 		mil = 0x00;
	BCF        RB1_bit+0, 1
;DespertadorPic.c,174 :: 		cent = 0x00;
	BCF        RB2_bit+0, 2
;DespertadorPic.c,175 :: 		dez = 0x00;
	BCF        RB3_bit+0, 3
;DespertadorPic.c,176 :: 		control = 0x01;
	MOVLW      1
	MOVWF      _control+0
;DespertadorPic.c,177 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;DespertadorPic.c,178 :: 		unidade = minuAlarme%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _minuAlarme+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _unidade+0
	CLRF       _unidade+1
;DespertadorPic.c,179 :: 		uni = 0x01;
	BSF        RB4_bit+0, 4
;DespertadorPic.c,180 :: 		PORTC = display(unidade);
	MOVF       _unidade+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _unidade+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;DespertadorPic.c,181 :: 		}
L_interrupt41:
L_interrupt38:
L_interrupt34:
L_interrupt30:
;DespertadorPic.c,182 :: 		}
L_interrupt26:
;DespertadorPic.c,183 :: 		}
L_interrupt3:
;DespertadorPic.c,185 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt42
;DespertadorPic.c,187 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;DespertadorPic.c,188 :: 		TMR1H = 0x0B;
	MOVLW      11
	MOVWF      TMR1H+0
;DespertadorPic.c,189 :: 		TMR1L = 0xDC;
	MOVLW      220
	MOVWF      TMR1L+0
;DespertadorPic.c,191 :: 		led = ~led;
	MOVLW      128
	XORWF      RB7_bit+0, 1
;DespertadorPic.c,193 :: 		cont++;
	INCF       _cont+0, 1
;DespertadorPic.c,195 :: 		if(cont == 0x02){
	MOVF       _cont+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt43
;DespertadorPic.c,197 :: 		cont = 0x00;
	CLRF       _cont+0
;DespertadorPic.c,198 :: 		seg++;
	INCF       _seg+0, 1
;DespertadorPic.c,199 :: 		}
L_interrupt43:
;DespertadorPic.c,200 :: 		}
L_interrupt42:
;DespertadorPic.c,201 :: 		}
L__interrupt93:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;DespertadorPic.c,203 :: 		void main(){
;DespertadorPic.c,205 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;DespertadorPic.c,206 :: 		ADCON0 = 0x00; // Desliga o conversor AD
	CLRF       ADCON0+0
;DespertadorPic.c,207 :: 		ADCON1 = 0x07; // Configura todo porta, que tem os pinos analogicos, como pinos digitais
	MOVLW      7
	MOVWF      ADCON1+0
;DespertadorPic.c,209 :: 		OPTION_REG = 0x83; // Desabilita os pull-ups internos, configura o prescaler do timer0 em 1:16, e a interrupção externa por borda de descida
	MOVLW      131
	MOVWF      OPTION_REG+0
;DespertadorPic.c,210 :: 		INTCON = 0xB0; // Habilita a interrupção global, habilita a interrupção do timer0 e habilita a interrupção externa
	MOVLW      176
	MOVWF      INTCON+0
;DespertadorPic.c,212 :: 		T1CON = 0x31; // Habilita o timer1 e configura seu prescaler em 1:8;
	MOVLW      49
	MOVWF      T1CON+0
;DespertadorPic.c,213 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1 (registrador PIE1)
	BSF        TMR1IE_bit+0, 0
;DespertadorPic.c,214 :: 		TMR1H = 0x0B; // Inicia a contagem do timer 1 em 3036(decimal), para uma contagem de 62500
	MOVLW      11
	MOVWF      TMR1H+0
;DespertadorPic.c,215 :: 		TMR1L = 0xDC;
	MOVLW      220
	MOVWF      TMR1L+0
;DespertadorPic.c,217 :: 		TRISA = 0xF9; // Configura apenas RA1 e RA2 como saída digital
	MOVLW      249
	MOVWF      TRISA+0
;DespertadorPic.c,218 :: 		TRISB = 0x61; // Configura apenas RB0, RB5 e RB6 como entradas digitais
	MOVLW      97
	MOVWF      TRISB+0
;DespertadorPic.c,219 :: 		TRISC = 0x80; // Configura apenas RC7 como entrada digital
	MOVLW      128
	MOVWF      TRISC+0
;DespertadorPic.c,220 :: 		PORTA = 0xF9; // Inicia apenas RA1 e RA2 em Low
	MOVLW      249
	MOVWF      PORTA+0
;DespertadorPic.c,221 :: 		PORTB = 0x30; // Inicia RB0, RB4 e RB5 em High, o resto em Low
	MOVLW      48
	MOVWF      PORTB+0
;DespertadorPic.c,222 :: 		PORTC = 0x80; // Inicia os displays mostrando "0"
	MOVLW      128
	MOVWF      PORTC+0
;DespertadorPic.c,224 :: 		while(1){
L_main44:
;DespertadorPic.c,226 :: 		relogio();
	CALL       _relogio+0
;DespertadorPic.c,228 :: 		if(!ajusteAlarme) flag.B2 = ~flag.B2;
	BTFSC      RA0_bit+0, 0
	GOTO       L_main46
	MOVLW      4
	XORWF      _flag+0, 1
L_main46:
;DespertadorPic.c,229 :: 		delay_ms(70);
	MOVLW      91
	MOVWF      R12+0
	MOVLW      231
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	NOP
	NOP
;DespertadorPic.c,231 :: 		if(ajusteAlarme && !flag.B2)
	BTFSS      RA0_bit+0, 0
	GOTO       L_main50
	BTFSC      _flag+0, 2
	GOTO       L_main50
L__main88:
;DespertadorPic.c,232 :: 		ajusteRelogio();
	CALL       _ajusteRelogio+0
	GOTO       L_main51
L_main50:
;DespertadorPic.c,233 :: 		else if(ajusteAlarme && flag.B2)
	BTFSS      RA0_bit+0, 0
	GOTO       L_main54
	BTFSS      _flag+0, 2
	GOTO       L_main54
L__main87:
;DespertadorPic.c,234 :: 		alarme();
	CALL       _alarme+0
L_main54:
L_main51:
;DespertadorPic.c,235 :: 		}
	GOTO       L_main44
;DespertadorPic.c,236 :: 		}
	GOTO       $+0
; end of _main

_relogio:

;DespertadorPic.c,238 :: 		void relogio(){
;DespertadorPic.c,240 :: 		if(seg > 59){
	MOVF       _seg+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_relogio55
;DespertadorPic.c,242 :: 		seg = 0;
	CLRF       _seg+0
;DespertadorPic.c,243 :: 		minu++;
	INCF       _minu+0, 1
;DespertadorPic.c,245 :: 		if(minu > 59){
	MOVF       _minu+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_relogio56
;DespertadorPic.c,247 :: 		minu = 0;
	CLRF       _minu+0
;DespertadorPic.c,248 :: 		hora++;
	INCF       _hora+0, 1
;DespertadorPic.c,250 :: 		if(hora > 23)
	MOVF       _hora+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_relogio57
;DespertadorPic.c,251 :: 		hora = 0;
	CLRF       _hora+0
L_relogio57:
;DespertadorPic.c,252 :: 		}
L_relogio56:
;DespertadorPic.c,253 :: 		}
L_relogio55:
;DespertadorPic.c,254 :: 		}
	RETURN
; end of _relogio

_ajusteRelogio:

;DespertadorPic.c,256 :: 		void ajusteRelogio(){
;DespertadorPic.c,258 :: 		if(!botMin)
	BTFSC      RB5_bit+0, 5
	GOTO       L_ajusteRelogio58
;DespertadorPic.c,259 :: 		flag.B0 = 0x01;
	BSF        _flag+0, 0
L_ajusteRelogio58:
;DespertadorPic.c,260 :: 		if(!botHora)
	BTFSC      RB6_bit+0, 6
	GOTO       L_ajusteRelogio59
;DespertadorPic.c,261 :: 		flag.B1 = 0x01;
	BSF        _flag+0, 1
L_ajusteRelogio59:
;DespertadorPic.c,263 :: 		if(botMin && flag.B0){
	BTFSS      RB5_bit+0, 5
	GOTO       L_ajusteRelogio62
	BTFSS      _flag+0, 0
	GOTO       L_ajusteRelogio62
L__ajusteRelogio90:
;DespertadorPic.c,265 :: 		flag.B0 = 0x00;
	BCF        _flag+0, 0
;DespertadorPic.c,266 :: 		minu++;
	INCF       _minu+0, 1
;DespertadorPic.c,268 :: 		if(minu > 59) minu = 0;
	MOVF       _minu+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_ajusteRelogio63
	CLRF       _minu+0
L_ajusteRelogio63:
;DespertadorPic.c,269 :: 		}
L_ajusteRelogio62:
;DespertadorPic.c,270 :: 		if(botHora && flag.B1){
	BTFSS      RB6_bit+0, 6
	GOTO       L_ajusteRelogio66
	BTFSS      _flag+0, 1
	GOTO       L_ajusteRelogio66
L__ajusteRelogio89:
;DespertadorPic.c,272 :: 		flag.B1 = 0x00;
	BCF        _flag+0, 1
;DespertadorPic.c,273 :: 		hora++;
	INCF       _hora+0, 1
;DespertadorPic.c,275 :: 		if(hora > 23) hora = 0;
	MOVF       _hora+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_ajusteRelogio67
	CLRF       _hora+0
L_ajusteRelogio67:
;DespertadorPic.c,276 :: 		}
L_ajusteRelogio66:
;DespertadorPic.c,277 :: 		}
	RETURN
; end of _ajusteRelogio

_alarme:

;DespertadorPic.c,279 :: 		void alarme(){
;DespertadorPic.c,281 :: 		if(!botMin) flag.B0 = 0x01;
	BTFSC      RB5_bit+0, 5
	GOTO       L_alarme68
	BSF        _flag+0, 0
L_alarme68:
;DespertadorPic.c,282 :: 		if(!botHora) flag.B1 = 0x01;
	BTFSC      RB6_bit+0, 6
	GOTO       L_alarme69
	BSF        _flag+0, 1
L_alarme69:
;DespertadorPic.c,284 :: 		if(botMin && flag.B0){
	BTFSS      RB5_bit+0, 5
	GOTO       L_alarme72
	BTFSS      _flag+0, 0
	GOTO       L_alarme72
L__alarme92:
;DespertadorPic.c,286 :: 		flag.B0 = 0x00;
	BCF        _flag+0, 0
;DespertadorPic.c,287 :: 		minuAlarme++;
	INCF       _minuAlarme+0, 1
;DespertadorPic.c,289 :: 		if(minuAlarme > 59) minuAlarme = 0;
	MOVF       _minuAlarme+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_alarme73
	CLRF       _minuAlarme+0
L_alarme73:
;DespertadorPic.c,290 :: 		}
L_alarme72:
;DespertadorPic.c,291 :: 		if(botHora && flag.B1){
	BTFSS      RB6_bit+0, 6
	GOTO       L_alarme76
	BTFSS      _flag+0, 1
	GOTO       L_alarme76
L__alarme91:
;DespertadorPic.c,293 :: 		flag.B1 = 0x00;
	BCF        _flag+0, 1
;DespertadorPic.c,294 :: 		horaAlarme++;
	INCF       _horaAlarme+0, 1
;DespertadorPic.c,296 :: 		if(horaAlarme > 23) hora = 0;
	MOVF       _horaAlarme+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_alarme77
	CLRF       _hora+0
L_alarme77:
;DespertadorPic.c,297 :: 		}
L_alarme76:
;DespertadorPic.c,298 :: 		}
	RETURN
; end of _alarme

_display:

;DespertadorPic.c,300 :: 		int display(int num){
;DespertadorPic.c,302 :: 		int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
	MOVLW      63
	MOVWF      display_vetorDisplay_L0+0
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+1
	MOVLW      6
	MOVWF      display_vetorDisplay_L0+2
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+3
	MOVLW      91
	MOVWF      display_vetorDisplay_L0+4
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+5
	MOVLW      79
	MOVWF      display_vetorDisplay_L0+6
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+7
	MOVLW      102
	MOVWF      display_vetorDisplay_L0+8
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+9
	MOVLW      109
	MOVWF      display_vetorDisplay_L0+10
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+11
	MOVLW      125
	MOVWF      display_vetorDisplay_L0+12
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+13
	MOVLW      7
	MOVWF      display_vetorDisplay_L0+14
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+15
	MOVLW      127
	MOVWF      display_vetorDisplay_L0+16
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+17
	MOVLW      103
	MOVWF      display_vetorDisplay_L0+18
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+19
;DespertadorPic.c,305 :: 		aux = vetorDisplay[num];
	MOVF       FARG_display_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_display_num+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      display_vetorDisplay_L0+0
	MOVWF      FSR
;DespertadorPic.c,307 :: 		return aux;
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
;DespertadorPic.c,308 :: 		}
	RETURN
; end of _display

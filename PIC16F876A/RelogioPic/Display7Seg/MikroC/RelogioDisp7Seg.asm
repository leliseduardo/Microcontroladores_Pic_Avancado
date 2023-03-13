
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;RelogioDisp7Seg.c,62 :: 		void interrupt(){
;RelogioDisp7Seg.c,64 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;RelogioDisp7Seg.c,66 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;RelogioDisp7Seg.c,68 :: 		if(!mil && control == 0x01){
	BTFSC      RB0_bit+0, 0
	GOTO       L_interrupt3
	MOVF       _control+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
L__interrupt37:
;RelogioDisp7Seg.c,70 :: 		cent = 0x00;
	BCF        RB1_bit+0, 1
;RelogioDisp7Seg.c,71 :: 		dez = 0x00;
	BCF        RB2_bit+0, 2
;RelogioDisp7Seg.c,72 :: 		uni = 0x00;
	BCF        RB3_bit+0, 3
;RelogioDisp7Seg.c,73 :: 		control = 0x02;
	MOVLW      2
	MOVWF      _control+0
;RelogioDisp7Seg.c,74 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;RelogioDisp7Seg.c,75 :: 		milesimo = (hora%100)/10; // Ex: 22 % 100 = 22, 22 / 10 = 2. Logo, milesimo = 2
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
;RelogioDisp7Seg.c,76 :: 		mil = 0x01;
	BSF        RB0_bit+0, 0
;RelogioDisp7Seg.c,77 :: 		PORTC = display(milesimo);
	MOVF       _milesimo+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _milesimo+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;RelogioDisp7Seg.c,78 :: 		}
	GOTO       L_interrupt4
L_interrupt3:
;RelogioDisp7Seg.c,79 :: 		else if(!cent && control == 0x02){
	BTFSC      RB1_bit+0, 1
	GOTO       L_interrupt7
	MOVF       _control+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
L__interrupt36:
;RelogioDisp7Seg.c,81 :: 		mil = 0x00;
	BCF        RB0_bit+0, 0
;RelogioDisp7Seg.c,82 :: 		dez = 0x00;
	BCF        RB2_bit+0, 2
;RelogioDisp7Seg.c,83 :: 		uni = 0x00;
	BCF        RB3_bit+0, 3
;RelogioDisp7Seg.c,84 :: 		control = 0x03;
	MOVLW      3
	MOVWF      _control+0
;RelogioDisp7Seg.c,85 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;RelogioDisp7Seg.c,86 :: 		centena = hora%10;
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
;RelogioDisp7Seg.c,87 :: 		cent = 0x01;
	BSF        RB1_bit+0, 1
;RelogioDisp7Seg.c,88 :: 		PORTC = display(centena);
	MOVF       _centena+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _centena+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;RelogioDisp7Seg.c,89 :: 		}
	GOTO       L_interrupt8
L_interrupt7:
;RelogioDisp7Seg.c,90 :: 		else if(!dez && control == 0x03){
	BTFSC      RB2_bit+0, 2
	GOTO       L_interrupt11
	MOVF       _control+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt11
L__interrupt35:
;RelogioDisp7Seg.c,92 :: 		mil = 0x00;
	BCF        RB0_bit+0, 0
;RelogioDisp7Seg.c,93 :: 		cent = 0x00;
	BCF        RB1_bit+0, 1
;RelogioDisp7Seg.c,94 :: 		uni = 0x00;
	BCF        RB3_bit+0, 3
;RelogioDisp7Seg.c,95 :: 		control = 0x04;
	MOVLW      4
	MOVWF      _control+0
;RelogioDisp7Seg.c,96 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;RelogioDisp7Seg.c,97 :: 		dezena = (minu%100)/10;
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
;RelogioDisp7Seg.c,98 :: 		dez = 0x01;
	BSF        RB2_bit+0, 2
;RelogioDisp7Seg.c,99 :: 		PORTC = display(dezena);
	MOVF       _dezena+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _dezena+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;RelogioDisp7Seg.c,100 :: 		}
	GOTO       L_interrupt12
L_interrupt11:
;RelogioDisp7Seg.c,101 :: 		else if(!uni && control == 0x04){
	BTFSC      RB3_bit+0, 3
	GOTO       L_interrupt15
	MOVF       _control+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt15
L__interrupt34:
;RelogioDisp7Seg.c,103 :: 		mil = 0x00;
	BCF        RB0_bit+0, 0
;RelogioDisp7Seg.c,104 :: 		cent = 0x00;
	BCF        RB1_bit+0, 1
;RelogioDisp7Seg.c,105 :: 		dez = 0x00;
	BCF        RB2_bit+0, 2
;RelogioDisp7Seg.c,106 :: 		control = 0x01;
	MOVLW      1
	MOVWF      _control+0
;RelogioDisp7Seg.c,107 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;RelogioDisp7Seg.c,108 :: 		unidade = minu%10;
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
;RelogioDisp7Seg.c,109 :: 		uni = 0x01;
	BSF        RB3_bit+0, 3
;RelogioDisp7Seg.c,110 :: 		PORTC = display(unidade);
	MOVF       _unidade+0, 0
	MOVWF      FARG_display_num+0
	MOVF       _unidade+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;RelogioDisp7Seg.c,111 :: 		}
L_interrupt15:
L_interrupt12:
L_interrupt8:
L_interrupt4:
;RelogioDisp7Seg.c,112 :: 		}
L_interrupt0:
;RelogioDisp7Seg.c,114 :: 		if(TMR1IF_bit){
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt16
;RelogioDisp7Seg.c,116 :: 		TMR1IF_bit = 0x00;
	BCF        TMR1IF_bit+0, 0
;RelogioDisp7Seg.c,117 :: 		TMR1H = 0x0B;
	MOVLW      11
	MOVWF      TMR1H+0
;RelogioDisp7Seg.c,118 :: 		TMR1L = 0xDC;
	MOVLW      220
	MOVWF      TMR1L+0
;RelogioDisp7Seg.c,120 :: 		led = ~led;
	MOVLW      64
	XORWF      RB6_bit+0, 1
;RelogioDisp7Seg.c,122 :: 		cont++;
	INCF       _cont+0, 1
;RelogioDisp7Seg.c,124 :: 		if(cont == 0x02){
	MOVF       _cont+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt17
;RelogioDisp7Seg.c,126 :: 		cont = 0x00;
	CLRF       _cont+0
;RelogioDisp7Seg.c,127 :: 		seg++;
	INCF       _seg+0, 1
;RelogioDisp7Seg.c,128 :: 		}
L_interrupt17:
;RelogioDisp7Seg.c,129 :: 		}
L_interrupt16:
;RelogioDisp7Seg.c,130 :: 		}
L__interrupt40:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;RelogioDisp7Seg.c,132 :: 		void main(){
;RelogioDisp7Seg.c,134 :: 		CMCON = 0x07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;RelogioDisp7Seg.c,136 :: 		OPTION_REG = 0x83; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:16
	MOVLW      131
	MOVWF      OPTION_REG+0
;RelogioDisp7Seg.c,137 :: 		INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção do timer0
	MOVLW      160
	MOVWF      INTCON+0
;RelogioDisp7Seg.c,139 :: 		T1CON = 0x31; // Habilita o timer1 e configura seu prescaler em 1:8;
	MOVLW      49
	MOVWF      T1CON+0
;RelogioDisp7Seg.c,140 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1 (registrador PIE1)
	BSF        TMR1IE_bit+0, 0
;RelogioDisp7Seg.c,141 :: 		TMR1H = 0x0B; // Inicia a contagem do timer 1 em 3036(decimal), para uma contagem de 62500
	MOVLW      11
	MOVWF      TMR1H+0
;RelogioDisp7Seg.c,142 :: 		TMR1L = 0xDC;
	MOVLW      220
	MOVWF      TMR1L+0
;RelogioDisp7Seg.c,144 :: 		TRISB = 0xB0; // Configura apenas RB4, RB5 e RB7 como entradas digitais
	MOVLW      176
	MOVWF      TRISB+0
;RelogioDisp7Seg.c,145 :: 		TRISC = 0x80; // Configura apenas RC7 como entrada digital
	MOVLW      128
	MOVWF      TRISC+0
;RelogioDisp7Seg.c,146 :: 		PORTB = 0xB0; // Inicia RB4, RB5 e RB7 em High, o resto em Low
	MOVLW      176
	MOVWF      PORTB+0
;RelogioDisp7Seg.c,147 :: 		PORTC = 0x80; // Inicia os displays mostrando "0"
	MOVLW      128
	MOVWF      PORTC+0
;RelogioDisp7Seg.c,149 :: 		while(1){
L_main18:
;RelogioDisp7Seg.c,151 :: 		relogio();
	CALL       _relogio+0
;RelogioDisp7Seg.c,152 :: 		}
	GOTO       L_main18
;RelogioDisp7Seg.c,153 :: 		}
	GOTO       $+0
; end of _main

_relogio:

;RelogioDisp7Seg.c,155 :: 		void relogio(){
;RelogioDisp7Seg.c,157 :: 		if(seg > 59){
	MOVF       _seg+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_relogio20
;RelogioDisp7Seg.c,159 :: 		seg = 0;
	CLRF       _seg+0
;RelogioDisp7Seg.c,160 :: 		minu++;
	INCF       _minu+0, 1
;RelogioDisp7Seg.c,162 :: 		if(minu > 59){
	MOVF       _minu+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_relogio21
;RelogioDisp7Seg.c,164 :: 		minu = 0;
	CLRF       _minu+0
;RelogioDisp7Seg.c,165 :: 		hora++;
	INCF       _hora+0, 1
;RelogioDisp7Seg.c,167 :: 		if(hora > 23)
	MOVF       _hora+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_relogio22
;RelogioDisp7Seg.c,168 :: 		hora = 0;
	CLRF       _hora+0
L_relogio22:
;RelogioDisp7Seg.c,169 :: 		}
L_relogio21:
;RelogioDisp7Seg.c,170 :: 		}
L_relogio20:
;RelogioDisp7Seg.c,172 :: 		if(!botMin)
	BTFSC      RB4_bit+0, 4
	GOTO       L_relogio23
;RelogioDisp7Seg.c,173 :: 		flag.B0 = 0x01;
	BSF        _flag+0, 0
L_relogio23:
;RelogioDisp7Seg.c,174 :: 		if(!botHora)
	BTFSC      RB5_bit+0, 5
	GOTO       L_relogio24
;RelogioDisp7Seg.c,175 :: 		flag.B1 = 0x01;
	BSF        _flag+0, 1
L_relogio24:
;RelogioDisp7Seg.c,177 :: 		if(botMin && flag.B0){
	BTFSS      RB4_bit+0, 4
	GOTO       L_relogio27
	BTFSS      _flag+0, 0
	GOTO       L_relogio27
L__relogio39:
;RelogioDisp7Seg.c,179 :: 		flag.B0 = 0x00;
	BCF        _flag+0, 0
;RelogioDisp7Seg.c,180 :: 		minu++;
	INCF       _minu+0, 1
;RelogioDisp7Seg.c,182 :: 		if(minu > 59){
	MOVF       _minu+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_relogio28
;RelogioDisp7Seg.c,184 :: 		minu = 0;
	CLRF       _minu+0
;RelogioDisp7Seg.c,185 :: 		hora++;
	INCF       _hora+0, 1
;RelogioDisp7Seg.c,187 :: 		if(hora > 59)
	MOVF       _hora+0, 0
	SUBLW      59
	BTFSC      STATUS+0, 0
	GOTO       L_relogio29
;RelogioDisp7Seg.c,188 :: 		hora = 0;
	CLRF       _hora+0
L_relogio29:
;RelogioDisp7Seg.c,189 :: 		}
L_relogio28:
;RelogioDisp7Seg.c,190 :: 		}
L_relogio27:
;RelogioDisp7Seg.c,191 :: 		if(botHora && flag.B1){
	BTFSS      RB5_bit+0, 5
	GOTO       L_relogio32
	BTFSS      _flag+0, 1
	GOTO       L_relogio32
L__relogio38:
;RelogioDisp7Seg.c,193 :: 		flag.B1 = 0x00;
	BCF        _flag+0, 1
;RelogioDisp7Seg.c,194 :: 		hora++;
	INCF       _hora+0, 1
;RelogioDisp7Seg.c,196 :: 		if(hora > 23)
	MOVF       _hora+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_relogio33
;RelogioDisp7Seg.c,197 :: 		hora = 0;
	CLRF       _hora+0
L_relogio33:
;RelogioDisp7Seg.c,198 :: 		}
L_relogio32:
;RelogioDisp7Seg.c,199 :: 		}
	RETURN
; end of _relogio

_display:

;RelogioDisp7Seg.c,202 :: 		int display(int num){
;RelogioDisp7Seg.c,204 :: 		int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
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
;RelogioDisp7Seg.c,207 :: 		aux = vetorDisplay[num];
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
;RelogioDisp7Seg.c,209 :: 		return aux;
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
;RelogioDisp7Seg.c,210 :: 		}
	RETURN
; end of _display

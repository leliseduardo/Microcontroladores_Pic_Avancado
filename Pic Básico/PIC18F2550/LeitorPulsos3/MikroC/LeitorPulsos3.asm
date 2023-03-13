
_interrupt:

;LeitorPulsos3.c,64 :: 		void interrupt(){
;LeitorPulsos3.c,66 :: 		if(INT0IF_bit){
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;LeitorPulsos3.c,68 :: 		INT0IF_bit = 0x00;
	BCF         INT0IF_bit+0, 1 
;LeitorPulsos3.c,69 :: 		baseTempo1 = 0x00;
	CLRF        _baseTempo1+0 
	CLRF        _baseTempo1+1 
;LeitorPulsos3.c,70 :: 		baseTempo2 = 0x00;
	CLRF        _baseTempo2+0 
	CLRF        _baseTempo2+1 
;LeitorPulsos3.c,71 :: 		pulso++;
	INCF        _pulso+0, 1 
;LeitorPulsos3.c,72 :: 		cont = pulso;
	MOVF        _pulso+0, 0 
	MOVWF       _cont+0 
;LeitorPulsos3.c,74 :: 		} // end if INT0IF_bit
L_interrupt0:
;LeitorPulsos3.c,76 :: 		if(TMR2IF_bit){
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt1
;LeitorPulsos3.c,78 :: 		TMR2IF_bit = 0x00;
	BCF         TMR2IF_bit+0, 1 
;LeitorPulsos3.c,80 :: 		baseTempo1++;
	INFSNZ      _baseTempo1+0, 1 
	INCF        _baseTempo1+1, 1 
;LeitorPulsos3.c,81 :: 		baseTempo2++;
	INFSNZ      _baseTempo2+0, 1 
	INCF        _baseTempo2+1, 1 
;LeitorPulsos3.c,83 :: 		if(baseTempo1 == 2000){  // A cada 2000 x 50us = 100ms a variável pulso é limpa
	MOVF        _baseTempo1+1, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVLW       208
	XORWF       _baseTempo1+0, 0 
L__interrupt17:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;LeitorPulsos3.c,88 :: 		baseTempo1 = 0x00;
	CLRF        _baseTempo1+0 
	CLRF        _baseTempo1+1 
;LeitorPulsos3.c,90 :: 		pulso = 0x00;
	CLRF        _pulso+0 
;LeitorPulsos3.c,92 :: 		flagControl = 0x01;
	BSF         _flagControl+0, BitPos(_flagControl+0) 
;LeitorPulsos3.c,94 :: 		} // end if baseTempo == 2000
L_interrupt2:
;LeitorPulsos3.c,96 :: 		if(baseTempo2 == 6000){ // A cada 6000 x 50us = 300ms a variável cont é limpa, confirmando que nenhum sensor está ativado
	MOVF        _baseTempo2+1, 0 
	XORLW       23
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt18
	MOVLW       112
	XORWF       _baseTempo2+0, 0 
L__interrupt18:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;LeitorPulsos3.c,98 :: 		baseTempo2 = 0x00;
	CLRF        _baseTempo2+0 
	CLRF        _baseTempo2+1 
;LeitorPulsos3.c,100 :: 		cont = 0x00;
	CLRF        _cont+0 
;LeitorPulsos3.c,102 :: 		flagControl = 0x01;
	BSF         _flagControl+0, BitPos(_flagControl+0) 
;LeitorPulsos3.c,104 :: 		} // end if baseTempo2 == 60000
L_interrupt3:
;LeitorPulsos3.c,106 :: 		} // end if TMR2IF_bit
L_interrupt1:
;LeitorPulsos3.c,108 :: 		} // end void interrupt
L__interrupt16:
	RETFIE      1
; end of _interrupt

_main:

;LeitorPulsos3.c,111 :: 		void main() {
;LeitorPulsos3.c,113 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;LeitorPulsos3.c,114 :: 		TRISB = 0x03; // Configura apenas RB0 e RB1 como entradas digitais, o resto como saída
	MOVLW       3
	MOVWF       TRISB+0 
;LeitorPulsos3.c,116 :: 		INTCON = 0xD0; // Habilita a interrupção global, a interrupção por periféricos e a interrupção externa INT0
	MOVLW       208
	MOVWF       INTCON+0 
;LeitorPulsos3.c,117 :: 		INTEDG0_bit = 0x01; // Registrador INTCON2. Configura a interrupção externa INT0 por borda de subida
	BSF         INTEDG0_bit+0, 6 
;LeitorPulsos3.c,118 :: 		TMR2ON_bit = 0x01; // Registrador T2CON. Habilita o timer2
	BSF         TMR2ON_bit+0, 2 
;LeitorPulsos3.c,119 :: 		PR2 = 200; // Configura o TMR2 para contar até 200
	MOVLW       200
	MOVWF       PR2+0 
;LeitorPulsos3.c,120 :: 		TMR2IE_bit = 0x01; // Registrador PIE1, habilita a interrupção por overflow do timer2
	BSF         TMR2IE_bit+0, 1 
;LeitorPulsos3.c,122 :: 		flagControl = 0x00;
	BCF         _flagControl+0, BitPos(_flagControl+0) 
;LeitorPulsos3.c,124 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;LeitorPulsos3.c,125 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LeitorPulsos3.c,126 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LeitorPulsos3.c,127 :: 		lcd_chr(1, 1, 'P');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,128 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,129 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,130 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,131 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,132 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,133 :: 		lcd_chr_cp('S');
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,134 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,135 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,136 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,137 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,138 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,141 :: 		while(1){
L_main4:
;LeitorPulsos3.c,145 :: 		leitura_Sensor();
	CALL        _leitura_Sensor+0, 0
;LeitorPulsos3.c,147 :: 		} // end Loop infinito
	GOTO        L_main4
;LeitorPulsos3.c,149 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Sensor:

;LeitorPulsos3.c,152 :: 		void leitura_Sensor(){
;LeitorPulsos3.c,154 :: 		if(flagControl){
	BTFSS       _flagControl+0, BitPos(_flagControl+0) 
	GOTO        L_leitura_Sensor6
;LeitorPulsos3.c,156 :: 		flagControl = 0x00;
	BCF         _flagControl+0, BitPos(_flagControl+0) 
;LeitorPulsos3.c,158 :: 		switch(cont){
	GOTO        L_leitura_Sensor7
;LeitorPulsos3.c,160 :: 		case 0x01: display_Digital1();
L_leitura_Sensor9:
	CALL        _display_Digital1+0, 0
;LeitorPulsos3.c,161 :: 		break;
	GOTO        L_leitura_Sensor8
;LeitorPulsos3.c,162 :: 		case 0x02: display_Digital2();
L_leitura_Sensor10:
	CALL        _display_Digital2+0, 0
;LeitorPulsos3.c,163 :: 		break;
	GOTO        L_leitura_Sensor8
;LeitorPulsos3.c,164 :: 		case 0x03: display_Digital3();
L_leitura_Sensor11:
	CALL        _display_Digital3+0, 0
;LeitorPulsos3.c,165 :: 		break;
	GOTO        L_leitura_Sensor8
;LeitorPulsos3.c,166 :: 		case 0x04: display_Digital4();
L_leitura_Sensor12:
	CALL        _display_Digital4+0, 0
;LeitorPulsos3.c,167 :: 		break;
	GOTO        L_leitura_Sensor8
;LeitorPulsos3.c,168 :: 		case 0x05: display_Analogico1();
L_leitura_Sensor13:
	CALL        _display_Analogico1+0, 0
;LeitorPulsos3.c,169 :: 		break;
	GOTO        L_leitura_Sensor8
;LeitorPulsos3.c,170 :: 		case 0x06: display_Analogico2();
L_leitura_Sensor14:
	CALL        _display_Analogico2+0, 0
;LeitorPulsos3.c,171 :: 		break;
	GOTO        L_leitura_Sensor8
;LeitorPulsos3.c,172 :: 		default:   display_Default();
L_leitura_Sensor15:
	CALL        _display_Default+0, 0
;LeitorPulsos3.c,174 :: 		} // end switch cont
	GOTO        L_leitura_Sensor8
L_leitura_Sensor7:
	MOVF        _cont+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Sensor9
	MOVF        _cont+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Sensor10
	MOVF        _cont+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Sensor11
	MOVF        _cont+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Sensor12
	MOVF        _cont+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Sensor13
	MOVF        _cont+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Sensor14
	GOTO        L_leitura_Sensor15
L_leitura_Sensor8:
;LeitorPulsos3.c,176 :: 		} // end if flagControl
L_leitura_Sensor6:
;LeitorPulsos3.c,178 :: 		} // end void leitura_Sensor
	RETURN      0
; end of _leitura_Sensor

_display_Digital1:

;LeitorPulsos3.c,181 :: 		void display_Digital1(){
;LeitorPulsos3.c,183 :: 		lcd_chr(2, 2, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,184 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,185 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,186 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,187 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,188 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,189 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,190 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,191 :: 		lcd_chr_cp('1');
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,192 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,193 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,194 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,197 :: 		} // end void imprime_Display1
	RETURN      0
; end of _display_Digital1

_display_Digital2:

;LeitorPulsos3.c,200 :: 		void display_Digital2(){
;LeitorPulsos3.c,202 :: 		lcd_chr(2, 2, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,203 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,204 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,205 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,206 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,207 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,208 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,209 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,210 :: 		lcd_chr_cp('2');
	MOVLW       50
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,211 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,212 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,213 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,215 :: 		} // end void imprime_Display2
	RETURN      0
; end of _display_Digital2

_display_Digital3:

;LeitorPulsos3.c,218 :: 		void display_Digital3(){
;LeitorPulsos3.c,220 :: 		lcd_chr(2, 2, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,221 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,222 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,223 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,224 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,225 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,226 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,227 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,228 :: 		lcd_chr_cp('3');
	MOVLW       51
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,229 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,230 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,231 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,233 :: 		} // end void imprime_Display3
	RETURN      0
; end of _display_Digital3

_display_Digital4:

;LeitorPulsos3.c,236 :: 		void display_Digital4(){
;LeitorPulsos3.c,238 :: 		lcd_chr(2, 2, 'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,239 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,240 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,241 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,242 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,243 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,244 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,245 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,246 :: 		lcd_chr_cp('4');
	MOVLW       52
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,247 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,248 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,249 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,251 :: 		} // end void imprime_Display4
	RETURN      0
; end of _display_Digital4

_display_Analogico1:

;LeitorPulsos3.c,254 :: 		void display_Analogico1(){
;LeitorPulsos3.c,256 :: 		lcd_chr(2, 2, 'A');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       65
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,257 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,258 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,259 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,260 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,261 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,262 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,263 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,264 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,265 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,266 :: 		lcd_chr_cp('1');
	MOVLW       49
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,267 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,269 :: 		} // end void imprime_Display5
	RETURN      0
; end of _display_Analogico1

_display_Analogico2:

;LeitorPulsos3.c,272 :: 		void display_Analogico2(){
;LeitorPulsos3.c,274 :: 		lcd_chr(2, 2, 'A');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       65
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,275 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,276 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,277 :: 		lcd_chr_cp('l');
	MOVLW       108
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,278 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,279 :: 		lcd_chr_cp('g');
	MOVLW       103
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,280 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,281 :: 		lcd_chr_cp('c');
	MOVLW       99
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,282 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,283 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,284 :: 		lcd_chr_cp('2');
	MOVLW       50
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,285 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,287 :: 		} // end void imprime_Display6
	RETURN      0
; end of _display_Analogico2

_display_Default:

;LeitorPulsos3.c,290 :: 		void display_Default(){
;LeitorPulsos3.c,292 :: 		lcd_chr(2, 2, 'S');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       83
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;LeitorPulsos3.c,293 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,294 :: 		lcd_chr_cp('n');
	MOVLW       110
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,295 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,296 :: 		lcd_chr_cp('o');
	MOVLW       111
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,297 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,298 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,299 :: 		lcd_chr_cp('s');
	MOVLW       115
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,300 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,301 :: 		lcd_chr_cp('O');
	MOVLW       79
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,302 :: 		lcd_chr_cp('k');
	MOVLW       107
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,303 :: 		lcd_chr_cp('!');
	MOVLW       33
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;LeitorPulsos3.c,305 :: 		} // end void imprime_Display6
	RETURN      0
; end of _display_Default

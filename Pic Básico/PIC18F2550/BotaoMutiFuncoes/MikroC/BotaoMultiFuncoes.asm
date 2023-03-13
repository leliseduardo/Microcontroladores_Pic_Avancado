
_main:

;BotaoMultiFuncoes.c,41 :: 		void main() {
;BotaoMultiFuncoes.c,43 :: 		ADCON1 = 0x0F; // Configura todos os pinos que podem ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;BotaoMultiFuncoes.c,44 :: 		TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
	MOVLW       254
	MOVWF       TRISB+0 
;BotaoMultiFuncoes.c,45 :: 		PORTB = 0xFE; // Inicia todas as entradas digitais em High
	MOVLW       254
	MOVWF       PORTB+0 
;BotaoMultiFuncoes.c,46 :: 		LATB = 0xFE; // Inicia todas as saídas digiais em Low, no caso, somente LATB0
	MOVLW       254
	MOVWF       LATB+0 
;BotaoMultiFuncoes.c,48 :: 		INTCON2.B7 = 0x00; // Habilita os pull-ups internos de todas as entradas do portb
	BCF         INTCON2+0, 7 
;BotaoMultiFuncoes.c,50 :: 		T0CON = 0x84; // Habilita o timer0, configura com 16 bits, incremento por ciclo de máquina e prescaler de 1:32
	MOVLW       132
	MOVWF       T0CON+0 
;BotaoMultiFuncoes.c,51 :: 		TMR0L = 0xEE; // Inicia <TMR0H::TMR0L> para contar 31250
	MOVLW       238
	MOVWF       TMR0L+0 
;BotaoMultiFuncoes.c,52 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;BotaoMultiFuncoes.c,54 :: 		flagBotao = 0;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;BotaoMultiFuncoes.c,55 :: 		ativaAjuste = 0;
	BCF         _ativaAjuste+0, BitPos(_ativaAjuste+0) 
;BotaoMultiFuncoes.c,57 :: 		PWM1_Init(1500);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       166
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;BotaoMultiFuncoes.c,58 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;BotaoMultiFuncoes.c,61 :: 		while(1){
L_main0:
;BotaoMultiFuncoes.c,63 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_main2
;BotaoMultiFuncoes.c,65 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;BotaoMultiFuncoes.c,66 :: 		TMR0L = 0xEE;
	MOVLW       238
	MOVWF       TMR0L+0 
;BotaoMultiFuncoes.c,67 :: 		TMR0H = 0x85;
	MOVLW       133
	MOVWF       TMR0H+0 
;BotaoMultiFuncoes.c,69 :: 		if(!botao && flagBotao) cont++;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_main5
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_main5
L__main18:
	INCF        _cont+0, 1 
	GOTO        L_main6
L_main5:
;BotaoMultiFuncoes.c,70 :: 		else cont = 0x00; // Necessário para evitar a troca de função por interferência do botão
	CLRF        _cont+0 
L_main6:
;BotaoMultiFuncoes.c,72 :: 		if(cont == 0x08){
	MOVF        _cont+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
;BotaoMultiFuncoes.c,74 :: 		cont = 0x00;
	CLRF        _cont+0 
;BotaoMultiFuncoes.c,75 :: 		ativaAjuste = ~ativaAjuste;
	BTG         _ativaAjuste+0, BitPos(_ativaAjuste+0) 
;BotaoMultiFuncoes.c,77 :: 		for(i = 0x00; i < 0x0A; i++){
	CLRF        _i+0 
L_main8:
	MOVLW       10
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;BotaoMultiFuncoes.c,79 :: 		led = ~led;
	BTG         LATB0_bit+0, 0 
;BotaoMultiFuncoes.c,80 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	DECFSZ      R11, 1, 1
	BRA         L_main11
	NOP
;BotaoMultiFuncoes.c,77 :: 		for(i = 0x00; i < 0x0A; i++){
	INCF        _i+0, 1 
;BotaoMultiFuncoes.c,82 :: 		} // end for i = 0x00; i < 0x0A; i++
	GOTO        L_main8
L_main9:
;BotaoMultiFuncoes.c,84 :: 		led = 0x00;
	BCF         LATB0_bit+0, 0 
;BotaoMultiFuncoes.c,86 :: 		} // end if cont == 0x04
L_main7:
;BotaoMultiFuncoes.c,88 :: 		} // end if TMR0IF_bit
L_main2:
;BotaoMultiFuncoes.c,90 :: 		leitura_Botao();
	CALL        _leitura_Botao+0, 0
;BotaoMultiFuncoes.c,91 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;BotaoMultiFuncoes.c,95 :: 		} // end Loop infinito
	GOTO        L_main0
;BotaoMultiFuncoes.c,97 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botao:

;BotaoMultiFuncoes.c,100 :: 		void leitura_Botao(){
;BotaoMultiFuncoes.c,102 :: 		if(!botao) flagBotao = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botao12
	BSF         _flagBotao+0, BitPos(_flagBotao+0) 
L_leitura_Botao12:
;BotaoMultiFuncoes.c,104 :: 		if(botao && flagBotao){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botao15
	BTFSS       _flagBotao+0, BitPos(_flagBotao+0) 
	GOTO        L_leitura_Botao15
L__leitura_Botao19:
;BotaoMultiFuncoes.c,106 :: 		flagBotao = 0x00;
	BCF         _flagBotao+0, BitPos(_flagBotao+0) 
;BotaoMultiFuncoes.c,108 :: 		if(ativaAjuste) duty += 0x0A; // 0x0A(hexadecimal) = 10(decimal)
	BTFSS       _ativaAjuste+0, BitPos(_ativaAjuste+0) 
	GOTO        L_leitura_Botao16
	MOVLW       10
	ADDWF       _duty+0, 1 
	GOTO        L_leitura_Botao17
L_leitura_Botao16:
;BotaoMultiFuncoes.c,109 :: 		else led = ~led;
	BTG         LATB0_bit+0, 0 
L_leitura_Botao17:
;BotaoMultiFuncoes.c,111 :: 		} // end if botao && flagBotao
L_leitura_Botao15:
;BotaoMultiFuncoes.c,113 :: 		} // end void leitura_Botao
	RETURN      0
; end of _leitura_Botao

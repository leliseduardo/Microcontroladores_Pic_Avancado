
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MotorPassoTimer0.c,31 :: 		void interrupt(){
;MotorPassoTimer0.c,33 :: 		if(T0IF_bit){
	BTFSS      T0IF_bit+0, 2
	GOTO       L_interrupt0
;MotorPassoTimer0.c,35 :: 		T0IF_bit = 0x00;
	BCF        T0IF_bit+0, 2
;MotorPassoTimer0.c,36 :: 		TMR0 = velocidade;
	MOVF       _velocidade+0, 0
	MOVWF      TMR0+0
;MotorPassoTimer0.c,38 :: 		switch(cont){
	GOTO       L_interrupt1
;MotorPassoTimer0.c,40 :: 		case 0x01: passo1();
L_interrupt3:
	CALL       _passo1+0
;MotorPassoTimer0.c,41 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,42 :: 		case 0x02: passo2();
L_interrupt4:
	CALL       _passo2+0
;MotorPassoTimer0.c,43 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,44 :: 		case 0x03: passo3();
L_interrupt5:
	CALL       _passo3+0
;MotorPassoTimer0.c,45 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,46 :: 		case 0x04: passo4();
L_interrupt6:
	CALL       _passo4+0
;MotorPassoTimer0.c,47 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,48 :: 		case 0x05: passo5();
L_interrupt7:
	CALL       _passo5+0
;MotorPassoTimer0.c,49 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,50 :: 		case 0x06: passo6();
L_interrupt8:
	CALL       _passo6+0
;MotorPassoTimer0.c,51 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,52 :: 		case 0x07: passo7();
L_interrupt9:
	CALL       _passo7+0
;MotorPassoTimer0.c,53 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,54 :: 		case 0x08: passo8();
L_interrupt10:
	CALL       _passo8+0
;MotorPassoTimer0.c,55 :: 		break;
	GOTO       L_interrupt2
;MotorPassoTimer0.c,56 :: 		}
L_interrupt1:
	MOVF       _cont+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt3
	MOVF       _cont+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt4
	MOVF       _cont+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt5
	MOVF       _cont+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt6
	MOVF       _cont+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt7
	MOVF       _cont+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt8
	MOVF       _cont+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt9
	MOVF       _cont+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt10
L_interrupt2:
;MotorPassoTimer0.c,58 :: 		cont++;
	INCF       _cont+0, 1
;MotorPassoTimer0.c,60 :: 		if(cont > 0x08)
	MOVF       _cont+0, 0
	SUBLW      8
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt11
;MotorPassoTimer0.c,61 :: 		cont = 0x01;
	MOVLW      1
	MOVWF      _cont+0
L_interrupt11:
;MotorPassoTimer0.c,62 :: 		}
L_interrupt0:
;MotorPassoTimer0.c,63 :: 		}
L__interrupt30:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MotorPassoTimer0.c,65 :: 		void main() {
;MotorPassoTimer0.c,67 :: 		CMCON = 0x07; //Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;MotorPassoTimer0.c,68 :: 		OPTION_REG = 0x87; // Desabilita os pull-ups internos, fazr tmr0 incrementar com o clock interno e configura o prescaler em 1:256
	MOVLW      135
	MOVWF      OPTION_REG+0
;MotorPassoTimer0.c,69 :: 		INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção pelo timer0
	MOVLW      160
	MOVWF      INTCON+0
;MotorPassoTimer0.c,70 :: 		TMR0 = velocidade;
	MOVF       _velocidade+0, 0
	MOVWF      TMR0+0
;MotorPassoTimer0.c,72 :: 		TRISA = 0xFC; // Configura apenas RA0 e RA1 como saídas digitais
	MOVLW      252
	MOVWF      TRISA+0
;MotorPassoTimer0.c,73 :: 		TRISB = 0xF0; // Configura segundo neeble como saída
	MOVLW      240
	MOVWF      TRISB+0
;MotorPassoTimer0.c,74 :: 		PORTA = 0xFC; // Inicia apenas RB0 e RB1 em Low
	MOVLW      252
	MOVWF      PORTA+0
;MotorPassoTimer0.c,75 :: 		PORTB = 0xF0; // Inicia o segundo neeble em Low
	MOVLW      240
	MOVWF      PORTB+0
;MotorPassoTimer0.c,77 :: 		while(1){
L_main12:
;MotorPassoTimer0.c,79 :: 		if(!bot1 && !led1){
	BTFSC      RA2_bit+0, 2
	GOTO       L_main16
	BTFSC      RA0_bit+0, 0
	GOTO       L_main16
L__main29:
;MotorPassoTimer0.c,81 :: 		led1 = 0x01;
	BSF        RA0_bit+0, 0
;MotorPassoTimer0.c,82 :: 		velocidade++;
	INCF       _velocidade+0, 1
;MotorPassoTimer0.c,83 :: 		}
L_main16:
;MotorPassoTimer0.c,84 :: 		if(!bot2 && !led2){
	BTFSC      RA3_bit+0, 3
	GOTO       L_main19
	BTFSC      RA1_bit+0, 1
	GOTO       L_main19
L__main28:
;MotorPassoTimer0.c,86 :: 		led2 = 0x01;
	BSF        RA1_bit+0, 1
;MotorPassoTimer0.c,87 :: 		velocidade--;
	DECF       _velocidade+0, 1
;MotorPassoTimer0.c,88 :: 		}
L_main19:
;MotorPassoTimer0.c,90 :: 		if(bot1 && led1)
	BTFSS      RA2_bit+0, 2
	GOTO       L_main22
	BTFSS      RA0_bit+0, 0
	GOTO       L_main22
L__main27:
;MotorPassoTimer0.c,91 :: 		led1 = 0x00;
	BCF        RA0_bit+0, 0
L_main22:
;MotorPassoTimer0.c,93 :: 		if(bot2 && led2)
	BTFSS      RA3_bit+0, 3
	GOTO       L_main25
	BTFSS      RA1_bit+0, 1
	GOTO       L_main25
L__main26:
;MotorPassoTimer0.c,94 :: 		led2 = 0x00;
	BCF        RA1_bit+0, 1
L_main25:
;MotorPassoTimer0.c,95 :: 		}
	GOTO       L_main12
;MotorPassoTimer0.c,96 :: 		}
	GOTO       $+0
; end of _main

_passo1:

;MotorPassoTimer0.c,98 :: 		void passo1(){
;MotorPassoTimer0.c,100 :: 		m1 = 0x01;
	BSF        RB3_bit+0, 3
;MotorPassoTimer0.c,101 :: 		m2 = 0x00;
	BCF        RB2_bit+0, 2
;MotorPassoTimer0.c,102 :: 		m3 = 0x00;
	BCF        RB1_bit+0, 1
;MotorPassoTimer0.c,103 :: 		m4 = 0x00;
	BCF        RB0_bit+0, 0
;MotorPassoTimer0.c,104 :: 		}
	RETURN
; end of _passo1

_passo2:

;MotorPassoTimer0.c,106 :: 		void passo2(){
;MotorPassoTimer0.c,108 :: 		m1 = 0x01;
	BSF        RB3_bit+0, 3
;MotorPassoTimer0.c,109 :: 		m2 = 0x01;
	BSF        RB2_bit+0, 2
;MotorPassoTimer0.c,110 :: 		m3 = 0x00;
	BCF        RB1_bit+0, 1
;MotorPassoTimer0.c,111 :: 		m4 = 0x00;
	BCF        RB0_bit+0, 0
;MotorPassoTimer0.c,112 :: 		}
	RETURN
; end of _passo2

_passo3:

;MotorPassoTimer0.c,114 :: 		void passo3(){
;MotorPassoTimer0.c,116 :: 		m1 = 0x00;
	BCF        RB3_bit+0, 3
;MotorPassoTimer0.c,117 :: 		m2 = 0x01;
	BSF        RB2_bit+0, 2
;MotorPassoTimer0.c,118 :: 		m3 = 0x00;
	BCF        RB1_bit+0, 1
;MotorPassoTimer0.c,119 :: 		m4 = 0x00;
	BCF        RB0_bit+0, 0
;MotorPassoTimer0.c,120 :: 		}
	RETURN
; end of _passo3

_passo4:

;MotorPassoTimer0.c,122 :: 		void passo4(){
;MotorPassoTimer0.c,124 :: 		m1 = 0x00;
	BCF        RB3_bit+0, 3
;MotorPassoTimer0.c,125 :: 		m2 = 0x01;
	BSF        RB2_bit+0, 2
;MotorPassoTimer0.c,126 :: 		m3 = 0x01;
	BSF        RB1_bit+0, 1
;MotorPassoTimer0.c,127 :: 		m4 = 0x00;
	BCF        RB0_bit+0, 0
;MotorPassoTimer0.c,128 :: 		}
	RETURN
; end of _passo4

_passo5:

;MotorPassoTimer0.c,130 :: 		void passo5(){
;MotorPassoTimer0.c,132 :: 		m1 = 0x00;
	BCF        RB3_bit+0, 3
;MotorPassoTimer0.c,133 :: 		m2 = 0x00;
	BCF        RB2_bit+0, 2
;MotorPassoTimer0.c,134 :: 		m3 = 0x01;
	BSF        RB1_bit+0, 1
;MotorPassoTimer0.c,135 :: 		m4 = 0x00;
	BCF        RB0_bit+0, 0
;MotorPassoTimer0.c,136 :: 		}
	RETURN
; end of _passo5

_passo6:

;MotorPassoTimer0.c,138 :: 		void passo6(){
;MotorPassoTimer0.c,140 :: 		m1 = 0x00;
	BCF        RB3_bit+0, 3
;MotorPassoTimer0.c,141 :: 		m2 = 0x00;
	BCF        RB2_bit+0, 2
;MotorPassoTimer0.c,142 :: 		m3 = 0x01;
	BSF        RB1_bit+0, 1
;MotorPassoTimer0.c,143 :: 		m4 = 0x01;
	BSF        RB0_bit+0, 0
;MotorPassoTimer0.c,144 :: 		}
	RETURN
; end of _passo6

_passo7:

;MotorPassoTimer0.c,146 :: 		void passo7(){
;MotorPassoTimer0.c,148 :: 		m1 = 0x00;
	BCF        RB3_bit+0, 3
;MotorPassoTimer0.c,149 :: 		m2 = 0x00;
	BCF        RB2_bit+0, 2
;MotorPassoTimer0.c,150 :: 		m3 = 0x00;
	BCF        RB1_bit+0, 1
;MotorPassoTimer0.c,151 :: 		m4 = 0x01;
	BSF        RB0_bit+0, 0
;MotorPassoTimer0.c,152 :: 		}
	RETURN
; end of _passo7

_passo8:

;MotorPassoTimer0.c,154 :: 		void passo8(){
;MotorPassoTimer0.c,156 :: 		m1 = 0x01;
	BSF        RB3_bit+0, 3
;MotorPassoTimer0.c,157 :: 		m2 = 0x00;
	BCF        RB2_bit+0, 2
;MotorPassoTimer0.c,158 :: 		m3 = 0x00;
	BCF        RB1_bit+0, 1
;MotorPassoTimer0.c,159 :: 		m4 = 0x01;
	BSF        RB0_bit+0, 0
;MotorPassoTimer0.c,160 :: 		}
	RETURN
; end of _passo8

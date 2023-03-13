
_main:

;MultiplexDisplay.c,12 :: 		void main() {
;MultiplexDisplay.c,14 :: 		CMCON = 0X07; // Desabilita os comparadores internos
	MOVLW      7
	MOVWF      CMCON+0
;MultiplexDisplay.c,15 :: 		TRISA = 0X03; // Seleciona an0 e an1 como entradas digitais
	MOVLW      3
	MOVWF      TRISA+0
;MultiplexDisplay.c,16 :: 		TRISB = 0X00; // Seleciona todo o portb como saida digital
	CLRF       TRISB+0
;MultiplexDisplay.c,17 :: 		digDezena = 0x00; // Desliga o display das dezena
	BCF        PORTA+0, 2
;MultiplexDisplay.c,18 :: 		digCentena = 0x00; // Desliga o display das centenas
	BCF        PORTA+0, 3
;MultiplexDisplay.c,20 :: 		while(1){
L_main0:
;MultiplexDisplay.c,24 :: 		contagem(); // Função que verifica se os botôes foram clicados
	CALL       _contagem+0
;MultiplexDisplay.c,27 :: 		cent = (cont/100) - ((cont%100)/100); //Filtra, de cont, o numero centesimal. Ex: Se cont = 154, cent = 1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _cent+0
	MOVF       R0+1, 0
	MOVWF      _cent+1
;MultiplexDisplay.c,28 :: 		PORTB = display(cent); // Usa a função display para retornar o numero hexadecimal que aciona o portb igual a cent
	MOVF       R0+0, 0
	MOVWF      FARG_display_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;MultiplexDisplay.c,29 :: 		digCentena = 1;  // Liga o display que representa a centena, fazendo com que os leds desse diplay acendam
	BSF        PORTA+0, 3
;MultiplexDisplay.c,30 :: 		delay_ms(5); // Espera 5ms, que representa a alta frequencia que os displays ficarão ligados
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
;MultiplexDisplay.c,31 :: 		digCentena = 0; // Desliga o display das centenas
	BCF        PORTA+0, 3
;MultiplexDisplay.c,34 :: 		dez = (cont%100); // Exclui o numero centesimal de cont. Ex: Se cont = 154, dez = 54
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _dez+0
	MOVF       R0+1, 0
	MOVWF      _dez+1
;MultiplexDisplay.c,35 :: 		dez = (dez/10) - ((dez%10)/10); // Filtra, de dez, o numero decimal. Ex: Se dez = 54, dez = 5
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _dez+0, 0
	MOVWF      R0+0
	MOVF       _dez+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _dez+0
	MOVF       R0+1, 0
	MOVWF      _dez+1
;MultiplexDisplay.c,36 :: 		PORTB = display(dez); // Usa a função display para retornar o numero hexadecimal que aciona o portb igual a dez
	MOVF       R0+0, 0
	MOVWF      FARG_display_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;MultiplexDisplay.c,37 :: 		digDezena = 1; // Liga o display que representa os numero decimais
	BSF        PORTA+0, 2
;MultiplexDisplay.c,38 :: 		delay_ms(5); // Espera 5ms, o tempo referente a frequencia que os displays ficarão ligados
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
;MultiplexDisplay.c,39 :: 		digDezena = 0; // Desliga o display das dezenas
	BCF        PORTA+0, 2
;MultiplexDisplay.c,42 :: 		unid = cont%10; // Filtra, de cont, a unidade do numero. Ex: Se cont = 154, unid = 4
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _cont+0, 0
	MOVWF      R0+0
	MOVF       _cont+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _unid+0
	MOVF       R0+1, 0
	MOVWF      _unid+1
;MultiplexDisplay.c,43 :: 		PORTB = display(unid); // Usa a função display para retornar o numero hexadecimal que aciona o portb igual a unid
	MOVF       R0+0, 0
	MOVWF      FARG_display_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_num+1
	CALL       _display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;MultiplexDisplay.c,44 :: 		digUnidade = 1; // Liga o display das unidades
	BSF        PORTB+0, 7
;MultiplexDisplay.c,45 :: 		delay_ms(5); // Espera 5ms, tempo referente à frequência que os displays ficarão ligados
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
;MultiplexDisplay.c,46 :: 		digUnidade = 0; // Desliga o display da unidades
	BCF        PORTB+0, 7
;MultiplexDisplay.c,47 :: 		}
	GOTO       L_main0
;MultiplexDisplay.c,48 :: 		}
	GOTO       $+0
; end of _main

_display:

;MultiplexDisplay.c,50 :: 		int display(int num){
;MultiplexDisplay.c,52 :: 		int vetorDisplay[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0xF7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
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
	MOVLW      15
	MOVWF      display_vetorDisplay_L0+17
	MOVLW      103
	MOVWF      display_vetorDisplay_L0+18
	MOVLW      0
	MOVWF      display_vetorDisplay_L0+19
;MultiplexDisplay.c,55 :: 		aux = vetorDisplay[num];
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
;MultiplexDisplay.c,57 :: 		return aux;
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
;MultiplexDisplay.c,58 :: 		}
	RETURN
; end of _display

_contagem:

;MultiplexDisplay.c,60 :: 		void contagem(){
;MultiplexDisplay.c,62 :: 		while(mais == 1){
L_contagem5:
	BTFSS      PORTA+0, 1
	GOTO       L_contagem6
;MultiplexDisplay.c,63 :: 		cont = cont + 10;
	MOVLW      10
	ADDWF      _cont+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cont+1, 1
;MultiplexDisplay.c,64 :: 		delay_ms(180);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      145
	MOVWF      R12+0
	MOVLW      207
	MOVWF      R13+0
L_contagem7:
	DECFSZ     R13+0, 1
	GOTO       L_contagem7
	DECFSZ     R12+0, 1
	GOTO       L_contagem7
	DECFSZ     R11+0, 1
	GOTO       L_contagem7
	NOP
	NOP
;MultiplexDisplay.c,65 :: 		if(cont > 300)
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cont+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__contagem13
	MOVF       _cont+0, 0
	SUBLW      44
L__contagem13:
	BTFSC      STATUS+0, 0
	GOTO       L_contagem8
;MultiplexDisplay.c,66 :: 		cont = 300;
	MOVLW      44
	MOVWF      _cont+0
	MOVLW      1
	MOVWF      _cont+1
L_contagem8:
;MultiplexDisplay.c,67 :: 		}
	GOTO       L_contagem5
L_contagem6:
;MultiplexDisplay.c,69 :: 		while(menos == 1){
L_contagem9:
	BTFSS      PORTA+0, 0
	GOTO       L_contagem10
;MultiplexDisplay.c,70 :: 		cont = cont - 10;
	MOVLW      10
	SUBWF      _cont+0, 1
	BTFSS      STATUS+0, 0
	DECF       _cont+1, 1
;MultiplexDisplay.c,71 :: 		delay_ms(180);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      145
	MOVWF      R12+0
	MOVLW      207
	MOVWF      R13+0
L_contagem11:
	DECFSZ     R13+0, 1
	GOTO       L_contagem11
	DECFSZ     R12+0, 1
	GOTO       L_contagem11
	DECFSZ     R11+0, 1
	GOTO       L_contagem11
	NOP
	NOP
;MultiplexDisplay.c,72 :: 		if(cont < 1)
	MOVLW      128
	XORWF      _cont+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__contagem14
	MOVLW      1
	SUBWF      _cont+0, 0
L__contagem14:
	BTFSC      STATUS+0, 0
	GOTO       L_contagem12
;MultiplexDisplay.c,73 :: 		cont = 0;
	CLRF       _cont+0
	CLRF       _cont+1
L_contagem12:
;MultiplexDisplay.c,74 :: 		}
	GOTO       L_contagem9
L_contagem10:
;MultiplexDisplay.c,75 :: 		}
	RETURN
; end of _contagem

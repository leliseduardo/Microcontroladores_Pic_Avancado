
_main:

;SPISimples.c,29 :: 		void main() {
;SPISimples.c,31 :: 		ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;SPISimples.c,33 :: 		Chip_Select = 1;                       // Deselect DAC
	BSF         RC0_bit+0, 0 
;SPISimples.c,34 :: 		Chip_Select_Direction = 0;             // Set CS# pin as Output
	BCF         TRISC0_bit+0, 0 
;SPISimples.c,35 :: 		SPI1_Init();                           // Initialize SPI module
	CALL        _SPI1_Init+0, 0
;SPISimples.c,39 :: 		while(1){
L_main0:
;SPISimples.c,41 :: 		leitura_Botoes();
	CALL        _leitura_Botoes+0, 0
;SPISimples.c,43 :: 		Chip_Select = 0;
	BCF         RC0_bit+0, 0 
;SPISimples.c,45 :: 		SPI1_Write(valor);
	MOVF        _valor+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;SPISimples.c,47 :: 		Chip_Select = 1;
	BSF         RC0_bit+0, 0 
;SPISimples.c,48 :: 		delay_ms(1);
	MOVLW       6
	MOVWF       R12, 0
	MOVLW       48
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
;SPISimples.c,50 :: 		} // end Loop infinito
	GOTO        L_main0
;SPISimples.c,52 :: 		} // end void main
	GOTO        $+0
; end of _main

_leitura_Botoes:

;SPISimples.c,56 :: 		void leitura_Botoes(){
;SPISimples.c,58 :: 		if(!incremento) flagBotoes.B0 = 0x01;
	BTFSC       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes3
	BSF         _flagBotoes+0, 0 
L_leitura_Botoes3:
;SPISimples.c,59 :: 		if(!decremento) flagBotoes.B1 = 0x01;
	BTFSC       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes4
	BSF         _flagBotoes+0, 1 
L_leitura_Botoes4:
;SPISimples.c,61 :: 		if(incremento && flagBotoes.B0){
	BTFSS       RB7_bit+0, 7 
	GOTO        L_leitura_Botoes7
	BTFSS       _flagBotoes+0, 0 
	GOTO        L_leitura_Botoes7
L__leitura_Botoes21:
;SPISimples.c,63 :: 		flagBotoes.B0 = 0x00;
	BCF         _flagBotoes+0, 0 
;SPISimples.c,64 :: 		dado++;
	INCF        _dado+0, 1 
;SPISimples.c,66 :: 		if(dado > 0x05) dado = 0x01;
	MOVF        _dado+0, 0 
	SUBLW       5
	BTFSC       STATUS+0, 0 
	GOTO        L_leitura_Botoes8
	MOVLW       1
	MOVWF       _dado+0 
L_leitura_Botoes8:
;SPISimples.c,68 :: 		} // end if incremento && flagBotoes.B0
L_leitura_Botoes7:
;SPISimples.c,70 :: 		if(decremento && flagBotoes.B1){
	BTFSS       RB6_bit+0, 6 
	GOTO        L_leitura_Botoes11
	BTFSS       _flagBotoes+0, 1 
	GOTO        L_leitura_Botoes11
L__leitura_Botoes20:
;SPISimples.c,72 :: 		flagBotoes.B1 = 0x00;
	BCF         _flagBotoes+0, 1 
;SPISimples.c,73 :: 		dado--;
	DECF        _dado+0, 1 
;SPISimples.c,75 :: 		if(dado < 1) dado = 0x05;
	MOVLW       1
	SUBWF       _dado+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_leitura_Botoes12
	MOVLW       5
	MOVWF       _dado+0 
L_leitura_Botoes12:
;SPISimples.c,77 :: 		} // if decremento && flagBotoes.B1
L_leitura_Botoes11:
;SPISimples.c,79 :: 		switch(dado){
	GOTO        L_leitura_Botoes13
;SPISimples.c,81 :: 		case 0x01: valor = 0x01;
L_leitura_Botoes15:
	MOVLW       1
	MOVWF       _valor+0 
;SPISimples.c,82 :: 		break;
	GOTO        L_leitura_Botoes14
;SPISimples.c,83 :: 		case 0x02: valor = 0x02;
L_leitura_Botoes16:
	MOVLW       2
	MOVWF       _valor+0 
;SPISimples.c,84 :: 		break;
	GOTO        L_leitura_Botoes14
;SPISimples.c,85 :: 		case 0x03: valor = 0x72;
L_leitura_Botoes17:
	MOVLW       114
	MOVWF       _valor+0 
;SPISimples.c,86 :: 		break;
	GOTO        L_leitura_Botoes14
;SPISimples.c,87 :: 		case 0x04: valor = 0xBD;
L_leitura_Botoes18:
	MOVLW       189
	MOVWF       _valor+0 
;SPISimples.c,88 :: 		break;
	GOTO        L_leitura_Botoes14
;SPISimples.c,89 :: 		case 0x05: valor = 0xAA;
L_leitura_Botoes19:
	MOVLW       170
	MOVWF       _valor+0 
;SPISimples.c,90 :: 		break;
	GOTO        L_leitura_Botoes14
;SPISimples.c,92 :: 		} // end switch dado
L_leitura_Botoes13:
	MOVF        _dado+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Botoes15
	MOVF        _dado+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Botoes16
	MOVF        _dado+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Botoes17
	MOVF        _dado+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Botoes18
	MOVF        _dado+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_leitura_Botoes19
L_leitura_Botoes14:
;SPISimples.c,94 :: 		} // end void leitura_Botoes
	RETURN      0
; end of _leitura_Botoes


_main:

;DisplayeLCDSimples.c,43 :: 		void main() {
;DisplayeLCDSimples.c,45 :: 		ADCON0 = 0x01; // Seleciona e habilita o canal AN0 e habilita o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;DisplayeLCDSimples.c,46 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão como sendo o intervalo da fonte (Vss a Vdd) e configura apenas AN0 como analógico
	MOVLW       14
	MOVWF       ADCON1+0 
;DisplayeLCDSimples.c,48 :: 		TRISA = 0xFF; // Configura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;DisplayeLCDSimples.c,49 :: 		TRISB = 0x03; // Configura apenas RD0 e RD1 como entradas digitais, pois não serão usados
	MOVLW       3
	MOVWF       TRISB+0 
;DisplayeLCDSimples.c,52 :: 		lcd_Init();
	CALL        _Lcd_Init+0, 0
;DisplayeLCDSimples.c,53 :: 		lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;DisplayeLCDSimples.c,54 :: 		lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;DisplayeLCDSimples.c,56 :: 		while(1){
L_main0:
;DisplayeLCDSimples.c,58 :: 		imprimeLCD(); // Imprime o texto "Leitura ADC" no display
	CALL        _imprimeLCD+0, 0
;DisplayeLCDSimples.c,59 :: 		leituraADC();
	CALL        _leituraADC+0, 0
;DisplayeLCDSimples.c,60 :: 		}
	GOTO        L_main0
;DisplayeLCDSimples.c,61 :: 		}
	GOTO        $+0
; end of _main

_leituraADC:

;DisplayeLCDSimples.c,63 :: 		void leituraADC(){
;DisplayeLCDSimples.c,67 :: 		adc = adc_read(0); // Leitura do conversor AD no canal 0
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;DisplayeLCDSimples.c,69 :: 		mil = adc/1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       leituraADC_mil_L0+0 
;DisplayeLCDSimples.c,70 :: 		cen = (adc%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _adc+0, 0 
	MOVWF       R0 
	MOVF        _adc+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       leituraADC_cen_L0+0 
;DisplayeLCDSimples.c,71 :: 		dez = (adc%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _adc+0, 0 
	MOVWF       R0 
	MOVF        _adc+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       leituraADC_dez_L0+0 
;DisplayeLCDSimples.c,72 :: 		uni = adc%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _adc+0, 0 
	MOVWF       R0 
	MOVF        _adc+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       leituraADC_uni_L0+0 
;DisplayeLCDSimples.c,74 :: 		lcd_chr(2, 4, mil+48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       leituraADC_mil_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DisplayeLCDSimples.c,75 :: 		lcd_chr_cp(cen+48);
	MOVLW       48
	ADDWF       leituraADC_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,76 :: 		lcd_chr_cp(dez+48);
	MOVLW       48
	ADDWF       leituraADC_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,77 :: 		lcd_chr_cp(uni+48);
	MOVLW       48
	ADDWF       leituraADC_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,82 :: 		}
	RETURN      0
; end of _leituraADC

_imprimeLCD:

;DisplayeLCDSimples.c,84 :: 		void imprimeLCD(){
;DisplayeLCDSimples.c,86 :: 		lcd_chr(1, 2, 'L');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       76
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;DisplayeLCDSimples.c,87 :: 		lcd_chr_cp('e');
	MOVLW       101
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,88 :: 		lcd_chr_cp('i');
	MOVLW       105
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,89 :: 		lcd_chr_cp('t');
	MOVLW       116
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,90 :: 		lcd_chr_cp('u');
	MOVLW       117
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,91 :: 		lcd_chr_cp('r');
	MOVLW       114
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,92 :: 		lcd_chr_cp('a');
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,93 :: 		lcd_chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,94 :: 		lcd_chr_cp('A');
	MOVLW       65
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,95 :: 		lcd_chr_cp('D');
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,96 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;DisplayeLCDSimples.c,97 :: 		}
	RETURN      0
; end of _imprimeLCD

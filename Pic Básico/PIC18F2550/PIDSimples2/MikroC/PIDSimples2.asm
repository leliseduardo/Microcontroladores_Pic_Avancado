
_interrupt:

;PIDSimples2.c,56 :: 		void interrupt(){
;PIDSimples2.c,58 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;PIDSimples2.c,60 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;PIDSimples2.c,61 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;PIDSimples2.c,62 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;PIDSimples2.c,64 :: 		baseTempo += 1;
	INFSNZ      _baseTempo+0, 1 
	INCF        _baseTempo+1, 1 
;PIDSimples2.c,66 :: 		} // end TMR0IF_bit
L_interrupt0:
;PIDSimples2.c,68 :: 		} // end void interrupt
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;PIDSimples2.c,70 :: 		void main() {
;PIDSimples2.c,73 :: 		TRISA = 0xFF; // Cofigura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;PIDSimples2.c,75 :: 		ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e ativa o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;PIDSimples2.c,76 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura AN0 como entrada analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;PIDSimples2.c,78 :: 		INTCON = 0xA0; // Ativa a interrupção global e a interrupção por overflow do timer 0
	MOVLW       160
	MOVWF       INTCON+0 
;PIDSimples2.c,79 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de maquina e prescale de 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;PIDSimples2.c,80 :: 		TMR0H = 0x9E; // Inicia em 40536 para uma contagem de 25000
	MOVLW       158
	MOVWF       TMR0H+0 
;PIDSimples2.c,81 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;PIDSimples2.c,84 :: 		PWM1_Init(1000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;PIDSimples2.c,85 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;PIDSimples2.c,86 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PIDSimples2.c,89 :: 		lcd_Init();
	CALL        _Lcd_Init+0, 0
;PIDSimples2.c,90 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PIDSimples2.c,91 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PIDSimples2.c,92 :: 		lcd_out(1, 2, "ADC: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_PIDSimples2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_PIDSimples2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PIDSimples2.c,93 :: 		lcd_out(2, 2, "PWM: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_PIDSimples2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_PIDSimples2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PIDSimples2.c,96 :: 		while(1){
L_main1:
;PIDSimples2.c,98 :: 		medidaADC = adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _medidaADC+0 
	MOVF        R1, 0 
	MOVWF       _medidaADC+1 
;PIDSimples2.c,100 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PIDSimples2.c,102 :: 		if(baseTempo == 40){
	MOVLW       0
	XORWF       _baseTempo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main6
	MOVLW       40
	XORWF       _baseTempo+0, 0 
L__main6:
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;PIDSimples2.c,104 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
	CLRF        _baseTempo+1 
;PIDSimples2.c,106 :: 		controle_PID();
	CALL        _controle_PID+0, 0
;PIDSimples2.c,108 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;PIDSimples2.c,110 :: 		} // end if baseTempo == 40
L_main3:
;PIDSimples2.c,112 :: 		} // end Loop infinito
	GOTO        L_main1
;PIDSimples2.c,114 :: 		} // end void main
	GOTO        $+0
; end of _main

_controle_PID:

;PIDSimples2.c,116 :: 		void controle_PID(){
;PIDSimples2.c,118 :: 		erro = valorIdeal - medidaADC;
	MOVF        _medidaADC+0, 0 
	MOVWF       R0 
	MOVF        _medidaADC+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _valorIdeal+0, 0 
	MOVWF       R0 
	MOVF        _valorIdeal+1, 0 
	MOVWF       R1 
	MOVF        _valorIdeal+2, 0 
	MOVWF       R2 
	MOVF        _valorIdeal+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _erro+0 
	MOVF        R1, 0 
	MOVWF       _erro+1 
	MOVF        R2, 0 
	MOVWF       _erro+2 
	MOVF        R3, 0 
	MOVWF       _erro+3 
;PIDSimples2.c,120 :: 		proporcional = erro * kp;
	MOVF        _kp+0, 0 
	MOVWF       R4 
	MOVF        _kp+1, 0 
	MOVWF       R5 
	MOVF        _kp+2, 0 
	MOVWF       R6 
	MOVF        _kp+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _proporcional+0 
	MOVF        R1, 0 
	MOVWF       _proporcional+1 
	MOVF        R2, 0 
	MOVWF       _proporcional+2 
	MOVF        R3, 0 
	MOVWF       _proporcional+3 
;PIDSimples2.c,122 :: 		integral += (erro * ki * 1);
	MOVF        _erro+0, 0 
	MOVWF       R0 
	MOVF        _erro+1, 0 
	MOVWF       R1 
	MOVF        _erro+2, 0 
	MOVWF       R2 
	MOVF        _erro+3, 0 
	MOVWF       R3 
	MOVF        _ki+0, 0 
	MOVWF       R4 
	MOVF        _ki+1, 0 
	MOVWF       R5 
	MOVF        _ki+2, 0 
	MOVWF       R6 
	MOVF        _ki+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        _integral+0, 0 
	MOVWF       R4 
	MOVF        _integral+1, 0 
	MOVWF       R5 
	MOVF        _integral+2, 0 
	MOVWF       R6 
	MOVF        _integral+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _integral+0 
	MOVF        R1, 0 
	MOVWF       _integral+1 
	MOVF        R2, 0 
	MOVWF       _integral+2 
	MOVF        R3, 0 
	MOVWF       _integral+3 
;PIDSimples2.c,124 :: 		derivativo = (((ultimaMedida - medidaADC) * kd) / 1);
	MOVF        _medidaADC+0, 0 
	SUBWF       _ultimaMedida+0, 0 
	MOVWF       R0 
	MOVF        _medidaADC+1, 0 
	SUBWFB      _ultimaMedida+1, 0 
	MOVWF       R1 
	CALL        _Int2Double+0, 0
	MOVF        _kd+0, 0 
	MOVWF       R4 
	MOVF        _kd+1, 0 
	MOVWF       R5 
	MOVF        _kd+2, 0 
	MOVWF       R6 
	MOVF        _kd+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__controle_PID+0 
	MOVF        R1, 0 
	MOVWF       FLOC__controle_PID+1 
	MOVF        R2, 0 
	MOVWF       FLOC__controle_PID+2 
	MOVF        R3, 0 
	MOVWF       FLOC__controle_PID+3 
	MOVF        FLOC__controle_PID+0, 0 
	MOVWF       _derivativo+0 
	MOVF        FLOC__controle_PID+1, 0 
	MOVWF       _derivativo+1 
	MOVF        FLOC__controle_PID+2, 0 
	MOVWF       _derivativo+2 
	MOVF        FLOC__controle_PID+3, 0 
	MOVWF       _derivativo+3 
;PIDSimples2.c,126 :: 		ultimaMedida = medidaADC;
	MOVF        _medidaADC+0, 0 
	MOVWF       _ultimaMedida+0 
	MOVF        _medidaADC+1, 0 
	MOVWF       _ultimaMedida+1 
;PIDSimples2.c,128 :: 		PID = proporcional + integral + derivativo;
	MOVF        _proporcional+0, 0 
	MOVWF       R0 
	MOVF        _proporcional+1, 0 
	MOVWF       R1 
	MOVF        _proporcional+2, 0 
	MOVWF       R2 
	MOVF        _proporcional+3, 0 
	MOVWF       R3 
	MOVF        _integral+0, 0 
	MOVWF       R4 
	MOVF        _integral+1, 0 
	MOVWF       R5 
	MOVF        _integral+2, 0 
	MOVWF       R6 
	MOVF        _integral+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        FLOC__controle_PID+0, 0 
	MOVWF       R4 
	MOVF        FLOC__controle_PID+1, 0 
	MOVWF       R5 
	MOVF        FLOC__controle_PID+2, 0 
	MOVWF       R6 
	MOVF        FLOC__controle_PID+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _PID+0 
	MOVF        R1, 0 
	MOVWF       _PID+1 
	MOVF        R2, 0 
	MOVWF       _PID+2 
	MOVF        R3, 0 
	MOVWF       _PID+3 
;PIDSimples2.c,130 :: 		PID = PID/4; // Normalização, pois ADC tem 10 bits e o PWM tem 9 bits
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _PID+0 
	MOVF        R1, 0 
	MOVWF       _PID+1 
	MOVF        R2, 0 
	MOVWF       _PID+2 
	MOVF        R3, 0 
	MOVWF       _PID+3 
;PIDSimples2.c,131 :: 		duty = 128 - PID;
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       134
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _duty+0 
	MOVF        R1, 0 
	MOVWF       _duty+1 
;PIDSimples2.c,132 :: 		if(duty == 256) duty = 255;
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__controle_PID7
	MOVLW       0
	XORWF       R0, 0 
L__controle_PID7:
	BTFSS       STATUS+0, 2 
	GOTO        L_controle_PID4
	MOVLW       255
	MOVWF       _duty+0 
	MOVLW       0
	MOVWF       _duty+1 
L_controle_PID4:
;PIDSimples2.c,146 :: 		} // end void controle_PID
	RETURN      0
; end of _controle_PID

_imprime_Display:

;PIDSimples2.c,149 :: 		void imprime_Display(){
;PIDSimples2.c,154 :: 		dig4 = medidaADC/1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _medidaADC+0, 0 
	MOVWF       R0 
	MOVF        _medidaADC+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig4_L0+0 
;PIDSimples2.c,155 :: 		dig3 = (medidaADC%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _medidaADC+0, 0 
	MOVWF       R0 
	MOVF        _medidaADC+1, 0 
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
	MOVWF       imprime_Display_dig3_L0+0 
;PIDSimples2.c,156 :: 		dig2 = (medidaADC%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _medidaADC+0, 0 
	MOVWF       R0 
	MOVF        _medidaADC+1, 0 
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
	MOVWF       imprime_Display_dig2_L0+0 
;PIDSimples2.c,157 :: 		dig1 = medidaADC%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _medidaADC+0, 0 
	MOVWF       R0 
	MOVF        _medidaADC+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Display_dig1_L0+0 
;PIDSimples2.c,159 :: 		lcd_chr(1, 7, dig4 + 48);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_dig4_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PIDSimples2.c,160 :: 		lcd_chr_cp(dig3 + 48);
	MOVLW       48
	ADDWF       imprime_Display_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDSimples2.c,161 :: 		lcd_chr_cp(dig2 + 48);
	MOVLW       48
	ADDWF       imprime_Display_dig2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDSimples2.c,162 :: 		lcd_chr_cp(dig1 + 48);
	MOVLW       48
	ADDWF       imprime_Display_dig1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDSimples2.c,164 :: 		cen = duty/100;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _duty+0, 0 
	MOVWF       R0 
	MOVF        _duty+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       imprime_Display_cen_L0+0 
;PIDSimples2.c,165 :: 		dez = (duty%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _duty+0, 0 
	MOVWF       R0 
	MOVF        _duty+1, 0 
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
	MOVWF       imprime_Display_dez_L0+0 
;PIDSimples2.c,166 :: 		uni = duty%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _duty+0, 0 
	MOVWF       R0 
	MOVF        _duty+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       imprime_Display_uni_L0+0 
;PIDSimples2.c,168 :: 		lcd_chr(2, 7, cen + 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PIDSimples2.c,169 :: 		lcd_chr_cp(dez + 48);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDSimples2.c,170 :: 		lcd_chr_cp(uni + 48);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDSimples2.c,172 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

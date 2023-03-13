
_interrupt:

;PIDTemperatura.c,61 :: 		void interrupt(){
;PIDTemperatura.c,63 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;PIDTemperatura.c,65 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;PIDTemperatura.c,66 :: 		TMR0H = 0x9E;
	MOVLW       158
	MOVWF       TMR0H+0 
;PIDTemperatura.c,67 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;PIDTemperatura.c,69 :: 		baseTempo += 1;
	INFSNZ      _baseTempo+0, 1 
	INCF        _baseTempo+1, 1 
;PIDTemperatura.c,71 :: 		} // end TMR0IF_bit
L_interrupt0:
;PIDTemperatura.c,73 :: 		} // end void interrupt
L__interrupt15:
	RETFIE      1
; end of _interrupt

_main:

;PIDTemperatura.c,75 :: 		void main() {
;PIDTemperatura.c,78 :: 		TRISA = 0xFF; // Cofigura todo porta como entrada
	MOVLW       255
	MOVWF       TRISA+0 
;PIDTemperatura.c,80 :: 		ADCON0 = 0x01; // Seleciona o canal AN0 como analógico e ativa o conversor AD
	MOVLW       1
	MOVWF       ADCON0+0 
;PIDTemperatura.c,81 :: 		ADCON1 = 0x0E; // Configura o intervalo de conversão entre Vss e Vdd e configura AN0 como entrada analógica
	MOVLW       14
	MOVWF       ADCON1+0 
;PIDTemperatura.c,83 :: 		INTCON = 0xA0; // Ativa a interrupção global e a interrupção por overflow do timer 0
	MOVLW       160
	MOVWF       INTCON+0 
;PIDTemperatura.c,84 :: 		T0CON = 0x81; // Habilita o timer0, configura com 16 bits, incremento por ciclo de maquina e prescale de 1:4
	MOVLW       129
	MOVWF       T0CON+0 
;PIDTemperatura.c,85 :: 		TMR0H = 0x9E; // Inicia em 40536 para uma contagem de 25000
	MOVLW       158
	MOVWF       TMR0H+0 
;PIDTemperatura.c,86 :: 		TMR0L = 0x58;
	MOVLW       88
	MOVWF       TMR0L+0 
;PIDTemperatura.c,89 :: 		PWM1_Init(1000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;PIDTemperatura.c,90 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;PIDTemperatura.c,91 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PIDTemperatura.c,94 :: 		lcd_Init();
	CALL        _Lcd_Init+0, 0
;PIDTemperatura.c,95 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PIDTemperatura.c,96 :: 		lcd_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PIDTemperatura.c,97 :: 		lcd_out(1, 2, "Temp: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_PIDTemperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_PIDTemperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PIDTemperatura.c,98 :: 		lcd_out(2, 2, "PWM: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_PIDTemperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_PIDTemperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PIDTemperatura.c,101 :: 		while(1){
L_main1:
;PIDTemperatura.c,103 :: 		celsius();
	CALL        _celsius+0, 0
;PIDTemperatura.c,105 :: 		PWM1_Set_Duty(duty);
	MOVF        _duty+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PIDTemperatura.c,107 :: 		if(baseTempo == 4){
	MOVLW       0
	XORWF       _baseTempo+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVLW       4
	XORWF       _baseTempo+0, 0 
L__main16:
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;PIDTemperatura.c,109 :: 		baseTempo = 0x00;
	CLRF        _baseTempo+0 
	CLRF        _baseTempo+1 
;PIDTemperatura.c,111 :: 		controle_PID();
	CALL        _controle_PID+0, 0
;PIDTemperatura.c,113 :: 		imprime_Display();
	CALL        _imprime_Display+0, 0
;PIDTemperatura.c,115 :: 		} // end if baseTempo == 4
L_main3:
;PIDTemperatura.c,117 :: 		} // end Loop infinito
	GOTO        L_main1
;PIDTemperatura.c,119 :: 		} // end void main
	GOTO        $+0
; end of _main

_controle_PID:

;PIDTemperatura.c,121 :: 		void controle_PID(){
;PIDTemperatura.c,123 :: 		medidaADC = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       R0 
	MOVF        _temperatura+1, 0 
	MOVWF       R1 
	MOVF        _temperatura+2, 0 
	MOVWF       R2 
	MOVF        _temperatura+3, 0 
	MOVWF       R3 
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _medidaADC+0 
	MOVF        R1, 0 
	MOVWF       _medidaADC+1 
;PIDTemperatura.c,125 :: 		erro = valorIdeal - medidaADC;
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
;PIDTemperatura.c,127 :: 		proporcional = erro * kp;
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
;PIDTemperatura.c,129 :: 		integral += (erro * ki * 100E-3);
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
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       123
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
;PIDTemperatura.c,131 :: 		derivativo = (((ultimaMedida - medidaADC) * kd) / 100E-3);
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
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       123
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
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
;PIDTemperatura.c,133 :: 		ultimaMedida = medidaADC;
	MOVF        _medidaADC+0, 0 
	MOVWF       _ultimaMedida+0 
	MOVF        _medidaADC+1, 0 
	MOVWF       _ultimaMedida+1 
;PIDTemperatura.c,135 :: 		PID = proporcional + integral + derivativo;
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
;PIDTemperatura.c,137 :: 		PID = PID/4; // Normalização, pois ADC tem 10 bits e o PWM tem 9 bits
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
;PIDTemperatura.c,138 :: 		duty = PID + 128;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _duty+0 
	MOVF        R1, 0 
	MOVWF       _duty+1 
;PIDTemperatura.c,139 :: 		if(duty == 256) duty = 255;
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__controle_PID17
	MOVLW       0
	XORWF       R0, 0 
L__controle_PID17:
	BTFSS       STATUS+0, 2 
	GOTO        L_controle_PID4
	MOVLW       255
	MOVWF       _duty+0 
	MOVLW       0
	MOVWF       _duty+1 
L_controle_PID4:
;PIDTemperatura.c,149 :: 		} // end void controle_PID
	RETURN      0
; end of _controle_PID

_imprime_Display:

;PIDTemperatura.c,152 :: 		void imprime_Display(){
;PIDTemperatura.c,156 :: 		cen = duty/100;
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
;PIDTemperatura.c,157 :: 		dez = (duty%100)/10;
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
;PIDTemperatura.c,158 :: 		uni = duty%10;
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
;PIDTemperatura.c,160 :: 		lcd_chr(2, 7, cen + 48);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       48
	ADDWF       imprime_Display_cen_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PIDTemperatura.c,161 :: 		lcd_chr_cp(dez + 48);
	MOVLW       48
	ADDWF       imprime_Display_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDTemperatura.c,162 :: 		lcd_chr_cp(uni + 48);
	MOVLW       48
	ADDWF       imprime_Display_uni_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDTemperatura.c,164 :: 		} // end void imprime_Display
	RETURN      0
; end of _imprime_Display

_celsius:

;PIDTemperatura.c,166 :: 		void celsius(){
;PIDTemperatura.c,168 :: 		adc = media_Temperatura();
	CALL        _media_Temperatura+0, 0
	MOVF        R0, 0 
	MOVWF       _adc+0 
	MOVF        R1, 0 
	MOVWF       _adc+1 
;PIDTemperatura.c,170 :: 		temperatura = ((adc * 5.0) / 1024.0);
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _temperatura+0 
	MOVF        R1, 0 
	MOVWF       _temperatura+1 
	MOVF        R2, 0 
	MOVWF       _temperatura+2 
	MOVF        R3, 0 
	MOVWF       _temperatura+3 
;PIDTemperatura.c,172 :: 		temperatura = temperatura * 100.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__celsius+0 
	MOVF        R1, 0 
	MOVWF       FLOC__celsius+1 
	MOVF        R2, 0 
	MOVWF       FLOC__celsius+2 
	MOVF        R3, 0 
	MOVWF       FLOC__celsius+3 
	MOVF        FLOC__celsius+0, 0 
	MOVWF       _temperatura+0 
	MOVF        FLOC__celsius+1, 0 
	MOVWF       _temperatura+1 
	MOVF        FLOC__celsius+2, 0 
	MOVWF       _temperatura+2 
	MOVF        FLOC__celsius+3, 0 
	MOVWF       _temperatura+3 
;PIDTemperatura.c,174 :: 		if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5)){
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        FLOC__celsius+0, 0 
	MOVWF       R4 
	MOVF        FLOC__celsius+1, 0 
	MOVWF       R5 
	MOVF        FLOC__celsius+2, 0 
	MOVWF       R6 
	MOVF        FLOC__celsius+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__celsius14
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	MOVF        _ultimaTemperatura+0, 0 
	MOVWF       R0 
	MOVF        _ultimaTemperatura+1, 0 
	MOVWF       R1 
	MOVF        _ultimaTemperatura+2, 0 
	MOVWF       R2 
	MOVF        _ultimaTemperatura+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        _temperatura+0, 0 
	MOVWF       R0 
	MOVF        _temperatura+1, 0 
	MOVWF       R1 
	MOVF        _temperatura+2, 0 
	MOVWF       R2 
	MOVF        _temperatura+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__celsius14
	GOTO        L_celsius7
L__celsius14:
;PIDTemperatura.c,176 :: 		ultimaTemperatura = temperatura;
	MOVF        _temperatura+0, 0 
	MOVWF       _ultimaTemperatura+0 
	MOVF        _temperatura+1, 0 
	MOVWF       _ultimaTemperatura+1 
	MOVF        _temperatura+2, 0 
	MOVWF       _ultimaTemperatura+2 
	MOVF        _temperatura+3, 0 
	MOVWF       _ultimaTemperatura+3 
;PIDTemperatura.c,178 :: 		FloatToStr(temperatura, txt);
	MOVF        _temperatura+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _temperatura+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _temperatura+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _temperatura+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;PIDTemperatura.c,180 :: 		lcd_chr(1, 8, txt[0]);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PIDTemperatura.c,181 :: 		lcd_chr_cp(txt[1]);
	MOVF        _txt+1, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDTemperatura.c,182 :: 		lcd_chr_cp(txt[2]);
	MOVF        _txt+2, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDTemperatura.c,183 :: 		lcd_chr_cp(txt[3]);
	MOVF        _txt+3, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDTemperatura.c,184 :: 		lcd_chr_cp(txt[4]);
	MOVF        _txt+4, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDTemperatura.c,185 :: 		lcd_chr_cp(txt[5]);
	MOVF        _txt+5, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;PIDTemperatura.c,186 :: 		CustomChar(1, 14);
	MOVLW       1
	MOVWF       FARG_CustomChar_pos_row+0 
	MOVLW       14
	MOVWF       FARG_CustomChar_pos_char+0 
	CALL        _CustomChar+0, 0
;PIDTemperatura.c,187 :: 		lcd_chr(1, 15, 'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PIDTemperatura.c,190 :: 		} // end if temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5
L_celsius7:
;PIDTemperatura.c,192 :: 		} // void celsius
	RETURN      0
; end of _celsius

_media_Temperatura:

;PIDTemperatura.c,195 :: 		int media_Temperatura(){
;PIDTemperatura.c,198 :: 		int media = 0x00;
	CLRF        media_Temperatura_media_L0+0 
	CLRF        media_Temperatura_media_L0+1 
;PIDTemperatura.c,200 :: 		for(i = 0x00; i < 0x64; i++)
	CLRF        media_Temperatura_i_L0+0 
L_media_Temperatura8:
	MOVLW       100
	SUBWF       media_Temperatura_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_media_Temperatura9
;PIDTemperatura.c,201 :: 		media += adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	ADDWF       media_Temperatura_media_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      media_Temperatura_media_L0+1, 1 
;PIDTemperatura.c,200 :: 		for(i = 0x00; i < 0x64; i++)
	INCF        media_Temperatura_i_L0+0, 1 
;PIDTemperatura.c,201 :: 		media += adc_read(0);
	GOTO        L_media_Temperatura8
L_media_Temperatura9:
;PIDTemperatura.c,203 :: 		return (media/0x64);
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        media_Temperatura_media_L0+0, 0 
	MOVWF       R0 
	MOVF        media_Temperatura_media_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
;PIDTemperatura.c,205 :: 		} // end int media_Temperatura
	RETURN      0
; end of _media_Temperatura

_CustomChar:

;PIDTemperatura.c,209 :: 		void CustomChar(char pos_row, char pos_char) {
;PIDTemperatura.c,212 :: 		Lcd_Cmd(72);
	MOVLW       72
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PIDTemperatura.c,213 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF        CustomChar_i_L0+0 
L_CustomChar11:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar12
	MOVLW       _character+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar11
L_CustomChar12:
;PIDTemperatura.c,214 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PIDTemperatura.c,215 :: 		Lcd_Chr(pos_row, pos_char, 1);
	MOVF        FARG_CustomChar_pos_row+0, 0 
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        FARG_CustomChar_pos_char+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;PIDTemperatura.c,217 :: 		}
	RETURN      0
; end of _CustomChar

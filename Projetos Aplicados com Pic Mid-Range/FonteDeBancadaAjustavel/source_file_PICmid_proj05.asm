
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;source_file_PICmid_proj05.c,84 :: 		void interrupt()
;source_file_PICmid_proj05.c,86 :: 		if(TMR0IF_bit)                              //houve interrupção do Timer0?
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;source_file_PICmid_proj05.c,88 :: 		TMR0IF_bit = 0x00;                       //limpa flag
	BCF        TMR0IF_bit+0, 2
;source_file_PICmid_proj05.c,89 :: 		TMR0       = 56;                         //reinicializa TMR0
	MOVLW      56
	MOVWF      TMR0+0
;source_file_PICmid_proj05.c,90 :: 		countT0   += 0x01;                       //incrementa countT0
	INCF       _countT0+0, 1
	BTFSC      STATUS+0, 2
	INCF       _countT0+1, 1
;source_file_PICmid_proj05.c,94 :: 		if(countT0 == 1000)                      //countT0 igual a 1000?
	MOVF       _countT0+1, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt27
	MOVLW      232
	XORWF      _countT0+0, 0
L__interrupt27:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;source_file_PICmid_proj05.c,96 :: 		countT0 = 0x00;                       //reinicia countT0
	CLRF       _countT0+0
	CLRF       _countT0+1
;source_file_PICmid_proj05.c,97 :: 		update_lcd += 1;                      //incrementa update_lcd
	INCF       _update_lcd+0, 1
	BTFSC      STATUS+0, 2
	INCF       _update_lcd+1, 1
;source_file_PICmid_proj05.c,100 :: 		if(bt_up_f) upcnt += 1;               //incrementa upcnt, se flag bt_up_f setada
	BTFSS      _flagsA+0, 0
	GOTO       L_interrupt2
	INCF       _upcnt+0, 1
L_interrupt2:
;source_file_PICmid_proj05.c,102 :: 		if(upcnt > 15)                        //upcnt maior ou igual a 15?
	MOVF       _upcnt+0, 0
	SUBLW      15
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
;source_file_PICmid_proj05.c,104 :: 		upcnt = 15;                         //mantém em 15
	MOVLW      15
	MOVWF      _upcnt+0
;source_file_PICmid_proj05.c,105 :: 		duty1 += 10;                        //incrementa duty1 de 10 em 10 (ajuste grosso)
	MOVLW      10
	ADDWF      _duty1+0, 1
	BTFSC      STATUS+0, 0
	INCF       _duty1+1, 1
;source_file_PICmid_proj05.c,107 :: 		} //end if upcnt
L_interrupt3:
;source_file_PICmid_proj05.c,110 :: 		if(bt_down_f) dwcnt += 1;             //incrementa dwcnt, se flag bt_down_f setada
	BTFSS      _flagsA+0, 1
	GOTO       L_interrupt4
	INCF       _dwcnt+0, 1
L_interrupt4:
;source_file_PICmid_proj05.c,112 :: 		if(dwcnt > 15)                        //dwcnt maior ou igual a 15?
	MOVF       _dwcnt+0, 0
	SUBLW      15
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt5
;source_file_PICmid_proj05.c,114 :: 		dwcnt = 15;                         //mantém em 15
	MOVLW      15
	MOVWF      _dwcnt+0
;source_file_PICmid_proj05.c,115 :: 		duty1 -= 10;                        //decrementa duty1 de 10 em 10 (ajuste grosso)
	MOVLW      10
	SUBWF      _duty1+0, 1
	BTFSS      STATUS+0, 0
	DECF       _duty1+1, 1
;source_file_PICmid_proj05.c,117 :: 		} //end if dwcnt
L_interrupt5:
;source_file_PICmid_proj05.c,120 :: 		if(update_lcd == 5)
	MOVLW      0
	XORWF      _update_lcd+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt28
	MOVLW      5
	XORWF      _update_lcd+0, 0
L__interrupt28:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt6
;source_file_PICmid_proj05.c,122 :: 		update_lcd = 0x00;
	CLRF       _update_lcd+0
	CLRF       _update_lcd+1
;source_file_PICmid_proj05.c,123 :: 		new_volt   = 0x01;
	BSF        _flagsA+0, 2
;source_file_PICmid_proj05.c,126 :: 		}
L_interrupt6:
;source_file_PICmid_proj05.c,130 :: 		} //end if countT0
L_interrupt1:
;source_file_PICmid_proj05.c,133 :: 		} //end TMR0IF_bit
L_interrupt0:
;source_file_PICmid_proj05.c,136 :: 		} //end interrupt
L__interrupt26:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;source_file_PICmid_proj05.c,141 :: 		void main()
;source_file_PICmid_proj05.c,143 :: 		TRISB = 0xF3;                               //Configura RB0 e RB1 como entrada
	MOVLW      243
	MOVWF      TRISB+0
;source_file_PICmid_proj05.c,144 :: 		TRISC = 0x09;                               //Configura saída para os PWMs
	MOVLW      9
	MOVWF      TRISC+0
;source_file_PICmid_proj05.c,145 :: 		PORTB = 0xF3;                               //Inicializa PORTB
	MOVLW      243
	MOVWF      PORTB+0
;source_file_PICmid_proj05.c,146 :: 		PORTC = 0x09;                               //Inicializa PORTC
	MOVLW      9
	MOVWF      PORTC+0
;source_file_PICmid_proj05.c,148 :: 		ADCON0 = 0x01;
	MOVLW      1
	MOVWF      ADCON0+0
;source_file_PICmid_proj05.c,149 :: 		ADCON1 = 0x4E;
	MOVLW      78
	MOVWF      ADCON1+0
;source_file_PICmid_proj05.c,151 :: 		INTCON     = 0xA0;                          //habilita interrupção global e do Timer0
	MOVLW      160
	MOVWF      INTCON+0
;source_file_PICmid_proj05.c,152 :: 		OPTION_REG = 0x80;                          //TMR0 incrementa com ciclo de máquina, PS 1:2
	MOVLW      128
	MOVWF      OPTION_REG+0
;source_file_PICmid_proj05.c,153 :: 		TMR0       = 56;                            //inicializa TMR0
	MOVLW      56
	MOVWF      TMR0+0
;source_file_PICmid_proj05.c,155 :: 		PWM1_Init(1000);                            //Inicializa PWM1 com 1kHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;source_file_PICmid_proj05.c,156 :: 		PWM2_Init(1000);                            //Inicializa PWM2 com 1kHz
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;source_file_PICmid_proj05.c,157 :: 		PWM1_Start();                               //Start PWM1
	CALL       _PWM1_Start+0
;source_file_PICmid_proj05.c,158 :: 		PWM2_Start();                               //Start PWM2
	CALL       _PWM2_Start+0
;source_file_PICmid_proj05.c,159 :: 		PWM1_Set_Duty(duty1);                       //configura duty inicial do PWM1
	MOVF       _duty1+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;source_file_PICmid_proj05.c,160 :: 		PWM2_Set_Duty(128);                         //configura duty PWM2 em 50%
	MOVLW      128
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;source_file_PICmid_proj05.c,162 :: 		Lcd_Init();                                 //inicializa LCD
	CALL       _Lcd_Init+0
;source_file_PICmid_proj05.c,163 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                   //desliga o cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;source_file_PICmid_proj05.c,164 :: 		Lcd_Cmd(_LCD_CLEAR);                        //limpa o LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;source_file_PICmid_proj05.c,165 :: 		Lcd_Out(1,2,"FONTE W.R.KITS");              //envia mensagem
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_source_file_PICmid_proj05+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;source_file_PICmid_proj05.c,166 :: 		new_volt = 0x01;                            //seta new_volt
	BSF        _flagsA+0, 2
;source_file_PICmid_proj05.c,169 :: 		while(1)                                    //loop infinito
L_main7:
;source_file_PICmid_proj05.c,171 :: 		v_adjust();                              //chama a função v_adjust
	CALL       _v_adjust+0
;source_file_PICmid_proj05.c,173 :: 		voltmeter();                             //chama a função do voltímetro
	CALL       _voltmeter+0
;source_file_PICmid_proj05.c,176 :: 		} //end while
	GOTO       L_main7
;source_file_PICmid_proj05.c,178 :: 		} //end main
	GOTO       $+0
; end of _main

_v_adjust:

;source_file_PICmid_proj05.c,187 :: 		void v_adjust()                                //Função para ajuste de tensão
;source_file_PICmid_proj05.c,189 :: 		if(!bt_up)   bt_up_f   = 0x01;               //seta bt_up_f se bt_up pressionado
	BTFSC      RB0_bit+0, 0
	GOTO       L_v_adjust9
	BSF        _flagsA+0, 0
L_v_adjust9:
;source_file_PICmid_proj05.c,190 :: 		if(!bt_down) bt_down_f = 0x01;               //seta bt_down_f se bt_down pressionado
	BTFSC      RB1_bit+0, 1
	GOTO       L_v_adjust10
	BSF        _flagsA+0, 1
L_v_adjust10:
;source_file_PICmid_proj05.c,192 :: 		if(bt_up && bt_up_f)                         //bt_up solto e flag setada?
	BTFSS      RB0_bit+0, 0
	GOTO       L_v_adjust13
	BTFSS      _flagsA+0, 0
	GOTO       L_v_adjust13
L__v_adjust24:
;source_file_PICmid_proj05.c,194 :: 		bt_up_f = 0x00;                           //limpa flag
	BCF        _flagsA+0, 0
;source_file_PICmid_proj05.c,195 :: 		upcnt   = 0x00;                           //limpa flag de incremento rápido
	CLRF       _upcnt+0
;source_file_PICmid_proj05.c,196 :: 		duty1  += 0x01;                           //incrementa duty1
	INCF       _duty1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _duty1+1, 1
;source_file_PICmid_proj05.c,198 :: 		} //end if bt_up
L_v_adjust13:
;source_file_PICmid_proj05.c,200 :: 		if(bt_down && bt_down_f)                     //bt_down solto e flag setada?
	BTFSS      RB1_bit+0, 1
	GOTO       L_v_adjust16
	BTFSS      _flagsA+0, 1
	GOTO       L_v_adjust16
L__v_adjust23:
;source_file_PICmid_proj05.c,202 :: 		bt_down_f = 0x00;                         //limpa flag
	BCF        _flagsA+0, 1
;source_file_PICmid_proj05.c,203 :: 		dwcnt     = 0x00;                         //limpa flag de decremento rápido
	CLRF       _dwcnt+0
;source_file_PICmid_proj05.c,204 :: 		duty1    -= 0x01;                         //decrementa duty1
	MOVLW      1
	SUBWF      _duty1+0, 1
	BTFSS      STATUS+0, 0
	DECF       _duty1+1, 1
;source_file_PICmid_proj05.c,206 :: 		} //end if bt_up
L_v_adjust16:
;source_file_PICmid_proj05.c,208 :: 		PWM1_Set_Duty(duty1);                        //atualiza duty1
	MOVF       _duty1+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;source_file_PICmid_proj05.c,211 :: 		if(duty1 < 1) duty1 = 0;                     //fixa duty1 em zero, se for menor que 1 (limite inferior)
	MOVLW      128
	XORWF      _duty1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__v_adjust29
	MOVLW      1
	SUBWF      _duty1+0, 0
L__v_adjust29:
	BTFSC      STATUS+0, 0
	GOTO       L_v_adjust17
	CLRF       _duty1+0
	CLRF       _duty1+1
	GOTO       L_v_adjust18
L_v_adjust17:
;source_file_PICmid_proj05.c,213 :: 		else if(duty1 > 230) duty1 = 230;            //fixa duty1 em 230, se maior que 230 (limite superior)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _duty1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__v_adjust30
	MOVF       _duty1+0, 0
	SUBLW      230
L__v_adjust30:
	BTFSC      STATUS+0, 0
	GOTO       L_v_adjust19
	MOVLW      230
	MOVWF      _duty1+0
	CLRF       _duty1+1
L_v_adjust19:
L_v_adjust18:
;source_file_PICmid_proj05.c,218 :: 		} //end v_adjust
	RETURN
; end of _v_adjust

_voltmeter:

;source_file_PICmid_proj05.c,223 :: 		void voltmeter()
;source_file_PICmid_proj05.c,227 :: 		if(new_volt || upcnt >=15 || dwcnt >= 15)
	BTFSC      _flagsA+0, 2
	GOTO       L__voltmeter25
	MOVLW      15
	SUBWF      _upcnt+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__voltmeter25
	MOVLW      15
	SUBWF      _dwcnt+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__voltmeter25
	GOTO       L_voltmeter22
L__voltmeter25:
;source_file_PICmid_proj05.c,229 :: 		adc_value = ADC_Read(0);                    //faz leitura do canal AN0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_value+0
	MOVF       R0+1, 0
	MOVWF      _adc_value+1
;source_file_PICmid_proj05.c,230 :: 		new_volt = 0x00;
	BCF        _flagsA+0, 2
;source_file_PICmid_proj05.c,231 :: 		}
L_voltmeter22:
;source_file_PICmid_proj05.c,233 :: 		volt = ((adc_value * 20.0) / 1023.0)*100.0; //cálculo da tensão em volts
	MOVF       _adc_value+0, 0
	MOVWF      R0+0
	MOVF       _adc_value+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _volt+0
	MOVF       R0+1, 0
	MOVWF      _volt+1
	MOVF       R0+2, 0
	MOVWF      _volt+2
	MOVF       R0+3, 0
	MOVWF      _volt+3
;source_file_PICmid_proj05.c,236 :: 		volt_i = (int)volt;                         //conversão para inteiro
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _volt_i+0
	MOVF       R0+1, 0
	MOVWF      _volt_i+1
;source_file_PICmid_proj05.c,238 :: 		mil_v = volt_i/1000;                        //calcula dezena da tensão
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      voltmeter_mil_v_L0+0
;source_file_PICmid_proj05.c,239 :: 		cen_v = (volt_i%1000)/100;                  //calcula unidade da tensão
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       _volt_i+0, 0
	MOVWF      R0+0
	MOVF       _volt_i+1, 0
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
	MOVWF      voltmeter_cen_v_L0+0
;source_file_PICmid_proj05.c,240 :: 		dez_v = (volt_i%100)/10;                    //calcula dezena da casa decimal
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _volt_i+0, 0
	MOVWF      R0+0
	MOVF       _volt_i+1, 0
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
	MOVWF      voltmeter_dez_v_L0+0
;source_file_PICmid_proj05.c,241 :: 		uni_v = volt_i%10;                          //calcula unidade da casa decimal
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _volt_i+0, 0
	MOVWF      R0+0
	MOVF       _volt_i+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      voltmeter_uni_v_L0+0
;source_file_PICmid_proj05.c,243 :: 		Lcd_Chr (2,5,mil_v+0x30);                   //envia pro LCD
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      voltmeter_mil_v_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;source_file_PICmid_proj05.c,244 :: 		Lcd_Chr_Cp  (cen_v+0x30);                   //
	MOVLW      48
	ADDWF      voltmeter_cen_v_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;source_file_PICmid_proj05.c,245 :: 		Lcd_Chr_Cp  ('.');                          //
	MOVLW      46
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;source_file_PICmid_proj05.c,246 :: 		Lcd_Chr_Cp  (dez_v+0x30);                   //
	MOVLW      48
	ADDWF      voltmeter_dez_v_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;source_file_PICmid_proj05.c,247 :: 		Lcd_Chr_Cp  (uni_v+0x30);                   //
	MOVLW      48
	ADDWF      voltmeter_uni_v_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;source_file_PICmid_proj05.c,248 :: 		Lcd_Chr_Cp  ('V');                          //
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;source_file_PICmid_proj05.c,251 :: 		} //end voltmeter
	RETURN
; end of _voltmeter

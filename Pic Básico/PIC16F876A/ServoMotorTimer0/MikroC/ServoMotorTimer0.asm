
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;ServoMotorTimer0.c,7 :: 		void interrupt(){
;ServoMotorTimer0.c,9 :: 		if(TMR0IF_bit){
	BTFSS      TMR0IF_bit+0, 2
	GOTO       L_interrupt0
;ServoMotorTimer0.c,11 :: 		TMR0IF_bit = 0x00;
	BCF        TMR0IF_bit+0, 2
;ServoMotorTimer0.c,13 :: 		if(servo1){
	BTFSS      RC4_bit+0, 4
	GOTO       L_interrupt1
;ServoMotorTimer0.c,14 :: 		TMR0 = duty;
	MOVF       _duty+0, 0
	MOVWF      TMR0+0
;ServoMotorTimer0.c,15 :: 		servo1 = 0x00;
	BCF        RC4_bit+0, 4
;ServoMotorTimer0.c,16 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;ServoMotorTimer0.c,18 :: 		TMR0 = 255 - duty;
	MOVF       _duty+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;ServoMotorTimer0.c,19 :: 		servo1 = 0x01;
	BSF        RC4_bit+0, 4
;ServoMotorTimer0.c,20 :: 		}
L_interrupt2:
;ServoMotorTimer0.c,21 :: 		}
L_interrupt0:
;ServoMotorTimer0.c,22 :: 		}
L__interrupt5:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;ServoMotorTimer0.c,30 :: 		void main() {
;ServoMotorTimer0.c,32 :: 		CMCON = 0x07; // Desabilita os comparadores interno
	MOVLW      7
	MOVWF      CMCON+0
;ServoMotorTimer0.c,33 :: 		OPTION_REG = 0x87; //Desabilita os pull-ups internos e configura o prescaler em 1:256 no timer 1
	MOVLW      135
	MOVWF      OPTION_REG+0
;ServoMotorTimer0.c,34 :: 		GIE_bit = 0x01; // Habilita a interrupção global
	BSF        GIE_bit+0, 7
;ServoMotorTimer0.c,35 :: 		PEIE_bit = 0x01; // Habilita a interrupção por periféricos
	BSF        PEIE_bit+0, 6
;ServoMotorTimer0.c,36 :: 		TMR0IE_bit = 0x01; // Habilita o timer1
	BSF        TMR0IE_bit+0, 5
;ServoMotorTimer0.c,37 :: 		ADON_bit = 0x01; // Habilita o conversor AD
	BSF        ADON_bit+0, 0
;ServoMotorTimer0.c,38 :: 		ADCON1 = 0x0E; // Configura apenas AN0/RA0 como entrada analógica
	MOVLW      14
	MOVWF      ADCON1+0
;ServoMotorTimer0.c,39 :: 		TRISA = 0xFF; // Todo porta como entrada
	MOVLW      255
	MOVWF      TRISA+0
;ServoMotorTimer0.c,40 :: 		TRISC = 0xEF; // Apenas RC4 como saída digital
	MOVLW      239
	MOVWF      TRISC+0
;ServoMotorTimer0.c,41 :: 		PORTC = 0xEF; // Inicia RC4 em Low
	MOVLW      239
	MOVWF      PORTC+0
;ServoMotorTimer0.c,43 :: 		while(1){
L_main3:
;ServoMotorTimer0.c,85 :: 		adc = (adc_read(0))/85;
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVLW      85
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _adc+0
	MOVF       R0+1, 0
	MOVWF      _adc+1
;ServoMotorTimer0.c,87 :: 		duty = adc + 12;
	MOVLW      12
	ADDWF      R0+0, 0
	MOVWF      _duty+0
;ServoMotorTimer0.c,88 :: 		}
	GOTO       L_main3
;ServoMotorTimer0.c,89 :: 		}
	GOTO       $+0
; end of _main

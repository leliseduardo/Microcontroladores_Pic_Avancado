
_interrupt:

;BaseTempo1s.c,35 :: 		void interrupt(){
;BaseTempo1s.c,37 :: 		if(TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, 0 
	GOTO        L_interrupt0
;BaseTempo1s.c,39 :: 		asm BSF TMR1H,7; // Comando em assembly denominado Bit Set File, que seta High no bit de um registrador, no caso o bit 7 do
	BSF         TMR1H+0, 7, 1
;BaseTempo1s.c,43 :: 		TMR1IF_bit = 0x00;
	BCF         TMR1IF_bit+0, 0 
;BaseTempo1s.c,45 :: 		outT1 = ~outT1;
	BTG         LATB7_bit+0, 7 
;BaseTempo1s.c,46 :: 		}
L_interrupt0:
;BaseTempo1s.c,47 :: 		}
L__interrupt3:
	RETFIE      1
; end of _interrupt

_main:

;BaseTempo1s.c,49 :: 		void main() {
;BaseTempo1s.c,52 :: 		INTCON = 0xC0; // Habilita a interrupção global e por periféricos
	MOVLW       192
	MOVWF       INTCON+0 
;BaseTempo1s.c,55 :: 		TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
	BSF         TMR1IE_bit+0, 0 
;BaseTempo1s.c,58 :: 		T1CON = 0x0B; // Configura o timer1 com 8bits, clock de outra fonte, prescaler 1:1, habilita o oscilador do timer1, síncrono,
	MOVLW       11
	MOVWF       T1CON+0 
;BaseTempo1s.c,62 :: 		TMR1L = 0x00; // Inicia a contagem em 32768, para uma contagem de 32768
	CLRF        TMR1L+0 
;BaseTempo1s.c,63 :: 		TMR1H = 0x80;
	MOVLW       128
	MOVWF       TMR1H+0 
;BaseTempo1s.c,65 :: 		ADCON1 = 0x07; // Configura todos os pinos que poderiam ser analógicos como digitais
	MOVLW       7
	MOVWF       ADCON1+0 
;BaseTempo1s.c,66 :: 		TRISB = 0x7F; // Configura apenas RB7 como saída digital, o resto como entrada, pois não serão utilizados
	MOVLW       127
	MOVWF       TRISB+0 
;BaseTempo1s.c,67 :: 		outT1 = 0x00; // Inicia LATB7 em Low
	BCF         LATB7_bit+0, 7 
;BaseTempo1s.c,69 :: 		while(1){
L_main1:
;BaseTempo1s.c,72 :: 		}
	GOTO        L_main1
;BaseTempo1s.c,73 :: 		}
	GOTO        $+0
; end of _main

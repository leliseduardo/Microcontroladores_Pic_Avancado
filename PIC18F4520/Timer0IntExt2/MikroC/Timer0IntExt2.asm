
_interrupt:

;Timer0IntExt2.c,47 :: 		void interrupt(){
;Timer0IntExt2.c,49 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;Timer0IntExt2.c,51 :: 		TMR0IF_bit = 0x00;
	BCF         TMR0IF_bit+0, 2 
;Timer0IntExt2.c,52 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer0IntExt2.c,53 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer0IntExt2.c,55 :: 		outT0 = ~outT0;
	BTG         LATB7_bit+0, 7 
;Timer0IntExt2.c,56 :: 		}
L_interrupt0:
;Timer0IntExt2.c,58 :: 		if(INT1IF_bit){
	BTFSS       INT1IF_bit+0, 0 
	GOTO        L_interrupt1
;Timer0IntExt2.c,60 :: 		INT1IF_bit = 0x00;
	BCF         INT1IF_bit+0, 0 
;Timer0IntExt2.c,62 :: 		outInt1 = ~outInt1;
	BTG         LATB6_bit+0, 6 
;Timer0IntExt2.c,63 :: 		}
L_interrupt1:
;Timer0IntExt2.c,64 :: 		}
L__interrupt6:
	RETFIE      1
; end of _interrupt

_main:

;Timer0IntExt2.c,67 :: 		void main() {
;Timer0IntExt2.c,72 :: 		IPEN_bit = 0x00; // Desabilita as interrupções por nível de prioridade (alta e baixa)
	BCF         IPEN_bit+0, 7 
;Timer0IntExt2.c,75 :: 		INTCON = 0xE0; // Habilita a interrupção global, habilita a interrupção por nível dos periféricos e habilita a interrupção do timer0
	MOVLW       224
	MOVWF       INTCON+0 
;Timer0IntExt2.c,78 :: 		INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
	BSF         INTEDG1_bit+0, 5 
;Timer0IntExt2.c,79 :: 		TMR0IP_bit = 0x00; // Configura a interrupção do timer0 com baixa prioridade
	BCF         TMR0IP_bit+0, 2 
;Timer0IntExt2.c,82 :: 		INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
	BSF         INT1IE_bit+0, 3 
;Timer0IntExt2.c,83 :: 		INT1IP_bit = 0x01; // Configura a interrupção externa INT1 com alta prioridade
	BSF         INT1IP_bit+0, 6 
;Timer0IntExt2.c,86 :: 		TMR0ON_bit = 0x01; // Habilita o timer0
	BSF         TMR0ON_bit+0, 7 
;Timer0IntExt2.c,87 :: 		T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
	BCF         T08BIT_bit+0, 6 
;Timer0IntExt2.c,88 :: 		T0CS_bit = 0x00; // Configura o incremento do timer0 a partir do ciclo de máquina
	BCF         T0CS_bit+0, 5 
;Timer0IntExt2.c,89 :: 		PSA_bit = 0x01; // Não associa o prescaler ao timer0, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
	BSF         PSA_bit+0, 3 
;Timer0IntExt2.c,92 :: 		TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para um contagem de 50000
	MOVLW       176
	MOVWF       TMR0L+0 
;Timer0IntExt2.c,93 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;Timer0IntExt2.c,95 :: 		ADCON1 = 0x0F; // Configura todos os botões que poderiam ser analógicos como digitais
	MOVLW       15
	MOVWF       ADCON1+0 
;Timer0IntExt2.c,96 :: 		TRISB = 0x3F; // Ou 0b00111111, que configura apenas RB6 e RB7 como saídas digitais e o resto como entrada
	MOVLW       63
	MOVWF       TRISB+0 
;Timer0IntExt2.c,97 :: 		outInt1 = 0x00; // Inicia LATB6 em Low
	BCF         LATB6_bit+0, 6 
;Timer0IntExt2.c,98 :: 		outT0 = 0x00; // Inicia LATB7 em Low
	BCF         LATB7_bit+0, 7 
;Timer0IntExt2.c,101 :: 		while(1){
L_main2:
;Timer0IntExt2.c,103 :: 		if(chave) IPEN_bit = 0x01; // Se chave em High, habilita a interrupção por nível de prioridade (alta e baixa)
	BTFSS       RB5_bit+0, 5 
	GOTO        L_main4
	BSF         IPEN_bit+0, 7 
	GOTO        L_main5
L_main4:
;Timer0IntExt2.c,105 :: 		else IPEN_bit = 0x00; // Se chave em Low, desabilita a interrupção por nível de prioridade (alta e baixa)
	BCF         IPEN_bit+0, 7 
L_main5:
;Timer0IntExt2.c,106 :: 		} // end while
	GOTO        L_main2
;Timer0IntExt2.c,107 :: 		} // end void main
	GOTO        $+0
; end of _main

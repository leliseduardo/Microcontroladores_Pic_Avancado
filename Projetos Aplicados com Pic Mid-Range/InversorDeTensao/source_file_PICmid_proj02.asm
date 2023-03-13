; =======================================================================================
;
;   Projetos Aplicados com PIC Mid-Range
;
;   Oscilador para Inversor de Tensão (Projeto 1)
;
;   Gera dois sinais de 60Hz em contra-fase
;
;   Sinais gerados por interrupção do Timer0
;
;   Compilador: MPLAB IDE v8.92
;
;   MCU: PIC12F675   Clock: Externo 16MHz   CM: 250ns
;
;   Autor: Eng. Wagner Rambo
;
;   Data: Abril de 2018
;
; =======================================================================================


; =======================================================================================
; --- Listagem e Inclusão de Arquivos ---
	list		p=12f675					;Microcontrolador utilizado no projeto
	#include	<p12f675.inc>				;Inclui arquivo com registradores do PIC12F675


; =======================================================================================
; --- FUSE Bits ---
; -> Oscilador Externo 16MHz;
; -> Sem WatchDog Timer;
; -> Power Up Timer Habilitado;
; -> Master Clear Desabilitado;
; -> Sem Brown Out;
; -> Sem proteções.

	__config	_HS_OSC & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF & _BOREN_OFF & _CP_OFF & _CPD_OFF


; =======================================================================================
; --- Paginação de Memória ---

	#define	bank0	bcf	STATUS,RP0			;cria mnemônico para seleção do banco 0 de memória
	#define	bank1	bsf	STATUS,RP0			;cria mnemônico para seleção do banco 1 de memória


; =======================================================================================
; --- Definicação de Saídas ---

	#define	osc_a		GPIO,GP0			;oscilador a
	#define	osc_b		GPIO,GP1			;oscilador b


; =======================================================================================
; --- Registradores de Uso Geral ---

	cblock	H'20'							;Início da memória disponível para o usuário
	
	W_TEMP									;Armazena valor temporário de W
	STATUS_TEMP								;Armazena valor temporário de STATUS
	AUX
	
	endc									;Final da memória disponível para o usuário


; =======================================================================================
; --- Vetor de RESET ---

	org			H'0000'						;Origem no endereço 00h de memória
	goto		inicio						;Desvia do vetor de interrupção
	

; =======================================================================================
; --- Vetor de Interrupção ---

	org			H'0004'						;Todas interrupções apontam para este endereço na memória de programa
	
; -- Salva Contexto --
	movwf		W_TEMP						;Salva conteúdo de Work no registrador W_TEMP
	swapf		STATUS,W					;Carrega conteúdo de STATUS no registrador Work com nibbles invertidos
	bank0									;Seleciona o banco 0 de memória
	movwf		STATUS_TEMP					;Salva conteúdo de STATUS no registrador STATUS_TEMP
	
; -- Teste das flags --
	btfsc		INTCON,T0IF					;Ocorreu overflow do Timer0?
	goto		trata_TMR0					;Sim, desvia para tratar interrupção do Timer0
	goto		exit_ISR					;Não, desvia para saída de interrupção
		
	
; -- Trata Interrupção do Timer0 --
trata_TMR0:
	bcf			INTCON,T0IF					;Limpa flag
    movlw		H'7E'						;Carrega literal 126d para o registrador Work
	movwf		TMR0						;Reinicializa TMR0 com 126d


; -- Base de Tempo de 8.333ms --

	

delay:										;compensação de 26 ciclos de máquina
	decfsz      AUX							;decrementa aux. Chegou em zero?
	goto        delay						;não. Desvia para label delay
	movlw		D'7'						;sim. Move literal 7d para Work
	movwf		AUX							;recarrega AUX com 7d
	nop										;sem operação por 1CM
 

	btfss		osc_a						;osc_a em high?
	goto		dead_t_a					;não. desvia para dead_t_a
	btfss		osc_b						;sim. osc_b em high?
	goto		dead_t_b					;não. desvia para dead_t_b
	goto		exit_ISR					;sim. desvia para saída da interrupção
 
	
dead_t_a:									
	bcf			osc_b						;osc_b forçado a low
	nop										;no operation
	nop										;no operation
	movlw		H'01'						;move 1 para work
	xorwf		GPIO,F						;inverte osc_a
	goto		exit_ISR					;desvia para saída da interrupção
	
dead_t_b:
	bcf			osc_a						;osc_a forçado a low
	nop										;no operation
	nop										;no operation
	movlw		H'02'						;move 2 para work
	xorwf		GPIO,F						;inverte osc_b

	
; -- Recupera Contexto (Saída de Interrupção ) --
exit_ISR:
	swapf		STATUS_TEMP,W				;Carrega conteúdo de STATUS_TEMP no registrador Work
	movwf		STATUS						;Recupera STATUS pré ISR
	swapf		W_TEMP,F					;Inverte nibbles do W_TEMP e armazena em W_TEMP
	swapf		W_TEMP,W					;Inverte novamente nibbles de W_TEMP armazendo em Work (Recupera Work pré ISR)
	retfie									;Retorna da interrupção
	

; =======================================================================================
; --- Configurações Iniciais ---
inicio:

	bank1									;Seleciona banco1 de memória
	movlw		H'3C'						;Carrega literal 00111100b para o registrador Work
	movwf		TRISIO						;Configura GP0 e GP1 como saída (TRISIO = 0x3C)
	movlw		H'87'						;Carrega literal 10000111b para o registrador Work
	movwf		OPTION_REG					;(OPTION_REG = 0x87)
											; - Desabilita Pull-Ups internos
											; - TMR0 incrementa pelo ciclo de máquina
											; - Prescaler do TMR0 1:256
	clrf		ANSEL						;Apenas pinos digitais (ANSEL = 0x00)
											
	bank0									;Seleciona banco0 de memória
	movlw		H'07'						;Carrega literal 00000111b para o registrador work
	movwf		CMCON						;desabilita comparadores internos
	movlw		H'A0'						;Carrega literal 10100000b para o registrador Work
	movwf		INTCON						;(INTCON = 0xA0)		
											; - Habilita interrupção global
											; - Habilita interrupção do Timer0
	movlw		H'7E'						;Carrega literal 126d para o registrador Work
	movwf		TMR0						;Inicializa TMR0 com 126d
	
	;
	;  T0_ovf = (256 - TMR0) x prescaler x CM
	;  T0_ovf = (256 - 126 ) x   256     x 250E-9
	;  T0_ovf = 8.32ms *
	;
	;
	; *será realizado ajuste fino para obter a base de tempo de 8.333ms
	
	
	movlw		D'7'						;Carrega literal 7d para o registrador Work
	movwf		AUX							;Inicializa AUX em 7d
	
	bcf			osc_a						;osc_a inicia em low
	bsf			osc_b						;osc_b inicia em high


 
; =======================================================================================
; --- Loop Infinito ---	
	 
 
 	goto		$							;Desvia para o endereço atual da memória de programa
	
	
; =======================================================================================	
; --- Final do Programa ---	
	end										;Final do programa

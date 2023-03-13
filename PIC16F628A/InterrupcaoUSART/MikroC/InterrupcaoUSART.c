/* 

   Esse programa tem a fun��o de configurar o uso da comunica��o USART, isto �, serial, atrav�s de registradores do Pic, e n�o somente pelas fun��es
   prontas do MikroC. Ainda, nessas configura��es, ir� ser programada uma interrup��o atrav�s da USART. Como s�o muitos registradores ainda n�o vistos,
   estou fazendo essa anota��o para n�o me confundir quanto ao uso desses registradores. Irei anotar aqui qual s�o os registradores usados.
   
   Configura��o b�sica USART: 8 bits, sem paridade, 1 stop bit 9600 baud rate, assincrona
   
   Comunica��o assincrona: Uma via envia um dado e outra recebe. Por isso o dispositivo que envia o dado deve estar com o mesmo baud rate do que recebe
   
   Registradores USART:
     SPBRG = SP Baud Rate Generator
     TXSTA, flags: TXEN_bit (hab. transmissao), BRGH_bit(sel. baud rate alta vel.), SYNC_bit (conf. modo ass�ncrono)
     RCSTA, flags: SPEN_bit (hab. porta serial), CREN_bit (habilita recep��o cont�nua)
     PIE1, flag RCIE_bit (hab. interrup��o da USART)
     PIR1, flag RCIF_bit (limpaa flag de interrup��o USART)
     TRIS: TX como sa�da e RX como entrada
     TXREG (Registrador de transmiss�o de dados): envia o dado ao serial (para o terminal)
     RCREG (Registrador de recep��o de dados): recebe o dado na serial (do teclado, por exemplo)
     TRMT_bit (reg. TXSTA): Verifica se o buffer est� vazio (1 quando est� vazio, 0 est� cheio)
     FERR_bit (Reg. RCSTA): Indica erro de framing (1 se tem erro, 0 se n�o tem erro)
     OERR_bit (Reg. RCSTA): Indica erro de overrun (1 se tem erro, 0 se n�o tem erro)
     
     TXREG = 0x0D (Car Return): Enter
     TXREG = 0x0A (Line Feed): Realimenta a linha
     Estes valores hexadecimais para as teclas e fun��es espec�ficas, podem ser vistos na tabela ASCII
     
     Duas fun��es essenciais para o bom uso da comunica��o USART � a fun��o de teste do buffer, que utiliza a flag TRMT_bit para verificar se o
     buffer est� vazio, e a fun��o echo, que permite escrever na serial em tempo real.
     Para entender o echo � necess�rio entender como funcionam os registradores TXREG e RCREG. Quando se atribui um caracter ao registrador
     TXREG, este envia para a serial, que � o mesmo que enviar para o terminal onde escrevemos. Isto �, TXREG imprime um caracter. Ainda, TXREG
     envia do Pic para o PC, via serial. J� RCREG, envia do PC para o Pic, e n�o escreve nada no terminal. Ao se atribuir RCREG ao TXREG, o Pic est�
     enviando ao PC, logo, ao terminal, o que foi enviado do PC para o Pic. Por isso se chama echo (ou eco). Ent�o, TXREG imprime do terminal o que
     o PIC est� enviando, e RCREG recebe, no Pic, o que o PC enviou. Fazendo TXREG = RCREG, ser� impresso o RCREG, valor recebido pelo Pic.
     
     C�lculo do overflow do timer0
     
     Clock = 4Mhz, Ciclo de m�quina = 1us
     
     Overflow = ciclo de maquina x prescaler x TMR0
     Overflow = 1us x 256 x 256
     Overflow = 65.6 ms ~= 66ms
     
*/

// configura��o de hardware

#define led1 RA0_bit
#define led2 RA1_bit

// Fun��es auxiliares

void eco();
void textoInicio();
void bufferTeste();

// Vari�veis globais

char cont = 0x00;

// Fun��o de interrup��o

void interrupt(){

     if(RCIF_bit){
     
       RCIF_bit = 0x00;
       
       if(FERR_bit || OERR_bit){ // Verifica se h� algum erro, se houver
       
         CREN_bit = 0x00; // Desabilita a recep��o cont�nua para tentar corrigir algum erro
         CREN_bit = 0x01; // Habilita a recp��o cont�nua novamente
         
         asm retfie; // C�digo em assembly para sair da interrup��o, caso tenha sido necess�rio corrigir algum erro
       }
       
       eco();
     }
     
     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       
       cont++;
       
       if(cont == 0x0A){ // Se cont = 10(decimal) = 0x0A. Se Overflow = 66ms, os leds alternam a cada 66ms x 10 = 660ms
       
         cont = 0x00;
         led1 = ~led1;
         led2 = ~led2;
       }
     }
}

void main() {

     // Registradores do timer0 e interrup��o global

     CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0x87; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:256, associado ao timer0
     INTCON = 0xE0; // Habilita a interrup��o global, a interrup��o por perif�ricos e habilita a interrup��o pelo timer0
     
     // Registradores da USART e sua interrup��o
     
     SPBRG = 0x19; // Ou 25(decimal), para um baud rate de 9600. Esse valor equivale ao c�lculo para Osc 4MHz, com a USART configurada
                   // com baud rate de alta velocidade e no modo ass�ncrono
     // Reg. TXSTA
     TXEN_bit = 0x01; // Habilita transmiss�o
     SYNC_bit = 0x00; // Configura no modo ass�ncrono
     BRGH_bit = 0x01; // Configura o baud rate de alta velocidade

     // Reg. RCSTA
     SPEN_bit = 0x01; // Habilita a porta serial
     CREN_bit = 0x01; // Habilita a recep��o cont�nua
     
     // Reg. PIE1
     RCIE_bit = 0x01; // Habilita a interrup��o por recep��o da USART. Isto �, ocorre a interrup. quando a serial recebe dados
     // Reg. PIR1
     RCIF_bit = 0x00; // Limpa a flag de interrup��o por recep��o da USART
     
     TRISA = 0xFC; // Configura apenas RA0 e RA1 como sa�das digitais
     TRISB = 0xFB; // Configura apenas RB2 (TX) como sa�da digital
     PORTB = 0xFB; // Inicia apenas RB2 (TX) em Low
     led1 = 0x00; // Inicia led1 (RA0) em Low
     led2 = 0x01; // Inicia led2 (RA1) em High
     
     textoInicio();
     
     while(1){
     
       // Apenas aguarda a interrup��o
     }
}

void textoInicio(){

     TXREG = 'H';
     bufferTeste();
     TXREG = 'e';
     bufferTeste();
     TXREG = 'l';
     bufferTeste();
     TXREG = 'l';
     bufferTeste();
     TXREG = 'o';
     bufferTeste();
     TXREG = ' ';
     bufferTeste();
     TXREG = 'W';
     bufferTeste();
     TXREG = 'o';
     bufferTeste();
     TXREG = 'r';
     bufferTeste();
     TXREG = 'l';
     bufferTeste();
     TXREG = 'd';
     bufferTeste();
     TXREG = '!';
     bufferTeste();
     TXREG = 0x0D;
     bufferTeste();
     TXREG = 0x0A;
     bufferTeste();
}

void eco(){

     TXREG = 'D';
     bufferTeste();
     TXREG = 'i';
     bufferTeste();
     TXREG = 'g';
     bufferTeste();
     TXREG = 'i';
     bufferTeste();
     TXREG = 't';
     bufferTeste();
     TXREG = 'a';
     bufferTeste();
     TXREG = 'd';
     bufferTeste();
     TXREG = 'o';
     bufferTeste();
     TXREG = ':';
     bufferTeste();
     TXREG = ' ';
     bufferTeste();
     TXREG = RCREG;
     bufferTeste();
     TXREG = 0x0D;
     bufferTeste();
     TXREG = 0x0A;
     bufferTeste();
}

void bufferTeste(){

    while(!TRMT_bit);
}












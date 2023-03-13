/* 

   Esse programa tem a função de configurar o uso da comunicação USART, isto é, serial, através de registradores do Pic, e não somente pelas funções
   prontas do MikroC. Ainda, nessas configurações, irá ser programada uma interrupção através da USART. Como são muitos registradores ainda não vistos,
   estou fazendo essa anotação para não me confundir quanto ao uso desses registradores. Irei anotar aqui qual são os registradores usados.
   
   Configuração básica USART: 8 bits, sem paridade, 1 stop bit 9600 baud rate, assincrona
   
   Comunicação assincrona: Uma via envia um dado e outra recebe. Por isso o dispositivo que envia o dado deve estar com o mesmo baud rate do que recebe
   
   Registradores USART:
     SPBRG = SP Baud Rate Generator
     TXSTA, flags: TXEN_bit (hab. transmissao), BRGH_bit(sel. baud rate alta vel.), SYNC_bit (conf. modo assíncrono)
     RCSTA, flags: SPEN_bit (hab. porta serial), CREN_bit (habilita recepção contínua)
     PIE1, flag RCIE_bit (hab. interrupção da USART)
     PIR1, flag RCIF_bit (limpaa flag de interrupção USART)
     TRIS: TX como saída e RX como entrada
     TXREG (Registrador de transmissão de dados): envia o dado ao serial (para o terminal)
     RCREG (Registrador de recepção de dados): recebe o dado na serial (do teclado, por exemplo)
     TRMT_bit (reg. TXSTA): Verifica se o buffer está vazio (1 quando está vazio, 0 está cheio)
     FERR_bit (Reg. RCSTA): Indica erro de framing (1 se tem erro, 0 se não tem erro)
     OERR_bit (Reg. RCSTA): Indica erro de overrun (1 se tem erro, 0 se não tem erro)
     
     TXREG = 0x0D (Car Return): Enter
     TXREG = 0x0A (Line Feed): Realimenta a linha
     Estes valores hexadecimais para as teclas e funções específicas, podem ser vistos na tabela ASCII
     
     Duas funções essenciais para o bom uso da comunicação USART é a função de teste do buffer, que utiliza a flag TRMT_bit para verificar se o
     buffer está vazio, e a função echo, que permite escrever na serial em tempo real.
     Para entender o echo é necessário entender como funcionam os registradores TXREG e RCREG. Quando se atribui um caracter ao registrador
     TXREG, este envia para a serial, que é o mesmo que enviar para o terminal onde escrevemos. Isto é, TXREG imprime um caracter. Ainda, TXREG
     envia do Pic para o PC, via serial. Já RCREG, envia do PC para o Pic, e não escreve nada no terminal. Ao se atribuir RCREG ao TXREG, o Pic está
     enviando ao PC, logo, ao terminal, o que foi enviado do PC para o Pic. Por isso se chama echo (ou eco). Então, TXREG imprime do terminal o que
     o PIC está enviando, e RCREG recebe, no Pic, o que o PC enviou. Fazendo TXREG = RCREG, será impresso o RCREG, valor recebido pelo Pic.
     
     Cálculo do overflow do timer0
     
     Clock = 4Mhz, Ciclo de máquina = 1us
     
     Overflow = ciclo de maquina x prescaler x TMR0
     Overflow = 1us x 256 x 256
     Overflow = 65.6 ms ~= 66ms
     
*/

// configuração de hardware

#define led1 RA0_bit
#define led2 RA1_bit

// Funções auxiliares

void eco();
void textoInicio();
void bufferTeste();

// Variáveis globais

char cont = 0x00;

// Função de interrupção

void interrupt(){

     if(RCIF_bit){
     
       RCIF_bit = 0x00;
       
       if(FERR_bit || OERR_bit){ // Verifica se há algum erro, se houver
       
         CREN_bit = 0x00; // Desabilita a recepção contínua para tentar corrigir algum erro
         CREN_bit = 0x01; // Habilita a recpção contínua novamente
         
         asm retfie; // Código em assembly para sair da interrupção, caso tenha sido necessário corrigir algum erro
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

     // Registradores do timer0 e interrupção global

     CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0x87; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:256, associado ao timer0
     INTCON = 0xE0; // Habilita a interrupção global, a interrupção por periféricos e habilita a interrupção pelo timer0
     
     // Registradores da USART e sua interrupção
     
     SPBRG = 0x19; // Ou 25(decimal), para um baud rate de 9600. Esse valor equivale ao cálculo para Osc 4MHz, com a USART configurada
                   // com baud rate de alta velocidade e no modo assíncrono
     // Reg. TXSTA
     TXEN_bit = 0x01; // Habilita transmissão
     SYNC_bit = 0x00; // Configura no modo assíncrono
     BRGH_bit = 0x01; // Configura o baud rate de alta velocidade

     // Reg. RCSTA
     SPEN_bit = 0x01; // Habilita a porta serial
     CREN_bit = 0x01; // Habilita a recepção contínua
     
     // Reg. PIE1
     RCIE_bit = 0x01; // Habilita a interrupçâo por recepção da USART. Isto é, ocorre a interrup. quando a serial recebe dados
     // Reg. PIR1
     RCIF_bit = 0x00; // Limpa a flag de interrupção por recepção da USART
     
     TRISA = 0xFC; // Configura apenas RA0 e RA1 como saídas digitais
     TRISB = 0xFB; // Configura apenas RB2 (TX) como saída digital
     PORTB = 0xFB; // Inicia apenas RB2 (TX) em Low
     led1 = 0x00; // Inicia led1 (RA0) em Low
     led2 = 0x01; // Inicia led2 (RA1) em High
     
     textoInicio();
     
     while(1){
     
       // Apenas aguarda a interrupção
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












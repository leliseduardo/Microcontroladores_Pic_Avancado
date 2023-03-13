#define led1 RA0_bit
#define led2 RA1_bit
#define motor RA2_bit

// Funções auxiliares

void eco();
void textoInicio();
void bufferTeste();
void motorLigado();
void motorDesligado();

// Variáveis globais

char cont = 0x00;
bit ligaMotor;
bit desligaMotor;

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

     TRISA = 0xF8; // Configura apenas RA0, RA1 e RA2 como saídas digitais
     TRISB = 0xFB; // Configura apenas RB2 (TX) como saída digital
     PORTB = 0xFB; // Inicia apenas RB2 (TX) em Low
     led1 = 0x00; // Inicia led1 (RA0) em Low
     led2 = 0x01; // Inicia led2 (RA1) em High
     motor = 0x00;
     
     ligaMotor = 0x00;
     desligaMotor = 0x00;

     textoInicio();

     while(1){

       if(RCREG == 'k' && !ligaMotor){
       
         desligaMotor = 0x00;
         ligaMotor = 0x01;
         
         motorLigado();
       }
       else if(ligaMotor) motor = 0x01;
       
       if(RCREG == 'q' && !desligaMotor){
       
         ligaMotor = 0x00;
         desligaMotor = 0x01;
         
         motorDesligado();
       }
       else if(desligaMotor) motor = 0x00;
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

void motorLigado(){

    TXREG = 'M';
    bufferTeste();
    TXREG = 'o';
    bufferTeste();
    TXREG = 't';
    bufferTeste();
    TXREG = 'o';
    bufferTeste();
    TXREG = 'r';
    bufferTeste();
    TXREG = ' ';
    bufferTeste();
    TXREG = 'L';
    bufferTeste();
    TXREG = 'i';
    bufferTeste();
    TXREG = 'g';
    bufferTeste();
    TXREG = 'a';
    bufferTeste();
    TXREG = 'd';
    bufferTeste();
    TXREG = 'o';
    bufferTeste();
    TXREG = '!';
    bufferTeste();
    TXREG = 0x0D;
    bufferTeste();
    TXREG = 0x0A;
    bufferTeste();
}

void motorDesligado(){

    TXREG = 'M';
    bufferTeste();
    TXREG = 'o';
    bufferTeste();
    TXREG = 't';
    bufferTeste();
    TXREG = 'o';
    bufferTeste();
    TXREG = 'r';
    bufferTeste();
    TXREG = ' ';
    bufferTeste();
    TXREG = 'd';
    bufferTeste();
    TXREG = 'e';
    bufferTeste();
    TXREG = 's';
    bufferTeste();
    TXREG = 'l';
    bufferTeste();
    TXREG = 'i';
    bufferTeste();
    TXREG = 'g';
    bufferTeste();
    TXREG = 'a';
    bufferTeste();
    TXREG = 'd';
    bufferTeste();
    TXREG = 'o';
    bufferTeste();
    TXREG = '!';
    bufferTeste();
    TXREG = 0x0D;
    bufferTeste();
    TXREG = 0x0A;
    bufferTeste();
}
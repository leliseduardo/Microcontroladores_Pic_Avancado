#define led1 RA0_bit
#define led2 RA1_bit
#define motor RA2_bit

// Fun��es auxiliares

void eco();
void textoInicio();
void bufferTeste();
void motorLigado();
void motorDesligado();

// Vari�veis globais

char cont = 0x00;
bit ligaMotor;
bit desligaMotor;

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

     TRISA = 0xF8; // Configura apenas RA0, RA1 e RA2 como sa�das digitais
     TRISB = 0xFB; // Configura apenas RB2 (TX) como sa�da digital
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
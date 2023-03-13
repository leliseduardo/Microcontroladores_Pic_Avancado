#define led1 RA0_bit
#define led2 RA1_bit
#define bot RA2_bit

// Fun��es auxiliares

void imprimeContagem();
void bufferTeste();
void numero(int num);

// Vari�veis globais

char cont = 0x00;
int valor = 0x00;
char *texto = "0000";
bit auxBotao;

// Fun��o de interrup��o

void interrupt(){

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

     auxBotao = 0x00;

     imprimeContagem();

     while(1){

       if(!bot) auxBotao = 0x01;
       
       if(bot && auxBotao){
       
         auxBotao = 0x00;
         
         valor++;
         numero(valor);
       }
     }
}

void imprimeContagem(){

     TXREG = 'C';
     bufferTeste();
     TXREG = 'o';
     bufferTeste();
     TXREG = 'n';
     bufferTeste();
     TXREG = 't';
     bufferTeste();
     TXREG = 'a';
     bufferTeste();
     TXREG = 'g';
     bufferTeste();
     TXREG = 'e';
     bufferTeste();
     TXREG = 'm';
     bufferTeste();
     TXREG = ':';
     bufferTeste();
     TXREG = texto[0];
     bufferTeste();
     TXREG = texto[1];
     bufferTeste();
     TXREG = texto[2];
     bufferTeste();
     TXREG = texto[3];
     bufferTeste();
     TXREG = 0x0D;
     bufferTeste();
     TXREG = 0x0A;
     bufferTeste();
}


void bufferTeste(){

    while(!TRMT_bit);
}

void numero(int num){

     texto[0] = (num/1000) + '0';
     texto[1] = (num%1000)/100 + '0';
     texto[2] = (num%100)/10 + '0';
     texto[3] = (num%10) + '0';
     
     imprimeContagem();
}








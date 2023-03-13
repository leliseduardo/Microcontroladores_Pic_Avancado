#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/USARTContador/MikroC/USARTContador.c"






void imprimeContagem();
void bufferTeste();
void numero(int num);



char cont = 0x00;
int valor = 0x00;
char *texto = "0000";
bit auxBotao;



void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;

 cont++;

 if(cont == 0x0A){

 cont = 0x00;
  RA0_bit  = ~ RA0_bit ;
  RA1_bit  = ~ RA1_bit ;
 }
 }
}

void main() {



 CMCON = 0x07;
 OPTION_REG = 0x87;
 INTCON = 0xE0;



 SPBRG = 0x19;


 TXEN_bit = 0x01;
 SYNC_bit = 0x00;
 BRGH_bit = 0x01;


 SPEN_bit = 0x01;
 CREN_bit = 0x01;


 RCIE_bit = 0x01;

 RCIF_bit = 0x00;

 TRISA = 0xFC;
 TRISB = 0xFB;
 PORTB = 0xFB;
  RA0_bit  = 0x00;
  RA1_bit  = 0x01;

 auxBotao = 0x00;

 imprimeContagem();

 while(1){

 if(! RA2_bit ) auxBotao = 0x01;

 if( RA2_bit  && auxBotao){

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

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/InterrupcaoUSART/MikroC/InterrupcaoUSART.c"
#line 53 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/InterrupcaoUSART/MikroC/InterrupcaoUSART.c"
void eco();
void textoInicio();
void bufferTeste();



char cont = 0x00;



void interrupt(){

 if(RCIF_bit){

 RCIF_bit = 0x00;

 if(FERR_bit || OERR_bit){

 CREN_bit = 0x00;
 CREN_bit = 0x01;

 asm retfie;
 }

 eco();
 }

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

 textoInicio();

 while(1){


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

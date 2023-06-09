#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic B�sico/PIC16F628A/USARTMotor/MikroC/USARTMotor.c"






void eco();
void textoInicio();
void bufferTeste();
void motorLigado();
void motorDesligado();



char cont = 0x00;
bit ligaMotor;
bit desligaMotor;



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

 TRISA = 0xF8;
 TRISB = 0xFB;
 PORTB = 0xFB;
  RA0_bit  = 0x00;
  RA1_bit  = 0x01;
  RA2_bit  = 0x00;

 ligaMotor = 0x00;
 desligaMotor = 0x00;

 textoInicio();

 while(1){

 if(RCREG == 'k' && !ligaMotor){

 desligaMotor = 0x00;
 ligaMotor = 0x01;

 motorLigado();
 }
 else if(ligaMotor)  RA2_bit  = 0x01;

 if(RCREG == 'q' && !desligaMotor){

 ligaMotor = 0x00;
 desligaMotor = 0x01;

 motorDesligado();
 }
 else if(desligaMotor)  RA2_bit  = 0x00;
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

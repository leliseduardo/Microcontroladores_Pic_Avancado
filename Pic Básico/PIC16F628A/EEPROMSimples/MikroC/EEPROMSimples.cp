#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/EEPROMSimples/MikroC/EEPROMSimples.c"





void contador();
void escreveMemoria();

int cont = 0x00;
char anodo;
char display[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67};

void main() {

 CMCON = 0x07;
 TRISA = 0x03;
 TRISB = 0x00;
 PORTA = 0x03;
 PORTB = 0x00;

 cont = EEPROM_Read(0x00);

 while(1){

 contador();

 if(! RA1_bit ){
 escreveMemoria();

 delay_ms(200);
 }

 anodo = display[cont];

 PORTB = anodo;

 }
}

void contador(){

 if(! RA0_bit ){
 cont++;

 delay_ms(200);
 }

 if(cont > 9)
 cont = 0;
}

void escreveMemoria(){

 EEPROM_Write(0x00, cont);
 delay_ms(25);

  RA2_bit  = 0x01;
 delay_ms(500);
  RA2_bit  = 0x00;
}

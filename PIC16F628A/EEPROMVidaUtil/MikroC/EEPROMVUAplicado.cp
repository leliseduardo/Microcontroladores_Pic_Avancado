#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/EEPROMVidaUtil/MikroC/EEPROMVUAplicado.c"





unsigned int varreduraMemoria();
void salvaMemoria(unsigned char dado);
void apagaMemoria();
unsigned int ultimoGravado();

unsigned int ultimoDado;

int soma = 0;
int ajudai;
char anodo;
char display[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0xFF,0x6F};

void main() {

 CMCON = 0x07;
 TRISA = 0x03;
 TRISB = 0x00;
 PORTA = 0x03;
 PORTB = 0x00;

 ultimoDado = ultimoGravado();

 soma = ultimoDado;
 PORTB = display[soma];

 while(1){

 if( RA0_bit  == 0){
 anodo = display[soma];

 PORTB = anodo;

 soma++;

 if(soma > 9){
 ajudai = 9;
 soma = 0;
 }

 delay_ms(250);
 }

 if( RA1_bit  == 0){
 if(ajudai == 9){
 salvaMemoria(9);
 ajudai = 0;
 }
 else
 salvaMemoria(soma-1);

 delay_ms(100);
 }


 }

}

unsigned int varreduraMemoria(){

 unsigned char end;
 unsigned int i, aux;
 unsigned int cont = 0;

 for(i=0; i <= 128; i++){

 if(i < 128){
 end = EEPROM_Read(i);

 if(end == 0xFF){
 if(i == 0){
 aux = i;
 i = 128;
 }
 else if(i == 127){
 aux = i;
 i = 128;
 }
 else if(EEPROM_Read(i+1) == 0xFF){
 aux = i;
 i = 128;
 }
 }
 }
 else
 cont = 128;
 }

 if(cont == 128)
 aux = cont;

 return aux;
}

void salvaMemoria(unsigned char dado){

 unsigned int end;

 end = varreduraMemoria();

 if(end == 128){
 apagaMemoria();
 end = 0;
 }

 EEPROM_Write(end, dado);

 delay_ms(25);
}

void apagaMemoria(){

 unsigned int i;

 for(i=0; i < 128; i++){
 EEPROM_Write(i, 0xFF);
 delay_ms(25);
 }
}

unsigned int ultimoGravado(){

 int end;
 unsigned int aux;

 end = varreduraMemoria();

 if(end == 0)
 aux = 0;
 else if(end == 128)
 aux = 127;
 else
 aux = end - 1;

 aux = EEPROM_Read(aux);

 return aux;
}

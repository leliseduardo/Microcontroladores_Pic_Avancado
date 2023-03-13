#define s1 RA0_bit
#define s2 RA1_bit
#define led1 RA2_bit
#define led2 RA3_bit

void contador();
void escreveMemoria();

int cont = 0x00;
char anodo;
char display[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; // Numeros, em hexa, que representam de 0 a 9 no display

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     TRISA = 0x03; // Seleciona RA0 e RA1 como entradas digitais e o resto como saída digital
     TRISB = 0x00; // Seleciona todo portb como saída digital
     PORTA = 0x03; // Inicia RA0 e RA1 em nível alto, e o resto em nível baixo
     PORTB = 0x00; // Inicia todo o portb com nível lógico baixo
     
     cont = EEPROM_Read(0x00);
     
     while(1){
     
       contador();
       
       if(!s2){
         escreveMemoria();
         
         delay_ms(200);
       }
     
       anodo = display[cont];
       
       PORTB = anodo;
     
     }
}

void contador(){

     if(!s1){
       cont++;
       
       delay_ms(200);
     }
     
     if(cont > 9)
       cont = 0;
}

void escreveMemoria(){

     EEPROM_Write(0x00, cont);
     delay_ms(25);
     
     led1 = 0x01;
     delay_ms(500);
     led1 = 0x00;
}
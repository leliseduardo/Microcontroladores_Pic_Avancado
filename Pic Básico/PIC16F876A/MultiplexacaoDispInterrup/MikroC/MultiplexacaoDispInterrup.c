/* 
   Tempo de interrupção do Timer 0

   clock = 4MHz ciclo de maquina = 1us

   overflow = ciclo de maquina x prescaler x TMR0
   overflow = 1us x 16 x 256 = 4ms
*/

// Configuração de hardware

#define milOut RB0_bit
#define cenOut RB1_bit
#define dezOut RB2_bit
#define uniOut RB3_bit
#define incDec Rb4_bit

// Funções auxiliares
void contador();
int display(int num);

// Variáveis auxiliares
char control = 0x01;
unsigned cont = 0x00;
int mil = 0x00;
int cen = 0x00; 
int dez = 0x00;
int uni = 0x00;

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       TMR0 = 0x00;
       
       if(!milOut && control == 0x01){
       
         control = 0x02;
         cenOut = 0x00;
         dezOut = 0x00;
         uniOut = 0x00;
         PORTC = 0x00;
         mil = cont / 1000;
         milOut = 0x01;
         PORTC = display(mil);
       }
       else if(!cenOut && control == 0x02){
       
         control = 0x03;
         milOut = 0x00;
         dezOut = 0x00;
         uniOut = 0x00;
         PORTC = 0x00;
         cen = (cont%1000) / 100;
         cenOut = 0x01;
         PORTC = display(cen);
       }
       else if(!dezOut && control == 0x03){
       
         control = 0x04;
         milOut = 0x00;
         cenOut = 0x00;
         uniOut = 0x00;
         PORTC = 0x00;
         dez = (cont % 100) / 10;
         dezOut = 0x01;
         PORTC = display(dez);
       }
       else if(!uniOut && control == 0x04){
       
         control = 0x01;
         milOut = 0x00;
         cenOut = 0x00;
         dezOut = 0x00;
         PORTC = 0x00;
         uni = cont%10;
         uniOut = 0x01;
         PORTC = display(uni);
       }
     }
}

void main() {
     CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0x83; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:1
     INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção do timer0
     TMR0 = 0x00; // Começa a contagem do timer0 em 0x00

     TRISB = 0xF0; // Configura primeiro neeble como entrada digital e o segundo neeble como saída digital
     TRISC = 0x80; // Confgirua apenas RB7 como entrada digital
     PORTB = 0xF0; // Inicia o primeiro neeble em High e o segundo neeble em Low
     PORTC = 0x80; // Inicia apenas RB7 em High
     
     while(1){
     
       contador();
     }
}

void contador(){

     if(incDec){
       
       cont++;
       if(cont > 9999) cont = 0;
       delay_ms(100);
     }
     else{
     
       cont--;
       if(cont < 0) cont = 9999;
       delay_ms(100);
     }
}

int display(int num){

    int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
    int aux;

    aux = vetorDisplay[num];

    return aux;
}
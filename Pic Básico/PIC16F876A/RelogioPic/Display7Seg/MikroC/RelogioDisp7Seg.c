/*

  Cálculos de overflow
  
  Clock = 4MHz, Ciclo de máquina = 1us
  
  Timer 0:
  
  Overflow = ciclo de maquina x prescaler x TMR0
  Overflow = 1us x 16 x 256
  Overflow = 4,093ms ~= 4ms

  Timer 1:
  
  Overflow = ciclo de maquina x prescaler x (TMR1H::TMR1L)
  500ms    = 1us x 8 x (TMR1H::TMR1L)
  (TMR1H::TMR1L) = 500ms / (1us x 8)
  (TMR1H::TMR1L) = 62500
  
  Para incrementar 62500 vezes, o timer1 deve começar sua contagem em:
  
  Inicio = 65536 - 62500 = 3036
  (TMR1H::TMR1L) = 3036(decimal) = 0x0BDC(hexadecimal)
  TMR1H = 0x0B
  TMR1L = 0xDC

  No vídeo desta aula, aparece no osciloscópio um ruído no tempo em que o led está ligado, no pulso de 500ms em que ele fica ligado.
  Na verdade, isso não é ruído, e aparece porque o led também está sendo multiplexado pelo timer0, já que os leds estão com o catodo
  ligado à dez e uni (RB2 e RB3). Assim, enquando o RB6 (pino do led) está ativa (durante 500ms), o led fica sendo multiplexado a cada
  4ms, tempo do timer0.

*/

// Configuração de hardware

#define mil RB0_bit
#define cent RB1_bit
#define dez RB2_bit
#define uni RB3_bit
#define botMin RB4_bit
#define botHora RB5_bit
#define led RB6_bit

// Funções auxiliares

int display(int num);
void relogio();
void arrumaRelogio();

// Variáveis globais

int milesimo, centena, dezena, unidade;
char seg = 0x00;
char minu = 0x00;
char hora = 0x00;
char control = 0x01;
char cont = 0x00;
char flag = 0x00;

// Função de interrupção

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
     
       if(!mil && control == 0x01){
       
         cent = 0x00;
         dez = 0x00;
         uni = 0x00;
         control = 0x02;
         PORTC = 0x00;
         milesimo = (hora%100)/10; // Ex: 22 % 100 = 22, 22 / 10 = 2. Logo, milesimo = 2
         mil = 0x01;
         PORTC = display(milesimo);
       }
       else if(!cent && control == 0x02){

         mil = 0x00;
         dez = 0x00;
         uni = 0x00;
         control = 0x03;
         PORTC = 0x00;
         centena = hora%10;
         cent = 0x01;
         PORTC = display(centena);
       }
       else if(!dez && control == 0x03){

         mil = 0x00;
         cent = 0x00;
         uni = 0x00;
         control = 0x04;
         PORTC = 0x00;
         dezena = (minu%100)/10;
         dez = 0x01;
         PORTC = display(dezena);
       }
       else if(!uni && control == 0x04){

         mil = 0x00;
         cent = 0x00;
         dez = 0x00;
         control = 0x01;
         PORTC = 0x00;
         unidade = minu%10;
         uni = 0x01;
         PORTC = display(unidade);
       }
     }
     
     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00;
       TMR1H = 0x0B;
       TMR1L = 0xDC;
       
       led = ~led;
       
       cont++;
       
       if(cont == 0x02){
       
         cont = 0x00;
         seg++;
       }
     }
}

void main(){

     CMCON = 0x07; // Desabilita os comparadores internos
     
     OPTION_REG = 0x83; // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:16
     INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção do timer0
     
     T1CON = 0x31; // Habilita o timer1 e configura seu prescaler em 1:8;
     TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1 (registrador PIE1)
     TMR1H = 0x0B; // Inicia a contagem do timer 1 em 3036(decimal), para uma contagem de 62500
     TMR1L = 0xDC;
     
     TRISB = 0xB0; // Configura apenas RB4, RB5 e RB7 como entradas digitais
     TRISC = 0x80; // Configura apenas RC7 como entrada digital
     PORTB = 0xB0; // Inicia RB4, RB5 e RB7 em High, o resto em Low
     PORTC = 0x80; // Inicia os displays mostrando "0"
     
     while(1){
     
       relogio();
     }
}

void relogio(){

     if(seg > 59){
     
       seg = 0;
       minu++;
       
       if(minu > 59){
       
         minu = 0;
         hora++;
         
         if(hora > 23)
           hora = 0;
       }
     }
     
     if(!botMin)
       flag.B0 = 0x01;
     if(!botHora)
       flag.B1 = 0x01;

     if(botMin && flag.B0){

       flag.B0 = 0x00;
       minu++;

       if(minu > 59){

         minu = 0;
         hora++;

         if(hora > 59)
           hora = 0;
       }
     }
   if(botHora && flag.B1){

       flag.B1 = 0x00;
       hora++;

       if(hora > 23)
         hora = 0;
    }
}


 int display(int num){

    int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
    int aux;

    aux = vetorDisplay[num];

    return aux;
}
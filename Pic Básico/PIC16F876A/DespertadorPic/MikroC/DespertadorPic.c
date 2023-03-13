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

*/

// Configuração de hardware

#define mil RB1_bit
#define cent RB2_bit
#define dez RB3_bit
#define uni RB4_bit
#define botMin RB5_bit
#define botHora RB6_bit
#define led RB7_bit

#define ajusteAlarme RA0_bit
#define buzzer RA1_bit
#define ledAlarme RA2_bit

// Funções auxiliares

int display(int num);
void relogio();
void ajusteRelogio();
void alarme();

// Variáveis globais

int milesimo, centena, dezena, unidade;
char seg = 0x00;
char minu = 0x00;
char hora = 0x00;
char control = 0x01;
char cont = 0x00;
char flag = 0x00;

char minuAlarme = 0x00;
char horaAlarme = 0x00;


// Função de interrupção

void interrupt(){

     if(INTF_bit){
     
       INTF_bit = 0x00;
       
       flag.B3 = ~flag.B3;
       
       if(flag.B3) ledAlarme = 0x01;
       else ledAlarme = 0x00;
     }

     if(T0IF_bit){

       T0IF_bit = 0x00;
       
       if(flag.B3){
         if(minuAlarme == minu && horaAlarme == hora)
           buzzer = 0x01;
         else
           buzzer = 0x00;
       }
       else
         buzzer = 0x00;

       if(!flag.B2){
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
       if(flag.B2){
         if(!mil && control == 0x01){

           cent = 0x00;
           dez = 0x00;
           uni = 0x00;
           control = 0x02;
           PORTC = 0x00;
           milesimo = (horaAlarme%100)/10; // Ex: 22 % 100 = 22, 22 / 10 = 2. Logo, milesimo = 2
           mil = 0x01;
           PORTC = display(milesimo);
         }
         else if(!cent && control == 0x02){

           mil = 0x00;
           dez = 0x00;
           uni = 0x00;
           control = 0x03;
           PORTC = 0x00;
           centena = horaAlarme%10;
           cent = 0x01;
           PORTC = display(centena);
         }
         else if(!dez && control == 0x03){

           mil = 0x00;
           cent = 0x00;
           uni = 0x00;
           control = 0x04;
           PORTC = 0x00;
           dezena = (minuAlarme%100)/10;
           dez = 0x01;
           PORTC = display(dezena);
         }
         else if(!uni && control == 0x04){

           mil = 0x00;
           cent = 0x00;
           dez = 0x00;
           control = 0x01;
           PORTC = 0x00;
           unidade = minuAlarme%10;
           uni = 0x01;
           PORTC = display(unidade);
         }
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
     ADCON0 = 0x00; // Desliga o conversor AD
     ADCON1 = 0x07; // Configura todo porta, que tem os pinos analogicos, como pinos digitais

     OPTION_REG = 0x83; // Desabilita os pull-ups internos, configura o prescaler do timer0 em 1:16, e a interrupção externa por borda de descida
     INTCON = 0xB0; // Habilita a interrupção global, habilita a interrupção do timer0 e habilita a interrupção externa

     T1CON = 0x31; // Habilita o timer1 e configura seu prescaler em 1:8;
     TMR1IE_bit = 0x01; // Habilita a interrupção pelo timer1 (registrador PIE1)
     TMR1H = 0x0B; // Inicia a contagem do timer 1 em 3036(decimal), para uma contagem de 62500
     TMR1L = 0xDC;

     TRISA = 0xF9; // Configura apenas RA1 e RA2 como saída digital
     TRISB = 0x61; // Configura apenas RB0, RB5 e RB6 como entradas digitais
     TRISC = 0x80; // Configura apenas RC7 como entrada digital
     PORTA = 0xF9; // Inicia apenas RA1 e RA2 em Low
     PORTB = 0x30; // Inicia RB0, RB4 e RB5 em High, o resto em Low
     PORTC = 0x80; // Inicia os displays mostrando "0"

     while(1){
     
       relogio();
     
       if(!ajusteAlarme) flag.B2 = ~flag.B2;
       delay_ms(70);

       if(ajusteAlarme && !flag.B2)
         ajusteRelogio();
       else if(ajusteAlarme && flag.B2)
         alarme();
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
}

void ajusteRelogio(){

     if(!botMin)
       flag.B0 = 0x01;
     if(!botHora)
       flag.B1 = 0x01;

     if(botMin && flag.B0){

       flag.B0 = 0x00;
       minu++;

       if(minu > 59) minu = 0;
     }
     if(botHora && flag.B1){

       flag.B1 = 0x00;
       hora++;

       if(hora > 23) hora = 0;
     }
}

void alarme(){

     if(!botMin) flag.B0 = 0x01;
     if(!botHora) flag.B1 = 0x01;
     
     if(botMin && flag.B0){
     
       flag.B0 = 0x00;
       minuAlarme++;
       
       if(minuAlarme > 59) minuAlarme = 0;
     }
     if(botHora && flag.B1){
     
       flag.B1 = 0x00;
       horaAlarme++;
       
       if(horaAlarme > 23) hora = 0;
     }
}

 int display(int num){

    int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67}; //Numeros de 0 a 9 no display, representados em hexa
    int aux;

    aux = vetorDisplay[num];

    return aux;
}
/*

        Este programa tem a fun��o de multiplexar dois displays de 7 segmentos para exibir a temperatura lida por um sensor LM35 e enviada ao
    conversor AD do PIC. Como s�o apenas dois displays, ser� mostrado s� a temperatura com decimal e unidade.
        Este projeto tem como objetivo criar um term�metro para medir a temperatura ambiente e, por isso, s� mostra decimal e unidade, sem casas
    decimais. Por�m, o projeto eletr�nico, assim como o c�digo aqui desenvolvido, servem como base para um term�metro mais preciso, que me�a
    com casas decimais, ou ent�o um term�metro que use outro sensor, que n�o o lm35, e me�a temperatura de alguma m�quina ou ambiente espec�fico.
    
    ***** TIMER 0 *****
    
    Overflow = (256 - TMR0) * Prescaler * Ciclo de maquina

                         Overflow
    TMR0 = 256 - ------------------------------
                  Prescaler * Ciclo de maquina
            
                    5ms
    TMR0 = 256 - ---------- = 256 - 78 = 178
                  64 * 1us
            
    178d = B2h

    TMR0 = B2h
    
         Na pr�tica, na protoboard, o circuito funcionou como esperado, n�o utilizando nenhuma fun��o de m�dia, somente a fun��o celsius. Utilizar
    um fio comprido na sa�da do lm35 causa muitas interfer�ncias, com erros grandes de leitura. Na PCI isso n�o deve ser problema.

*/

// Mapemento de hardware
#define disp1 RB3_bit
#define disp2 RB1_bit


// Prot�tipo de fun��es
void display(unsigned short n);
void celsius();
//long media_Temp();
//long media_Movel();

// Vari�veis auxiliares
char control = 0x00;
unsigned short dezena = 0x00, unidade = 0x00;
long mediaMovel = 0x00;
//float tensao = 0.0; 
long temperatura = 0x00, ultimaTemperatura = 0x00;
int media[40];

// Fun��o de interrup��o
void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;                   // Limpa flag de interrup��o do timer0
       TMR0 = 0xB2;                         // Reinicia valor de TMR0

       // A cada 5ms
       
       if(!disp1 && control == 0x00){                        // Liga display 1, das dezenas
       
         disp2 = 0x00;                      // Desliga display 2
         PORTB = 0x00;                      // Limpa PORTB
         PORTC = 0x00;                      // Limpa PORTC
         disp1 = 0x01;                      // Liga display 1
         display(dezena);                   // Envia n�mero a ser exibido no display
         control = 0x01;                    // Seta vari�vel de controle
       
       } // end if
       else if(!disp2 && control == 0x01){
       
         disp1 = 0x00;                      // Desliga display 1
         PORTB = 0x00;                      // Limpa PORTB
         PORTC = 0x00;                      // Limpa PORTC
         disp2 = 0x01;                      // Liga display 2
         display(unidade);                  // Envia n�mero a ser exibido no display
         control = 0x00;                       // Limpa vari�vel de controle
       
       } // end if
     
     } // end if TMR0IF_bit

} // end void interrupt

// Programa principal
void main() {

     // Comparador interno
     CMCON = 0x07;                             // Desabilita os comparadores internos
     //Registradores de I/O
     TRISB = 0x15;                             // Ou 0b00010101, configura todos os pinos que ser�o utilizados como sa�das digitais
     TRISC = 0x0F;                             // Ou 0b00001111, configura o primeiro nibble como sa�da digital
     TRISA = 0xFF;
     // Resgistradores de interrup��o
     OPTION_REG = 0x85;                        // Desabilita os pull-ups internos e configura o prescaler do timer0 em 1:64
     INTCON = 0xA0;                            // Habilita a interrup��o global e a interrup��o do timer0
     TMR0 = 0xB2;                              // Inicializa TMR0 = B2h = 178d, para contagem de 78 e overflow de 5ms
     disp1 = 0x00;                             // Inicia display 1 desligado
     disp2 = 0x00;                             // Inicia display 2 desligado
     // Registradores do ADC
     ADCON0 = 0x41;                            // Habilita o conversor AD
     ADCON1 = 0x4E;                            // Configura apenas AN0 como entrada anal�gica, com a convers�o no intervalo entre as tens�es da fonte
     
     
     // Loop infinito
     while(1){
     
       celsius();
       
       delay_ms(1000);
     
     } // end loop infinito

} // end void main


// Fun��es auxiliares

void celsius(){

     
     mediaMovel = adc_read(0);
     
     temperatura = ((mediaMovel * 500) / 1024);
     
     if((temperatura > ultimaTemperatura + 1) || (temperatura < ultimaTemperatura - 1)){
     
       ultimaTemperatura = temperatura;
       
       if(temperatura > 99){

         dezena = 0x09;
         unidade = 0x09;

       }
       else if(temperatura < 1){
       
         dezena = 0x00;
         unidade = 0x00;
       }
       else{
       
         dezena = temperatura / 10;
         unidade = temperatura % 10;
       
       }
     
     } // end if
     

} // end void celsius


/*
long media_Temp(){

     long adc = 0x00;
     char i = 0x00;
     
     for(i = 0; i <= 20; i++)
       adc += adc_read(0);
       
     return (adc/20);

} // end long media_Temp
      */

   /*
long media_Movel(){

     long mediaM = 0x00, cont = 0x00;
     long adc = 0x00;
     char i = 0x00;
     
     adc = adc_read(0);
     
     for(i = 39; i > 0; i--)
       media[i] = media[i-1];
       
     media[0] = adc;
     
     for(i = 0; i < 40; i++)
       cont = cont + media[i];
       
     mediaM = cont / 40;

     return mediaM;

} // end void media_Movel
             */


void display(unsigned short n){

    switch(n){
    
      case 0: RC4_bit = 0x01;
              RC5_bit = 0x01;
              RC6_bit = 0x01;
              RC7_bit = 0x01;
              RB5_bit = 0x01;
              RB6_bit = 0x01;
              RB7_bit = 0x00;
              break;
      case 1: RC4_bit = 0x00;
              RC5_bit = 0x01;
              RC6_bit = 0x01;
              RC7_bit = 0x00;
              RB5_bit = 0x00;
              RB6_bit = 0x00;
              RB7_bit = 0x00;
              break;
      case 2: RC4_bit = 0x01;
              RC5_bit = 0x01;
              RC6_bit = 0x00;
              RC7_bit = 0x01;
              RB5_bit = 0x01;
              RB6_bit = 0x00;
              RB7_bit = 0x01;
              break;
      case 3: RC4_bit = 0x01;
              RC5_bit = 0x01;
              RC6_bit = 0x01;
              RC7_bit = 0x01;
              RB5_bit = 0x00;
              RB6_bit = 0x00;
              RB7_bit = 0x01;
              break;
      case 4: RC4_bit = 0x00;
              RC5_bit = 0x01;
              RC6_bit = 0x01;
              RC7_bit = 0x00;
              RB5_bit = 0x00;
              RB6_bit = 0x01;
              RB7_bit = 0x01;
              break;
      case 5: RC4_bit = 0x01;
              RC5_bit = 0x00;
              RC6_bit = 0x01;
              RC7_bit = 0x01;
              RB5_bit = 0x00;
              RB6_bit = 0x01;
              RB7_bit = 0x01;
              break;
      case 6: RC4_bit = 0x01;
              RC5_bit = 0x00;
              RC6_bit = 0x01;
              RC7_bit = 0x01;
              RB5_bit = 0x01;
              RB6_bit = 0x01;
              RB7_bit = 0x01;
              break;
      case 7: RC4_bit = 0x01;
              RC5_bit = 0x01;
              RC6_bit = 0x01;
              RC7_bit = 0x00;
              RB5_bit = 0x00;
              RB6_bit = 0x00;
              RB7_bit = 0x00;
              break;
      case 8: RC4_bit = 0x01;
              RC5_bit = 0x01;
              RC6_bit = 0x01;
              RC7_bit = 0x01;
              RB5_bit = 0x01;
              RB6_bit = 0x01;
              RB7_bit = 0x01;
              break;
      case 9: RC4_bit = 0x01;
              RC5_bit = 0x01;
              RC6_bit = 0x01;
              RC7_bit = 0x00;
              RB5_bit = 0x00;
              RB6_bit = 0x01;
              RB7_bit = 0x01;
              break;
    
    } // end switch

} // end void display


/* 

     Display

     RC4  RC5  RC6  RC7  RB5  RB6  RB7
      a    b    c    d    e    f    g
 0    1    1    1    1    1    1    0
 1    0    1    1    0    0    0    0
 2    1    1    0    1    1    0    1
 3    1    1    1    1    0    0    1
 4    0    1    1    0    0    1    1
 5    1    0    1    1    0    1    1
 6    1    0    1    1    1    1    1
 7    1    1    1    0    0    0    0
 8    1    1    1    1    1    1    1
 9    1    1    1    0    0    1    1
 
 
 
*/
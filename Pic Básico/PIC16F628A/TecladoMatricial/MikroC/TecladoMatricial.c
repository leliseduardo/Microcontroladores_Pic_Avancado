// Mapeamento de Hardware

#define s1 RA0_bit
#define s2 RA1_bit
#define led1 RA2_bit
#define led2 RA3_bit

#define col1 RB1_bit
#define col2 RB2_bit
#define col3 RB3_bit
#define lina RB4_bit
#define linb RB5_bit
#define linc RB6_bit
#define lind RB7_bit

// Defini��o de vari�veis

void piscaLed(int num);

int control = 0x01;

// Fun��o de interrup��o

void interrupt() {

     if(T0IF_bit){  // Testa se o timer0 estourou
              T0IF_bit = 0x00; // Zera a vari�vel de estouro
              TMR0 = 0x6C; // Inicia o contador do timer0
              
              if(col1 && control == 0x01){
                      col1 = 0x00;
                      col2 = 0x01;
                      col3 = 0x01;
                      control = 0x02;

                      if(!lina)
                        piscaLed(1);
                      if(!linb)
                        piscaLed(4);
                      if(!linc)
                        piscaLed(7);
                      if(!lind)
                        piscaLed(11);
              }
              else if(col2 && control == 0x02){
                      col1 = 0x01;
                      col2 = 0x00;
                      col3 = 0x01;
                      control = 0x03;
                      
                      if(!lina)
                        piscaLed(2);
                      if(!linb)
                        piscaLed(5);
                      if(!linc)
                        piscaLed(8);
                      if(!lind)
                        piscaLed(10);
              }
              else if(col3 && control == 0x03){
                      col1 = 0x01;
                      col2 = 0x01;
                      col3 = 0x00;
                      control = 0x01;
                      
                      if(!lina)
                        piscaLed(3);
                      if(!linb)
                        piscaLed(6);
                      if(!linc)
                        piscaLed(9);
                      if(!lind)
                        piscaLed(12);
              }
     }
}



void main() {

     // Defini��o de registradores
     
     CMCON = 0x07; // Desabilita os comparadores internos
     TRISA = 0x03; // Seleciona apenas RA0 e RA1 como entradas digitais
     TRISB = 0xF0; // Seleciona o primeiro nibble como entrada digital
     PORTA = 0x03; // Inicia apenas RA0 e RA1 em n�vel logico alto
     PORTB = 0xFF; // Inicia todo o portb em n�vel logico alto
     
     OPTION_REG = 0X86; // Debabilita o pull-up interno do portb e seleciona o prescaler em 1:128
     GIE_bit = 0x01; // Habilita a interrup��o global
     PEIE_bit = 0x01; // Habilita a interrup��o por perifericos externos
     T0IE_bit = 0x01; // Habilita a interrup��o por estouro do timer0
     
     TMR0 = 0x6C; // Inicia o timer0 em 0x6C = 108 (decimal)
     
     // Loop principal
     
     while(1);{
     
     }
}

void piscaLed(int num){

     int i;
     
     for(i = 0; i < num; i++){
           led1 = 0x01;
           led2 = 0x01;
           delay_ms(200);
           led1 = 0x00;
           led2 = 0x00;
           delay_ms(200);
     }
}

// Configuração de hardware

#define m1 RB3_bit
#define m2 RB2_bit
#define m3 RB1_bit
#define m4 RB0_bit
#define led1 RA0_bit
#define led2 RA1_bit
#define bot1 RA2_bit
#define bot2 RA3_bit

// Funções auxiliares

void passo1();
void passo2();
void passo3();
void passo4();
void passo5();
void passo6();
void passo7();
void passo8();

// Variáveis globais

unsigned char velocidade = 0x64; // Variável que controlar o contador tmr0, e define a valocidade do motor de passo, começa em 100 decimal.
                                 // Em 3 decimal, o motor estará com a maior velocidade possivel que. Através de prática, conseguiu-se
                                 // um tempo mínimo de 800us entre os passos. Abaixo disso o motor não roda
unsigned char cont = 0x01;

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       TMR0 = velocidade;
       
       switch(cont){
       
         case 0x01: passo1();
         break;
         case 0x02: passo2();
         break;
         case 0x03: passo3();
         break;
         case 0x04: passo4();
         break;
         case 0x05: passo5();
         break;
         case 0x06: passo6();
         break;
         case 0x07: passo7();
         break;
         case 0x08: passo8();
         break;
       }
       
       cont++;
       
       if(cont > 0x08)
         cont = 0x01;
     }
}

void main() {

     CMCON = 0x07; //Desabilita os comparadores internos
     OPTION_REG = 0x87; // Desabilita os pull-ups internos, fazr tmr0 incrementar com o clock interno e configura o prescaler em 1:256
     INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção pelo timer0
     TMR0 = velocidade;
     
     TRISA = 0xFC; // Configura apenas RA0 e RA1 como saídas digitais
     TRISB = 0xF0; // Configura segundo neeble como saída
     PORTA = 0xFC; // Inicia apenas RB0 e RB1 em Low
     PORTB = 0xF0; // Inicia o segundo neeble em Low
     
     while(1){
     
        if(!bot1 && !led1){

          led1 = 0x01;
          velocidade++;
        }
        if(!bot2 && !led2){
        
          led2 = 0x01;
          velocidade--;
        }
        
        if(bot1 && led1)
          led1 = 0x00;
          
        if(bot2 && led2)
          led2 = 0x00;
     }
}

void passo1(){

     m1 = 0x01;
     m2 = 0x00;
     m3 = 0x00;
     m4 = 0x00;
}

void passo2(){

     m1 = 0x01;
     m2 = 0x01;
     m3 = 0x00;
     m4 = 0x00;
}

void passo3(){

     m1 = 0x00;
     m2 = 0x01;
     m3 = 0x00;
     m4 = 0x00;
}

void passo4(){

     m1 = 0x00;
     m2 = 0x01;
     m3 = 0x01;
     m4 = 0x00;
}

void passo5(){

     m1 = 0x00;
     m2 = 0x00;
     m3 = 0x01;
     m4 = 0x00;
}

void passo6(){

     m1 = 0x00;
     m2 = 0x00;
     m3 = 0x01;
     m4 = 0x01;
}

void passo7(){

     m1 = 0x00;
     m2 = 0x00;
     m3 = 0x00;
     m4 = 0x01;
}

void passo8(){

     m1 = 0x01;
     m2 = 0x00;
     m3 = 0x00;
     m4 = 0x01;
}
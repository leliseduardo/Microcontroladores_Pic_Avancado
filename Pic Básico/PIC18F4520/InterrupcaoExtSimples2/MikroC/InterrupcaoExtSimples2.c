/* 

        Este programa, assim como o projeto "InterrupcaExtSimples", tem a fun��o de apresentar as interrup��es da fam�lia 18F dos micro-
    controladores Pic. Nesse projeto ser�o configuradas tr�s interrup��es externas que, ainda, n�o apresentam prioridade alta e baixa de
    interrup��o e, sim, uma prioridade relativa, assim como ocorria nas fam�lias 12F e 16F. Portanto, este programa serve para demonstrar
    o tempo de lat�ncia das inteterrup��es nesse tipo de prioridade, onde a ordem em que as flags de interrup��o s�o testadas ditam a prio-
    ridade. Ou seja, a �ltima flag testada ter� a maior lat�ncia, visto que tem que esperar a execu��o das outras interrup��es.

*/

// Configura�� de hardware
#define out0 LATB5_bit
#define out1 LATB6_bit
#define out2 LATB7_bit

// Fun��o de interrup��o
void interrupt(){

     if(INT0IF_bit){
     
       INT0IF_bit = 0x00;
       
       out0 = ~out0;
     }

     if(INT2IF_bit){
     
       INT2IF_bit = 0x00;
       
       out2 = ~out2;
     }
     
     if(INT1IF_bit){
     
       INT1IF_bit = 0x00;
       
       out1 = ~out1;
     }
}

void main() {

     // Configura��o de registradores
     INTCON = 0x90; // Ou 0b10010000, habilita a interrup��o global e habilita a interrup��o externa INT0
     
     // Flags do registrador INTCON2
     INTEDG0_bit = 0x00; // Configura a interrup��o externa INT0 por borda de descida
     INTEDG1_bit = 0x01; // Configura a interrup��o externa INT1 por borda de subida
     INTEDG2_bit = 0x00; // Configura a interrup��o externa INT2 por borda de descida
     
     // Flags do registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrup��o externa INT1
     INT2IE_bit = 0x01; // Habilita a interrup��o externa INT2
     
     ADCON1 = 0x0F; // Configura todos os pinos que podem ser anal�gicos como digitais
     
     TRISB = 0x1F; // Configura RB5, RB6 e RB7 como sa�das digitais
     
     out0 = 0x00;
     out1 = 0x00;
     out2 = 0x00;
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrup��o...
     } // end while
     
} // end void main









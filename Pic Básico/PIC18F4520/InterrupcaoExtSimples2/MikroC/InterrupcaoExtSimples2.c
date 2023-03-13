/* 

        Este programa, assim como o projeto "InterrupcaExtSimples", tem a função de apresentar as interrupções da família 18F dos micro-
    controladores Pic. Nesse projeto serão configuradas três interrupções externas que, ainda, não apresentam prioridade alta e baixa de
    interrupção e, sim, uma prioridade relativa, assim como ocorria nas famílias 12F e 16F. Portanto, este programa serve para demonstrar
    o tempo de latência das inteterrupções nesse tipo de prioridade, onde a ordem em que as flags de interrupção são testadas ditam a prio-
    ridade. Ou seja, a última flag testada terá a maior latência, visto que tem que esperar a execução das outras interrupções.

*/

// Configuraçã de hardware
#define out0 LATB5_bit
#define out1 LATB6_bit
#define out2 LATB7_bit

// Função de interrupção
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

     // Configuração de registradores
     INTCON = 0x90; // Ou 0b10010000, habilita a interrupção global e habilita a interrupção externa INT0
     
     // Flags do registrador INTCON2
     INTEDG0_bit = 0x00; // Configura a interrupção externa INT0 por borda de descida
     INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
     INTEDG2_bit = 0x00; // Configura a interrupção externa INT2 por borda de descida
     
     // Flags do registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
     INT2IE_bit = 0x01; // Habilita a interrupção externa INT2
     
     ADCON1 = 0x0F; // Configura todos os pinos que podem ser analógicos como digitais
     
     TRISB = 0x1F; // Configura RB5, RB6 e RB7 como saídas digitais
     
     out0 = 0x00;
     out1 = 0x00;
     out2 = 0x00;
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrupção...
     } // end while
     
} // end void main









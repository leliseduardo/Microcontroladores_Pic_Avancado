/*

        Este programa tem a fun��o de criar um sensor utilizando o PIC12F675. Com ele, ser�o lidos 4 bot�es e uma entrada anal�gica. Assim, de
    acordo com a entrada lida, ser� gerado um pulso de sa�da. Esse pulso de sa�da ser� de acordo com a entrada acionada.
        Com este sensor pronto, utiliza-se um receptor feito com o PIC18F4550/2550, utilizando uma interrup��o externa.
        
        Este programa utiliza uma leitura anal�gica, uma interrup��o pelo timer0 e todos os seus pinos como entrada e um como sa�da.
        
**************************** Timer 0 *******************************************

        Overflow = contagem * prescale * ciclo de maquina
        Overflow = 256 * 256 * 1us
        Overflow = 66ms
        
********************************************************************************

    Na simula��o do proteus o circuito e o programa funcionaram perfeitamente.

*/

//

// Mapeamento de hardware
#define digital1 GP1_bit
#define digital2 GP2_bit
#define digital3 GP3_bit
#define digital4 GP4_bit
#define saida GP5_bit

// Fun��o auxiliar
void pulso_Saida(int n);

// Vari�veis auxiliares
char baseTempo = 0x00;

int adc = 0x00;

// Fun��o de interrup��o
void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
     
       baseTempo++;
       
       if(baseTempo == 0x04){ // A cada 66ms x 4 = 262ms, o conversor AD � lido
       
         baseTempo = 0x00;
         adc = adc_read(0);
       
       } // end if baseTempo == 0x04
     
     } // end T0IF_bit

} // end void interrupt

void main() {

     // Configura��o de registradores
     CMCON = 0x07; // Desabilita os comparadores internos
     ANSEL = 0x11; // Fosc/8 e configura apenas AN0 como entrada anal�gica
     ADCON0 = 0x01; // Seleciona o canal AN0 como entrada anal�gica e habilita o conversor AD
     
     INTCON = 0xA0; // Habilita interrup��o global e a interrup��o por overflow do timer0
     OPTION_REG = 0x07; // Habilita os pull-ups internos, timer0 incrementa com ciclo de maquina e configura o prescale em 1:256
     TRISIO = 0x1F; // Ou 0b0001 1111, configura apenas GP5 como sa�da, o resto como entrada
     
     saida = 0x00;
     
     // Loop infinito
     while(1){
     
       if(!digital1) pulso_Saida(0x01);
       if(!digital2) pulso_Saida(0x02);
       if(!digital3) pulso_Saida(0x03);
       if(!digital4) pulso_Saida(0x04);
       
       switch(adc){
       
         case 0:
         case 512: pulso_Saida(5); 
         break;
         case 877:
         case 955:
         case 1023: pulso_Saida(6);
         break;
       
       } // end switch adc
     
     } // end Loop infinito

} // end void main


void pulso_Saida(int n){

     char i;
     
     for(i = 0x00; i < n; i++){
     
       saida = 0x01;
       delay_ms(30);
       saida = 0x00;
       delay_ms(30);
     
     } // end for i = 0x00; i < n; i++
     
     delay_ms(250);

} // end void pulso_Saida
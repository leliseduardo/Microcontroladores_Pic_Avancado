/* 

   Esse programa, atrav�s do incremento externo do timer0, faz TMR0 incrementar 6 vezes para ocorrer a interrup��o.
   Ap�s clicar 6 vezes no bot�o o led muda de estado

*/

#define led1 RA0_bit

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       TMR0 = 250;
       
       led1 = ~led1;
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0xB8; // Desabilita os pull-up internos, configura o incremento do tmr0 pelo pino RA4, quando houver uma transi��o
                        // de High para Low, configura para usar o prescaler do WTD e o configura para 1:1
     INTCON = 0xA0;  // Habilita a interrup��o global, desabilita a interrup��o por perifericos e ativa a interrup��o do timer0
     TMR0 = 250; // tmr0 come�a a contagem em 250, logo, s� conta at� 6, pois 256 - 250 = 6
     
     TRISA = 0xFE; // Ou 0b11111110, que configura apenas RA0 como sa�da digital
     led1 = 0x00; // Inicia led1, que � RA0, em Low
     
     while(1){
     
       //
     }
}
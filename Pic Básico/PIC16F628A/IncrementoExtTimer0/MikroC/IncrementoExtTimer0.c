/* 

   Esse programa, através do incremento externo do timer0, faz TMR0 incrementar 6 vezes para ocorrer a interrupção.
   Após clicar 6 vezes no botão o led muda de estado

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
     OPTION_REG = 0xB8; // Desabilita os pull-up internos, configura o incremento do tmr0 pelo pino RA4, quando houver uma transição
                        // de High para Low, configura para usar o prescaler do WTD e o configura para 1:1
     INTCON = 0xA0;  // Habilita a interrupção global, desabilita a interrupção por perifericos e ativa a interrupção do timer0
     TMR0 = 250; // tmr0 começa a contagem em 250, logo, só conta até 6, pois 256 - 250 = 6
     
     TRISA = 0xFE; // Ou 0b11111110, que configura apenas RA0 como saída digital
     led1 = 0x00; // Inicia led1, que é RA0, em Low
     
     while(1){
     
       //
     }
}
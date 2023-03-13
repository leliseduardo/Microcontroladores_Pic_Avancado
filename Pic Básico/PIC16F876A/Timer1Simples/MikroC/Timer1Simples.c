/*

  Ciclo de máquina = 1/(16000/4) = 1/4MHz = 250ns
  
  Overflow = ciclo de máquina * prescaler * contador timer 1
  contador do timer 1 tem 16 bits = 65536
  Overflow = 250ns * 1 * 65536 = 16.3ms

*/


void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     T1CON = 0x01; // Ativa o timer 1 e configura o prescaler como 1:1
     TMR1L = 0x00; // Inicia a contagem do timer 1 em 0
     TMR1H = 0x00;
     
     TRISC = 0xEF; // Ou 0b11101111, que configura apensa RC4 como saída digital
     RC4_bit = 0x00;
     
     while(1){
     
       if(TMR1IF_bit){
       
         TMR1IF_bit = 0x00;
         
         RC4_bit = ~RC4_bit;
       }
     }
}
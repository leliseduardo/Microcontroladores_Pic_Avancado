#define S1 RA0_bit
#define S2 RA1_bit
#define Led1 RA3_bit
#define Led2 RA2_bit


void main() {

     CMCON = 7;
     TRISA = 3; // ou 0b00000011, número 3 em binário. Bits menos significativos iguais a 1 pois S1 e S2 são inputs
     PORTA = 3; // Pois S1 e S2 são ativados quando se joga nível 0 neles

     while(1){
       if(S1 == 0){
         while(1){
           Led1 = 0;
           Led2 = 1;
           delay_ms(500);
           Led1 = 1;
           Led2 = 0;
           delay_ms(500);
         }
       }

       if(S2 == 0){
        while(1){
          Led1 = 1;
          Led2 = 1;
          delay_ms(500);
          Led1 = 0;
          Led2 = 0;
          delay_ms(500);
        }
       }
     }



}
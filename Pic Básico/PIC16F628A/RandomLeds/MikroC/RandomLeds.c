#define s1 RA0_bit
#define s2 RA1_bit
#define led1 RA3_bit
#define led2 RA2_bit

int numbers;

void main() {

     CMCON = 7;
     TRISA = 3; // ou 0b00000011, pois s1 e s2 são inputs
     PORTA = 3; // ou 0b00000011, pois s1 e s2 são ativadas com nível 0
     
     while(1){
     
       numbers = rand();
       
       led1 = numbers;
       led2 = ~led1;
       
       while(led1 == 1){
         if(s1 == 0)
           led1 = 0;
           
         delay_ms(70);
       }
       
       while(led2 == 1){
         if(s2 == 0)
           led2 = 0;
           
         delay_ms(70);
       }
       
       delay_ms(500);
     
     }

}
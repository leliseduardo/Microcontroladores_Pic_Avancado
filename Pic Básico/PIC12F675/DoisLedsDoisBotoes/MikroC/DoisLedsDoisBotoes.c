#define S1 GPIO.F0
#define S2 GPIO.F1
#define D1 GPIO.F4
#define D2 GPIO.F5

void main() {

     ANSEL = 0;
     CMCON = 7;

     TRISIO0_bit = 1;
     TRISIO1_bit = 1;
     TRISIO4_bit = 0;
     TRISIO5_bit = 0;

     S1 = 1;
     S2 = 1;
     D1 = 0;
     D2 = 0;
     
     while(1){
     
       if(S1 == 0){
         D1 = ~D1;
         delay_ms(300);
       }
       
       if(S2 == 0){
         D2 = ~D2;
         delay_ms(300);
       }
     
     }
}
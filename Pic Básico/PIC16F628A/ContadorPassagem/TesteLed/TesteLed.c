#define led RA1_bit

void main() {

     CMCON = 0x07;
     TRISA = 0x00;
     TRISB = 0xFF;
     PORTA = 0x00;
     PORTB = 0xFF;
     
     while(1){
     
       unsigned long int i = 0;

         while(i < 7000){
           led = 0x01;
           delay_us(14);
           led = 0x00;
           delay_us(14);
           i++;
         }

         i = 0;
         
         delay_ms(200);
     }

}
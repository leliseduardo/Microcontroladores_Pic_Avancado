
int control = 0b11111111; // ou 0xFF ou 255

void main() {

     TRISB = 0;
     PORTB = 0b11111111; // ou 0xFF ou 255
     
     while(1){
     
       PORTB = control;
       
       control = control << 1;
       delay_ms(200);
       
       if(control == 0)
         control = 0b11111111; // ou 0xFF ou 255
     
     }

}
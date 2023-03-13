
int leituraADC = 0;
bit control;

void main() {

     ANSEL = 1; // Ou 0b00000001 Seleciona AN0 como entrada analógica
     ADCON0 = 1; // Ou 0b00000001 Habilita a entrada AN0
     CMCON = 7;
     TRISIO4_bit = 0;
     TRISIO5_bit = 0;
     GPIO = 0;
     control = 0x00;

     while(1){
     
     leituraADC = adc_read(0);

     if(leituraADC < 700){
      
       control = ~control;
      
      
       delay_ms(1000);

      }

      if(control){

         GPIO.F4 = ~GPIO.F4;
         GPIO.F5 = ~GPIO.F5;

       }
       else
         GPIO = 0x00;

    }
 
}
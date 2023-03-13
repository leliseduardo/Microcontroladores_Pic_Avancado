#define led1 GPIO.F5
#define led2 GPIO.F4
#define led3 GPIO.F2
#define led4 GPIO.F1

int leituraADC = 0;

void main() {

     ANSEL = 1; // Ou 0b00000001 Seleciona AN0 como entrada analógica
     ADCON0 = 1; // Ou 0b00000001 Habilita a entrada AN0
     CMCON = 7;
     
     TRISIO = 1; // Ou 0b00000001 Habilita GP0 como entrada
     GPIO = 0; // Ou 0x00000000 Inicia todos em low
     
     while(1){
       leituraADC = ADC_Read(0);
       
       if(leituraADC > 0){
         led1 = 0;
         led2 = 0;
         led3 = 0;
         led4 = 0;
       }
       
       if(leituraADC > 204){
         led1 = 1;
         led2 = 0;
         led3 = 0;
         led4 = 0;
       }
       
       if(leituraADC > 408){
         led1 = 1;
         led2 = 1;
         led3 = 0;
         led4 = 0;
       }
       
       if(leituraADC > 612){
         led1 = 1;
         led2 = 1;
         led3 = 1;
         led4 = 0;
       }
       
       if(leituraADC > 816){
         led1 = 1;
         led2 = 1;
         led3 = 1;
         led4 = 1;
       }
       
       delay_ms(100); // Taxa de atualização do ADC
     }
     

}
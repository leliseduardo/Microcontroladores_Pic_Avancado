
int cont = 0;

void escreveDisplay(int num);

void interrupt(){

     if(INTF_bit){
     
       INTF_bit = 0x00;

       cont++;
       if(cont > 9)
         cont = 0;
         
       escreveDisplay(cont);
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     
     GIE_bit = 0x01; // Ativa a interrupção global
     PEIE_bit = 0x00; // Desativa a interrupção por periferios
     INTE_bit = 0x01; // Ativa a interrupção externa no pino RB0/INT
     INTEDG_bit = 0x01;// Interrupção por borda de subida
     
     TRISA = 0xFF; // Ou 0b00000010, que configura apenas RA1 como entrada digital
     TRISB = 0x01; // Configura apenas RB0 como entrada digital
     PORTA = 0xFF; // Inicia apenas RA1 em high
     PORTB = 0x7F; // Ou 0b01111111, inicia o portb de tal forma que apareça zero no display
     

     while(1){
     
       //
     }
}

void escreveDisplay(int num){

     int anodo[] = {0x7F, 0x0D, 0xB7, 0x9F, 0xCD, 0xDB, 0xF9, 0x0F, 0xFF, 0xCF};
     
     char aux;
     
     aux = anodo[num];
     
     PORTB = aux;
}
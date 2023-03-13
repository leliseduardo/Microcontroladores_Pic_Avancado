#define led RB0_bit

void interrupt(){

     if(CMIF_bit){
     
       CMIF_bit = 0x00;
       
       if(C1OUT_bit)
         led = 0x01;
       else
         led = 0x00;
     }
}

void main() {

     GIE_bit = 0x01; // Ativa a interrupção global
     PEIE_bit = 0x01; // Ativa a interrupção por periféricos
     CMIE_bit = 0x01; // Ativa os comparadores internos
     CMCON = 0x02; // Ativa os dois comparadores internos sem saída externa, apenas a mudança da flag C1OUT
     
     TRISA = 0x0F; // Configura o primeiro nibble como entrada digital, isto é, RA0, RA1, RA2 e RA3
     TRISB = 0xFE; // Configura apenas RB0 como saída digital
}

void interrupt(){

     if(CMIF_bit){
     
       CMIF_bit = 0x00;
     }
}

void main() {

     GIE_bit = 0x01; // Ativa a interrupção global
     PEIE_bit = 0x01; // Ativa a interrupção por periféricos
     CMIE_bit = 0x01; // Ativa os comparadores internos
     CMCON = 0x03; // Ativa os dois comparadores internos e configura suas saídas nos pinos RA4 e RA5
     
     TRISA = 0x0F; // Configura RA0, RA1, RA2 e RA3 como entradas digitais
}
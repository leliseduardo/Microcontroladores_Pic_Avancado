#define rele RB0_bit

void interrupt(){

     if(CMIF_bit){
     
       CMIF_bit = 0;
       
       if(!C1OUT_bit)
           rele = 0x01;
       else
           rele = 0x00;
     }
}

void main() {

     CMCON = 0x02; // Habilita os comparadores internos com tensão de referencia internas e tensao de saída interna
     VRCON = 0xBC; // Habilita referencia interna e configura a tensao interna para 2,5V
     INTCON = 0xC0; // Habilita a interrupção global e a interrupção por periféricos
     CMIE_bit = 0x01; // Flag do registrador PIE1, habilita a interrupção pelo comparador
     
     TRISA = 0xFF; // Configura todo porta como entrada digital
     TRISB = 0xFE; // Configura apenas RB0 como saída digital
     rele = 0x00;
     
     while(1){
     
       //Apenas aguarda a interrupção
     }
}
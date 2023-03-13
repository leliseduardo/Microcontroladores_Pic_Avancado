
void interrupt(){

  if(RBIF_bit){
    
    RBIF_bit = 0x00;
    
    RC4_bit = ~RC4_bit;
  }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     RBIE_bit = 0x01; // Habilita a interrup��o por mudan�a de estado do portb que, no caso, � apenas para o nibble mais significativo
     RBIF_bit = 0x00; // For�a a flag de interrup��o para 0, isto �, a flag que monitora a mudan�a de estado do portb � 0
     GIE_bit = 0x01; // Habilita a interrup��o global
     
     TRISB = 0xFF; // Todo portb como entrada
     TRISC = 0xEF; // Apenas RC4 como sa�da
     
     while(1){
     
       //
     }
}

void interrupt(){

  if(RBIF_bit){
    
    RBIF_bit = 0x00;
    
    RC4_bit = ~RC4_bit;
  }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     RBIE_bit = 0x01; // Habilita a interrupção por mudança de estado do portb que, no caso, é apenas para o nibble mais significativo
     RBIF_bit = 0x00; // Força a flag de interrupção para 0, isto é, a flag que monitora a mudança de estado do portb é 0
     GIE_bit = 0x01; // Habilita a interrupção global
     
     TRISB = 0xFF; // Todo portb como entrada
     TRISC = 0xEF; // Apenas RC4 como saída
     
     while(1){
     
       //
     }
}
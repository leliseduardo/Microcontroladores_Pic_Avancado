

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     TRISA = 0xFF; // Todo porta como entrada digital, mesmo sendo um conversor DA RA2 é configurado como entrada
     
     VRCON = 0xE7; // O valor máximo para o conversor DA é de 3,1V, mas nesse prog não vai ser utilizada essa tensão
                   // para VRCON = 0xE7, VRef = 1,45V
                   
      while(1){
      
        VRCON = 0xE7;
        delay_ms(50);
        VRCON = 0xE6;
        delay_ms(50);
        VRCON = 0xE5;
        delay_ms(50);
        VRCON = 0xE4;
        delay_ms(50);
        VRCON = 0xE3;
        delay_ms(50);
        VRCON = 0xE2;
        delay_ms(50);
        VRCON = 0xE1;
        delay_ms(50);
      }
}
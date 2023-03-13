void main() {
     
     
unsigned char anodo, cont = 0x00; // numero 0 em hexa
unsigned char numero[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0xFF,0x6F}; //Numeros de 0 a 9 no display, representados em hexa

CMCON = 0x07; // ou 0b00000111
TRISB = 0X00; // ou 0b00000000, seleciona o portb todo como saída
PORTB = 0X00; // inicia todo o portb com nível baixo

      while(1){

        anodo = numero[cont];
        
        PORTB = anodo;
        
        cont++;
        if(cont == 10)
          cont = 0;
          
        delay_ms(1000);

      } //end while

}
/* 

   Este programa, assim como o "ADC Simples", utiliza a convers�o AD. Agora, pegando RC0 e RC1, utiliza-se com mais precis�o o ADC.
   A fun��o deste programa � fazer uma barra de n�vel com leds, onde os leds s�o postos na vertical e, quanto maior a tens�o no ADC,
   mais alto � o n�vel na barra, isto �, quanto maior a tens�o no ADC mais leds acender�o de baixo para cima.

*/

void main() {

     ADCON0 = 0x01; // Configura AN0 como canal anal�gico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura os limites de tens�o como os limites da fonte (VSS � VDD) e configura apenas AN0 como anal�gica e o
                    // resto dos pinos que poderiam ser anal�gicos s�o configurados como digitais
     
     TRISA = 0xFF; // Configura todo porta como entrada
     TRISB = 0x00; // Configura todo portb como sa�da
     TRISC = 0xFC; // Configura apensa RC0 e RC1 como sa�da
     LATB = 0x00; // Inicia todo portb em Low
     LATC = 0x00; // Inicia RC0 e RC1 em Low
     
     while(1){ // Loop infinito
     
       switch(ADC_Read(0)){
       
         case 0: LATB = 0b00000000; LATC = 0x00; break;
         case 100: LATB = 0b00000001; LATC = 0x00; break;
         case 200: LATB = 0b00000011; LATC = 0x00; break;
         case 300: LATB = 0b00000111; LATC = 0x00; break;
         case 400: LATB = 0b00001111; LATC = 0x00; break;
         case 500: LATB = 0b00011111; LATC = 0x00; break;
         case 600: LATB = 0b00111111; LATC = 0x00; break;
         case 700: LATB = 0b01111111; LATC = 0x00; break;
         case 800: LATB = 0b11111111; LATC = 0x00; break;
         case 900: LATB = 0b11111111; LATC = 0x01; break;
         case 1000: LATB = 0b11111111; LATC = 0x03; break;
       } // end switch
     } // end loop
}
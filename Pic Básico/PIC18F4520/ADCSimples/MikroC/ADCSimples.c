/* 

   Neste código é introduzido o modo de uso do conversor AD do pic de forma simples e introdutória. Nele os registradores do conversor
   AD são programados para o uso de simples conversão.
   Ainda, o conversor é programado entre os intervalos de tensão da fonte (VSS até VDD) e, a medida que a tensão na porta analógica
   aumenta, os pinos do portb vão incrementando numa contagem binária.

*/

void main() {

     INTCON2 = 0x7F; // Ou 0b0111 1111, habilita os pull-ups internos do portb
     ADCON0 = 0x01; // Configura AN0 como canal analógico e ativa o conversor AC
     ADCON1 = 0x0E; // Configura o intervalo de tensão analógica igual ao da fonte (VSS até VDD) e configura apenas AN0 como porta
                    // analógica. As outras portas que poderiam ser analogicas são configuradas como portas digitais
     TRISA = 0xFF; // Configura todo porta como entrada. Para uma porta analógica funcionar, ela deve ser conf. como entrada
     TRISB = 0x00; // Configura todo portb como saída digital
     LATB = 0x00; // Inicia todo o portb em Low
     
     while(1){
     
        LATB = ADC_Read(0);
     } // end while
} // end void main
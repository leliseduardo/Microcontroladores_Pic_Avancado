/* 

   Neste c�digo � introduzido o modo de uso do conversor AD do pic de forma simples e introdut�ria. Nele os registradores do conversor
   AD s�o programados para o uso de simples convers�o.
   Ainda, o conversor � programado entre os intervalos de tens�o da fonte (VSS at� VDD) e, a medida que a tens�o na porta anal�gica
   aumenta, os pinos do portb v�o incrementando numa contagem bin�ria.

*/

void main() {

     INTCON2 = 0x7F; // Ou 0b0111 1111, habilita os pull-ups internos do portb
     ADCON0 = 0x01; // Configura AN0 como canal anal�gico e ativa o conversor AC
     ADCON1 = 0x0E; // Configura o intervalo de tens�o anal�gica igual ao da fonte (VSS at� VDD) e configura apenas AN0 como porta
                    // anal�gica. As outras portas que poderiam ser analogicas s�o configuradas como portas digitais
     TRISA = 0xFF; // Configura todo porta como entrada. Para uma porta anal�gica funcionar, ela deve ser conf. como entrada
     TRISB = 0x00; // Configura todo portb como sa�da digital
     LATB = 0x00; // Inicia todo o portb em Low
     
     while(1){
     
        LATB = ADC_Read(0);
     } // end while
} // end void main
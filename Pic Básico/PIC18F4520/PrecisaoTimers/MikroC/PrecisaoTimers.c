/* 

        O objetivo deste programa é mostrar uma forma de se obter mais precisão dos timers do Pic. Para isso, uma solução via hardware será feita,
     porém, a explicação de como este hardware diminui o erro não será aqui explicada, pois tem na vídeo aula 118 no curso de Pic básico/Inter-
     mediário. Como tenho esse vídeo salvo, não farei as explicações aqui, uma vez que essa aplicação é muito específica e dificilmente irei
     utiliza-la.
        Ainda sim, é importante conhecer esta técnica para ver como a programação pode ser versátil na resolução de programas.

        Na simulação do proteus funcionou perfeitamente, mas sem um osciloscópio não tem porque fazer na prática. A explicação e demonstração dadas
     pelo professor são suficientes.
     
*/

// Configuração de hardware
#define Led LATB0_bit

// Variáveis auxiliares
signed long cont = 15625;

// Função de interrupção
void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       
       cont -= 256;
       
       if(cont <= 0){
       
         cont += 15625;
         
         Led = ~Led;
       
       } // end if cont <=0
     
     } // end if TMR0IF_bit

} // end void interrupt

void main() {

     // Configuração de registradores
     
     INTCON = 0xA0; // Habilita a interrupção global e a interrupção por overflow do timer0
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x01; // Configura o timer0 com 8 bits
     T0CS_bit = 0x00; // Configura o incremento do timer0 com o ciclo de máquina
     PSA_bit = 0x00; // Associa o prescaler ao Timer0
     T0PS1_bit = 0x00; // Configura o prescaler como 1:64
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0_bit como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia as entradas digitais em High
     Led = 0x00; // Inicia LATB0 em Low
     
     while(1); // Loop infinito apenas aguarda a interrupção

}







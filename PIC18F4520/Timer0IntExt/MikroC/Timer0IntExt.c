/* 

        Este programa tem a fun��o de demonstrar o funcionamento da interrup��o externa juntamente com a interrup��o do timer0 configurado
    como de 16 bits. Ainda n�o � utilizada prioridade alta e baixa em nenhuma interrup��o. Desta forma, a prioridade das interrup��es �
    relativa, assim como na fam�lia 12F e 16F.
        A prioridade relativa faz com que as interrup��es ocorram de forma sequ�ncial, isto �, na ordem em que foram escritas no programa.
    Caso a flag da interrup��o que foi escrita por �ltimo seja verdadeira, ela n�o interrompe a interrup��o que foi escrita primeiro, ela
    simplesmente espera a primeira interrup��o concluir para que haja sua interrup��o. Como exemplo, neste programa a interrup��o interna
    foi programada por �ltimo e h� a interrup��o externa quando o sinal externo tem uma borda de subida. Caso o programa esteja executando
    a interrup��o do timer0 e haja uma borda de subida na interrup��o externa, a interrup��o externa espera a execu��o da interrup��o do
    timer0 para que ela possa executar.
       Caso houvesse prioridade alta na interrup��o externa, por exemplo, ela iria interromper a interrup��o do timer0, parando a execu��o
    onde est�, executar a rotina de interrup��o externa e depois voltar para a interrup��odo timer0 de onde parou.
       Esta � a grande diferen�a entre prioridade alta e baixa de interru��o e prioridade relativa.

       Neste programa o timer0 ir� contar at� 50.000, na configura��o de 16 bits. O c�lculo para iniciar sua contagem �:

        2^16 = 65536 - 50000 = 15536
        15536 (decimal) = 0x3CB0 (hexadecimal)

        TMR0L = 0xB0
        TMR1H = 0x3C

        O c�lculo de overflow do timer0 �:

        Overflow = (65536 - <TMR0L::TMR0H>) * Prescaler * Ciclo de m�quina
        Overflow = (65536 - 15536) * Prescaler * Ciclo de m�quina
        Overflow = 50000 * 1 * 1us (4MHz)
        Overflow = 50ms
       
*/

// Configura��o de hardware
#define outInt1 LATB6_bit
#define outT0 LATB7_bit

// Vari�veis auxiliares
short cont = 0x00;

// Fun��o de interrup��o
void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xB0;
       TMR0H = 0x3C;
       
       cont++;
       
       if(cont == 0x0A){
       
         cont = 0x00;
         
         outT0 = ~outT0;
       } // end if
     } // end if
     
     if(INT1IF_bit){
     
       INT1IF_bit = 0x00;
       
       outInt1 = ~outInt1;
     }
     
} // end void interrupt

void main() {

     //Configura��o de registradores
     // Registrador INTCON
     INTCON = 0xA0; // Habilita a interrup��o global e habilita a interrup��o por overflow do timer0
     
     //Registrador INTCON2
     INTEDG1_bit = 0x01; // Configura a interrup��o externa INT1 por borda de subida
     
     // Registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrup��o externa INT1
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o timer0 para incrementar a partir do ciclo de m�quina
     PSA_bit = 0x01; // N�o associa o prescaler ao timer0, isto �, o timer0 fica sem prescaler, o que equivale a 1:1
    
     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para uma contagem de 50000
     TMR0H = 0x3C;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0x3F; // Ou 0b00111111, que configura LATB6 e LATB7 como sa�das digitais e o resto como entrada
     outInt1 = 0x00; // Inicia LATB6 em Low
     outT0 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrup��o
     } // end while
} // end void main

























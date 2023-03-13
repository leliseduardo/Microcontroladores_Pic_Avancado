/* 

        Este programa tem a função de demonstrar o funcionamento da interrupção externa juntamente com a interrupção do timer0 configurado
    como de 16 bits. Ainda não é utilizada prioridade alta e baixa em nenhuma interrupção. Desta forma, a prioridade das interrupções é
    relativa, assim como na família 12F e 16F.
        A prioridade relativa faz com que as interrupções ocorram de forma sequêncial, isto é, na ordem em que foram escritas no programa.
    Caso a flag da interrupção que foi escrita por último seja verdadeira, ela não interrompe a interrupção que foi escrita primeiro, ela
    simplesmente espera a primeira interrupção concluir para que haja sua interrupção. Como exemplo, neste programa a interrupção interna
    foi programada por último e há a interrupção externa quando o sinal externo tem uma borda de subida. Caso o programa esteja executando
    a interrupção do timer0 e haja uma borda de subida na interrupção externa, a interrupção externa espera a execução da interrupção do
    timer0 para que ela possa executar.
       Caso houvesse prioridade alta na interrupção externa, por exemplo, ela iria interromper a interrupção do timer0, parando a execução
    onde está, executar a rotina de interrupção externa e depois voltar para a interrupçãodo timer0 de onde parou.
       Esta é a grande diferença entre prioridade alta e baixa de interrução e prioridade relativa.

       Neste programa o timer0 irá contar até 50.000, na configuração de 16 bits. O cálculo para iniciar sua contagem é:

        2^16 = 65536 - 50000 = 15536
        15536 (decimal) = 0x3CB0 (hexadecimal)

        TMR0L = 0xB0
        TMR1H = 0x3C

        O cálculo de overflow do timer0 é:

        Overflow = (65536 - <TMR0L::TMR0H>) * Prescaler * Ciclo de máquina
        Overflow = (65536 - 15536) * Prescaler * Ciclo de máquina
        Overflow = 50000 * 1 * 1us (4MHz)
        Overflow = 50ms
       
*/

// Configuração de hardware
#define outInt1 LATB6_bit
#define outT0 LATB7_bit

// Variáveis auxiliares
short cont = 0x00;

// Função de interrupção
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

     //Configuração de registradores
     // Registrador INTCON
     INTCON = 0xA0; // Habilita a interrupção global e habilita a interrupção por overflow do timer0
     
     //Registrador INTCON2
     INTEDG1_bit = 0x01; // Configura a interrupção externa INT1 por borda de subida
     
     // Registrador INTCON3
     INT1IE_bit = 0x01; // Habilita a interrupção externa INT1
     
     // Registrador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Configura o timer0 para incrementar a partir do ciclo de máquina
     PSA_bit = 0x01; // Não associa o prescaler ao timer0, isto é, o timer0 fica sem prescaler, o que equivale a 1:1
    
     // Resitradores <TMR0H::TMR0L>
     TMR0L = 0xB0; // Inicia a contagem do timer0 em 15536, para uma contagem de 50000
     TMR0H = 0x3C;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0x3F; // Ou 0b00111111, que configura LATB6 e LATB7 como saídas digitais e o resto como entrada
     outInt1 = 0x00; // Inicia LATB6 em Low
     outT0 = 0x00; // Inicia LATB7 em Low
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrupção
     } // end while
} // end void main

























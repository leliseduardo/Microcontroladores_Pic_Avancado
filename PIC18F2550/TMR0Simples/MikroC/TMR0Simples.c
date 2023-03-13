/* 

        O objetivo deste programa é finalmente entrar na interrupções. Para isso, utiliza-se o timer0 para fazer uma simples interrupção. Como
    função de interrupção o programa irá simplesmente alterar o estado da saída LATB0.
        Este programa, na aula, é feito em Assembly e serve apenas para demonstrar o fluxo do programa quando há uma interrupção e, ainda, demons-
    trar como funcionam os fluxos de interrupção programados em Assembly e os novos comandos para a família 18F.
        Porém, usarei este programa para relembrar a configuração do timer0 com interrupção simples e já ir exercitando a programação desta
    poderosa ferramenta.
    
    ******************** Timer 0 ***********************************************
    
    ciclo de máquina = 250ns
    TMR0L = 0xEE = 238
    
    Overflow = (256 - TMR0L) * prescale * ciclo de maquina
    Overflow = (256 - 238) * 2 * 250ns
    Overflow = 18 * 2 * 250ns
    Overflow = 9us
    
    ****************************************************************************

*/

// Mapeamento de hardware
#define out LATB0_bit

// Função de interrupção
void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xEE;
       
       out = ~out;
     
     } // end TMR0IF_bit

} // end void interrupt

void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser digitais como analógicos
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     out = 0x01; // Inicia LATB0 em Low
     
     INTCON = 0xA0; // Habilita a interrupção global e a interrupção por overflow do timer0
     
     T0CON = 0xC0; // Habilita o timer0, configura com 8 bits, incrementa com ciclo de máquina e prescaler 1:2
     TMR0L = 0xEE;
     
     // Loop infinito
     while(1){
     
       // Apenas aguarda a interrupção
     
     } // end loop infinito

} // end void main

















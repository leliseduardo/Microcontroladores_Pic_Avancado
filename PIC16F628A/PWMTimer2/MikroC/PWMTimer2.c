// Mapeamento de hardware

#define s1 RA0_bit
#define s2 RA1_bit
#define led RB3_bit


// Função de interrupção

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0;
       TMR0 = 0x6C;
     
       if(!s1)
         CCPR1L++;
       
       if(!s2)
         CCPR1L--;
     }

}

void main() {

     // Configuração de registradores
     
     // Ports
     CMCON = 0x07; // Desabilita os comparadores internos
     TRISA = 0x03; // Configura RA0 e RA1 como entradas digitais
     PORTA = 0x03; // Inicia RA0 e RA1 em nível lógico alto
     TRISB = 0x00; // Configura todo o portb como saída digital
     PORTB = 0x00; // Inicia todo o portb em nível lógico baixo
     
     // Timers
     OPTION_REG = 0x86; // Desliga pull-up interno e configura o prescaler em 1:128
     GIE_bit = 0x01;  //  Ativa a interrupção global
     PEIE_bit = 0x01; // Ativa a interrupção por periferico externo
     T0IE_bit = 0x01; // Ativa o timer0
     TMR0 = 0x6C; // Inicia a contagem do timer0 em 0x6C
     
     T2CON = 0x06; // Ativa o timer2 e configura o postscaler para 1:1 e o prescaler para 1:16
     PR2 = 0xFF; // Faz o TMR2 contar até 0xFF
     
     // periodo = (PR2 + 1) x ciclo da máquina x prescaler do timer2, de acordo com o datasheet
     // ciclo de maquina = (1 / (frequencia de clock / 4)), nesse caso, 1 / (4000000/4) = 0,000001 s
     // periodo = 256 x 1u x 16 = 4,09ms
     // frequencia = 1/periodo = 244,14Hz Essa frequencia é a frequencia do timer2, que vai ser usada como PWM, então, é a freq do PWM
     
     // PWM
     CCPR1L = 0x00; // Inicia esse registrador, de 8 bits, em 0x00. Ele é responsável por 8 dos 10 bits do PWM. Ou seja, o led inicia apagado
     CCP1CON = 0x0C; // Ativa o modo PWM
     
     // Nesse codigo usa-se apenas 8, dos 10 bits do PWM. Quando maior a resolução do PWM, isto é, quanto mais bits tem o registrador do PWM,
     // maior é a resolução do duty cicle, isto é, maior é a resolução do nível alto do PWM. Logo, consegue-se maior precisão na curva de tensão
     // que se deseja com o PWM. A saída vai de 0 a 5 V com intervalos menores.
     
     // Loop infinito
     
     while(1){
     
              //
     
     }

}
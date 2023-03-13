
// função interrupção

void interrupt(){
     if(TMR2IF_bit){ // Verifica se houve o overflow no timer2
       TMR2IF_bit = 0x00;
       
       PORTB = ~PORTB;
     }
}

void main() {

     // Configuração de registradores

     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x01; // Habilita a interrupção por periféricos externos
     TMR2IE_bit = 0x01; // Habilita a interrupção do timer2 com PR2, número máximo que o contador do timer2 irá contar
     T2CON = 0b00011101; // Habilita o timer2, configura o postscaler como 1:4 e o prescaler como 1:4
                         // 0b 0 (nao definido) 0000 (postscaler = 1:1) 1 ( timer1 ON) 00 (prescaler = 1:1)
     PR2 = 100; // Faz PR2 = 100, isto é, faz o contador do timer2 contar até 100
     
     TRISB = 0x00; // Todo portb como saída digital
     PORTB = 0x00; // Todo portb inicia com nivel logico 0
     
     // Loop infinito
     
     while(1){
     
              // Loop infinito
     
     }
}
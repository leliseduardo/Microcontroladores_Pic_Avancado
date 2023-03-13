
// fun��o interrup��o

void interrupt(){
     if(TMR2IF_bit){ // Verifica se houve o overflow no timer2
       TMR2IF_bit = 0x00;
       
       PORTB = ~PORTB;
     }
}

void main() {

     // Configura��o de registradores

     GIE_bit = 0x01; // Habilita a interrup��o global
     PEIE_bit = 0x01; // Habilita a interrup��o por perif�ricos externos
     TMR2IE_bit = 0x01; // Habilita a interrup��o do timer2 com PR2, n�mero m�ximo que o contador do timer2 ir� contar
     T2CON = 0b00011101; // Habilita o timer2, configura o postscaler como 1:4 e o prescaler como 1:4
                         // 0b 0 (nao definido) 0000 (postscaler = 1:1) 1 ( timer1 ON) 00 (prescaler = 1:1)
     PR2 = 100; // Faz PR2 = 100, isto �, faz o contador do timer2 contar at� 100
     
     TRISB = 0x00; // Todo portb como sa�da digital
     PORTB = 0x00; // Todo portb inicia com nivel logico 0
     
     // Loop infinito
     
     while(1){
     
              // Loop infinito
     
     }
}
/* 

   ciclo de maquina = 1 /(16MHz / 4) = 250ns

   tempo de overflow = ciclo de maquina x precaler x TRM1H::TMR1L
   
   ciclo de maquina = 250ns
   prescaler = 8
   tempo de overflow = 2ms;
   
   TMR1h::TMR1L = tempo de overflow / (ciclo de maquina x prescaler) = 1000
   
   Como TRM1H::TMR1L = 2^(16) = 65536
   
   Logo, a contagem deve começar em 65536 - 1000 = 64536, para que o contador do timer1 conte só até 1000
   
   Se a contagem começa em 64536, basta converter esse valor para hexa, que fica FC18
   
   Assim:
   
   TMR1L = 0x18
   TMR1H = 0xFC

*/

char aux = 0x00;

void interrupt(){
     if(TMR1IF_bit){
     
       TMR1IF_bit = 0x00; // Zera a variável de interrupção(overflow)
       TMR1L = 0x18; // Reinicia a contagem do contador do timer1 em 64536
       TMR1H = 0xFC;
       
       RC4_bit = 0x00;
       
       aux++;
       
       if(aux == 50){
         
         aux = 0x00;
         
         RC4_bit = 0x01;
         RC5_bit = ~RC5_bit;
       }
     }
}

void main() {

     CMCON = 0x07;  // Desativa os comparadores internos
     T1CON = 0x31;  // Ou 0b00110001, que configura o prescaler em 1:8 e habilita o timer 1
     TMR1L = 0x18;  // Inicia o contador do timer1 em 64536, para que o timer1 (de 16 bits), conte até 1000 somente
     TMR1H = 0xFC;
     
     GIE_bit = 0x01; // Habilita a interrupção global;
     PEIE_bit = 0x01; // Habilita a interrupção por periféricos
     TMR1IE_bit = 0x01; // Habilita a interrupção por overflow do timer1
     
     TRISC = 0xCF; // Ou 0b11001111, que configura apenas RC4 e RC5 como saídas digitais
     RC4_bit = 0x00; // RC4 inicia em low
     RC5_bit = 0x00; // RC5 inicia em low

}
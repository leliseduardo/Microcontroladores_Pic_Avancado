

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     T1CON = 0x31; // Ou 0b00110001, que configura o prescaler em 1:8 e ativa o timer1
     TMR1L = 0x00; // Inicia o contador do timer1 em 0
     TMR1H = 0x00;
     
     // CCP1CON = 0x08; // Ou 0b00001000, que configura o modo comparador para setar RC2 na comparação
     CCP1CON = 0x0B; // Ou 0b00001011, que configura o modo comparador como gatilho especial, reiniciando o contador do timer1
     CCPR1L = 0xFF;  // Inicia o registrador do modo comparador em 0xFFFF;
     CCPR1H = 0xFF;
     
     TRISC = 0xFA; // Ou 0x11111010, que configura apenas RC0 e RC2 como saída digital
     RC2_bit = 0x00; // Inicia RC2 em Low
     RC0_bit = 0x00; // Inicia RC0 em Low
     
     /* 
     
        O tempo para o contador do timer1 chegar ao numero iniciado no registrador do modo de comparação (CCPR1H::CCPR1L), é
        o tempo que o programa demora para incrementar o contador até aquele número.
        
        Tempo de comparação = Ciclo de maquina x prescaler x (CCPR1H::CCPR1L)
        
        Tempo de comparação = 250ns x 8 x 65536 = 131us
     
     */
     
     while(1){
     
       if(CCP1IF_bit){
       
         CCP1IF_bit = 0x00;
         
         RC0_bit = ~RC0_bit;
       }
     }

}
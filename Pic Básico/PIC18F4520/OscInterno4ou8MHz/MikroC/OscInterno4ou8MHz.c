/* 

   Este programa tem a função de alterar o oscilador interno em tempo real, a partir do clique de um botão. O pic começa com o oscilador
   interno em 8MHz e, ao clicar no botâo, ele altera para 4MHz, alterando a frequencia de acionamento do led.

*/

// Configuração do hardware

#define led LATB0_bit
#define bot RB1_bit

// Fungão auxiliar

void osc();

void main() {

     ADCON1 = 0x0F; // Configura todas as portas que podem ser analógicas, como digitais
     INTCON2 = 0x7F; // Habilita os pull-ups internos do portb
     OSCCON = 0x70; // Ou 0b0111 0000, configura o oscilador interno para 8MHz
     
     TRISB = 0xFE; // Configura apenas RB0 como saída digital
     
     led = 0x00;
     
     while(1){
     
       led = 0x01;
       osc();
       led = 0x00;
       osc();
     }
}

void osc(){

     unsigned char i, j;
     
     for(i = 255; i; i--){
     
       if(!bot) IRCF0_bit = ~IRCF0_bit; // Caso o botao seja pressionado, o registrador OSCCON muda de 0x70 para 0x60, mas isso é feito
                                    // apenas alterando a flag IRCF0, deste registrador. Ex: 0b0111 0000(8MHZ) muda para 0b0110 0000(4MHZ)
                                    // Mudando OSCCON para 0x60, o oscilador interno é configurado para 4MHz
     
       for(j = 255; j; j--);
     }
}













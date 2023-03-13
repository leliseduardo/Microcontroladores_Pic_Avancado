#define s1 RA0_bit
#define s2 RA1_bit
#define led1 RA2_bit
#define led2 RA3_bit

void interrupt(){ // timer com tempo de estouro = (1 / (4MHz/4))*(256 - 108)*128 = 18,9ms, sendo f = 4MHz, TMR0 = 0x6C = 108 e prescaler = 1:128
     if(T0IF){
     
              T0IF_bit = 0x00; // Faz a variavel de estouro ser igual a zero, isto é, diz que ainda não houve estouro
              
              TMR0 = 0x6C; // Inicia novamente o contador timer0 em 0x6C
     
              if(s1 == 0)
                    led1 = 0x01;

              if(s2 == 0)
                    led1 = 0x00;
     }
}

void main() {

     OPTION_REG = 0X86; // Desabilita os pull-ups internos do PORTB e seleciona o prescaler em 1:128
     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x01; // Habilita a interrupção por perifericos
     T0IE_bit = 0x01; // Habilita a interrupção por estouro do timer0
     
     TMR0 = 0x6C; // Inicia a contagem do timer0 em 0x6C = 0b0110 1100 = 108(decimal)

     CMCON = 0x07;
     TRISA = 0x03;
     PORTA = 0x03;

     while(1){

              led2 = 0x01;
              delay_ms(500);
              led2 = 0x00;
              delay_ms(500);
     }
}
// Configura��o de hardware

#define ledAmarelo RA0_bit
#define ledAzul RA1_bit

// Vari�veis globais

bit control;

// Func��o de interrup��o

void interrupt(){

     if(INTF_bit){
       
       INTF_bit = 0x00;
       
       control = ~control;

       ledAzul = control;
       delay_ms(100);
     }
}

void main() {

     // Configura��o de registradores

     CMCON = 0x07; // Desabilita os comparadores internos
     
     GIE_bit = 0x01; // Habilita a interrup��o global
     PEIE_bit = 0x00; // Desabilita a interrup��o por perif�ricos
     INTE_bit = 0x01; // Habilita a interrup��o externa no pino RB0/INT
     INTEDG_bit = 0x00; // Habilita a interrup��o externa em borda de descida, isto �, quando o bot�o em RB0 descer de 5v para 0v
     
     TRISA = 0xFC; // Ou 0b11111100, que configura apenas RA0 e RA1 como sa�das digitais, o resto como entrada
     TRISB = 0xFF; // Ou 0b11111111, que configura todo portb como entrada digital
     PORTA = 0xFC; // Ou 0b11111100, que inicia apenas RA0 e RA1 cem Low, o resto em High
     PORTB = 0xFF; // Ou 0b11111111, que inicia todo o portb em High
     
     // Inicializa��o de var�veis
     
     control = 0x00;
     
     // Loop infinito
     
     while(1){

              ledAmarelo = 0x01;
              delay_ms(1000);
              ledAmarelo = 0x00;
              delay_ms(1000);
     }
}
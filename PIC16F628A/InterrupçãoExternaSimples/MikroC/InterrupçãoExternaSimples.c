// Configuração de hardware

#define ledAmarelo RA0_bit
#define ledAzul RA1_bit

// Variáveis globais

bit control;

// Funcção de interrupção

void interrupt(){

     if(INTF_bit){
       
       INTF_bit = 0x00;
       
       control = ~control;

       ledAzul = control;
       delay_ms(100);
     }
}

void main() {

     // Configuração de registradores

     CMCON = 0x07; // Desabilita os comparadores internos
     
     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x00; // Desabilita a interrupção por periféricos
     INTE_bit = 0x01; // Habilita a interrupção externa no pino RB0/INT
     INTEDG_bit = 0x00; // Habilita a interrupção externa em borda de descida, isto é, quando o botão em RB0 descer de 5v para 0v
     
     TRISA = 0xFC; // Ou 0b11111100, que configura apenas RA0 e RA1 como saídas digitais, o resto como entrada
     TRISB = 0xFF; // Ou 0b11111111, que configura todo portb como entrada digital
     PORTA = 0xFC; // Ou 0b11111100, que inicia apenas RA0 e RA1 cem Low, o resto em High
     PORTB = 0xFF; // Ou 0b11111111, que inicia todo o portb em High
     
     // Inicialização de varáveis
     
     control = 0x00;
     
     // Loop infinito
     
     while(1){

              ledAmarelo = 0x01;
              delay_ms(1000);
              ledAmarelo = 0x00;
              delay_ms(1000);
     }
}
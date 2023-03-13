#define led1 RA2_bit
#define led2 RA3_bit

bit control;

void interrupt(){

     if(INTF_bit){

       INTF_bit = 0x00;
       control = ~control;
       
       led2 = ~led2;
       
       if(control)
         asm sleep;
     }
     
     delay_ms(200);
}

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     OPTION_REG = 0x80; // Desativa os pull-ups internos e configura a interrupção externa por borda de descida
     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x00; // Desabilita a interrupção por periféricos
     INTE_bit = 0x01; // Habilita a interrupção externa no pino RB0/INT
     
     TRISA = 0xF3; // Configura apensa RA2 e RA3 como saídas digitais
     TRISB = 0xFF; // Configura todo portb como entrada digital
     
     RA2_bit = 0x00; // Inicia RA2 e RA3 em Low
     RA3_bit = 0x00;
     
     control = 0x00; // Inicializa a variável control em 0, ou nível lógico Low
     
     while(1){
     
       led1 = 0x01;
       delay_ms(500);
       led1 = 0x00;
       delay_ms(500);
     }
}
/*

        Programa teste para testar o projeto prático PicDuino. Este programa terá a função de acender o led1 quando o botao1 for pressionado e
     acender o led2 quando o botao2 for pressionado.
     
        Na prática, o circuito e o programa funcionaram perfeitamente.

*/

// Mapeamento de hardware
#define  botao1  RA0_bit
#define  botao2  RA1_bit
#define  led1    RA2_bit
#define  led2    RA3_bit

// Programa principal
void main() {

     CMCON = 0x07;                  // Desliga os comparadores internos
     TRISA = 0xF3;                  // Ou 0b11110011, configura apenas RA2 e RA3 como saídas digitais
     TRISB = 0xFF;                  // Configura todo portb como entrada digital
     led1  = 0x00;                  // Inicia led1 em Low
     led2  = 0x00;                  // Inicia led2 em Low
     
// Loop infinito
     while(1){

       if(!botao1)                  // Testa se botao1 está pressionado
         led1 = 0x01;               // Se estiver, acende led1
       else
         led1 = 0x00;               // Se não estiver, apaga led1
         
       if(!botao2)                  // Testa se botao2 está pressionado
         led2 = 0x01;               // Se estiver, acende led2
       else
         led2 = 0x00;               // Se não estiver, apaga led2

     } // end Loop infinito

} // end void main
int cont = 0x00;

void interrupt(){
     if(T0IF_bit){
       cont++;
       TMR0 = 0x06;
       
       T0IF_bit = 0x00;
     }
}

void main() {

     OPTION_REG = 0x81; // Ou 0b10000001, configura o prescaler para 1:4 associado ao TMR0 e desabilita os resistores de pull-up internos
     GIE_bit = 0x01; // Habilita a interru��o global do Pic
     PEIE_bit = 0x01; // Habilita a interrup��o por perif�ricos
     T0IE_bit = 0x01; // Habilita a interrup��o por estouro do TMR0
     
     TMR0 = 0x06; // Inicia a contagem do timer 0 em 6
     
     TRISB.RB4 = 0x00; // Seleciona RB4 como sa�da digital
     RB4_bit = 0x00; // Inicia RB4 em n�vel baixo (low)
     
     while(1){
       if(cont == 500){
         RB4_bit = ~RB4_bit; // Alterna RB4 entre HIGH e LOW
         cont = 0x00;
       }
     }

}
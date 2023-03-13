
#define servo1 RC4_bit

unsigned char duty = 0x00;

void inicialFinal();
void finalInicial();

void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       
       if(servo1){
         TMR0 = duty;
         servo1 = 0x00;
       }
       else{
         TMR0 = 255 - duty;
         servo1 = 0x01;
       }
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0x87; // Desabilita os pull-ups internos, ativa o timer0 e configura o prescaler em 1:255
     GIE_bit = 0x01; // Ativa a interrup��o global
     PEIE_bit = 0x01; // Ativa a interrup��o por perif�ricos
     TMR0IE_bit = 0x01; // Ativa o timer0
     
     TRISC = 0xEF; // Configura apenas RC4 como sa�da digital
     PORTC = 0xEF; // Inicia RC4 em Low
     
     duty = 7; // Inicia o servo na posi��o inicial
     
     while(1){

       inicialFinal();
       delay_ms(2000);
       finalInicial();
       delay_ms(2000);
     }
}

/* 
   Neste programa, farei o servo ir da posi��o inicial � final suavemente, e vice-versa. Por�m, para ficar em sua posi��o inicial
   deve-se dar um pulso de 0,6 ms, e para a posi��o final, um pulso de 2,4ms.

   Assim, para controlar a frequ�ncia e o pulso, utiliza-se o contador TMR0. Sabe-se que, nessa flag, 255 representa 22ms, que � o valor
   da interrup��o desejada e configurada, e que representa o per�odo para uma frequ�ncia de funcionamento do servo, de 50Hz. Logo, por
   regra de tr�s descobre-se o valor da flag TMR0 para os valores de 0,6ms (pos. inicial) e 2,4ms (pos. final).
   
   255 ----- 22ms     255 ----- 22ms
   x   ----- 0,6ms    x   ----- 2,4ms
     x = 7              x = 28
     
   Logo, a flag deve contar at� 7 para um pulso de 0,6ms e at� 28 para um pulso de 2,4ms
*/

void inicialFinal(){

     int i;
     
     for(i = 7; i < 30 ; i++){  // Coloquei para ir at� 29 (< 30) pois, na pr�tica, � o valor que faz o servo ir at� o ponto final realmente
       duty = i;
       delay_ms(25);
     }
}

void finalInicial(){

     int i;
     
     for(i = 28; i > 6; i--){
       duty = i;
       delay_ms(25);
     }
}

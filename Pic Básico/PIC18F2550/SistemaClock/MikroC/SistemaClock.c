/* 

        Este projeto � igual aos �ltimos dois, denominados "HelloWorld2" e "HelloWorld3", que apenas piscam o Led. O intuito da aula foi explicar
     o funcionamento dos clocks do Pic 18F4550/18F2550. Por isso, a pr�tica consistiu em variar um clock externo e verificar o piscar do led e, ao
     mesmo tempo, conferir atrav�s do pino RA6 a sa�da do clock/4. Como o o delay do Led foi configurado para 500ms quando o Pic tiver 16MHz de
     clock, ao variar a frequ�ncia, o delay tamb�m varia.
        Atrav�s do clock externo consegue-se muita precis�o, caos se queira, bastanto apenas uma fonte de clock muito precisa.
        
        Ao entrar com uma frequ�ncia muito baixa, o Pic n�o responde corretamente ao clock e apresenta mau funcionamento. Isso foi observado na
     demonstra��o da aula.

        N�o farei esta pr�tica pois n�o tenho um gerador de fu��es, por�m, o circuito desta pr�tica est� demonstrado no proteus e a demonstra��o
     da aula j� foi suficiente para entender o funcionamento do clock do Pic.

*/

// Fun��es auxiliares
void pisca_Led();

// Fun��o principal
void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
     PORTB = 0xFE; // Inicia todos as entradas digitais em High
     LATB0_bit = 0x00; // Inicia LATB0 em Low

     // Loop infinito
     while(1){

       pisca_Led();

     } // end loop infinito

} // end void main

void pisca_Led(){

     LATB0_bit = 0x01;
     delay_ms(200);
     LATB0_bit = 0x00;
     delay_ms(200);

} // end void pisca_Led


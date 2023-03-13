/* 

        Este projeto é igual aos últimos dois, denominados "HelloWorld2" e "HelloWorld3", que apenas piscam o Led. O intuito da aula foi explicar
     o funcionamento dos clocks do Pic 18F4550/18F2550. Por isso, a prática consistiu em variar um clock externo e verificar o piscar do led e, ao
     mesmo tempo, conferir através do pino RA6 a saída do clock/4. Como o o delay do Led foi configurado para 500ms quando o Pic tiver 16MHz de
     clock, ao variar a frequência, o delay também varia.
        Através do clock externo consegue-se muita precisão, caos se queira, bastanto apenas uma fonte de clock muito precisa.
        
        Ao entrar com uma frequência muito baixa, o Pic não responde corretamente ao clock e apresenta mau funcionamento. Isso foi observado na
     demonstração da aula.

        Não farei esta prática pois não tenho um gerador de fuções, porém, o circuito desta prática está demonstrado no proteus e a demonstração
     da aula já foi suficiente para entender o funcionamento do clock do Pic.

*/

// Funções auxiliares
void pisca_Led();

// Função principal
void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
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


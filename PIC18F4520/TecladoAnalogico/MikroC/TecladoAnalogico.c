/* 

   Neste programa, ser� implementado um teclado matricial anal�gico, que difrencia os botoes a partir de uma unica entrada anal�gica.
   Para isso, cada bot�o acionado enviar� uma tens�o espec�fica � entrada anal�gica, atrav�s de divisores de tens�o. Para facilitar
   a programa��o deste bot�es, uma tabela ser� montada para a tens�o de cada bot�o.
   Ser�o 15 bot�es no total e, o bot�o 1 dever� ter uma tens�o pr�xima a 0v, enquanto o bot�o 15 dever� ter uma tens�o pr�xima a 5v. Para
   isso, cada bot�o ser� colocado entre um resistor espec�fico, e um resistor de 100KOmh, comum a todos os bot�es. Logo, o resistor
   espec�fico de cada bot�o � que definir� a tens�o espec�fica deste.Assim, pode-se dizer que no bot�o 1 a tens�o enviada dever� ser de
   0,5V e do bot�o 15 de 4,8V. Assim, pode-se definir os resistores das extremidades e criar um intervalo de resistores. Logo:
   
   (VCC)O----------Re-----Bot-----100KOhm----------O(GND)
                         (Vbot)
                         
   Re = resistor espec�fico
   Rc = resistor comum (100KOhm)

   Re = (Rc(VDD-Vbot)) / Vbot
   Re = (100KOhmx(5V-0.5V)) / 0.5V
   Re = 900.000 Ohm
   
   Re = (100KOhmx(5V-4.8V)) / 4.8V
   Re = 4167 Ohm
   
   Resistores pr�ticos comerciais:
   Re m�x = 1MOhm
   Re Min = 4K7 Ohm
   
   Os outros Re devem estar entre estes dois resistores
   
   Tabela de bot�es:
   
   Bot�o    |     Flag           |        Minem�nico    |   Tens�o   |   Valor AD
     1      |   flag0.B0(bot1)   |       S1(flag2.B0)   |   0,51V    |     104
     2      |   flag0.B1(bot2)   |       S2(flag2.B1)   |   0,55V    |     112
     3      |   flag0.B2(bot3)   |       S3(flag2.B2)   |   0,74V    |     152
     4      |   flag0.B3(bot4)   |       S4(flag2.B3)   |   0,94V    |     188
     5      |   flag0.B4(bot5)   |       S5(flag2.B4)   |   1,29V    |     264
     6      |   flag0.B5(bot6)   |       S6(flag2.B5)   |   1,70V    |     348
     7      |   flag0.B6(bot7)   |       S7(flag2.B6)   |   2,00V    |     409
     8      |   flag0.B7(bot8)   |       S8(flag2.B7)   |   2,51V    |     514
     9      |   flag1.B0(bot9)   |       S9(flag3.B0)   |   2,87V    |     588
     10     |   flag1.B1(bot10)  |       S10(flag3.B1)  |   3,41V    |     698
     11     |   flag1.B2(bot11)  |       S11(flag3.B2)  |   3,85V    |     788
     12     |   flag1.B3(bot12)  |       S12(flag3.B3)  |   4,10V    |     840
     13     |   flag1.B4(bot13)  |       S13(flag3.B4)  |   4,35V    |     891
     14     |   flag1.B5(bot14)  |       S14(flag3.B5)  |   4,55V    |     932
     15     |   flag1.B6(bot15)  |       S15(flag3.B6)  |   4,78V    |     979
     
     Bot�o = N�mero do bot�o
     Flag = flag auxiliar utilizada para confirmar que o bot�o foi pressionado
     Mnem�nico = Flag auxiliar para utilizar o bot�o espec�fico em alguma fun��o espec�fica
     Tens�o = Tens�o gerada nos divisores de tens�o de cada bot�o
     Valor AD = Valor convertido no conversor AD da tens�o lida correspondente a cada bot�o. N�mero usado para identificar qual bot�o
     foi pressionado
    
     Neste programa os mnem�nicos auxiliares n�o ser�o usados, mas servem para usar um bot�o espec�fico caso seja necess�rio realizar uma
     fun��o espec�fica atrav�s deste bot�o.

*/

//Configura��o de hardware

#define led LATB0_bit

// Fun��es auxiliares

void leBotao();

// Vari�veis globais

unsigned char flag0 = 0x00;
unsigned char flag1 = 0x00;
unsigned char flag2 = 0x00;
unsigned char flag3 = 0x00;

int adc = 0x00;
char pisca = 0x00;
char i = 0x00;

// Defini��o de flags auxiliares

#define bot1 flag0.B0
#define bot2 flag0.B1
#define bot3 flag0.B2
#define bot4 flag0.B3
#define bot5 flag0.B4
#define bot6 flag0.B5
#define bot7 flag0.B6
#define bot8 flag0.B7
#define bot9 flag1.B0
#define bot10 flag1.B1
#define bot11 flag1.B2
#define bot12 flag1.B3
#define bot13 flag1.B4
#define bot14 flag1.B5
#define bot15 flag1.B6
#define flagAux flag1.B7

#define s1 flag2.B0
#define s2 flag2.B1
#define s3 flag2.B2
#define s4 flag2.B3
#define s5 flag2.B4
#define s6 flag2.B5
#define s7 flag2.B6
#define s8 flag2.B7
#define s9 flag3.B0
#define s10 flag3.B1
#define s11 flag3.B2
#define s12 flag3.B3
#define s13 flag3.B4
#define s14 flag3.B5
#define s15 flag3.B6

void main() {

     ADCON0 = 0x01; // Configura AN0 como canal anal�gico e habilita o conversor AD
     ADCON1 = 0x0E; // Configura o intervalo de tens�o como as tens�es da fonte (VSS e VDD) e configura apenas AN0 como porta anal�gica
     
     TRISA = 0xFF; // Configura todo porta como entrada
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital
     led = 0x00; // Inicia RB0 em Low
     
     while(1){
     
       leBotao();
     
       if(flagAux){
       
         for(i = 0x00; i < pisca; i++){
         
           led = 0x01;
           delay_ms(200);
           led = 0x00;
           delay_ms(200);
         }
         
         flag0 = 0x00;
         flag1 = 0x00;
         flag2 = 0x00;
         flag3 = 0x00;
       }
     }
}

void leBotao(){

     adc = ADC_Read(0);
     
     if(adc > 94 && adc < 108 ) bot1 = 0x01;
     else if(adc > 108 && adc < 132 ) bot2 = 0x01; // Intervalos de 10 a menos a 10 a mais do que o valor AD de cada bot�o
     else if(adc > 132 && adc < 162 ) bot3 = 0x01; // ou 20 a menos a 20 a mais
     else if(adc > 162 && adc < 208 ) bot4 = 0x01;
     else if(adc > 244 && adc < 284 ) bot5 = 0x01;
     else if(adc > 328 && adc < 368 ) bot6 = 0x01;
     else if(adc > 389 && adc < 429 ) bot7 = 0x01;
     else if(adc > 494 && adc < 534 ) bot8 = 0x01;
     else if(adc > 568 && adc < 608 ) bot9 = 0x01;
     else if(adc > 678 && adc < 718 ) bot10 = 0x01;
     else if(adc > 768 && adc < 808 ) bot11 = 0x01;
     else if(adc > 820 && adc < 860 ) bot12 = 0x01;
     else if(adc > 871 && adc < 911 ) bot13 = 0x01;
     else if(adc > 912 && adc < 952 ) bot14 = 0x01;
     else if(adc > 959 && adc < 999 ) bot15 = 0x01;

     if(adc < 94 && bot1){     // Confirma que o bot�o est� solto
     
       flagAux = 0x01; // Esta flag confirma que algum bot�o foi pressionado, e entra faz entrar na rotina que faz o led piscar, no loop inf.
       pisca = 0x01;
       s1 = 0x01;  // Coloca o mnem�nico auxiliar S1 em 0x01, para o caso de querer usar um bot�o espec�fico para uma fun��o espec�fica
       bot1 = 0x00;
     }
     if(adc < 108 && bot2){

       flagAux = 0x01;
       pisca = 0x02; // Pisca definira o numero de piscadas. Quanto maio o bot�o, maior o n�mero de piscadas
       s2 = 0x01;
       bot2 = 0x00;
     }
     if(adc < 132 && bot3){

       flagAux = 0x01;
       pisca = 0x03;
       s3 = 0x01;
       bot3 = 0x00;
     }
     if(adc < 162 && bot4){

       flagAux = 0x01;
       pisca = 0x04;
       s4 = 0x01;
       bot4 = 0x00;
     }
     if(adc < 244 && bot5){

       flagAux = 0x01;
       pisca = 0x05;
       s5 = 0x01;
       bot5 = 0x00;
     }
     if(adc < 328 && bot6){

       flagAux = 0x01;
       pisca = 0x06;
       s6 = 0x01;
       bot6 = 0x00;
     }
     if(adc < 389 && bot7){

       flagAux = 0x01;
       pisca = 0x07;
       s7 = 0x01;
       bot7 = 0x00;
     }
     if(adc < 494 && bot8){

       flagAux = 0x01;
       pisca = 0x08;
       s8 = 0x01;
       bot8 = 0x00;
     }
     if(adc < 568 && bot9){

       flagAux = 0x01;
       pisca = 0x09;
       s9 = 0x01;
       bot9 = 0x00;
     }
     if(adc < 678 && bot10){

       flagAux = 0x01;
       pisca = 0x0A;
       s10 = 0x01;
       bot10 = 0x00;
     }
     if(adc < 768 && bot11){

       flagAux = 0x01;
       pisca = 0x0B;
       s11 = 0x01;
       bot11 = 0x00;
     }
     if(adc < 820 && bot12){

       flagAux = 0x01;
       pisca = 0x0C;
       s12 = 0x01;
       bot12 = 0x00;
     }
     if(adc < 871 && bot13){

       flagAux = 0x01;
       pisca = 0x0D;
       s13 = 0x01;
       bot13 = 0x00;
     }
     if(adc < 912 && bot14){

       flagAux = 0x01;
       pisca = 0x0E;
       s14 = 0x01;
       bot14 = 0x00;
     }
     if(adc < 959 && bot15){

       flagAux = 0x01;
       pisca = 0x0F;
       s15 = 0x01;
       bot15 = 0x00;
     }
}

/*
   Bot�o    |     Flag           |        Minem�nico    |   Tens�o   |   Valor AD
     1      |   flag0.B0(bot1)   |       S1(flag2.B0)   |   0,51V    |     104
     2      |   flag0.B1(bot2)   |       S2(flag2.B1)   |   0,55V    |     112
     3      |   flag0.B2(bot3)   |       S3(flag2.B2)   |   0,74V    |     152
     4      |   flag0.B3(bot4)   |       S4(flag2.B3)   |   0,94V    |     188
     5      |   flag0.B4(bot5)   |       S5(flag2.B4)   |   1,29V    |     264
     6      |   flag0.B5(bot6)   |       S6(flag2.B5)   |   1,70V    |     348
     7      |   flag0.B6(bot7)   |       S7(flag2.B6)   |   2,00V    |     409
     8      |   flag0.B7(bot8)   |       S8(flag2.B7)   |   2,51V    |     514
     9      |   flag1.B0(bot9)   |       S9(flag3.B0)   |   2,87V    |     588
     10     |   flag1.B1(bot10)  |       S10(flag3.B1)  |   3,41V    |     698
     11     |   flag1.B2(bot11)  |       S11(flag3.B2)  |   3,85V    |     788
     12     |   flag1.B3(bot12)  |       S12(flag3.B3)  |   4,10V    |     840
     13     |   flag1.B4(bot13)  |       S13(flag3.B4)  |   4,35V    |     891
     14     |   flag1.B5(bot14)  |       S14(flag3.B5)  |   4,55V    |     932
     15     |   flag1.B6(bot15)  |       S15(flag3.B6)  |   4,78V    |     979
*/
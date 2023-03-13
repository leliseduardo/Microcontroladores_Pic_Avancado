/* 

        A função deste programa, durante a aula, foi apenas demonstrar o uso da memória do Pic. Por isso, o código é o mesmo do último projeto,
    denominado "HelloWorld1".
        Na aula, foi demonstrado e explicado a diferença entra a memória RAM e ROM durante a execução do programa. A memória RAM armazena as 
    variáveis do programa quando ele está rodando. A memória ROM armazena os comandos, que são as instruções feitas pelos códigos e, dependendo do
    comando, gasta mais memória ou menos. Como a linguagem C apresenta um certo nível de abstração, seus comandos podem gastar mais ou menos
    memória, de acordo com o tipo do comando. Isso ocorre pois, como a linguagem é tranformada pelo compilador em uma linguagem de máquina, como
    o Assembly, determinados comando em C podem gerar mais ou menos linhas de comando em Assembly e, por isso, gastar mais ou menos memória.

        Se as variáveis declaradas não forem inicializadas, o compilador "inteligentemente" não as utliza, a fim de economizar memória. Quando são
    inicializadas, percebe-se o aumento da memória RAM do Pic, que serve para armezenas variáveis.
        Caso o número de linhas de intruções aumente, o consumo de memória ROM aumenta, pois esta é a memória de programa, isto é, a memória que
    armazena o programa e suas instruções. Quanto mais linhas de intruções em Assembly, maior o consumo de memória. Um único comando na linguagem
    C pode representar várias linhas de comando em lingugem Assembly e, por isso, ocupar mais memória do que vários comandos em C que representem,
    em Assembly, poucas linhas de comando.

*/

// Funções auxiliares
void pisca_Led();

// VAriáveis auxiliares
long var1, var2, var3, var4, var5, var6, var7, var8;

// Função principal
void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     PORTB = 0xFE; // Inicia todos as entradas digitais em High
     LATB0_bit = 0x00; // Inicia LATB0 em Low

     // Loop infinito
     while(1){

       pisca_Led();
       
       var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251;
       

       var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251; var1 = 5555;
       var2 = 888888;
       var3 = 4444;
       var4 = 7777;
       var5 = 777777;
       var6 = 8888;
       var7 = 666666;
       var8 = 555251;

     } // end loop infinito

} // end void main

void pisca_Led(){

     LATB0_bit = 0x01;
     delay_ms(200);
     LATB0_bit = 0x00;
     delay_ms(200);

} // end void pisca_Led
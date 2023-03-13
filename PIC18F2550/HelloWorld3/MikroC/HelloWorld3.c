/* 

        A fun��o deste programa, durante a aula, foi apenas demonstrar o uso da mem�ria do Pic. Por isso, o c�digo � o mesmo do �ltimo projeto,
    denominado "HelloWorld1".
        Na aula, foi demonstrado e explicado a diferen�a entra a mem�ria RAM e ROM durante a execu��o do programa. A mem�ria RAM armazena as 
    vari�veis do programa quando ele est� rodando. A mem�ria ROM armazena os comandos, que s�o as instru��es feitas pelos c�digos e, dependendo do
    comando, gasta mais mem�ria ou menos. Como a linguagem C apresenta um certo n�vel de abstra��o, seus comandos podem gastar mais ou menos
    mem�ria, de acordo com o tipo do comando. Isso ocorre pois, como a linguagem � tranformada pelo compilador em uma linguagem de m�quina, como
    o Assembly, determinados comando em C podem gerar mais ou menos linhas de comando em Assembly e, por isso, gastar mais ou menos mem�ria.

        Se as vari�veis declaradas n�o forem inicializadas, o compilador "inteligentemente" n�o as utliza, a fim de economizar mem�ria. Quando s�o
    inicializadas, percebe-se o aumento da mem�ria RAM do Pic, que serve para armezenas vari�veis.
        Caso o n�mero de linhas de intru��es aumente, o consumo de mem�ria ROM aumenta, pois esta � a mem�ria de programa, isto �, a mem�ria que
    armazena o programa e suas instru��es. Quanto mais linhas de intru��es em Assembly, maior o consumo de mem�ria. Um �nico comando na linguagem
    C pode representar v�rias linhas de comando em lingugem Assembly e, por isso, ocupar mais mem�ria do que v�rios comandos em C que representem,
    em Assembly, poucas linhas de comando.

*/

// Fun��es auxiliares
void pisca_Led();

// VAri�veis auxiliares
long var1, var2, var3, var4, var5, var6, var7, var8;

// Fun��o principal
void main() {

     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser anal�gicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como sa�da digital, o resto como entrada
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
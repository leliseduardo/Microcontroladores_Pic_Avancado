/* 

   Terminado o código e testado o circuito, que funcionou, vou tirar algumas conclusões sobre esse programa
   
   O módulo CCP, no modo de captura, tem a função de capturar algum evento de um sinal que é recebido pelo pino
   do modulo. Tal evento pode ser uma borda de subida ou de descida, ou várias bordas de subida. Para usa-lo,
   deve-se configurar muitos registradores, o que pode deixar a lógica um pouco complicada, com tanta coisa para
   configurar e lembrar. Daí, vou fazer um resumo da lógica e tentar dizer quais são os registradores que se usa,
   mesmo aqueles que só se usa uma flag.
   
   Neste código, foi feita uma lógica que faz, inicialmente, o modo de captura capturar uma borda de subida. Tendo
   capturado, ele gera uma interrupção, que tem como função zerar o contador do timer1, mudar o modo de captura para
   borda de descida e iniciar a contagem. Feito isso, o programa conta o tempo até que haja uma borda de descida. Quando
   houver, é gerada novamente uma interrupção, que tem como função desligar a contagem do timer1, associar o tempo contado
   as variaveis globais e voltar o modo de captura para borda de subida. Dessa forma, o timer1 consegue contar o tempo certo
   em que um pulso ficou em HIGH. No loop infinito, a unica coisa que é feita é imprimir o numero contado, para isso associando
   o numero contado à variável global chamada tempoH, que significa tempo em High
   
   Para fazer tudo isso, deve-se configurar os registradores do timer 1, assim como do modulo cpp. Os registradores a serem configurados
   sâo:
       INTCON -> Que habilita as interrupções (GIE_bit e PEIE_bit)
       PIE1 -> Que desabilita a interrupção pelo timer1 e habilita a interrupção pelo ccp (TMR1IE_bit e CCP1IE_bit)
       CCP1CON -> Que Configura o tipo de modo de captura (borda subida ou descida)
       T1CON -> Que configura o prescaler, habilita o incremento do timer1 pelo clock interno e desabilita o timer1
       Nesse regitrador, as flags configuradas são, respectivamente: T1CKPS1_bit, T1CKPS0_bit, TMR1CS_bit, TMR1ON_bit
       Ainda, na função de interrupção é preciso testar a flag de interrupção do modulo cpp, CCP1IF_bit, e caso tenha
       ocorrido a interrupção, zera-la.
       
   Fora esses, tem os registradores comuns, TRIS, PORT e CMCON, que sempre se usam.
       
   Ainda, também é necessário iniciar o LCD
       
   Para fazer o gerador de sinais na prática, já que não tenho gerador de funções, projetei um oscilador com frequência variável
   f = 500Hz até f = 1600 Hz, com o CI 555. Este circuito auxiliar está projetado no caderno e funcionou perfeitamente.
*/

// Lcd pinout settings
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

//Variáveis globais

unsigned tempoH;
char tmrH, tmrL;
char txt[7];

void interrupt(){

    if(CCP1IF_bit && CCP1CON.B0){
      
      CCP1IF_bit = 0x00; // Zera a flag de interrupção
      TMR1H = 0x00; // Inicia TMR1 em 0
      TMR1L = 0x00;
      CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
      CCP1CON = 0x04; // Configura a captura em borda de descida
      CCP1IE_bit = 0x01; // Liga a interrupão do modulo ccp
      TMR1ON_bit = 0x01; // Liga a contagem do timer1
    }
    else if(CCP1IF){
       CCP1IF_bit = 0x00; // Zera a flag de interrupção
       TMR1ON_bit = 0x00; // Desliga a contagem do timer1
       CCP1IE_bit = 0x00; // Desliga a interrupção do modulo ccp
       CCP1CON = 0x05; // Configura a captura em borda de subida
       CCP1IE_bit = 0x01; // Liga a interrupção do modulo ccp
       tmrH = CCPR1H; // Iguala o neeble mais significativo do timer 1 a tempoH
       tmrL = CCPR1L; // Iguala o neeble menos significativo do timer 1 a tempoL
    }
}

void main() {

     CMCON = 0x07; // Desativa os comparadores internos
     INTCON = 0xC0; // Hablita a interrupção global e por periféricos
     TMR1IE_bit = 0x00; // Desabilita a interrupção do timer 1
     CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo cpp
     CCP1CON = 0x05; // Configura o modo de captura por borda de subida
     
     //Registrado T1CON
     T1CKPS1_bit = 0x00; // Configura o prescaler como 1:1
     T1CKPS0_bit = 0x00; // Configura o prescaler como 1:1
     TMR1CS_bit = 0x00; // Configura clock interno, e não clock externo a partir do pino RB6
     TMR1ON_bit = 0x00; // Para a contagem do timer 1
     
     TRISA = 0xFF; // Configura todo porta como entrada digital
     TRISB = 0x09; // Ou 0b00001001, que configura apenas RB0 e RB3 como entradas digitais
     PORTA = 0xFF; // Inicia todo o porta em High
     PORTB = 0x00; // Inicia todo o portb em Low

     lcd_init(); // Inicia lcd
     lcd_cmd(_LCD_CURSOR_OFF); // Desliga cursor
     lcd_cmd(_LCD_CLEAR); // Apaga caracteres display
     lcd_out(1,1,"Modo captura"); // Escreve na primeira linha
     lcd_out(2,14,"us"); // Coloca a unidade do valos lido, no final da segunda linha
     delay_ms(100); // Atraso de inicialização do display
     
     while(1){
     
       delay_ms(100);
       
       tempoH = (tmrH << 8) + tmrL; // Faz tempoH = 0b tmrH tmrL, sendo tmrH o mais sig, e o tmrL o menos sig.
       
       IntToStr(tempoH, txt);
       
       lcd_out(2,8,txt);
     }
}
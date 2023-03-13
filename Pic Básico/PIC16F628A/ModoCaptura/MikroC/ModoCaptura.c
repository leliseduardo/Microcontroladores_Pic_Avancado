/* 

   Este código não funcionou na simulação e, como no vídeo não foi feita nenhuma prática, tambpem não fiz.
   
   O código parece que não está bem escrito, um exemplo é a variável flag0.B1, que é usada e não tem finalidade nenhuma.
   Logo, parece que há falhas de lógica e de configuração do modo de captura. Como não conheço o assunto e estou aprendendo agora,
   não vou tentar arrumar o código, e sim esperar as próximas aulas que também abordam esse mesmo assunto.
   
   Ainda, mesmo que o código não tenha funcionado, deu para entender o que o modo de captura, que pertence ao módulo CCP do pic,
   pode fazer. O modo captura tem a função de contar o tempo, a partir do timer1, assim que um evento ocorre. Evento esse
   caracterizado por uma borda de subida ou descida, ou algumas bordas de subida. A contagem de tempo é feita pelo timer 1, que
   conta o tempo proporcional ao ciclo de máquina e prescaler. Ex:
   
   osc = 4MHz => ciclo de maquina = 1us, prescaler = 1:1, logo, timer1 incrementa a cada 1us = ciclo de maquina
   
   Assim que termina a captura, o tempo contado pelos timer1 é transferido para os registradores CCPR1H::CCPR1L, que
   armazenam essa contagem. Assim, se o incremento é feito a cada 1us, como no exemplo, e o contador contou até 122,
   então o tempo de captura foi de 122x1us = 122us, diretamente.
   
   O problema desta aula, e deste código, foi o professor não ter explicado claramente como a captura termina. Se a captura
   começa com uma borda de subida ou descida, e conta um determinado tempo (por exemplo, 122), como é que a captura sabe a
   hora de parar de contar ? Assim que eu aprender isso, nas próximas aulas, volto aqui em respondo essa pergunta.
   
   Assistindo a aula seguinda, deu para entender como o modo de captura para a contagem. O professor fez o uso das flags
   TMR1ON_bit para ligar e desligar a contagem do modo captura. No programa seguinte, com o nome de PulsoCapturaCPP, o código
   será bem auto explicativo e o modo captura terá seu funcionamento mais claro.
   Em resumo, necessita-se, por software, ligar o contador do timer1 quando a primeira captura ocorre, por borda de subida. Logo
   em seguida, alterar a captura para borda de descida. Assim, quando a captura ocorrer novamente, desliga-se a contagem do timer1
   e atribui o valor guardado em CCPR1H::CCPR1L em duas variáveis.
   Vale ressaltar que este módulo não é simulável e não funciona no proteus.
   
   Ainda, assitindo a aula sobre frequencimetro, descobri o mais importante. O tmr1 não começa a contar quando a captura ocorre. Ele
   conta continuamente enquanto o programa roda. A captura, na verdade, somente armazena o tempo que tmr1 contou até a hora da captura.
   Isso explica esse código e o código do projeto "Frequencimetro". Porém, algumas melhorias foram feitas no frequencimetro em relação a
   esse código, como ler o modulo do intervalo de tempo e utilizar um prescaler de 16 bordas de subida.
*/

// Lcd pinout settings
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

// Variáveis globais

char flag0 = 0x00; // flag auxiliar de controle
unsigned tempo1, tempo2;
char *texto = "Modo de captura";
char txt[16];

void interrupt(){

     if(CCP1IF_bit){
     
       if(!flag0.B0){ // Se o bit 0 de flag0 for zero
       
         tempo1 = (CCPR1H << 8) + CCPR1L;
         
         flag0.B0 = 0x01; // bit 0 de flag0 = 1
       }
       else{

         tempo2 = (CCPR1H << 8) + CCPR1L;
         
         flag0.B0 = 0x00;
         
         flag0.B1 = 0x01;
       }
       
       CCP1IE_bit = 0x00;
       CCP1CON.B0 = ~CCP1CON.B0;
       CCP1IE_bit = 0x01;
       
       CCP1IF_bit = 0x00;
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     T1CON = 0x01; // Configura o prescaler em 1:1 e habilita o timer 1
     CCP1CON = 0x05; // Configura o modo de captura para borda de subida
     CCP1IE_bit = 0x01; // Habilita a interrupção pelo modulo ccp1 que, no caso, utiliza o modo de captura
     GIE_bit = 0x01; // Habilita a interrupção global
     PEIE_bit = 0x01; // Habilita a interrupção por periféricos
     
     TRISA = 0xFF; // Todo porta como entrada digital
     TRISB = 0x09; // Apenas RB0 e RB3 (CCP1) como entradas digitais
     PORTA = 0xFF; // Inicia todo porta em High
     PORTB = 0x09; // Inicia apenas RB0 e RB3 em High
     
     lcd_init(); // Inicia o lcd
     lcd_cmd(_LCD_CURSOR_OFF); // Desliga o cursor
     lcd_cmd(_LCD_CLEAR); // Limpa a tela
     lcd_out(1,1,texto); // Escreve um texto na primeira linha
     
     while(1){
     
       tempo2 = tempo2 - tempo1;
       
       IntToStr(tempo2, txt);
       
       lcd_out(2,1,txt);
       
       flag0.B1 = 0x00;
     }
}
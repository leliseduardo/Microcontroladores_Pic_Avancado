/* 

        O objetivo deste programa é criar um cronômetro com display LCD. O cronômetro terá um botão de início e pausa e um botão para reini-
    ciar a contagem. A contagem de tempo será feita a partir do timer0, uma vez que, caso queira implementar este cronômetro no projeto
    "RelogioDespertadorCronômetro", não atrapalhe a contagem de tempo de 1s do timer1, implementado no projeto citado. Assim, o timer0 terá
    uma contagem de 10ms, a partir de um Cristal de 4MHz do Pic. Caso este projeto seja implementado no relógio, será interessante definir
    prioridade de interrupção entre o timer0 e timer1, sendo o timer1 com prioridade alta e o timer0 prioridade baixa. Assim, o relógio não
    sofrerá atrasos por conta da contagem do timer0.
    
        Para contar até 10ms, o timer0 terá que contar até o seguinte número:
        
        Ciclo de máquina = 1/(4MHz/4) = 1us
        Tempo de overflow = 10ms
        <TMR0L::TMR0H> máximo = 2^16 = 65536
        Contagem = Tempo de Overflow / Ciclo de máquina = 10ms / 1us = 10000
        
        <TMR0L::TMR0H> = 65536 - 10000 = 55536
        55536(decimal) = 0xD8F0(hexadecimal)
        TMR0L = 0xF0
        TMR0H = 0xD8
        Para uma contagem de 10000
        
        Overflow = (65536 - <TMR0L::TMR0H>) * prescaler * ciclo de maquina
        Overflow = (65536 - 55536) * 1 * 1us
        Overflow = 10000 * 1 * 1us
        Overflow = 10ms
        
        
    O tempo de interrupção, de acordo com o Osciloscópio do proteus, tem 10ms certos. O circuito funcionou na prática.
*/

// Configuração display lcd
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

// Configuração de hardware
#define botaoIniciaPara RB7_bit
#define botaoZera RB6_bit
#define saidaTeste LATB0_bit

// Funções auxiliares
void cronometro();
void display_Cronometro();

// Variáveis auxiliares
char centesimo = 0x00, segundos = 0x00, minutos = 0x00, hora = 0x00;
char *texto = "00:00:00:00";
char flagBotoes = 0x00;

// Função de interrupção
void interrupt(){

     if(TMR0IF_bit){
     
       TMR0IF_bit = 0x00;
       TMR0L = 0xF0;
       TMR0H = 0xD8;
       
       cronometro();
       
       saidaTeste = ~saidaTeste;
     } // end if TMR0IF_bit

} // end void interrupt

void main() {

     // Configuração de resgistradores
     INTCON = 0x80; // Habilita a interrupção global, desabilita a interrupção por overflow do timer0, por enquanto

     // Registador T0CON
     TMR0ON_bit = 0x01; // Habilita o timer0
     T08BIT_bit = 0x00; // Configura o timer0 com 16 bits
     T0CS_bit = 0x00; // Incrementa o timer0 com o ciclo de máquina
     PSA_bit = 0x01; // Não associa o prescaler ao timer0, isso equivale a prescaler 1:1
     
     TMR0L = 0xF0; // Inicia <TMR0L::TMR0H> em 55536, para uma contagem de 10000
     TMR0H = 0xD8;
     
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     saidaTeste = 0x00; // Inicia LATB0 em Low

     // Inicialização do siplay LCD
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_CMD(_LCD_CLEAR);
     
     // Loop infinito
     while(1){
     
       if(!botaoIniciaPara) flagBotoes.B0 = 0x01;
       
       if(!TMR0IE_bit) // Se a interrupção do timer0 está desligada
         if(!botaoZera) flagBotoes.B1 = 0x01;
       
       if(botaoIniciaPara && flagBotoes.B0){
       
         flagBotoes.B0 = 0x00;
         
         TMR0IE_bit = ~TMR0IE_bit;
       } // end if botaoIniciaPara && flagBotoes.B0
       
       if(botaoZera && flagBotoes.B1){
       
         flagBotoes.B1 = 0x00;
         
         hora = 0x00;
         minutos = 0x00;
         segundos = 0x00;
         centesimo = 0x00;
       } // end if botaoZera && flagBotoes.B1
       
       display_Cronometro();

     } // end loop infinito
     
} // end void main

void cronometro(){

     centesimo++;
     
     if(centesimo == 0x64){ // Se centesimo = 100

       centesimo = 0x00;

       segundos++;
       
       if(segundos == 0x3C){ // Se segundos = 60
       
         segundos = 0x00;
         
         minutos++;
         
         if(minutos == 0x6C){ // Se minutos = 60
         
           minutos = 0x00;
           
           hora++;
           
           if(hora == 0x18) // Se hora = 24
             hora = 0x00;

         
         } // end if minutos = 60
       
       } // end if segundos == 0x3C

     } // end if centesimo == 0x64
     
} // end void cronometro

void display_Cronometro(){

     texto[0] = hora/10 + '0';
     texto[1] = hora%10 + '0';
     texto[3] = minutos/10 + '0';
     texto[4] = minutos%10 + '0';
     texto[6] = segundos/10 + '0';
     texto[7] = segundos%10 + '0';
     texto[9] = centesimo/10 + '0';
     texto[10] = centesimo%10 + '0';
     
     lcd_out(1, 3, texto);

} // end void display_Cronometro









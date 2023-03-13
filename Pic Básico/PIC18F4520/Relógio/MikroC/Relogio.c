/* 

        Este programa tem como objetivo criar um relógio através da base de tempo de 1s, criado no projeto "BaseTempo1s". Este relógio
     terá 3 botões e um display LCD. Um botão para escolher entre o ajuste da hora, do segundo e do minuto, um botão para adicionar uma
     unidade no ajuste escolhido e um botão para adicionar 10 no ajuste escolhido. Este relógio também mostrará o dia da semana.
        Para organizar o projeto, vou definir alguns passos para sua construção:
        - Configurar o display e iniciá-lo
        - Configurar hardware
        - Configurar a base de tempo de 1s a partir do timer 1 e configurar demais registradores
        - Configurar função relogio
        - Configurar função display_Relogio
        - Configurar função ajuste_Relogio
        - Configurar loop infinito
        
        *** Timer1 ***

     contagem até 32768
     65536 - 32768 = 32768
     32768(decimal) = 0x8000(hexadecimal)

     TMR1L = 0x00
     TMR1H = 0x80

     Overflow = (65536 - <TMR1H::TMR1L>) * prescaler * período do oscilador externo
     Overflow = (65536 - 32768) * 1 * (1/32768Hz)
     Overflow = 32768 * 1 * 30,52us
     Overflow = 1s
        
*/

// Configuração do display LCD
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
#define botaoAjuste RB7_bit // Como são entradas digitais, configura-se RBX_bit, e não LATBX_bit
#define botaoSoma RB6_bit
#define botaoSoma10 RB5_bit

// Funções auxiliares
void relogio();
void display_Relogio();
void ajuste_Relogio();

// Variáveis auxiliáres
char segundo = 0x00, minuto = 0x00, hora = 0x00, dia = 0x00;
char *texto = "00:00:00";
char flags = 0x00;
char controleAjuste = 0x05;

// Função de interrupção
void interrupt() {

     if(TMR1IF_bit){
     
       asm BSF TMR1H,7;
       
       TMR1IF_bit = 0x00;
       
       relogio();
     } // end if TMR1IF_bit

} // end void interrupt

void main() {

     // Configuração de registradores
     
     // Registrador INTCON
     INTCON = 0xC0; // Habilita a interrupção global e por periféricos
     
     // Registrador PIE1
     TMR1IE_bit = 0x01; // Habilita a interrupção do timer1 por overflow
     
     // Registrador T1CON
     T1CON = 0x0B; // Configura o timer1 com 8 bits,pic com outro oscilador, prescaler 1:1, liga o oscilador do timer1, síncrono, clock
                   // externo e habilita o timer1
                   
     // Registrador <TMR1H::TMR1L>
     TMR1L = 0x00; // Inicia o timer1 em 32768, para uma contagem de 32768
     TMR1H = 0x80;
                   
     ADCON1 = 0x0F; // Configura todos os pinos que poderiam ser analógicos como digitais
     TRISB = 0xFF; // Configura todo portb como entrada digital

     // Inicialização do display
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);

     // Loop infinito
     while(1){
     
       display_Relogio();
       ajuste_Relogio();
     } //end loop infinito
} // end void main

void relogio(){

     segundo++;
     
     if(segundo == 0x3C){ // Se segundo = 60
     
       segundo = 0x00;
       minuto++;
       
       if(minuto == 0x3C){ // se minuto = 60
       
         minuto = 0x00;
         hora++;
         
         if(hora == 0x18){ // Se hora = 24
         
           hora = 0x00;
           dia++;
           
           if(dia == 0x07) // Se dia = 7. Lembrando que a variável dia começa em 0
             dia = 0x00;

         } // end if hora == 0x18
       
       } // end if minuto == 0x3C
       
     } // end if segundo == 0x3C
     
     
} // end void relogio

void display_Relogio(){

     texto[7] = segundo%10 + '0';
     texto[6] = segundo/10 + '0';
     texto[4] = minuto%10 + '0';
     texto[3] = minuto/10 + '0';
     texto[1] = hora%10 + '0';
     texto[0] = hora/10 + '0';
     
     lcd_out(1, 5, texto);
     
     switch(dia){
     
       case 0: lcd_chr(1, 14, 'D');
               lcd_chr_cp('o');
               lcd_chr_cp('m');
               break;
       case 1: lcd_chr(1, 14, 'S');
               lcd_chr_cp('e');
               lcd_chr_cp('g');
               break;
       case 2: lcd_chr(1, 14, 'T');
               lcd_chr_cp('e');
               lcd_chr_cp('r');
               break;
       case 3: lcd_chr(1, 14, 'Q');
               lcd_chr_cp('u');
               lcd_chr_cp('a');
               break;
       case 4: lcd_chr(1, 14, 'Q');
               lcd_chr_cp('u');
               lcd_chr_cp('i');
               break;
       case 5: lcd_chr(1, 14, 'S');
               lcd_chr_cp('e');
               lcd_chr_cp('x');
               break;
       case 6: lcd_chr(1, 14, 'S');
               lcd_chr_cp('a');
               lcd_chr_cp('b');
               break;
               
     } // end switch dia

} // end void display_Relogio

void ajuste_Relogio(){

     char i;

     if(!botaoAjuste) flags.B0 = 0x01;
     if(!botaoSoma) flags.B1 = 0x01;
     if(!botaoSoma10) flags.B2 = 0x01;
     
     if(botaoAjuste && flags.B0){
     
       flags.B0 = 0x00;
       
       controleAjuste++;
       
       if(controleAjuste > 4)
         controleAjuste = 0x00;

     } // end if botaoAjuste && flags.B0
     
     switch(controleAjuste){

       case 0x00: lcd_chr(1, 1, 'H'); // Ajuste hora
                    lcd_chr(2, 5, '^');
                    lcd_chr_cp('^');
                    break;
       case 0x01: lcd_chr(1, 1, 'M'); // Ajuste minuto
                    lcd_chr(2, 5, ' ');
                    lcd_chr_cp(' ');
                    lcd_chr(2, 8, '^');
                    lcd_chr_cp('^');
                    break;
       case 0x02: lcd_chr(1, 1, 'S'); // Ajuste segundos
                    lcd_chr(2, 8, ' ');
                    lcd_chr_cp(' ');
                    lcd_chr(2, 11, '^');
                    lcd_chr_cp('^');
                    break;
       case 0x03: lcd_chr(1, 1, 'D'); // Ajuste dias
                    lcd_chr(2, 11, ' ');
                    lcd_chr_cp(' ');
                    lcd_chr(2, 14, '^');
                    lcd_chr_cp('^');
                    lcd_chr_cp('^');
                    break;
       case 0x04: lcd_chr(1, 1, ' ');     // Limpa linha 2
                  for(i = 0; i < 12; i++)
                      lcd_chr(2, i+5, ' ');
                  break;

     } // end switch controleAjuste
     
     if(botaoSoma && flags.B1){
     
       flags.B1 = 0x00;
       
       switch(controleAjuste){
       
         case 0x00: hora++;
                    if(hora == 0x18)
                      hora = 0x00;
                    break;
         case 0x01: minuto++;
                    if(minuto == 0x3C)
                      minuto = 0x00;
                    break;
         case 0x02: segundo++;
                    if(segundo == 0x3C)
                      segundo = 0x00;
                    break;
         case 0x03: dia++;
                    if(dia == 0x07)
                      dia = 0x00;
                    break;
       
       } // end switch controleAjuste
     
     } // end if botaoSoma && flags.B1
     
     if(botaoSoma10 && flags.B2){
     
       flags.B2 = 0x00;
       
       switch(controleAjuste){

         case 0x00: hora = hora + 10;
                    if(hora >= 0x18)
                      hora = 0x00;
                    break;
         case 0x01: minuto = minuto + 10;
                    if(minuto >= 0x3C)
                      minuto = 0x00;
                    break;
         case 0x02: segundo = segundo + 10;
                    if(segundo >= 0x3C)
                      segundo = 0x00;
                    break;
                    
       } // end switch controleAjuste

     } // end if botaoSoma10 && flags.B2

} // end void ajuste_Relogio






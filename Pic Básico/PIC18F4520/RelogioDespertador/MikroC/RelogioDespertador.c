/* 

        O objetivo deste código é implementar um despertador em cima do relógio feito no último projeto, denominado "Relogio". O programa
     deverá entrar no modo de programação do despertador e ter um botão de ativação e desativação deste.
        Para isso, tenho que seguir os seguintes passos:
        - Configurar a função display_Alarme
        - Configurar a função ajuste_Alarme
        - Configurar a troca de displays
        - Configurar a ativação do alarme
        
        Lembrando que, para acionar um botão e evitar o efeito bouncing, que é aquela interferência mecânica do botão, deve-se usar uma
     flag de controle. Esta técinica funciona da seguinte forma:
        Teste-se se o botão foi pressionado. Se foi, seta para 1 a flag de controle.
        Depois, testa-se se o botão não está pressionado e se a flag de controle deste botão foi setada para 1. Se sim, faz a função para
     qual se quer atribuir o botão
        Dessa fora, evita-se a interferência do botão.
        
        Lista das flags de controle usadas:
        
        flags.B0 => botaoAjuste na função ajuste_Relógio
        flags.B1 => botaoSoma na função ajuste_Relogio
        flags.B2 => botaoSoma10 na função ajuste_Relogio
        flags.B3 => botaoAjuste na função ajuste_Alarme
        flags.B4 => botaoSoma na função ajuste_Alarme
        flags.B5 => botaoSoma10 na função ajuste_Alarme
        flags.B6 => flag que habilita a troca de displays somente quando o relógio não está sendo ajustado
        flags.B7 => botaoAlarme no loop infinito
        
        flags2.B0 => se tiver setada, entra no display do alarme
        flags2.B1 => flag que habilita a troca de displays somente quando o alarme não está sendo ajustado
        flags2.B2 => botaAlarme dentro do loop infinito, que desabilita o display do alarme
        flags2.B3 => Flag que habilita ou desabilita a ativação do alarme, está dentro do caso 4 do ajusta relogio e caso 3 do ajusta alarme
        flags2.B4 => botaoSoma10, utilizado para ativação do alarme
        flags2.B5 => flag utilizada para manter o alarme ativado
        flags2.B6 => botaoSoma10, utilizado para desabilitar o alarme
        flags2.B7 => botaoSoma, para desabilitar o buzzer

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
#define botaoAlarme RB4_bit
#define buzzer LATB0_bit

// Funções auxiliares
void CustomChar(char pos_row, char pos_char);

void relogio();
void display_Relogio();
void ajuste_Relogio();

void alarme();
void display_Alarme();
void ajuste_Alarme();

void troca_Display();
void ativa_Alarme();

// Variáveis auxiliáres
const char character[] = {21,10,14,17,29,21,17,14};
char flags = 0x00; // Flags de controle
char flags2 = 0x00;

char segundo = 0x00, minuto = 0x00, hora = 0x00, dia = 0x00;
char *texto = "00:00:00";
char controleAjuste = 0x04;

char minuto_a = 0x00, hora_a = 0x00, dia_a = 0x00;
char *texto2 = "00:00";
char controleAjuste_a;
bit ligaBuzzer;


// Função de interrupção
void interrupt() {

     if(TMR1IF_bit){

       asm BSF TMR1H,7;

       TMR1IF_bit = 0x00;

       relogio();
       
       if(ligaBuzzer)
         buzzer = ~buzzer;
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
     TRISB = 0xFE; // Configura apenas RB0 como saída digital, o resto como entrada
     
     buzzer = 0x00; // Inicia LATB0_bit em Low
     ligaBuzzer = 0; // Inicia o bit ligaBuzzer em 0

     // Inicialização do display
     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);

     // Loop infinito
     while(1){
     
       troca_Display();
       ativa_Alarme();

     } //end loop infinito
} // end void main


// ********** Funções de manipulação **********

void troca_Display(){

       if(flags.B6){

         if(!botaoAlarme) flags.B7 = 0x01;

         controleAjuste_a = 0x00; // Para que flags2.B1 seja = 0x00 na troca do display

       } // end is flags.B6

       if((botaoAlarme && flags.B7) || flags2.B0){

         flags.B6 = 0x00;
         flags.B7 = 0x00;
         flags2.B0 = 0x01;

         display_Alarme();
         ajuste_Alarme();

         if(flags2.B1){

           if(!botaoAlarme) flags2.B2 = 0x01;

           if(botaoAlarme && flags2.B2) flags2.B0 = 0x00;

         } // end if flags2.B1

       } // end if botaoAlarme && flags.B7
       else {

         flags2.B1 = 0x00;
         flags2.B2 = 0x00;

         display_Relogio();
         Ajuste_Relogio();

       } // end else botaoAlarme && flags.B7

} // end void display_Troca

void ativa_Alarme(){

       if(flags2.B3){
         if(!botaoSoma10) flags2.B4 = 0x01;

         if(ligaBuzzer){
          
           if(!botaoSoma) flags2.B7 = 0x01;
          
           if(botaoSoma && flags2.B7){

             flags2.B7 = 0x00;

             ligaBuzzer = 0x00;
             buzzer = 0;
             flags2.B6 = 0x01;

           } // end if botaoSoma && flags2.B7
         
         } // end if ligaBuzzer

         if((botaoSoma10 && flags2.B4) || flags2.B5){

           flags2.B5 = 0x01;

           CustomChar(2, 1);
           alarme();

           if(!botaoSoma10) flags2.B6 = 0x01;

           if(botaoSoma10 && flags2.B6){

             flags2.B6 = 0x00;
             flags2.B5 = 0x00;
             flags2.B4 = 0x00;
             ligaBuzzer = 0x00;
             buzzer = 0;

             lcd_chr(2, 1, ' ');

           } // end if !botaoSoma10 && flags2.B4

         } // end if botaoSoma10 && flags2.B4

       } // end if flags2.B3

}

// ********** Funções Relógio **********

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

     lcd_chr(1, 3, ' ');
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
                    flags.B6 = 0x00; // Flag que desabilita a troca de displays
                    flags2.B3 = 0x00; // Flag que desabilita a ativação do alarme
                    break;
       case 0x01: lcd_chr(1, 1, 'M'); // Ajuste minuto
                    lcd_chr(2, 5, ' ');
                    lcd_chr_cp(' ');
                    lcd_chr(2, 8, '^');
                    lcd_chr_cp('^');
                    flags.B6 = 0x00;
                    flags2.B3 = 0x00;
                    break;
       case 0x02: lcd_chr(1, 1, 'S'); // Ajuste segundos
                    lcd_chr(2, 8, ' ');
                    lcd_chr_cp(' ');
                    lcd_chr(2, 11, '^');
                    lcd_chr_cp('^');
                    flags.B6 = 0x00;
                    flags2.B3 = 0x00;
                    break;
       case 0x03: lcd_chr(1, 1, 'D'); // Ajuste dias
                    lcd_chr(2, 11, ' ');
                    lcd_chr_cp(' ');
                    lcd_chr(2, 14, '^');
                    lcd_chr_cp('^');
                    lcd_chr_cp('^');
                    flags.B6 = 0x00;
                    flags2.B3 = 0x00;
                    break;
       case 0x04: lcd_chr(1, 1, ' ');     // Limpa linha 2
                  for(i = 0; i < 12; i++)
                      lcd_chr(2, i+5, ' ');
                  flags.B6 = 0x01; // Flag que habilita a troca de displays
                  flags2.B3 = 0x01; // Flag que habilita a ativação do alarme
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





// ********** Funções Alarme **********

void alarme(){

     if(hora == hora_a){
     
       if(minuto == minuto_a){
       
         if(dia == dia_a)
           ligaBuzzer = 1;
       
       } // end minuto = minuto_a
       
     } // end if hora == hora_a
}

void display_Alarme(){

     texto2[4] = minuto_a%10 + '0';
     texto2[3] = minuto_a/10 + '0';
     texto2[1] = hora_a%10 + '0';
     texto2[0] = hora_a/10 + '0';
     
     CustomChar(1, 1);
     lcd_out(1, 5, texto2);
     lcd_chr(1, 10, ' ');
     lcd_chr_cp(' ');
     lcd_chr_cp(' ');

     switch(dia_a){

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

     } // end switch dia_a

} // end display_Alarme

void ajuste_Alarme(){

     char i;

     if(!botaoAjuste) flags.B3 = 0x01;
     if(!botaoSoma) flags.B4 = 0x01;
     if(!botaoSoma10) flags.B5 = 0x01;

     if(botaoAjuste && flags.B3){

       flags.B3 = 0x00;

       controleAjuste_a++;

       if(controleAjuste_a > 0x03)
         controleAjuste_a = 0x00;

     } // end if botaoAjuste_a && flags.B3

     switch(controleAjuste_a){

       case 0x00: lcd_chr(1, 3, 'H'); // Ajuste hora
                  lcd_chr(2, 5, '^');
                  lcd_chr_cp('^');
                  flags2.B1 = 0x00; // Flag que desabilita troca de displays
                  flags2.B3 = 0x00; // Flag que desabilita a ativação do alarme
                  break;
       case 0x01: lcd_chr(1, 3, 'M'); // Ajuste minuto
                  lcd_chr(2, 5, ' ');
                  lcd_chr_cp(' ');
                  lcd_chr(2, 8, '^');
                  lcd_chr_cp('^');
                  flags2.B1 = 0x00;
                  flags2.B3 = 0x00;
                  break;
       case 0x02: lcd_chr(1, 3, 'D'); // Ajuste dias
                  lcd_chr(2, 8, ' ');
                  lcd_chr_cp(' ');
                  lcd_chr(2, 14, '^');
                  lcd_chr_cp('^');
                  lcd_chr_cp('^');
                  flags2.B1 = 0x00;
                  flags2.B3 = 0x00;
                  break;
       case 0x03: lcd_chr(1, 3, ' ');     // Limpa linha 2
                  for(i = 0; i < 12; i++)
                      lcd_chr(2, i+5, ' ');
                  flags2.B1 = 0x01; // Flag que habilita a troca de displays
                  flags2.B3 = 0x01; // Flag que habilita a ativação do alarme
                  break;

     } // end switch controleAjuste_a

     if(botaoSoma && flags.B4){

       flags.B4 = 0x00;

       switch(controleAjuste_a){

         case 0x00: hora_a++;
                    if(hora_a == 0x18)
                      hora_a = 0x00;
                    break;
         case 0x01: minuto_a++;
                    if(minuto_a == 0x3C)
                      minuto_a = 0x00;
                    break;
         case 0x02: dia_a++;
                    if(dia_a == 0x07)
                      dia_a = 0x00;
                    break;

       } // end switch controleAjuste_a

     } // end if botaoSoma && flags.B4

     if(botaoSoma10 && flags.B5){

       flags.B5 = 0x00;

       switch(controleAjuste_a){

         case 0x00: hora_a = hora_a + 10;
                    if(hora_a >= 0x18)
                      hora_a = 0x00;
                    break;
         case 0x01: minuto_a = minuto_a + 10;
                    if(minuto_a >= 0x3C)
                      minuto_a = 0x00;
                    break;

       } // end switch controleAjuste_a

     } // end if botaoSoma10 && flags.B5

} // end void ajuste_Alarme






// ********** Outras funções **********

void CustomChar(char pos_row, char pos_char) {
  char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);
}
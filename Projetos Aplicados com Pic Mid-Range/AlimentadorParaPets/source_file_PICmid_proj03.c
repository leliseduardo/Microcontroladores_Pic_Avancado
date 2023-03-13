/* ============================================================================

   Projetos Aplicados com PIC Mid-Range

   Alimentador Program�vel para Pets (Projeto 3)

   Temporizador onde o usu�rio programa os hor�rios para alimentar o seu animal 
   de estima��o. Nos hor�rios programados, haver� aviso sonoro (buzzer), visual (LED)
   e a movimenta��o de um servo motor (caso deseje-se implementar uma estrutura 
   mec�nica para liberar a ra��o automaticamente).
   OBS.: Al�m do servo, o controle de um motor DC comum pode ser implementado.
   
   OBS2.: Optou-se apenas pela utiliza��o do motor DC, devido ao projeto da
   estrutura mec�nica estar baseada neste tipo de atuador.

   O sistema contar� com Bot�es de ajuste e interface por display de 7 segmentos.

   Formato do Rel�gio:

   Apresentar� horas e minutos, al�m dos hor�rios programados.
   00 a 24 Horas, ajust�veis via bot�es.


   Compilador: MikroC Pro For PIC v.4.15.0.0

   MCU: PIC16F876A   Clock: Externo 16MHz   CM: 250ns

   Autor: Eng. Wagner Rambo

   Data: Maio de 2018

============================================================================ */


// ============================================================================
// --- Mapeamento de Hardware ---
#define    plus        RA0_bit                 //Bot�o para incrementar valores
#define    adj_watch   RA1_bit                 //Bot�o para ajuste dos d�gitos
#define    adj_prog    RA2_bit                 //Bot�o para ajuste dos programas
#define    motor       RA5_bit                 //Motor DC que acionar� a mec�nica do alimentador

#define    debug_clk   RC0_bit                 //sa�da para debug da base de tempo
#define    buzz        RC1_bit                 //sa�da para acionamento do buzzer
#define    led         RC2_bit                 //sa�da para led de indica��o
#define    dig_pts     RC3_bit                 //sa�da para controle do d�gito dos pontos
#define    dig_uni     RC4_bit                 //sa�da para controle do d�gito das unidades
#define    dig_dez     RC5_bit                 //sa�da para controle do d�gito das dezenas
#define    dig_cen     RC6_bit                 //sa�da para controle do d�gito das centenas
#define    dig_mil     RC7_bit                 //sa�da para controle do d�gito dos milhares


// ============================================================================
// --- Flags Auxiliares ---
#define    plus_f      flagsA.B0               //flag para o bot�o de incremento simples
#define    adj_watch_f flagsA.B1               //flag para o bot�o de sele��o de ajuste
#define    adj_prog_f  flagsA.B2               //flag para o bot�o de ajuste dos programas
#define    feed2       flagsA.B4               //flag de indica��o de alimenta��o 2
#define    feed        flagsA.B5               //flag de indica��o de alimenta��o
#define    run_sys     flagsA.B6               //flag para ativar o modo de ajuste
#define    blk         flagsA.B7               //flag para indica��o de par�metro ajust�vel


// ============================================================================
// --- Prot�tipo das Fun��es ---
void update_data();                            //Fun��o para Atualiza��o de Dados
void read_bts();                               //Fun��o para leitura dos bot�es
void multiplex();                              //Fun��o para controle do display
char disp_cath(char num);                      //Fun��o para exibi��o dos n�meros em BCD


// ============================================================================
// --- Prot�tipo das Fun��es Externas ---
extern void relogio();                         //Fun��o de controle das vari�veis do rel�gio
extern void check_clk();                       //Fun��o para acionamento e alarme

         
// ============================================================================
// --- Vari�veis Globais ---
int            counter_T0 = 0x00;              //contador auxiliar para o Timer0

char           flagsA     = 0x00,              //Registrador para flags auxiliares
               counter_bk = 0x00,              //contador auxiliar para base de tempo de blk
               adj_num    = 0x00,              //n�mero atual do ajuste
               new_prog   = 0x01,              //n�mero para controle de ajuste de programa��es
               run_prog   = 0x01,              //n�mero para controle de par�metros a exibir
               mil,                            //armazena milhares para o display
               cen,                            //armazena centenas para o display
               dez,                            //armazena dezenas para o display
               uni,                            //armazena unidades para o display
               hr_disp    = 0x00,              //hora mostrada no display
               mn_disp    = 0x00,              //minuto mostrado no display
               horas_0    = 0x00,              //armazena as horas do rel�gio
               minutos_0  = 0x00,              //armazena os minutos do rel�gio
               segundos_0 = 0x00,              //armazena os segundos do rel�gio
               horas_1    = 0x00,              //armazena as horas do programa 1
               minutos_1  = 0x00,              //armazena os minutos do programa 1
               horas_2    = 0x00,              //armazena as horas do programa 2
               minutos_2  = 0x00,              //armazena os minutos do programa 2
               horas_3    = 0x00,              //armazena as horas do programa 3
               minutos_3  = 0x00,              //armazena os minutos do programa 3
               adj_count  = 0x00,              //contador para controle de acionamento
               feed_count = 0x00;              //contador para tempo de alimenta��o

unsigned char  feed_count2= 0x00;              //contador para tempo de alimenta��o 2
             

// ============================================================================
// --- Interrup��es ---
void interrupt()
{
   if(TMR0IF_bit)                              //Houve o estouro do Timer0?
   {                                           //Sim...

      TMR0IF_bit   = 0x00;                     //Limpa flag
      TMR0         = 0x06;                     //Reinicia Timer0
      counter_T0  += 0x01;                     //Incrementa counter_T0
      counter_bk  += 0x01;                     //Incrementa counter_bk

      // == BASE DE TEMPO DE 2ms ==
      multiplex();                             //chama fun��o de multiplexa��o
      
      if(counter_bk == 100)                    //counter_bk igual a 100?
      {                                        //sim
         counter_bk = 0x00;                    //reinicia counter_bk
         
         // == BASE DE TEMPO DE 200 ms ==
         blk = ~blk;                           //inverte blk (par�metro a ser ajustado pisca)
         
      } //end if counter_bk

      if(counter_T0 == 250)                    //counter igual a 250?
      {                                        //sim
         counter_T0 = 0x00;                    //reinicia counter

         // == BASE DE TEMPO DE 500 ms ==
         debug_clk = ~debug_clk;               //inverte o estado da sa�da de debug
         
         if(!debug_clk) relogio();             //chama fun��o do rel�gio quando debug_clk for low
         
         
         // == Verifica��o de "pressionar mantido" no bot�o Plus ==
         if(plus_f) adj_count+=1;              //incrementa adj_count, se plus_f setada
         if(adj_count == 4)                    //adj_count igual a 4?
         {                                     //sim, passaram 2 segundos...
            adj_count = 0x00;                  //reinicia
            run_sys   = ~run_sys;              //inverte estado de run_sys

         } //end if adj_count
         
         // == Verifica��o de igualmente entre hor�rios programados ==
         if(feed)                              //feed setada?
         {                                     //sim
            run_sys = 0;                       //limpa run_sys
            feed_count+=1;                     //incrementa feed_count
            buzz  = 0x01;                      //aciona buzzer
            motor = 0x01;                      //aciona motor
            
         } //end if feed
         
         if(feed_count == 20)                  //feed_count chegou em 20?
         {                                     //sim, passaram 10 segundos...
            feed_count = 0x00;                 //limpa feed_count
            buzz  = 0x00;                      //desliga buzzer
            motor = 0x00;                      //desliga motor
            feed = 0x00;                       //limpa flag feed
         
         } //end feed_count
         
         
         if(feed2) feed_count2+=1;             //incrementa feed_count2, se feed2 setada
         
         if(feed_count2 == 140)                //feed_count2 chegou em 140?
         {                                     //sim, passaram 70 segundos...
            feed_count2 = 0x00;                //limpa feed_count2
            run_sys     = 0x01;                //seta run_sys
            feed2       = 0x00;                //limpa flag feed2
         
         } //end if feed_count2

      } //end if counter


   } //end if TMR0IF_bit

} //end interrupt


// ============================================================================
// --- Fun��o Principal ---
void main()
{

   CMCON        = 0x07;                        //Desabilita comparadores
   ADCON1       = 0x07;                        //Configura todos I/Os como digitais

   OPTION_REG   = 0x84;                        //Desabilita resistores de pull-up internos, prescaler 1:32 associado ao Timer0
   GIE_bit      = 0x01;                        //Habilita interrup��o global
   TMR0IE_bit   = 0x01;                        //Habilita interrup��o do timer0
   TMR0         = 0x06;                        //Inicializa Timer0 em 6

   // == C�LCULO DE OVERFLOW TIMER0 ==
   //
   //  T0_ovf = (256 - TMR0) x PS x CM
   //  T0_ovf = (256 -   6 ) x 32 x 250E-9
   //  T0_ovf = 2ms
   //
  
   TRISA.RA5    = 0x00;                        //Configura RA5 como sa�da digital
   motor        = 0x00;                        //motor inicia desligado
   TRISB        = 0x80;                        //Configura todo PORTB como sa�da, exceto RB7
   PORTB        = 0x80;                        //Inicializa PORTB
   TRISC        = 0x00;                        //Configura todo PORTD como sa�da
   PORTC        = 0x00;                        //Inicializa PORTC


   while(1)                                    //Loop Infinito
   {
      read_bts();                              //l� bot�es
      update_data();                           //atualiza dados
      
      if(run_sys) check_clk();                 //compara hor�rios, se run_sys setada

      led = run_sys;                           //led recebe o estado atual de run_sys

   } //end while


} //end main


// ============================================================================
// --- Desenvolvimento das Fun��es ---


// ============================================================================
// --- Fun��o para Atualiza��o de Dados ---
void update_data()
{
   switch(new_prog)                            //verifica new_prog
   {
      case 1:                                  //caso 1
         hr_disp   = horas_0;                  //mostra horas do rel�gio
         mn_disp   = minutos_0;                //mostra minutos do rel�gio
         break;
      case 2:                                  //caso 2
         delay_ms(741);                        //aguarda
         new_prog+=1;                          //avan�a new_prog
         break;
      case 3:                                  //caso 3
         hr_disp   = horas_1;                  //mostra horas do programa 1
         mn_disp   = minutos_1;                //mostra minutos do programa 1
         break;
      case 4:                                  //caso 4
         delay_ms(741);                        //aguarda
         new_prog+=1;                          //avan�a new_prog
         break;
      case 5:                                  //caso 5
         hr_disp   = horas_2;                  //mostra horas do programa 2
         mn_disp   = minutos_2;                //mostra minutos do programa 2
         break;
      case 6:                                  //caso 6
         delay_ms(741);                        //aguarda
         new_prog+=1;                          //avan�a new_prog
         break;
      case 7:                                  //caso 7
         hr_disp   = horas_3;                  //mostra horas do programa 3
         mn_disp   = minutos_3;                //mostra minutos do programa 3
         break;
      case 8:                                  //caso 8
         delay_ms(741);                        //aguarda
         new_prog=1;                           //retorna para 1
         break;

   } //end switch new_prog
   

} //end update_data


// ============================================================================
// --- Fun��o para Leitura dos Bot�es ---
void read_bts()
{
   if(!plus)      plus_f      = 0x01;          //seta flag plus_f, se plus pressionado
   if(!adj_watch) adj_watch_f = 0x01;          //seta flag adj_watch_f, se adj_watch pressionado
   if(!adj_prog)  adj_prog_f  = 0x01;          //seta flag adj_prog_f, se adj_prog pressionado
   
   if(plus && plus_f)                          //bot�o plus solto e flag setada?
   {                                           //sim
      plus_f = 0x00;                           //limpa flag
      adj_count  = 0x00;                       //reinicia contador de ajuste
      
      switch(adj_num)                          //verifica adj_num
      {
         case 1:                               //caso 1 incrementa a dezena das horas
            switch(new_prog)                   //de acordo com new_prog
            {
               case 1: horas_0  += 10; break;
               case 3: horas_1  += 10; break;
               case 5: horas_2  += 10; break;
               case 7: horas_3  += 10; break;
               
            } //end switch new_prog
            break;
            
         case 2:                               //caso 2 incrementa a unidade das horas
            switch(new_prog)                   //de acordo com new_prog
            {
               case 1: horas_0  += 1; break;
               case 3: horas_1  += 1; break;
               case 5: horas_2  += 1; break;
               case 7: horas_3  += 1; break;

            } //end switch new_prog
            break;
            
         case 3:                               //caso 3 incrementa a dezena dos minutos
            switch(new_prog)                   //de acordo com new_prog
            {
               case 1: minutos_0 += 10; break;
               case 3: minutos_1 += 10; break;
               case 5: minutos_2 += 10; break;
               case 7: minutos_3 += 10; break;

            } //end switch new_prog
            break;
            
         case 4:                               //caso 4 incrementa a unidade dos minutos
            switch(new_prog)                   //de acordo com new_prog
            {
               case 1: minutos_0 += 1; break;
               case 3: minutos_1 += 1; break;
               case 5: minutos_2 += 1; break;
               case 7: minutos_3 += 1; break;

            } //end switch new_prog
            break;
      
      } //end switch
      
      delay_ms(50);                            //anti-bouncing
      
      if(horas_0 > 23)   horas_0   = 0;        //se horas maior que 23, volta para 0
      if(minutos_0 > 59) minutos_0 = 0;        //se minutos maior que 59, volta para 0
      if(horas_1 > 23)   horas_1   = 0;        //se horas maior que 23, volta para 0
      if(minutos_1 > 59) minutos_1 = 0;        //se minutos maior que 59, volta para 0
      if(horas_2 > 23)   horas_2   = 0;        //se horas maior que 23, volta para 0
      if(minutos_2 > 59) minutos_2 = 0;        //se minutos maior que 59, volta para 0
      if(horas_3 > 23)   horas_3   = 0;        //se horas maior que 23, volta para 0
      if(minutos_3 > 59) minutos_3 = 0;        //se minutos maior que 59, volta para 0
   
   } //end if plus
   
   if(adj_watch && adj_watch_f)                //bot�o adj_watch solto e flag setada?
   {                                           //sim
      adj_watch_f = 0x00;                      //limpa flag
      
      adj_num += 1;                            //incrementa adj_num
      
      delay_ms(50);                            //anti-bouncing

      
      if(adj_num > 4) adj_num = 0;             //se adj_num maior que 4, volta para 0
   
   
   } //end if adj_watch
   
   if(adj_prog && adj_prog_f)                  //bot�o adj_prog solto e flag setada?
   {                                           //sim
      adj_prog_f = 0x00;                       //limpa flag
      
      
      new_prog += 1;                           //incrementa new_prog
      run_prog += 1;                           //incrementa run_prog
      
      delay_ms(50);                            //anti-boucing
      
      if(new_prog > 8) new_prog = 1;           //se new_prog maior que 8, volta para 1
      if(run_prog > 2) run_prog = 1;
   
   } //end if adj_prog


} //end read_bts


// ============================================================================
// --- Fun��o para Multiplexa��o e Controle do Display ---
void multiplex()
{
   static char control = 1;                    //vari�vel local est�tica para controle do d�gito acionado

   
   if(!dig_mil && control == 1)                //D�gito dos milhares desligado?
   {                                           //Vari�vel de controle igual a 1?
      control = 0x02;                          //Sim, control recebe o valor 2
      dig_pts = 0x00;                          //Apaga d�gito dos pontos
      dig_uni = 0x00;                          //Apaga d�gito das unidades
      dig_dez = 0x00;                          //Apaga d�gito das dezenas
      dig_cen = 0x00;                          //Apaga d�gito das centenas
      PORTB   = 0x00;                          //Desliga PORTB
      mil = (hr_disp/10);                      //Calcula o d�gito do milhar
      dig_mil = 0x01;                          //Ativa d�gito dos milhares
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2:
         case 4:
         case 6: PORTB = 0x73; break;          //caso 2/4/6, imprime "P"
         case 8: PORTB = 0x74; break;          //caso 8    , imprime "h"
         
         default:                              //demais casos
            if(adj_num != 1 || !blk)           //se adj_num diferente de 1 ou blk em low...
              PORTB = disp_cath(mil);          //...escreve o valor no display
            else PORTB = 0;                    //sen�o, limpa display
      
      } //end switch
      
   } //end dig mil
   
   else if(!dig_cen && control == 2)           //D�gito das centenas desligado?
   {                                           //Vari�vel de controle igual a 2?
      control = 0x03;                          //Sim, control recebe o valor 3
      dig_pts = 0x00;                          //Apaga d�gito dos pontos
      dig_uni = 0x00;                          //Apaga d�gito das unidades
      dig_dez = 0x00;                          //Apaga d�gito das dezenas
      dig_mil = 0x00;                          //Apaga d�gito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB
      cen = (hr_disp%10);                      //Calcula o d�gito da centena
      dig_cen = 0x01;                          //Ativa d�gito das centenas
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2:
         case 4:
         case 6: PORTB = 0x50; break;          //caso 2/4/6, imprime "r"
         case 8: PORTB = 0x5C; break;          //caso 8    , imprime "o"

         default:                              //demais casos
            if(adj_num != 2 || !blk)           //se adj_num diferente de 2 ou blk em low...
              PORTB = disp_cath(cen);          //...escreve o valor no display
            else PORTB = 0;                    //sen�o, limpa display

      } //end switch


   } //end dig cen
   
   else if(!dig_dez && control == 3)           //D�gito das dezenas desligado?
   {                                           //Vari�vel de controle igual a 3?
      control = 0x04;                          //Sim, control recebe o valor 4
      dig_pts = 0x00;                          //Apaga d�gito dos pontos
      dig_uni = 0x00;                          //Apaga d�gito das unidades
      dig_cen = 0x00;                          //Apaga d�gito das centenas
      dig_mil = 0x00;                          //Apaga d�gito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB
      dez = (mn_disp/10);                      //Calcula o d�gito da dezena
      dig_dez = 0x01;                          //Ativa d�gito das dezenas
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2:
         case 4:
         case 6: PORTB = 0x5C; break;          //caso 2/4/6, imprime "o"
         case 8: PORTB = 0x1C; break;          //caso 8    , imprime "u"

         default:                              //demais casos
            if(adj_num != 3 || !blk)           //se adj_num diferente de 3 ou blk em low...
              PORTB = disp_cath(dez);          //...escreve o valor no display
            else PORTB = 0;                    //sen�o, limpa display

      } //end switch


   } //end dig dez
   
   else if(!dig_uni && control == 4)           //D�gito das unidades desligado?
   {                                           //Vari�vel de controle igual a 4?
      control = 0x05;                          //Sim, control recebe o valor 5
      dig_pts = 0x00;                          //Apaga d�gito dos pontos
      dig_dez = 0x00;                          //Apaga d�gito das dezenas
      dig_cen = 0x00;                          //Apaga d�gito das centenas
      dig_mil = 0x00;                          //Apaga d�gito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB
      uni = (mn_disp%10);                      //Calcula o d�gito da unidade
      dig_uni = 0x01;                          //Ativa d�gito das unidades
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2: PORTB = disp_cath(1); break;  //caso 2, imprime "1"
         case 4: PORTB = disp_cath(2); break;  //caso 4, imprime "2"
         case 6: PORTB = disp_cath(3); break;  //caso 6, imprime "3"
         case 8: PORTB = 0x50; break;          //caso 8    , imprime "r"

         default:                              //demais casos
            if(adj_num != 4 || !blk)           //se adj_num diferente de 4 ou blk em low...
              PORTB = disp_cath(uni);          //...escreve o valor no display
            else PORTB = 0;                    //sen�o, limpa display

      } //end switch


   } //end dig uni
   
   
   else if(!dig_pts && control == 5)           //D�gito dos pontos desligado?
   {                                           //Vari�vel de controle igual a 5?
      control = 0x01;                          //Sim, control recebe o valor 1
      dig_uni = 0x00;                          //Apaga d�gito das unidades
      dig_dez = 0x00;                          //Apaga d�gito das dezenas
      dig_cen = 0x00;                          //Apaga d�gito das centenas
      dig_mil = 0x00;                          //Apaga d�gito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB

      dig_pts = 0x01;                          //Ativa d�gito dos pontos

      if(!debug_clk)                           //se debug_clk em low...
          PORTB = 0x10;                        //...escreve o valor no display (pontos acesos)
      else  PORTB = 0;                         //sen�o, limpa display

   } //end dig uni

   
} //end multiplex


// ============================================================================
// --- Fun��o convers�o de n�mero em BCD ---
char disp_cath(char num)
{
   char cathode;                              //armazena c�digo BCD

   //Vetor para o c�digo BCD
   char segmento[10] = {0x3F,                  //BCD zero   '0'
                        0x06,                  //BCD um     '1'
                        0x5B,                  //BCD dois   '2'
                        0x4F,                  //BCD tr�s   '3'
                        0x66,                  //BCD quatro '4'
                        0x6D,                  //BCD cinco  '5'
                        0x7D,                  //BCD seis   '6'
                        0x07,                  //BCD sete   '7'
                        0x7F,                  //BCD oito   '8'
                        0x67};                 //BCD nove   '9'


    cathode = segmento[num];                   //salva dado BCD em cathode

    return(cathode);                           //retorna o n�mero BCD

} //end display
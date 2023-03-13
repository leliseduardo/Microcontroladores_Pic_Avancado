/* ============================================================================

   Projetos Aplicados com PIC Mid-Range

   Alimentador Programável para Pets (Projeto 3)

   Temporizador onde o usuário programa os horários para alimentar o seu animal 
   de estimação. Nos horários programados, haverá aviso sonoro (buzzer), visual (LED)
   e a movimentação de um servo motor (caso deseje-se implementar uma estrutura 
   mecânica para liberar a ração automaticamente).
   OBS.: Além do servo, o controle de um motor DC comum pode ser implementado.
   
   OBS2.: Optou-se apenas pela utilização do motor DC, devido ao projeto da
   estrutura mecânica estar baseada neste tipo de atuador.

   O sistema contará com Botões de ajuste e interface por display de 7 segmentos.

   Formato do Relógio:

   Apresentará horas e minutos, além dos horários programados.
   00 a 24 Horas, ajustáveis via botões.


   Compilador: MikroC Pro For PIC v.4.15.0.0

   MCU: PIC16F876A   Clock: Externo 16MHz   CM: 250ns

   Autor: Eng. Wagner Rambo

   Data: Maio de 2018

============================================================================ */


// ============================================================================
// --- Mapeamento de Hardware ---
#define    plus        RA0_bit                 //Botão para incrementar valores
#define    adj_watch   RA1_bit                 //Botão para ajuste dos dígitos
#define    adj_prog    RA2_bit                 //Botão para ajuste dos programas
#define    motor       RA5_bit                 //Motor DC que acionará a mecânica do alimentador

#define    debug_clk   RC0_bit                 //saída para debug da base de tempo
#define    buzz        RC1_bit                 //saída para acionamento do buzzer
#define    led         RC2_bit                 //saída para led de indicação
#define    dig_pts     RC3_bit                 //saída para controle do dígito dos pontos
#define    dig_uni     RC4_bit                 //saída para controle do dígito das unidades
#define    dig_dez     RC5_bit                 //saída para controle do dígito das dezenas
#define    dig_cen     RC6_bit                 //saída para controle do dígito das centenas
#define    dig_mil     RC7_bit                 //saída para controle do dígito dos milhares


// ============================================================================
// --- Flags Auxiliares ---
#define    plus_f      flagsA.B0               //flag para o botão de incremento simples
#define    adj_watch_f flagsA.B1               //flag para o botão de seleção de ajuste
#define    adj_prog_f  flagsA.B2               //flag para o botão de ajuste dos programas
#define    feed2       flagsA.B4               //flag de indicação de alimentação 2
#define    feed        flagsA.B5               //flag de indicação de alimentação
#define    run_sys     flagsA.B6               //flag para ativar o modo de ajuste
#define    blk         flagsA.B7               //flag para indicação de parâmetro ajustável


// ============================================================================
// --- Protótipo das Funções ---
void update_data();                            //Função para Atualização de Dados
void read_bts();                               //Função para leitura dos botões
void multiplex();                              //Função para controle do display
char disp_cath(char num);                      //Função para exibição dos números em BCD


// ============================================================================
// --- Protótipo das Funções Externas ---
extern void relogio();                         //Função de controle das variáveis do relógio
extern void check_clk();                       //Função para acionamento e alarme

         
// ============================================================================
// --- Variáveis Globais ---
int            counter_T0 = 0x00;              //contador auxiliar para o Timer0

char           flagsA     = 0x00,              //Registrador para flags auxiliares
               counter_bk = 0x00,              //contador auxiliar para base de tempo de blk
               adj_num    = 0x00,              //número atual do ajuste
               new_prog   = 0x01,              //número para controle de ajuste de programações
               run_prog   = 0x01,              //número para controle de parâmetros a exibir
               mil,                            //armazena milhares para o display
               cen,                            //armazena centenas para o display
               dez,                            //armazena dezenas para o display
               uni,                            //armazena unidades para o display
               hr_disp    = 0x00,              //hora mostrada no display
               mn_disp    = 0x00,              //minuto mostrado no display
               horas_0    = 0x00,              //armazena as horas do relógio
               minutos_0  = 0x00,              //armazena os minutos do relógio
               segundos_0 = 0x00,              //armazena os segundos do relógio
               horas_1    = 0x00,              //armazena as horas do programa 1
               minutos_1  = 0x00,              //armazena os minutos do programa 1
               horas_2    = 0x00,              //armazena as horas do programa 2
               minutos_2  = 0x00,              //armazena os minutos do programa 2
               horas_3    = 0x00,              //armazena as horas do programa 3
               minutos_3  = 0x00,              //armazena os minutos do programa 3
               adj_count  = 0x00,              //contador para controle de acionamento
               feed_count = 0x00;              //contador para tempo de alimentação

unsigned char  feed_count2= 0x00;              //contador para tempo de alimentação 2
             

// ============================================================================
// --- Interrupções ---
void interrupt()
{
   if(TMR0IF_bit)                              //Houve o estouro do Timer0?
   {                                           //Sim...

      TMR0IF_bit   = 0x00;                     //Limpa flag
      TMR0         = 0x06;                     //Reinicia Timer0
      counter_T0  += 0x01;                     //Incrementa counter_T0
      counter_bk  += 0x01;                     //Incrementa counter_bk

      // == BASE DE TEMPO DE 2ms ==
      multiplex();                             //chama função de multiplexação
      
      if(counter_bk == 100)                    //counter_bk igual a 100?
      {                                        //sim
         counter_bk = 0x00;                    //reinicia counter_bk
         
         // == BASE DE TEMPO DE 200 ms ==
         blk = ~blk;                           //inverte blk (parâmetro a ser ajustado pisca)
         
      } //end if counter_bk

      if(counter_T0 == 250)                    //counter igual a 250?
      {                                        //sim
         counter_T0 = 0x00;                    //reinicia counter

         // == BASE DE TEMPO DE 500 ms ==
         debug_clk = ~debug_clk;               //inverte o estado da saída de debug
         
         if(!debug_clk) relogio();             //chama função do relógio quando debug_clk for low
         
         
         // == Verificação de "pressionar mantido" no botão Plus ==
         if(plus_f) adj_count+=1;              //incrementa adj_count, se plus_f setada
         if(adj_count == 4)                    //adj_count igual a 4?
         {                                     //sim, passaram 2 segundos...
            adj_count = 0x00;                  //reinicia
            run_sys   = ~run_sys;              //inverte estado de run_sys

         } //end if adj_count
         
         // == Verificação de igualmente entre horários programados ==
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
// --- Função Principal ---
void main()
{

   CMCON        = 0x07;                        //Desabilita comparadores
   ADCON1       = 0x07;                        //Configura todos I/Os como digitais

   OPTION_REG   = 0x84;                        //Desabilita resistores de pull-up internos, prescaler 1:32 associado ao Timer0
   GIE_bit      = 0x01;                        //Habilita interrupção global
   TMR0IE_bit   = 0x01;                        //Habilita interrupção do timer0
   TMR0         = 0x06;                        //Inicializa Timer0 em 6

   // == CÁLCULO DE OVERFLOW TIMER0 ==
   //
   //  T0_ovf = (256 - TMR0) x PS x CM
   //  T0_ovf = (256 -   6 ) x 32 x 250E-9
   //  T0_ovf = 2ms
   //
  
   TRISA.RA5    = 0x00;                        //Configura RA5 como saída digital
   motor        = 0x00;                        //motor inicia desligado
   TRISB        = 0x80;                        //Configura todo PORTB como saída, exceto RB7
   PORTB        = 0x80;                        //Inicializa PORTB
   TRISC        = 0x00;                        //Configura todo PORTD como saída
   PORTC        = 0x00;                        //Inicializa PORTC


   while(1)                                    //Loop Infinito
   {
      read_bts();                              //lê botões
      update_data();                           //atualiza dados
      
      if(run_sys) check_clk();                 //compara horários, se run_sys setada

      led = run_sys;                           //led recebe o estado atual de run_sys

   } //end while


} //end main


// ============================================================================
// --- Desenvolvimento das Funções ---


// ============================================================================
// --- Função para Atualização de Dados ---
void update_data()
{
   switch(new_prog)                            //verifica new_prog
   {
      case 1:                                  //caso 1
         hr_disp   = horas_0;                  //mostra horas do relógio
         mn_disp   = minutos_0;                //mostra minutos do relógio
         break;
      case 2:                                  //caso 2
         delay_ms(741);                        //aguarda
         new_prog+=1;                          //avança new_prog
         break;
      case 3:                                  //caso 3
         hr_disp   = horas_1;                  //mostra horas do programa 1
         mn_disp   = minutos_1;                //mostra minutos do programa 1
         break;
      case 4:                                  //caso 4
         delay_ms(741);                        //aguarda
         new_prog+=1;                          //avança new_prog
         break;
      case 5:                                  //caso 5
         hr_disp   = horas_2;                  //mostra horas do programa 2
         mn_disp   = minutos_2;                //mostra minutos do programa 2
         break;
      case 6:                                  //caso 6
         delay_ms(741);                        //aguarda
         new_prog+=1;                          //avança new_prog
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
// --- Função para Leitura dos Botões ---
void read_bts()
{
   if(!plus)      plus_f      = 0x01;          //seta flag plus_f, se plus pressionado
   if(!adj_watch) adj_watch_f = 0x01;          //seta flag adj_watch_f, se adj_watch pressionado
   if(!adj_prog)  adj_prog_f  = 0x01;          //seta flag adj_prog_f, se adj_prog pressionado
   
   if(plus && plus_f)                          //botão plus solto e flag setada?
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
   
   if(adj_watch && adj_watch_f)                //botão adj_watch solto e flag setada?
   {                                           //sim
      adj_watch_f = 0x00;                      //limpa flag
      
      adj_num += 1;                            //incrementa adj_num
      
      delay_ms(50);                            //anti-bouncing

      
      if(adj_num > 4) adj_num = 0;             //se adj_num maior que 4, volta para 0
   
   
   } //end if adj_watch
   
   if(adj_prog && adj_prog_f)                  //botão adj_prog solto e flag setada?
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
// --- Função para Multiplexação e Controle do Display ---
void multiplex()
{
   static char control = 1;                    //variável local estática para controle do dígito acionado

   
   if(!dig_mil && control == 1)                //Dígito dos milhares desligado?
   {                                           //Variável de controle igual a 1?
      control = 0x02;                          //Sim, control recebe o valor 2
      dig_pts = 0x00;                          //Apaga dígito dos pontos
      dig_uni = 0x00;                          //Apaga dígito das unidades
      dig_dez = 0x00;                          //Apaga dígito das dezenas
      dig_cen = 0x00;                          //Apaga dígito das centenas
      PORTB   = 0x00;                          //Desliga PORTB
      mil = (hr_disp/10);                      //Calcula o dígito do milhar
      dig_mil = 0x01;                          //Ativa dígito dos milhares
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2:
         case 4:
         case 6: PORTB = 0x73; break;          //caso 2/4/6, imprime "P"
         case 8: PORTB = 0x74; break;          //caso 8    , imprime "h"
         
         default:                              //demais casos
            if(adj_num != 1 || !blk)           //se adj_num diferente de 1 ou blk em low...
              PORTB = disp_cath(mil);          //...escreve o valor no display
            else PORTB = 0;                    //senão, limpa display
      
      } //end switch
      
   } //end dig mil
   
   else if(!dig_cen && control == 2)           //Dígito das centenas desligado?
   {                                           //Variável de controle igual a 2?
      control = 0x03;                          //Sim, control recebe o valor 3
      dig_pts = 0x00;                          //Apaga dígito dos pontos
      dig_uni = 0x00;                          //Apaga dígito das unidades
      dig_dez = 0x00;                          //Apaga dígito das dezenas
      dig_mil = 0x00;                          //Apaga dígito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB
      cen = (hr_disp%10);                      //Calcula o dígito da centena
      dig_cen = 0x01;                          //Ativa dígito das centenas
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2:
         case 4:
         case 6: PORTB = 0x50; break;          //caso 2/4/6, imprime "r"
         case 8: PORTB = 0x5C; break;          //caso 8    , imprime "o"

         default:                              //demais casos
            if(adj_num != 2 || !blk)           //se adj_num diferente de 2 ou blk em low...
              PORTB = disp_cath(cen);          //...escreve o valor no display
            else PORTB = 0;                    //senão, limpa display

      } //end switch


   } //end dig cen
   
   else if(!dig_dez && control == 3)           //Dígito das dezenas desligado?
   {                                           //Variável de controle igual a 3?
      control = 0x04;                          //Sim, control recebe o valor 4
      dig_pts = 0x00;                          //Apaga dígito dos pontos
      dig_uni = 0x00;                          //Apaga dígito das unidades
      dig_cen = 0x00;                          //Apaga dígito das centenas
      dig_mil = 0x00;                          //Apaga dígito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB
      dez = (mn_disp/10);                      //Calcula o dígito da dezena
      dig_dez = 0x01;                          //Ativa dígito das dezenas
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2:
         case 4:
         case 6: PORTB = 0x5C; break;          //caso 2/4/6, imprime "o"
         case 8: PORTB = 0x1C; break;          //caso 8    , imprime "u"

         default:                              //demais casos
            if(adj_num != 3 || !blk)           //se adj_num diferente de 3 ou blk em low...
              PORTB = disp_cath(dez);          //...escreve o valor no display
            else PORTB = 0;                    //senão, limpa display

      } //end switch


   } //end dig dez
   
   else if(!dig_uni && control == 4)           //Dígito das unidades desligado?
   {                                           //Variável de controle igual a 4?
      control = 0x05;                          //Sim, control recebe o valor 5
      dig_pts = 0x00;                          //Apaga dígito dos pontos
      dig_dez = 0x00;                          //Apaga dígito das dezenas
      dig_cen = 0x00;                          //Apaga dígito das centenas
      dig_mil = 0x00;                          //Apaga dígito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB
      uni = (mn_disp%10);                      //Calcula o dígito da unidade
      dig_uni = 0x01;                          //Ativa dígito das unidades
      
      switch(new_prog)                         //verifica new_prog
      {
         case 2: PORTB = disp_cath(1); break;  //caso 2, imprime "1"
         case 4: PORTB = disp_cath(2); break;  //caso 4, imprime "2"
         case 6: PORTB = disp_cath(3); break;  //caso 6, imprime "3"
         case 8: PORTB = 0x50; break;          //caso 8    , imprime "r"

         default:                              //demais casos
            if(adj_num != 4 || !blk)           //se adj_num diferente de 4 ou blk em low...
              PORTB = disp_cath(uni);          //...escreve o valor no display
            else PORTB = 0;                    //senão, limpa display

      } //end switch


   } //end dig uni
   
   
   else if(!dig_pts && control == 5)           //Dígito dos pontos desligado?
   {                                           //Variável de controle igual a 5?
      control = 0x01;                          //Sim, control recebe o valor 1
      dig_uni = 0x00;                          //Apaga dígito das unidades
      dig_dez = 0x00;                          //Apaga dígito das dezenas
      dig_cen = 0x00;                          //Apaga dígito das centenas
      dig_mil = 0x00;                          //Apaga dígito dos milhares
      PORTB   = 0x00;                          //Desliga PORTB

      dig_pts = 0x01;                          //Ativa dígito dos pontos

      if(!debug_clk)                           //se debug_clk em low...
          PORTB = 0x10;                        //...escreve o valor no display (pontos acesos)
      else  PORTB = 0;                         //senão, limpa display

   } //end dig uni

   
} //end multiplex


// ============================================================================
// --- Função conversão de número em BCD ---
char disp_cath(char num)
{
   char cathode;                              //armazena código BCD

   //Vetor para o código BCD
   char segmento[10] = {0x3F,                  //BCD zero   '0'
                        0x06,                  //BCD um     '1'
                        0x5B,                  //BCD dois   '2'
                        0x4F,                  //BCD três   '3'
                        0x66,                  //BCD quatro '4'
                        0x6D,                  //BCD cinco  '5'
                        0x7D,                  //BCD seis   '6'
                        0x07,                  //BCD sete   '7'
                        0x7F,                  //BCD oito   '8'
                        0x67};                 //BCD nove   '9'


    cathode = segmento[num];                   //salva dado BCD em cathode

    return(cathode);                           //retorna o número BCD

} //end display
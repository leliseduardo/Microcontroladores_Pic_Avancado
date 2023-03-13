


// ============================================================================
// --- Mapeamento de Hardware ---
#define    plus        RA0_bit                 //Bot�o para incrementar valores
#define    plus10      RA1_bit                 //Bot�o para decrementar valores
#define    adj_watch   RA2_bit                 //Bot�o para ajuste das horas
#define    relay       RB4_bit                 //sa�da para acionamento do rel�
#define    led         RB5_bit                 //sa�da para led de indica��o


// ============================================================================
// --- Flags Auxiliares ---
#define    plus_f      flagsA.B0               //flag para o bot�o de incremento simples
#define    plus10_f    flagsA.B1               //flag para o bot�o de incremento de 10
#define    adj_watch_f flagsA.B2               //flag para o bot�o de sele��o de ajuste


// ============================================================================
// --- Vari�veis Externas ---
extern char         *text1,                    //Ponteiro para texto do rel�gio no LCD
                    *text2,                    //Ponteuro para texto do despertador no LCD
                    flagsA,                    //Registrador para flags auxiliares
                    ctrl_watch,                //Controle do ajuste do rel�gio
                    dias,                      //armazena o dia
                    horas,                     //armazena a hora
                    minutos,                   //armazena o minuto
                    segundos,                  //armazena o segundo
                    a_dias,                    //armazena o dia do despertador
                    a_horas,                   //armazena a hora do despertador
                    a_minutos,                 //armazena o minuto do despertador
                    a_segundos;                //armazena o segundo do despertador



// ============================================================================
// --- FUN��ES DO REL�GIO ---


// ============================================================================
// --- Realiza as compara��es para despertar ---
void despertar()                               //Fun��o do despertador
{


//Se as vari�veis do rel�gio e do alarme forem iguais...
     if(segundos == a_segundos)
     {
       if(minutos == a_minutos)
       {
         if(horas == a_horas)
         {
          if(dias == a_dias)
          {                                    //Hora de despertar??

              relay = 0x01;                    //Liga o rel�
              led   = 0x01;                    //Liga LED

          } //end if dias

         } //end if horas

       } //end if minutos

     } //end if segundos

} //end despertar


// ============================================================================
// --- Exibe Hor�rio Atual ---
void disp_horario()                            //Fun��o para exibir a hora atual
{

     //Atribui o valor das vari�veis do rel�gio aos elementos da string
     text1[7] = segundos%10 + '0';
     text1[6] = segundos/10 + '0';
     text1[4] = minutos%10 + '0';
     text1[3] = minutos/10 + '0';
     text1[1] = horas%10 + '0';
     text1[0] = horas/10 + '0';

     Lcd_Chr(1,5, text1[0]);                   //Imprimi o hor�rio no display
     Lcd_Chr_Cp  (text1[1]);                   //
     Lcd_Chr_Cp  (text1[2]);                   //
     Lcd_Chr_Cp  (text1[3]);                   //
     Lcd_Chr_Cp  (text1[4]);                   //
     Lcd_Chr_Cp  (text1[5]);                   //
     Lcd_Chr_Cp  (text1[6]);                   //
     Lcd_Chr_Cp  (text1[7]);                   //

     switch(dias)                              //Converte n�mero do dia para nome do dia
     {
        case 0:
             Lcd_Chr(1,14,'D');
             Lcd_Chr_Cp  ('O');
             Lcd_Chr_Cp  ('M');
             break;
        case 1:
             Lcd_Chr(1,14,'S');
             Lcd_Chr_Cp  ('E');
             Lcd_Chr_Cp  ('G');
             break;
        case 2:
             Lcd_Chr(1,14,'T');
             Lcd_Chr_Cp  ('E');
             Lcd_Chr_Cp  ('R');
             break;
        case 3:
             Lcd_Chr(1,14,'Q');
             Lcd_Chr_Cp  ('U');
             Lcd_Chr_Cp  ('A');
             break;
        case 4:
             Lcd_Chr(1,14,'Q');
             Lcd_Chr_Cp  ('U');
             Lcd_Chr_Cp  ('I');
             break;
        case 5:
             Lcd_Chr(1,14,'S');
             Lcd_Chr_Cp  ('E');
             Lcd_Chr_Cp  ('X');
             break;
        case 6:
             Lcd_Chr(1,14,'S');
             Lcd_Chr_Cp  ('A');
             Lcd_Chr_Cp  ('B');
             break;

     } //end switch


} //end relogio


// ============================================================================
// --- Atualiza o Hor�rio ---
void relogio()                                 //Fun��o para controle das vari�veis do rel�gio
{
     segundos++;                               //Incrementa os segundos

     if(segundos == 0x3c)                      //Segundos igual a 60?
     {                                         //Sim...
         segundos = 0x00;                      //Reinicia os segundos
         minutos++;                            //Incrementa os minutos

         if(minutos == 0x3c)                   //Minutos igual a 60?
         {                                     //Sim...
            minutos = 0x00;                    //Reinicia os minutos
            horas++;                           //Incrementa as horas

            if(horas == 0x18)                  //Horas igual a 24 ?
            {                                  //Sim...
               horas = 0x00;                   //Reinicia as horas
               dias++;                         //Incrementa os dias

               if(dias == 0x07) dias = 0x00;   //Se dias igual a 7, reinicia


            } //end if horas

         } //end if minutos

     } //end if segundos

} //end relogio


// ============================================================================
// --- Ajusta Rel�gio ---
void ajusta_relogio()                          //Fun��o para ajuste do rel�gio
{

     char i = 0;                               //Vari�vel para itera��es

     if(!plus)       plus_f      = 0x01;       //Se pressionar o bot�o 'mais', seta a flag
     if(!plus10)     plus10_f    = 0x01;       //Se pressionar o bot�o 'mais 10', seta a flag
     if(!adj_watch)  adj_watch_f = 0x01;       //Se pressionar o bot�o 'ajuste das horas', seta a flag


     if(adj_watch && adj_watch_f)              //Soltou bot�o de ajuste e flag setada?
     {                                         //Sim...
        adj_watch_f = 0x00;                    //Limpa flag05
        ctrl_watch++;                          //Incrementa vari�vel de controle do ajuste

        //Reinicia vari�vel de controle se for maior que 5:
        if(ctrl_watch > 0x05) ctrl_watch = 0x00;

     } //end if adj_watch


     switch(ctrl_watch)                        //Verifica vari�vel de controle de ajuste das horas
     {
        case 0x00:                             //Caso seja igual a 0
                Lcd_Chr (1,1,' ');
                Lcd_Chr (2,5,'^');             //Demonstra ajuste das horas
                Lcd_Chr_Cp  ('^');
                Lcd_Chr (2,8,' ');
                Lcd_Chr_Cp  (' ');
                Lcd_Chr(2,11,' ');
                Lcd_Chr_Cp  (' ');
                break;
        case 0x01:                             //Caso seja igual a 1
                Lcd_Chr (2,5,' ');
                Lcd_Chr_Cp  (' ');
                Lcd_Chr (2,8,'^');             //Demonstra ajuste dos minutos
                Lcd_Chr_Cp  ('^');
                Lcd_Chr(2,11,' ');
                Lcd_Chr_Cp  (' ');
                break;
        case 0x02:                             //Caso seja igual a 2
                Lcd_Chr (2,5,' ');
                Lcd_Chr_Cp  (' ');
                Lcd_Chr (2,8,' ');
                Lcd_Chr_Cp  (' ');
                Lcd_Chr(2,11,'^');             //Demonstra ajuste dos segundos
                Lcd_Chr_Cp  ('^');
                break;
        case 0x03:                             //Caso seja igual a 3
                Lcd_Chr (2,5,' ');             //Demonstra ajuste dos dias
                Lcd_Chr_Cp  (' ');
                Lcd_Chr (2,8,' ');
                Lcd_Chr_Cp  (' ');
                Lcd_Chr(2,11,' ');
                Lcd_Chr_Cp  (' ');
                Lcd_Chr(2,14,'^');
                break;

        case 0x04:                             //Caso seja igual a 5
                despertar();                                   //Desperta!
                  if(minutos == (a_minutos + 10))
                  {
                     relay = 0x00;                 //Desliga rel� ap�s 10 minutos
                     led   = 0x00;                 //Desliga led  ap�s 10 minutos

                  }
                Lcd_Chr(1,1,'D');
                for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
                break;
        case 0x05:                             //Caso seja igual a 5
                Lcd_Chr(1,1,' ');
                for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
                break;
     } //end switch ctrl_watch


           if(plus && plus_f)                  //Bot�o 'mais' foi solto e a flag foi setada?
           {                                   //Sim...
              plus_f = 0x00;                   //Limpa a flag07

              switch(ctrl_watch)               //Switch na vari�vel de controle
              {
                case 0x00:                     //Caso 0, libera ajuste das horas, incremento de unidades
                      horas++;
                      if(horas > 0x17) horas = 0x00;
                      break;
                case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de unidades
                      minutos++;
                      if(minutos > 0x3b) minutos = 0x00;
                      break;
                case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de unidades
                      segundos++;
                      if(segundos > 0x3b) segundos = 0x00;
                      break;
                case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
                      dias++;
                      if(dias > 0x06) dias = 0x00;
                      break;
              } //end switch
           } //end if plus

           if(plus10 && plus10_f)              //Bot�o 'mais10' solto e a flag foi setada?
           {                                   //Sim...
              plus10_f = 0x00;                 //Limpa a flag06

              switch(ctrl_watch)        //Switch na vari�vel de controle
              {
                case 0x00:
                      horas = horas + 10;      //Caso 0, libera ajuste das horas, incremento de dezenas
                      if(horas > 0x17) horas = 0x00;
                      break;
                case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de dezenas
                      minutos = minutos + 10;
                      if(minutos > 0x3b) minutos = 0x00;
                      break;
                case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de dezenas
                      segundos = segundos + 10;
                      if(segundos > 0x3b) segundos = 0x00;
                      break;
                case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
                      dias++;
                      if(dias > 0x06) dias = 0x00;
                      break;
              } //end switch

           } //end if plus10

} //end ajusta_relogio


// ============================================================================
// --- FUN��ES DO DESPERTADOR ---


// ============================================================================
// --- Mostra o despertador ---
void disp_alarme()                             //Fun��o para exibir a hora ajustada para o despertador
{

     //Atribui o valor das vari�veis do rel�gio aos elementos da string
     text2[7] = a_segundos%10 + '0';
     text2[6] = a_segundos/10 + '0';
     text2[4] = a_minutos%10 + '0';
     text2[3] = a_minutos/10 + '0';
     text2[1] = a_horas%10 + '0';
     text2[0] = a_horas/10 + '0';

     Lcd_Chr(1,5, text2[0]);                   //Imprimi o hor�rio de despertar no display
     Lcd_Chr_Cp  (text2[1]);                   //
     Lcd_Chr_Cp  (text2[2]);                   //
     Lcd_Chr_Cp  (text2[3]);                   //
     Lcd_Chr_Cp  (text2[4]);                   //
     Lcd_Chr_Cp  (text2[5]);                   //
     Lcd_Chr_Cp  (text2[6]);                   //
     Lcd_Chr_Cp  (text2[7]);                   //

     switch(a_dias)                             //Converte o n�mero dos dias em string
     {
        case 0:
             Lcd_Chr(1,14,'D');
             Lcd_Chr_Cp('O');
             Lcd_Chr_Cp('M');
             break;
        case 1:
             Lcd_Chr(1,14,'S');
             Lcd_Chr_Cp('E');
             Lcd_Chr_Cp('G');
             break;
        case 2:
             Lcd_Chr(1,14,'T');
             Lcd_Chr_Cp('E');
             Lcd_Chr_Cp('R');
             break;
        case 3:
             Lcd_Chr(1,14,'Q');
             Lcd_Chr_Cp('U');
             Lcd_Chr_Cp('A');
             break;
        case 4:
             Lcd_Chr(1,14,'Q');
             Lcd_Chr_Cp('U');
             Lcd_Chr_Cp('I');
             break;
        case 5:
             Lcd_Chr(1,14,'S');
             Lcd_Chr_Cp('E');
             Lcd_Chr_Cp('X');
             break;
        case 6:
             Lcd_Chr(1,14,'S');
             Lcd_Chr_Cp('A');
             Lcd_Chr_Cp('B');
             break;

     } //end switch


} //end disp_alarme


// ============================================================================
// --- Ajuste as vari�veis do despertador ---
void ajusta_alarme()                           //Fun��o para ajuste do despertador
{
     bit control_flag;

     char i = 0;                               //Vari�vel para itera��es

     if(!plus)       plus_f      = 0x01;       //Se pressionar o bot�o 'mais', seta a flag
     if(!plus10)     plus10_f    = 0x01;       //Se pressionar o bot�o 'mais 10', seta a flag
     if(!adj_watch)  adj_watch_f = 0x01;       //Se pressionar o bot�o 'ajuste das horas', seta a flag


     if(adj_watch && adj_watch_f)              //Soltou bot�o de ajuste e flag setada?
     {                                         //Sim...
        adj_watch_f = 0x00;                    //Limpa flag05
        ctrl_watch++;                          //Incrementa vari�vel de controle do ajuste

        //Reinicia vari�vel de controle se for maior que 5:
        if(ctrl_watch > 0x05) ctrl_watch = 0x00;

     } //end if adj_watch

     switch(ctrl_watch)                        //Switch da vari�vel de controle de ajuste das horas
     {
        case 0x00:                             //Caso seja igual a 0
                Lcd_Chr(1,1,' ');
                Lcd_Chr(2,5,'^');              //Demonstra ajuste das horas
                Lcd_Chr_Cp('^');
                Lcd_Chr(2,8,' ');
                Lcd_Chr_Cp(' ');
                Lcd_Chr(2,11,' ');
                Lcd_Chr_Cp(' ');
                control_flag = 0x00;
                break;
        case 0x01:                             //Caso seja igual a 1
                Lcd_Chr(2,5,' ');
                Lcd_Chr_Cp(' ');
                Lcd_Chr(2,8,'^');              //Demonstra ajuste dos minutos
                Lcd_Chr_Cp('^');
                Lcd_Chr(2,11,' ');
                Lcd_Chr_Cp(' ');
                break;
        case 0x02:                             //Caso seja igual a 2
                Lcd_Chr(2,5,' ');
                Lcd_Chr_Cp(' ');
                Lcd_Chr(2,8,' ');
                Lcd_Chr_Cp(' ');
                Lcd_Chr(2,11,'^');             //Demonstra ajuste dos segundos
                Lcd_Chr_Cp('^');
                break;
        case 0x03:                             //Caso seja igual a 3
                Lcd_Chr(2,5,' ');              //Demonstra ajuste dos dias
                Lcd_Chr_Cp(' ');
                Lcd_Chr(2,8,' ');
                Lcd_Chr_Cp(' ');
                Lcd_Chr(2,11,' ');
                Lcd_Chr_Cp(' ');
                Lcd_Chr(2,14,'^');
                break;
        case 0x04:
                despertar();                                   //Desperta!
                  if(minutos == (a_minutos + 10))
                  {
                     relay = 0x00;                 //Desliga rel� ap�s 10 minutos
                     led   = 0x00;                 //Desliga led  ap�s 10 minutos

                  }
                Lcd_Chr(1,1,'D');
                for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
                break;
        case 0x05:                             //Caso seja igual a 5
                Lcd_Chr(1,1,' ');
                for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' '); //Limpa display 'manualmente' a partir da quinta coluna
                break;
     }


           if(plus && plus_f)                  //Bot�o 'mais' foi solto e a flag foi setada?
           {                                   //Sim...
              plus_f = 0x00;                   //Limpa a flag07

              switch(ctrl_watch)               //Switch na vari�vel de controle
              {
                case 0x00:                     //Caso 0, libera ajuste das horas, incremento de unidades
                      a_horas++;
                      if(a_horas > 0x17) a_horas = 0x00;
                      break;
                case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de unidades
                      a_minutos++;
                      if(a_minutos > 0x3b) a_minutos = 0x00;
                      break;
                case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de unidades
                      a_segundos++;
                      if(a_segundos > 0x3b) a_segundos = 0x00;
                      break;
                case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
                      a_dias++;
                      if(a_dias > 0x06) a_dias = 0x00;
                      break;
              } //end switch
           } //end if plus

           if(plus10 && plus10_f)              //Bot�o 'mais10' solto e a flag foi setada?
           {                                   //Sim...
              plus10_f = 0x00;                 //Limpa a flag06

              switch(ctrl_watch)        //Switch na vari�vel de controle
              {
                case 0x00:
                      a_horas = a_horas + 10;      //Caso 0, libera ajuste das horas, incremento de dezenas
                      if(a_horas > 0x17) a_horas = 0x00;
                      break;
                case 0x01:                     //Caso 1, libera ajuste dos minutos, incremento de dezenas
                      a_minutos = a_minutos + 10;
                      if(a_minutos > 0x3b) a_minutos = 0x00;
                      break;
                case 0x02:                     //Caso 2, libera ajuste dos segundos, incremento de dezenas
                      a_segundos = a_segundos + 10;
                      if(a_segundos > 0x3b) a_segundos = 0x00;
                      break;
                case 0x03:                     //Caso 3, libera ajuste dos dias, incremento de unidades
                      a_dias++;
                      if(a_dias > 0x06) a_dias = 0x00;
                      break;
              } //end switch

           } //end if plus10

} //end ajusta_alarme


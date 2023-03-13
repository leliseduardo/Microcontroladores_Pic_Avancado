


// ============================================================================
// --- Mapeamento de Hardware ---
#define    plus        RA0_bit                 //Bot�o para incrementar valores
#define    adj_watch   RA2_bit                 //Bot�o para ajuste das horas
#define    buzz        RC1_bit                 //sa�da para acionamento do buzzer
#define    led         RC2_bit                 //sa�da para led de indica��o


// ============================================================================
// --- Flags Auxiliares ---
#define    plus_f      flagsA.B0               //flag para o bot�o de incremento simples
#define    adj_watch_f flagsA.B2               //flag para o bot�o de sele��o de ajuste
#define    feed2       flagsA.B4               //flag de indica��o de alimenta��o 2
#define    feed        flagsA.B5               //flag de indica��o de alimenta��o


// ============================================================================
// --- Vari�veis Externas ---
extern char         flagsA,                    //Registrador para flags auxiliares
                    horas_0,                   //armazena a hora
                    minutos_0,                 //armazena o minuto
                    segundos_0,                //armazena o segundo
                    horas_1,                   //armazena as horas do programa 1
                    minutos_1,                 //armazena os minutos do programa 1
                    horas_2,                   //armazena as horas do programa 2
                    minutos_2,                 //armazena os minutos do programa 2
                    horas_3,                   //armazena as horas do programa 3
                    minutos_3;                 //armazena os minutos do programa 3


// ============================================================================
// --- FUN��ES DO REL�GIO ---


// ============================================================================
// --- Atualiza o Hor�rio ---
void relogio()                                 //Fun��o para controle das vari�veis do rel�gio
{
     segundos_0++;                             //Incrementa os segundos

     if(segundos_0 == 0x3c)                    //Segundos igual a 60?
     {                                         //Sim...
         segundos_0 = 0x00;                    //Reinicia os segundos
         minutos_0++;                          //Incrementa os minutos

         if(minutos_0 == 0x3c)                 //Minutos igual a 60?
         {                                     //Sim...
            minutos_0 = 0x00;                  //Reinicia os minutos
            horas_0++;                         //Incrementa as horas

            if(horas_0 == 0x18) horas_0 = 0x00; //Se horas igual a 24, reinicia


         } //end if minutos

     } //end if segundos

} //end relogio


// ============================================================================
// --- Fun��o de Acionamento e Alarme ---
void check_clk()
{
   if(horas_0 == horas_1 && minutos_0 == minutos_1)
   {
      feed  = 0x01;                            //seta feed se programa 1 igual ao hor�rio
      feed2 = 0x01;                            //seta feed2 se programa 1 igual ao hor�rio
   
   }
   
   if(horas_0 == horas_2 && minutos_0 == minutos_2)
   {
      feed  = 0x01;                            //seta feed se programa 2 igual ao hor�rio
      feed2 = 0x01;                            //seta feed2 se programa 2 igual ao hor�rio

   }
   
   if(horas_0 == horas_3 && minutos_0 == minutos_3)
   {
      feed  = 0x01;                            //seta feed se programa 2 igual ao hor�rio
      feed2 = 0x01;                            //seta feed2 se programa 2 igual ao hor�rio

   }




}










/* ============================================================================

   Projetos Aplicados com PIC Mid-Range

   Despertador para Pregui�osos (Projeto 2)

   Ao inv�s de soar um alarme como um despertador convencional, a proposta
   deste dispositivo � de injetar uma tens�o de 12V provocando a queima de
   um microcontrolador PIC18F4550. Prop�sito: for�ar o usu�rio a se levantar
   da cama e desligar o despertador antes que ocorra a destrui��o do MCU,
   evitando assim um preju�zo financeiro.
   Obviamente um despertador convencional dever� ser programado pelo usu�rio
   5 ou 10 minutos antes do hor�rio de destrui��o.
   
   O sistema contar� com Bot�es de ajuste e LCD 16x2
   
   Formato do Rel�gio:
   
   Apresentar� horas, minutos, segundos e o dia da semana
   00 a 24 Horas, ajust�veis via bot�es.
   

   Compilador: MikroC Pro For PIC v.4.15.0.0

   MCU: PIC16F876A   Clock: Externo 16MHz   CM: 250ns

   Autor: Eng. Wagner Rambo

   Data: Abril de 2018

============================================================================ */

// ============================================================================
// --- Conex�es do M�dulo LCD ---
sbit LCD_RS at RC2_bit;
sbit LCD_EN at RC3_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

// --- Direcionamento dos pinos do LCD ---
sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC3_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;
//end LCD conex�es


// ============================================================================
// --- Mapeamento de Hardware ---
#define    debug_clk   RC0_bit                 //sa�da para debug da base de tempo
#define    plus        RA0_bit                 //Bot�o para incrementar valores
#define    plus10      RA1_bit                 //Bot�o para decrementar valores
#define    adj_watch   RA2_bit                 //Bot�o para ajuste das horas
#define    adj_alarm   RA3_bit                 //Bot�o para ajuste do despertador
#define    relay       RB4_bit                 //sa�da para acionamento do rel�
#define    led         RB5_bit                 //sa�da para led de indica��o


// ============================================================================
// --- Flags Auxiliares ---
#define    plus_f      flagsA.B0               //flag para o bot�o de incremento simples
#define    plus10_f    flagsA.B1               //flag para o bot�o de incremento de 10
#define    adj_watch_f flagsA.B2               //flag para o bot�o de sele��o de ajuste
#define    adj_alarm_f flagsA.B3               //flag para o bot�o de ajuste de alarme
#define    alarm_mode  flagsA.B4               //flag para indica��o do modo alarme


// ============================================================================
// --- Prot�tipo das Fun��es ---
extern void disp_horario();                    //Fun��o para mostrar as horas
extern void relogio();                         //Fun��o de controle das vari�veis do rel�gio
extern void ajusta_relogio();                  //Fun��o para ajustar o rel�gio
extern void disp_alarme();                     //Fun��o para mostrar o hor�rio do alarme
extern void ajusta_alarme();                   //Fun��o para ajustar o hor�rio do alarme
extern void despertar();                       //Fun��o para acionar o alarme na hora de despertar

// ============================================================================
// --- Vari�veis Globais ---
int          counter_T0 = 0x00;                //contador auxiliar para o Timer0

char         *text1     = "00:00:00",          //Ponteiro para texto do rel�gio no LCD
             *text2     = "00:00:00",          //Ponteuro para texto do despertador no LCD
             flagsA     = 0x00,                //Registrador para flags auxiliares
             ctrl_watch = 0x05,                //Controle do ajuste do rel�gio
             dias       = 0x00,                //armazena o dia
             horas      = 0x00,                //armazena a hora
             minutos    = 0x00,                //armazena o minuto
             segundos   = 0x00,                //armazena o segundo
             a_dias     = 0x00,                //armazena o dia do despertador
             a_horas    = 0x00,                //armazena a hora do despertador
             a_minutos  = 0x00,                //armazena o minuto do despertador
             a_segundos = 0x00;                //armazena o segundo do despertador


// ============================================================================
// --- Interrup��es ---
void interrupt()
{
   if(TMR0IF_bit)                              //Houve o estouro do Timer0?
   {                                           //Sim...

      TMR0IF_bit   = 0x00;                     //Limpa flag
      TMR0         = 0x06;                     //Reinicia Timer0
      counter_T0  += 0x01;                     //Incrementa contador T0

      // == BASE DE TEMPO DE 2ms ==
      

      if(counter_T0 == 500)                    //counter igual a 500?
      {
         counter_T0 = 0x00;                    //reinicia counter

         // == BASE DE TEMPO DE 1 segundo ==

         relogio();

         debug_clk = ~debug_clk;               //inverte o estado da sa�da de debug

      } //end if counter




     } //end if

} //end interrupt

// ============================================================================
// --- Fun��o Principal ---
void main() 
{
   TRISB        = 0xCF;                        //Configura RB4 e RB5 como sa�da
   PORTB        = 0xCF;                        //Inicializa PORTB
   
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


   TRISC        = 0x02;                        //Configura todo PORTD como sa�da, exceto RC1
   PORTC        = 0x02;                        //Inicializa PORTC
   
   Lcd_Init();                                 //Inicia m�dulo LCD
   Lcd_Cmd(_LCD_CLEAR);                        //Limpa display
   Lcd_Cmd(_LCD_CURSOR_OFF);                   //Apaga cursor

   
   
   while(1)                                    //Loop Infinito
   {
      if(!adj_alarm) adj_alarm_f = 0x01;
      if(adj_alarm && adj_alarm_f)
      {
         adj_alarm_f = 0x00;
         alarm_mode = ~alarm_mode;
      
      } //end if adj_alarm
      
      
      if(alarm_mode)
      {
         disp_alarme();
         ajusta_alarme();

      } //end if alarm_mode
      
      else
      {
         disp_horario();
         ajusta_relogio();
          
      } //end else
      
   } //end while


} //end main








/* ============================================================================

   Projetos Aplicados com PIC Mid-Range

   Despertador para Preguiçosos (Projeto 2)

   Ao invés de soar um alarme como um despertador convencional, a proposta
   deste dispositivo é de injetar uma tensão de 12V provocando a queima de
   um microcontrolador PIC18F4550. Propósito: forçar o usuário a se levantar
   da cama e desligar o despertador antes que ocorra a destruição do MCU,
   evitando assim um prejuízo financeiro.
   Obviamente um despertador convencional deverá ser programado pelo usuário
   5 ou 10 minutos antes do horário de destruição.
   
   O sistema contará com Botões de ajuste e LCD 16x2
   
   Formato do Relógio:
   
   Apresentará horas, minutos, segundos e o dia da semana
   00 a 24 Horas, ajustáveis via botões.
   

   Compilador: MikroC Pro For PIC v.4.15.0.0

   MCU: PIC16F876A   Clock: Externo 16MHz   CM: 250ns

   Autor: Eng. Wagner Rambo

   Data: Abril de 2018

============================================================================ */

// ============================================================================
// --- Conexões do Módulo LCD ---
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
//end LCD conexões


// ============================================================================
// --- Mapeamento de Hardware ---
#define    debug_clk   RC0_bit                 //saída para debug da base de tempo
#define    plus        RA0_bit                 //Botão para incrementar valores
#define    plus10      RA1_bit                 //Botão para decrementar valores
#define    adj_watch   RA2_bit                 //Botão para ajuste das horas
#define    adj_alarm   RA3_bit                 //Botão para ajuste do despertador
#define    relay       RB4_bit                 //saída para acionamento do relé
#define    led         RB5_bit                 //saída para led de indicação


// ============================================================================
// --- Flags Auxiliares ---
#define    plus_f      flagsA.B0               //flag para o botão de incremento simples
#define    plus10_f    flagsA.B1               //flag para o botão de incremento de 10
#define    adj_watch_f flagsA.B2               //flag para o botão de seleção de ajuste
#define    adj_alarm_f flagsA.B3               //flag para o botão de ajuste de alarme
#define    alarm_mode  flagsA.B4               //flag para indicação do modo alarme


// ============================================================================
// --- Protótipo das Funções ---
extern void disp_horario();                    //Função para mostrar as horas
extern void relogio();                         //Função de controle das variáveis do relógio
extern void ajusta_relogio();                  //Função para ajustar o relógio
extern void disp_alarme();                     //Função para mostrar o horário do alarme
extern void ajusta_alarme();                   //Função para ajustar o horário do alarme
extern void despertar();                       //Função para acionar o alarme na hora de despertar

// ============================================================================
// --- Variáveis Globais ---
int          counter_T0 = 0x00;                //contador auxiliar para o Timer0

char         *text1     = "00:00:00",          //Ponteiro para texto do relógio no LCD
             *text2     = "00:00:00",          //Ponteuro para texto do despertador no LCD
             flagsA     = 0x00,                //Registrador para flags auxiliares
             ctrl_watch = 0x05,                //Controle do ajuste do relógio
             dias       = 0x00,                //armazena o dia
             horas      = 0x00,                //armazena a hora
             minutos    = 0x00,                //armazena o minuto
             segundos   = 0x00,                //armazena o segundo
             a_dias     = 0x00,                //armazena o dia do despertador
             a_horas    = 0x00,                //armazena a hora do despertador
             a_minutos  = 0x00,                //armazena o minuto do despertador
             a_segundos = 0x00;                //armazena o segundo do despertador


// ============================================================================
// --- Interrupções ---
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

         debug_clk = ~debug_clk;               //inverte o estado da saída de debug

      } //end if counter




     } //end if

} //end interrupt

// ============================================================================
// --- Função Principal ---
void main() 
{
   TRISB        = 0xCF;                        //Configura RB4 e RB5 como saída
   PORTB        = 0xCF;                        //Inicializa PORTB
   
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


   TRISC        = 0x02;                        //Configura todo PORTD como saída, exceto RC1
   PORTC        = 0x02;                        //Inicializa PORTC
   
   Lcd_Init();                                 //Inicia módulo LCD
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








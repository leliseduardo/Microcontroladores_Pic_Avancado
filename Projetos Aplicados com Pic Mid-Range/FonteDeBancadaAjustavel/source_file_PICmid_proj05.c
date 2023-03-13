/* ============================================================================

   Projetos Aplicados com PIC Mid-Range

   Fonte de Bancada com Ajuste Digital (Projeto 5)

   Implemento de lógica PWM e voltímetro para controle e interface HM
   de um projeto de fonte de bancada com ajuste digital.

   O sistema contará com Botões de ajuste e LCD 16x2



   Compilador: MikroC Pro For PIC v.4.15.0.0

   MCU: PIC16F876A   Clock: Externo 16MHz   CM: 250ns

   Autor: Eng. Wagner Rambo

   Data: Junho de 2018
   
   www.wrkits.com.br

============================================================================ */

// ============================================================================
// --- Conexões do Módulo LCD ---
sbit LCD_RS at RB3_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

// --- Direcionamento dos pinos do LCD ---
sbit LCD_RS_Direction at TRISB3_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;
//end LCD conexões


// ============================================================================
// --- Mapeamento de Hardware ---
#define    bt_up       RB0_bit                 //botão up
#define    bt_down     RB1_bit                 //botão down


// ============================================================================
// --- Flags Auxiliares ---
#define    bt_up_f     flagsA.B0               //flag para estado do botão up
#define    bt_down_f   flagsA.B1               //flag para estado do botão down
#define    new_volt    flagsA.B2               //flag para fazer nova leitura de tensão


// ============================================================================
// --- Funções Protótipo ---
void v_adjust();                               //Função para ajuste de tensão
void voltmeter();                              //Função do voltímetro


// ============================================================================
// --- Variáveis Globais ---
unsigned char    flagsA     = 0x00,            //registrador de flags auxiliares
                 upcnt      = 0x00,            //controle para aumento rápido de tensão
                 dwcnt      = 0x00;            //controle para diminuição rápida de tensão

int              duty1      = 0x00,            //armazena duty cycle do PWM1
                 countT0    = 0x00,            //contador auxiliar para o Timer0
                 adc_value  = 0x00,            //armazena conteúdo do conversor AD
                 update_lcd = 0x00,            //contador para atualização do display
                 volt_i     = 0x00;            //armazena tensão em inteiros
                 
float            volt       = 0.0;             //armazena tensão em ponto flutuante





// ============================================================================
// --- Função Principal ---
void interrupt()
{
   if(TMR0IF_bit)                              //houve interrupção do Timer0?
   {                                           //sim
      TMR0IF_bit = 0x00;                       //limpa flag
      TMR0       = 56;                         //reinicializa TMR0
      countT0   += 0x01;                       //incrementa countT0
      
      // === Base de tempo de 100us ===
      
      if(countT0 == 1000)                      //countT0 igual a 1000?
      {                                        //sim
         countT0 = 0x00;                       //reinicia countT0
         update_lcd += 1;                      //incrementa update_lcd
         
         // === Base de tempo de 100ms ===
         if(bt_up_f) upcnt += 1;               //incrementa upcnt, se flag bt_up_f setada
         
         if(upcnt > 15)                        //upcnt maior ou igual a 15?
         {                                     //sim
           upcnt = 15;                         //mantém em 15
           duty1 += 10;                        //incrementa duty1 de 10 em 10 (ajuste grosso)

         } //end if upcnt
         
         
         if(bt_down_f) dwcnt += 1;             //incrementa dwcnt, se flag bt_down_f setada

         if(dwcnt > 15)                        //dwcnt maior ou igual a 15?
         {                                     //sim
           dwcnt = 15;                         //mantém em 15
           duty1 -= 10;                        //decrementa duty1 de 10 em 10 (ajuste grosso)

         } //end if dwcnt
         
         
         if(update_lcd == 5)
         {
            update_lcd = 0x00;
            new_volt   = 0x01;
         
         
         }
         

         
      } //end if countT0
   
   
   } //end TMR0IF_bit


} //end interrupt


// ============================================================================
// --- Função Principal ---
void main() 
{
   TRISB = 0xF3;                               //Configura RB0 e RB1 como entrada
   TRISC = 0x09;                               //Configura saída para os PWMs
   PORTB = 0xF3;                               //Inicializa PORTB
   PORTC = 0x09;                               //Inicializa PORTC

   ADCON0 = 0x01;
   ADCON1 = 0x4E;
   
   INTCON     = 0xA0;                          //habilita interrupção global e do Timer0
   OPTION_REG = 0x80;                          //TMR0 incrementa com ciclo de máquina, PS 1:2
   TMR0       = 56;                            //inicializa TMR0
   
   PWM1_Init(1000);                            //Inicializa PWM1 com 1kHz
   PWM2_Init(1000);                            //Inicializa PWM2 com 1kHz
   PWM1_Start();                               //Start PWM1
   PWM2_Start();                               //Start PWM2
   PWM1_Set_Duty(duty1);                       //configura duty inicial do PWM1
   PWM2_Set_Duty(128);                         //configura duty PWM2 em 50%
   
   Lcd_Init();                                 //inicializa LCD
   Lcd_Cmd(_LCD_CURSOR_OFF);                   //desliga o cursor
   Lcd_Cmd(_LCD_CLEAR);                        //limpa o LCD
   Lcd_Out(1,2,"FONTE W.R.KITS");              //envia mensagem
   new_volt = 0x01;                            //seta new_volt

   
   while(1)                                    //loop infinito
   {
      v_adjust();                              //chama a função v_adjust
      
      voltmeter();                             //chama a função do voltímetro
   
   
   } //end while

} //end main


// ============================================================================
// --- Funções Desenvolvimento ---


// ============================================================================
// --- Função para Ajuste de Tensão ---
void v_adjust()                                //Função para ajuste de tensão
{
  if(!bt_up)   bt_up_f   = 0x01;               //seta bt_up_f se bt_up pressionado
  if(!bt_down) bt_down_f = 0x01;               //seta bt_down_f se bt_down pressionado
  
  if(bt_up && bt_up_f)                         //bt_up solto e flag setada?
  {                                            //sim
     bt_up_f = 0x00;                           //limpa flag
     upcnt   = 0x00;                           //limpa flag de incremento rápido
     duty1  += 0x01;                           //incrementa duty1
  
  } //end if bt_up
  
  if(bt_down && bt_down_f)                     //bt_down solto e flag setada?
  {                                            //sim
     bt_down_f = 0x00;                         //limpa flag
     dwcnt     = 0x00;                         //limpa flag de decremento rápido
     duty1    -= 0x01;                         //decrementa duty1

  } //end if bt_up
  
  PWM1_Set_Duty(duty1);                        //atualiza duty1
  
  
  if(duty1 < 1) duty1 = 0;                     //fixa duty1 em zero, se for menor que 1 (limite inferior)

  else if(duty1 > 230) duty1 = 230;            //fixa duty1 em 230, se maior que 230 (limite superior)
  



} //end v_adjust


// ============================================================================
// --- Função do voltímetro ---
void voltmeter()
{
   char mil_v, cen_v, dez_v, uni_v;            //variáveis locais para armazenar
                                               //dezena, unidade e casas decimais da tensão
   if(new_volt || upcnt >=15 || dwcnt >= 15)
   {
      adc_value = ADC_Read(0);                    //faz leitura do canal AN0
      new_volt = 0x00;
   }
   
   volt = ((adc_value * 20.0) / 1023.0)*100.0; //cálculo da tensão em volts


   volt_i = (int)volt;                         //conversão para inteiro

   mil_v = volt_i/1000;                        //calcula dezena da tensão
   cen_v = (volt_i%1000)/100;                  //calcula unidade da tensão
   dez_v = (volt_i%100)/10;                    //calcula dezena da casa decimal
   uni_v = volt_i%10;                          //calcula unidade da casa decimal

   Lcd_Chr (2,5,mil_v+0x30);                   //envia pro LCD
   Lcd_Chr_Cp  (cen_v+0x30);                   //
   Lcd_Chr_Cp  ('.');                          //
   Lcd_Chr_Cp  (dez_v+0x30);                   //
   Lcd_Chr_Cp  (uni_v+0x30);                   //
   Lcd_Chr_Cp  ('V');                          //


} //end voltmeter








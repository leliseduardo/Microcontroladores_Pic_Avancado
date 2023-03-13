#line 1 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_005__Despertador_para_Preguiçosos_p3/PIC_mid_WR_files_005/source_file_PICmid_proj02.c"
#line 35 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_005__Despertador_para_Preguiçosos_p3/PIC_mid_WR_files_005/source_file_PICmid_proj02.c"
sbit LCD_RS at RC2_bit;
sbit LCD_EN at RC3_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;


sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC3_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;
#line 74 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_005__Despertador_para_Preguiçosos_p3/PIC_mid_WR_files_005/source_file_PICmid_proj02.c"
extern void disp_horario();
extern void relogio();
extern void ajusta_relogio();
extern void disp_alarme();
extern void ajusta_alarme();
extern void despertar();



int counter_T0 = 0x00;

char *text1 = "00:00:00",
 *text2 = "00:00:00",
 flagsA = 0x00,
 ctrl_watch = 0x05,
 dias = 0x00,
 horas = 0x00,
 minutos = 0x00,
 segundos = 0x00,
 a_dias = 0x00,
 a_horas = 0x00,
 a_minutos = 0x00,
 a_segundos = 0x00;




void interrupt()
{
 if(TMR0IF_bit)
 {

 TMR0IF_bit = 0x00;
 TMR0 = 0x06;
 counter_T0 += 0x01;




 if(counter_T0 == 500)
 {
 counter_T0 = 0x00;



 relogio();

  RC0_bit  = ~ RC0_bit ;

 }




 }

}



void main()
{
 TRISB = 0xCF;
 PORTB = 0xCF;

 CMCON = 0x07;
 ADCON1 = 0x07;

 OPTION_REG = 0x84;
 GIE_bit = 0x01;
 TMR0IE_bit = 0x01;
 TMR0 = 0x06;









 TRISC = 0x02;
 PORTC = 0x02;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);



 while(1)
 {
 if(! RA3_bit )  flagsA.B3  = 0x01;
 if( RA3_bit  &&  flagsA.B3 )
 {
  flagsA.B3  = 0x00;
  flagsA.B4  = ~ flagsA.B4 ;

 }


 if( flagsA.B4 )
 {
 disp_alarme();
 ajusta_alarme();

 }

 else
 {
 disp_horario();
 ajusta_relogio();

 }

 }


}

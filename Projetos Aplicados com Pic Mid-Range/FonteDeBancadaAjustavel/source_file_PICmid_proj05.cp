#line 1 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_014__Fonte_de_Bancada_com_Ajuste_Digital__p3/PIC_mid_WR_files_014/source_file_PICmid_proj05.c"
#line 28 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_014__Fonte_de_Bancada_com_Ajuste_Digital__p3/PIC_mid_WR_files_014/source_file_PICmid_proj05.c"
sbit LCD_RS at RB3_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;


sbit LCD_RS_Direction at TRISB3_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;
#line 60 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_014__Fonte_de_Bancada_com_Ajuste_Digital__p3/PIC_mid_WR_files_014/source_file_PICmid_proj05.c"
void v_adjust();
void voltmeter();




unsigned char flagsA = 0x00,
 upcnt = 0x00,
 dwcnt = 0x00;

int duty1 = 0x00,
 countT0 = 0x00,
 adc_value = 0x00,
 update_lcd = 0x00,
 volt_i = 0x00;

float volt = 0.0;







void interrupt()
{
 if(TMR0IF_bit)
 {
 TMR0IF_bit = 0x00;
 TMR0 = 56;
 countT0 += 0x01;



 if(countT0 == 1000)
 {
 countT0 = 0x00;
 update_lcd += 1;


 if( flagsA.B0 ) upcnt += 1;

 if(upcnt > 15)
 {
 upcnt = 15;
 duty1 += 10;

 }


 if( flagsA.B1 ) dwcnt += 1;

 if(dwcnt > 15)
 {
 dwcnt = 15;
 duty1 -= 10;

 }


 if(update_lcd == 5)
 {
 update_lcd = 0x00;
  flagsA.B2  = 0x01;


 }



 }


 }


}




void main()
{
 TRISB = 0xF3;
 TRISC = 0x09;
 PORTB = 0xF3;
 PORTC = 0x09;

 ADCON0 = 0x01;
 ADCON1 = 0x4E;

 INTCON = 0xA0;
 OPTION_REG = 0x80;
 TMR0 = 56;

 PWM1_Init(1000);
 PWM2_Init(1000);
 PWM1_Start();
 PWM2_Start();
 PWM1_Set_Duty(duty1);
 PWM2_Set_Duty(128);

 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,2,"FONTE W.R.KITS");
  flagsA.B2  = 0x01;


 while(1)
 {
 v_adjust();

 voltmeter();


 }

}








void v_adjust()
{
 if(! RB0_bit )  flagsA.B0  = 0x01;
 if(! RB1_bit )  flagsA.B1  = 0x01;

 if( RB0_bit  &&  flagsA.B0 )
 {
  flagsA.B0  = 0x00;
 upcnt = 0x00;
 duty1 += 0x01;

 }

 if( RB1_bit  &&  flagsA.B1 )
 {
  flagsA.B1  = 0x00;
 dwcnt = 0x00;
 duty1 -= 0x01;

 }

 PWM1_Set_Duty(duty1);


 if(duty1 < 1) duty1 = 0;

 else if(duty1 > 230) duty1 = 230;




}




void voltmeter()
{
 char mil_v, cen_v, dez_v, uni_v;

 if( flagsA.B2  || upcnt >=15 || dwcnt >= 15)
 {
 adc_value = ADC_Read(0);
  flagsA.B2  = 0x00;
 }

 volt = ((adc_value * 20.0) / 1023.0)*100.0;


 volt_i = (int)volt;

 mil_v = volt_i/1000;
 cen_v = (volt_i%1000)/100;
 dez_v = (volt_i%100)/10;
 uni_v = volt_i%10;

 Lcd_Chr (2,5,mil_v+0x30);
 Lcd_Chr_Cp (cen_v+0x30);
 Lcd_Chr_Cp ('.');
 Lcd_Chr_Cp (dez_v+0x30);
 Lcd_Chr_Cp (uni_v+0x30);
 Lcd_Chr_Cp ('V');


}

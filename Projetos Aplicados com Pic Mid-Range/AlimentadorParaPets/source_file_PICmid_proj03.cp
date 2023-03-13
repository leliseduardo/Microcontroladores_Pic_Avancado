#line 1 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_008__Alimentador_Programável_de_Pets_p3/PIC_mid_WR_files_008/source_file_PICmid_proj03.c"
#line 65 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_008__Alimentador_Programável_de_Pets_p3/PIC_mid_WR_files_008/source_file_PICmid_proj03.c"
void update_data();
void read_bts();
void multiplex();
char disp_cath(char num);




extern void relogio();
extern void check_clk();




int counter_T0 = 0x00;

char flagsA = 0x00,
 counter_bk = 0x00,
 adj_num = 0x00,
 new_prog = 0x01,
 run_prog = 0x01,
 mil,
 cen,
 dez,
 uni,
 hr_disp = 0x00,
 mn_disp = 0x00,
 horas_0 = 0x00,
 minutos_0 = 0x00,
 segundos_0 = 0x00,
 horas_1 = 0x00,
 minutos_1 = 0x00,
 horas_2 = 0x00,
 minutos_2 = 0x00,
 horas_3 = 0x00,
 minutos_3 = 0x00,
 adj_count = 0x00,
 feed_count = 0x00;

unsigned char feed_count2= 0x00;




void interrupt()
{
 if(TMR0IF_bit)
 {

 TMR0IF_bit = 0x00;
 TMR0 = 0x06;
 counter_T0 += 0x01;
 counter_bk += 0x01;


 multiplex();

 if(counter_bk == 100)
 {
 counter_bk = 0x00;


  flagsA.B7  = ~ flagsA.B7 ;

 }

 if(counter_T0 == 250)
 {
 counter_T0 = 0x00;


  RC0_bit  = ~ RC0_bit ;

 if(! RC0_bit ) relogio();



 if( flagsA.B0 ) adj_count+=1;
 if(adj_count == 4)
 {
 adj_count = 0x00;
  flagsA.B6  = ~ flagsA.B6 ;

 }


 if( flagsA.B5 )
 {
  flagsA.B6  = 0;
 feed_count+=1;
  RC1_bit  = 0x01;
  RA5_bit  = 0x01;

 }

 if(feed_count == 20)
 {
 feed_count = 0x00;
  RC1_bit  = 0x00;
  RA5_bit  = 0x00;
  flagsA.B5  = 0x00;

 }


 if( flagsA.B4 ) feed_count2+=1;

 if(feed_count2 == 140)
 {
 feed_count2 = 0x00;
  flagsA.B6  = 0x01;
  flagsA.B4  = 0x00;

 }

 }


 }

}




void main()
{

 CMCON = 0x07;
 ADCON1 = 0x07;

 OPTION_REG = 0x84;
 GIE_bit = 0x01;
 TMR0IE_bit = 0x01;
 TMR0 = 0x06;








 TRISA.RA5 = 0x00;
  RA5_bit  = 0x00;
 TRISB = 0x80;
 PORTB = 0x80;
 TRISC = 0x00;
 PORTC = 0x00;


 while(1)
 {
 read_bts();
 update_data();

 if( flagsA.B6 ) check_clk();

  RC2_bit  =  flagsA.B6 ;

 }


}








void update_data()
{
 switch(new_prog)
 {
 case 1:
 hr_disp = horas_0;
 mn_disp = minutos_0;
 break;
 case 2:
 delay_ms(741);
 new_prog+=1;
 break;
 case 3:
 hr_disp = horas_1;
 mn_disp = minutos_1;
 break;
 case 4:
 delay_ms(741);
 new_prog+=1;
 break;
 case 5:
 hr_disp = horas_2;
 mn_disp = minutos_2;
 break;
 case 6:
 delay_ms(741);
 new_prog+=1;
 break;
 case 7:
 hr_disp = horas_3;
 mn_disp = minutos_3;
 break;
 case 8:
 delay_ms(741);
 new_prog=1;
 break;

 }


}




void read_bts()
{
 if(! RA0_bit )  flagsA.B0  = 0x01;
 if(! RA1_bit )  flagsA.B1  = 0x01;
 if(! RA2_bit )  flagsA.B2  = 0x01;

 if( RA0_bit  &&  flagsA.B0 )
 {
  flagsA.B0  = 0x00;
 adj_count = 0x00;

 switch(adj_num)
 {
 case 1:
 switch(new_prog)
 {
 case 1: horas_0 += 10; break;
 case 3: horas_1 += 10; break;
 case 5: horas_2 += 10; break;
 case 7: horas_3 += 10; break;

 }
 break;

 case 2:
 switch(new_prog)
 {
 case 1: horas_0 += 1; break;
 case 3: horas_1 += 1; break;
 case 5: horas_2 += 1; break;
 case 7: horas_3 += 1; break;

 }
 break;

 case 3:
 switch(new_prog)
 {
 case 1: minutos_0 += 10; break;
 case 3: minutos_1 += 10; break;
 case 5: minutos_2 += 10; break;
 case 7: minutos_3 += 10; break;

 }
 break;

 case 4:
 switch(new_prog)
 {
 case 1: minutos_0 += 1; break;
 case 3: minutos_1 += 1; break;
 case 5: minutos_2 += 1; break;
 case 7: minutos_3 += 1; break;

 }
 break;

 }

 delay_ms(50);

 if(horas_0 > 23) horas_0 = 0;
 if(minutos_0 > 59) minutos_0 = 0;
 if(horas_1 > 23) horas_1 = 0;
 if(minutos_1 > 59) minutos_1 = 0;
 if(horas_2 > 23) horas_2 = 0;
 if(minutos_2 > 59) minutos_2 = 0;
 if(horas_3 > 23) horas_3 = 0;
 if(minutos_3 > 59) minutos_3 = 0;

 }

 if( RA1_bit  &&  flagsA.B1 )
 {
  flagsA.B1  = 0x00;

 adj_num += 1;

 delay_ms(50);


 if(adj_num > 4) adj_num = 0;


 }

 if( RA2_bit  &&  flagsA.B2 )
 {
  flagsA.B2  = 0x00;


 new_prog += 1;
 run_prog += 1;

 delay_ms(50);

 if(new_prog > 8) new_prog = 1;
 if(run_prog > 2) run_prog = 1;

 }


}




void multiplex()
{
 static char control = 1;


 if(! RC7_bit  && control == 1)
 {
 control = 0x02;
  RC3_bit  = 0x00;
  RC4_bit  = 0x00;
  RC5_bit  = 0x00;
  RC6_bit  = 0x00;
 PORTB = 0x00;
 mil = (hr_disp/10);
  RC7_bit  = 0x01;

 switch(new_prog)
 {
 case 2:
 case 4:
 case 6: PORTB = 0x73; break;
 case 8: PORTB = 0x74; break;

 default:
 if(adj_num != 1 || ! flagsA.B7 )
 PORTB = disp_cath(mil);
 else PORTB = 0;

 }

 }

 else if(! RC6_bit  && control == 2)
 {
 control = 0x03;
  RC3_bit  = 0x00;
  RC4_bit  = 0x00;
  RC5_bit  = 0x00;
  RC7_bit  = 0x00;
 PORTB = 0x00;
 cen = (hr_disp%10);
  RC6_bit  = 0x01;

 switch(new_prog)
 {
 case 2:
 case 4:
 case 6: PORTB = 0x50; break;
 case 8: PORTB = 0x5C; break;

 default:
 if(adj_num != 2 || ! flagsA.B7 )
 PORTB = disp_cath(cen);
 else PORTB = 0;

 }


 }

 else if(! RC5_bit  && control == 3)
 {
 control = 0x04;
  RC3_bit  = 0x00;
  RC4_bit  = 0x00;
  RC6_bit  = 0x00;
  RC7_bit  = 0x00;
 PORTB = 0x00;
 dez = (mn_disp/10);
  RC5_bit  = 0x01;

 switch(new_prog)
 {
 case 2:
 case 4:
 case 6: PORTB = 0x5C; break;
 case 8: PORTB = 0x1C; break;

 default:
 if(adj_num != 3 || ! flagsA.B7 )
 PORTB = disp_cath(dez);
 else PORTB = 0;

 }


 }

 else if(! RC4_bit  && control == 4)
 {
 control = 0x05;
  RC3_bit  = 0x00;
  RC5_bit  = 0x00;
  RC6_bit  = 0x00;
  RC7_bit  = 0x00;
 PORTB = 0x00;
 uni = (mn_disp%10);
  RC4_bit  = 0x01;

 switch(new_prog)
 {
 case 2: PORTB = disp_cath(1); break;
 case 4: PORTB = disp_cath(2); break;
 case 6: PORTB = disp_cath(3); break;
 case 8: PORTB = 0x50; break;

 default:
 if(adj_num != 4 || ! flagsA.B7 )
 PORTB = disp_cath(uni);
 else PORTB = 0;

 }


 }


 else if(! RC3_bit  && control == 5)
 {
 control = 0x01;
  RC4_bit  = 0x00;
  RC5_bit  = 0x00;
  RC6_bit  = 0x00;
  RC7_bit  = 0x00;
 PORTB = 0x00;

  RC3_bit  = 0x01;

 if(! RC0_bit )
 PORTB = 0x10;
 else PORTB = 0;

 }


}




char disp_cath(char num)
{
 char cathode;


 char segmento[10] = {0x3F,
 0x06,
 0x5B,
 0x4F,
 0x66,
 0x6D,
 0x7D,
 0x07,
 0x7F,
 0x67};


 cathode = segmento[num];

 return(cathode);

}

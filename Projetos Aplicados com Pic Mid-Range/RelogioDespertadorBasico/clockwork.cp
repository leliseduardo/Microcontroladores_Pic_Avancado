#line 1 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_005__Despertador_para_Preguiçosos_p3/PIC_mid_WR_files_005/clockwork.c"
#line 22 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_005__Despertador_para_Preguiçosos_p3/PIC_mid_WR_files_005/clockwork.c"
extern char *text1,
 *text2,
 flagsA,
 ctrl_watch,
 dias,
 horas,
 minutos,
 segundos,
 a_dias,
 a_horas,
 a_minutos,
 a_segundos;









void despertar()
{



 if(segundos == a_segundos)
 {
 if(minutos == a_minutos)
 {
 if(horas == a_horas)
 {
 if(dias == a_dias)
 {

  RB4_bit  = 0x01;
  RB5_bit  = 0x01;

 }

 }

 }

 }

}




void disp_horario()
{


 text1[7] = segundos%10 + '0';
 text1[6] = segundos/10 + '0';
 text1[4] = minutos%10 + '0';
 text1[3] = minutos/10 + '0';
 text1[1] = horas%10 + '0';
 text1[0] = horas/10 + '0';

 Lcd_Chr(1,5, text1[0]);
 Lcd_Chr_Cp (text1[1]);
 Lcd_Chr_Cp (text1[2]);
 Lcd_Chr_Cp (text1[3]);
 Lcd_Chr_Cp (text1[4]);
 Lcd_Chr_Cp (text1[5]);
 Lcd_Chr_Cp (text1[6]);
 Lcd_Chr_Cp (text1[7]);

 switch(dias)
 {
 case 0:
 Lcd_Chr(1,14,'D');
 Lcd_Chr_Cp ('O');
 Lcd_Chr_Cp ('M');
 break;
 case 1:
 Lcd_Chr(1,14,'S');
 Lcd_Chr_Cp ('E');
 Lcd_Chr_Cp ('G');
 break;
 case 2:
 Lcd_Chr(1,14,'T');
 Lcd_Chr_Cp ('E');
 Lcd_Chr_Cp ('R');
 break;
 case 3:
 Lcd_Chr(1,14,'Q');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('A');
 break;
 case 4:
 Lcd_Chr(1,14,'Q');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('I');
 break;
 case 5:
 Lcd_Chr(1,14,'S');
 Lcd_Chr_Cp ('E');
 Lcd_Chr_Cp ('X');
 break;
 case 6:
 Lcd_Chr(1,14,'S');
 Lcd_Chr_Cp ('A');
 Lcd_Chr_Cp ('B');
 break;

 }


}




void relogio()
{
 segundos++;

 if(segundos == 0x3c)
 {
 segundos = 0x00;
 minutos++;

 if(minutos == 0x3c)
 {
 minutos = 0x00;
 horas++;

 if(horas == 0x18)
 {
 horas = 0x00;
 dias++;

 if(dias == 0x07) dias = 0x00;


 }

 }

 }

}




void ajusta_relogio()
{

 char i = 0;

 if(! RA0_bit )  flagsA.B0  = 0x01;
 if(! RA1_bit )  flagsA.B1  = 0x01;
 if(! RA2_bit )  flagsA.B2  = 0x01;


 if( RA2_bit  &&  flagsA.B2 )
 {
  flagsA.B2  = 0x00;
 ctrl_watch++;


 if(ctrl_watch > 0x05) ctrl_watch = 0x00;

 }


 switch(ctrl_watch)
 {
 case 0x00:
 Lcd_Chr (1,1,' ');
 Lcd_Chr (2,5,'^');
 Lcd_Chr_Cp ('^');
 Lcd_Chr (2,8,' ');
 Lcd_Chr_Cp (' ');
 Lcd_Chr(2,11,' ');
 Lcd_Chr_Cp (' ');
 break;
 case 0x01:
 Lcd_Chr (2,5,' ');
 Lcd_Chr_Cp (' ');
 Lcd_Chr (2,8,'^');
 Lcd_Chr_Cp ('^');
 Lcd_Chr(2,11,' ');
 Lcd_Chr_Cp (' ');
 break;
 case 0x02:
 Lcd_Chr (2,5,' ');
 Lcd_Chr_Cp (' ');
 Lcd_Chr (2,8,' ');
 Lcd_Chr_Cp (' ');
 Lcd_Chr(2,11,'^');
 Lcd_Chr_Cp ('^');
 break;
 case 0x03:
 Lcd_Chr (2,5,' ');
 Lcd_Chr_Cp (' ');
 Lcd_Chr (2,8,' ');
 Lcd_Chr_Cp (' ');
 Lcd_Chr(2,11,' ');
 Lcd_Chr_Cp (' ');
 Lcd_Chr(2,14,'^');
 break;

 case 0x04:
 despertar();
 if(minutos == (a_minutos + 10))
 {
  RB4_bit  = 0x00;
  RB5_bit  = 0x00;

 }
 Lcd_Chr(1,1,'D');
 for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' ');
 break;
 case 0x05:
 Lcd_Chr(1,1,' ');
 for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' ');
 break;
 }


 if( RA0_bit  &&  flagsA.B0 )
 {
  flagsA.B0  = 0x00;

 switch(ctrl_watch)
 {
 case 0x00:
 horas++;
 if(horas > 0x17) horas = 0x00;
 break;
 case 0x01:
 minutos++;
 if(minutos > 0x3b) minutos = 0x00;
 break;
 case 0x02:
 segundos++;
 if(segundos > 0x3b) segundos = 0x00;
 break;
 case 0x03:
 dias++;
 if(dias > 0x06) dias = 0x00;
 break;
 }
 }

 if( RA1_bit  &&  flagsA.B1 )
 {
  flagsA.B1  = 0x00;

 switch(ctrl_watch)
 {
 case 0x00:
 horas = horas + 10;
 if(horas > 0x17) horas = 0x00;
 break;
 case 0x01:
 minutos = minutos + 10;
 if(minutos > 0x3b) minutos = 0x00;
 break;
 case 0x02:
 segundos = segundos + 10;
 if(segundos > 0x3b) segundos = 0x00;
 break;
 case 0x03:
 dias++;
 if(dias > 0x06) dias = 0x00;
 break;
 }

 }

}








void disp_alarme()
{


 text2[7] = a_segundos%10 + '0';
 text2[6] = a_segundos/10 + '0';
 text2[4] = a_minutos%10 + '0';
 text2[3] = a_minutos/10 + '0';
 text2[1] = a_horas%10 + '0';
 text2[0] = a_horas/10 + '0';

 Lcd_Chr(1,5, text2[0]);
 Lcd_Chr_Cp (text2[1]);
 Lcd_Chr_Cp (text2[2]);
 Lcd_Chr_Cp (text2[3]);
 Lcd_Chr_Cp (text2[4]);
 Lcd_Chr_Cp (text2[5]);
 Lcd_Chr_Cp (text2[6]);
 Lcd_Chr_Cp (text2[7]);

 switch(a_dias)
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

 }


}




void ajusta_alarme()
{
 bit control_flag;

 char i = 0;

 if(! RA0_bit )  flagsA.B0  = 0x01;
 if(! RA1_bit )  flagsA.B1  = 0x01;
 if(! RA2_bit )  flagsA.B2  = 0x01;


 if( RA2_bit  &&  flagsA.B2 )
 {
  flagsA.B2  = 0x00;
 ctrl_watch++;


 if(ctrl_watch > 0x05) ctrl_watch = 0x00;

 }

 switch(ctrl_watch)
 {
 case 0x00:
 Lcd_Chr(1,1,' ');
 Lcd_Chr(2,5,'^');
 Lcd_Chr_Cp('^');
 Lcd_Chr(2,8,' ');
 Lcd_Chr_Cp(' ');
 Lcd_Chr(2,11,' ');
 Lcd_Chr_Cp(' ');
 control_flag = 0x00;
 break;
 case 0x01:
 Lcd_Chr(2,5,' ');
 Lcd_Chr_Cp(' ');
 Lcd_Chr(2,8,'^');
 Lcd_Chr_Cp('^');
 Lcd_Chr(2,11,' ');
 Lcd_Chr_Cp(' ');
 break;
 case 0x02:
 Lcd_Chr(2,5,' ');
 Lcd_Chr_Cp(' ');
 Lcd_Chr(2,8,' ');
 Lcd_Chr_Cp(' ');
 Lcd_Chr(2,11,'^');
 Lcd_Chr_Cp('^');
 break;
 case 0x03:
 Lcd_Chr(2,5,' ');
 Lcd_Chr_Cp(' ');
 Lcd_Chr(2,8,' ');
 Lcd_Chr_Cp(' ');
 Lcd_Chr(2,11,' ');
 Lcd_Chr_Cp(' ');
 Lcd_Chr(2,14,'^');
 break;
 case 0x04:
 despertar();
 if(minutos == (a_minutos + 10))
 {
  RB4_bit  = 0x00;
  RB5_bit  = 0x00;

 }
 Lcd_Chr(1,1,'D');
 for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' ');
 break;
 case 0x05:
 Lcd_Chr(1,1,' ');
 for(i = 0; i<12; i++) Lcd_Chr(2,i+5,' ');
 break;
 }


 if( RA0_bit  &&  flagsA.B0 )
 {
  flagsA.B0  = 0x00;

 switch(ctrl_watch)
 {
 case 0x00:
 a_horas++;
 if(a_horas > 0x17) a_horas = 0x00;
 break;
 case 0x01:
 a_minutos++;
 if(a_minutos > 0x3b) a_minutos = 0x00;
 break;
 case 0x02:
 a_segundos++;
 if(a_segundos > 0x3b) a_segundos = 0x00;
 break;
 case 0x03:
 a_dias++;
 if(a_dias > 0x06) a_dias = 0x00;
 break;
 }
 }

 if( RA1_bit  &&  flagsA.B1 )
 {
  flagsA.B1  = 0x00;

 switch(ctrl_watch)
 {
 case 0x00:
 a_horas = a_horas + 10;
 if(a_horas > 0x17) a_horas = 0x00;
 break;
 case 0x01:
 a_minutos = a_minutos + 10;
 if(a_minutos > 0x3b) a_minutos = 0x00;
 break;
 case 0x02:
 a_segundos = a_segundos + 10;
 if(a_segundos > 0x3b) a_segundos = 0x00;
 break;
 case 0x03:
 a_dias++;
 if(a_dias > 0x06) a_dias = 0x00;
 break;
 }

 }

}

#line 1 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_008__Alimentador_Programável_de_Pets_p3/PIC_mid_WR_files_008/clockwork.c"
#line 22 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_008__Alimentador_Programável_de_Pets_p3/PIC_mid_WR_files_008/clockwork.c"
extern char flagsA,
 horas_0,
 minutos_0,
 segundos_0,
 horas_1,
 minutos_1,
 horas_2,
 minutos_2,
 horas_3,
 minutos_3;








void relogio()
{
 segundos_0++;

 if(segundos_0 == 0x3c)
 {
 segundos_0 = 0x00;
 minutos_0++;

 if(minutos_0 == 0x3c)
 {
 minutos_0 = 0x00;
 horas_0++;

 if(horas_0 == 0x18) horas_0 = 0x00;


 }

 }

}




void check_clk()
{
 if(horas_0 == horas_1 && minutos_0 == minutos_1)
 {
  flagsA.B5  = 0x01;
  flagsA.B4  = 0x01;

 }

 if(horas_0 == horas_2 && minutos_0 == minutos_2)
 {
  flagsA.B5  = 0x01;
  flagsA.B4  = 0x01;

 }

 if(horas_0 == horas_3 && minutos_0 == minutos_3)
 {
  flagsA.B5  = 0x01;
  flagsA.B4  = 0x01;

 }




}

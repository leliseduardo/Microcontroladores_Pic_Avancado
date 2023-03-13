#line 1 "C:/You Tube - Meu Canal/ZZZ_S�ries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_011__Controle_de_Port�o_Codificado__p3/PIC_mid_WR_files_011/RX_source/source_file_PICmid_proj04_rx.c"
#line 20 "C:/You Tube - Meu Canal/ZZZ_S�ries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_011__Controle_de_Port�o_Codificado__p3/PIC_mid_WR_files_011/RX_source/source_file_PICmid_proj04_rx.c"
void rx_func(char *cmd, char *val, char *ok);




char start, cnt;
char comand, value, check;
char m_control = 1;
 bit flag_c;



void interrupt()
{
 rx_func(&comand, &value, &check);

 if(check)
 {

 if(comand == 'A')
 {
 RB0_bit = value;
 flag_c = 1;

 }



 }

}




void main()
{
 CMCON = 0x07;
 TRISB = 0xCE;
 PORTB = 0xCE;

 flag_c = 0x00;

 RCIE_bit = 0x01;
 GIE_bit = 0x01;
 PEIE_Bit = 0x01;

 UART1_Init(1200);
 delay_ms(100);



 while(1)
 {

 if(RB0_bit && flag_c)
 {
 flag_c = 0;
 m_control += 1;
 delay_ms(200);

 if(m_control > 4) m_control = 1;

 }



 switch(m_control)
 {
 case 1:
 RB4_bit = 0x00;
 RB5_bit = 0x00;
 break;
 case 2:
 RB4_bit = 0x01;
 RB5_bit = 0x00;
 break;
 case 3:
 RB4_bit = 0x00;
 RB5_bit = 0x00;
 break;
 case 4:
 RB4_bit = 0x00;
 RB5_bit = 0x01;
 break;


 }

 }

}








void rx_func(char *cmd, char *val, char *ok)
{
 char buffer;
 char checksum;
 *ok = 0;

 if(RCIF_bit)
 {
 RCIF_bit = 0x00;

 buffer = Uart1_Read();

 if(start)
 {
 cnt++;

 if(cnt == 1) *cmd = buffer;

 if(cnt == 2) *val = buffer;

 if(cnt == 3)
 {
 checksum = buffer;
 start = 0x00;

 if(checksum == ~(char)(*cmd + *val)) *ok = 1;

 }

 }

 else
 {
 if(buffer == 0xFF)
 {
 start = 0x01;
 cnt = 0x00;

 }

 }

 }

}

#line 1 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_011__Controle_de_Portão_Codificado__p3/PIC_mid_WR_files_011/TX_source/source_file_PICmid_proj04_tx.c"
#line 20 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_011__Controle_de_Portão_Codificado__p3/PIC_mid_WR_files_011/TX_source/source_file_PICmid_proj04_tx.c"
void tx_func(char comand, char value);
void cmd_code();




char key = 0x00;




void main()
{
 CMCON = 0x07;
 TRISB = 0xFD;
 UART1_Init(1200);
 delay_ms(100);


 while(1)
 {
 cmd_code();

 if(!RB0_bit) tx_func(key,1);
 else if(!RB1_bit) tx_func(key,1);
 else tx_func(key,0);




 }

}








void tx_func(char comand, char value)
{

 UART1_Write(0xFF);
 delay_ms(10);
 UART1_Write(comand);
 delay_ms(10);
 UART1_Write(value);
 delay_ms(10);
 UART1_Write(~(char)(comand+value));
 delay_ms(10);


}




void cmd_code()
{
 if(RB7_bit) key.B7 = 0x01;
 else key.B7 = 0x00;

 if(RB6_bit) key.B6 = 0x01;
 else key.B6 = 0x00;

 if(RB5_bit) key.B5 = 0x01;
 else key.B5 = 0x00;

 if(RB4_bit) key.B4 = 0x01;
 else key.B4 = 0x00;

 if(RA3_bit) key.B3 = 0x01;
 else key.B3 = 0x00;

 if(RA2_bit) key.B2 = 0x01;
 else key.B2 = 0x00;

 if(RA1_bit) key.B1 = 0x01;
 else key.B1 = 0x00;

 if(RA0_bit) key.B0 = 0x01;
 else key.B0 = 0x00;


}

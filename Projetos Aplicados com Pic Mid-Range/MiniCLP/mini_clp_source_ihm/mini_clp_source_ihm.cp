#line 1 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_017__Mini_CLP__p3/PIC_mid_WR_files_017/mini_clp_source_ihm/mini_clp_source_ihm.c"
#line 28 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_017__Mini_CLP__p3/PIC_mid_WR_files_017/mini_clp_source_ihm/mini_clp_source_ihm.c"
sbit LCD_RS at RA7_bit;
sbit LCD_EN at RA6_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;


sbit LCD_RS_Direction at TRISA7_bit;
sbit LCD_EN_Direction at TRISA6_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
#line 63 "C:/You Tube - Meu Canal/ZZZ_Séries_Patrocinadas/Projetos Aplicados com PIC Mid-Range/PIC_MidRange_017__Mini_CLP__p3/PIC_mid_WR_files_017/mini_clp_source_ihm/mini_clp_source_ihm.c"
void principal();
void read_bts();
void menu_1();
void menu_2();
void menu_3();
void menu_4();
void lcd_msg(char opt);
void boot_sys();
void one_clear_LCD();




int menu_num = 0x00;

char flagsA = 0x00,
 control = 0x00;


char pos[4][3] = {0};






void main()
{
 CMCON = 0x07;
 TRISA = 0x2F;
 TRISB = 0x0B;
 PORTA = 0x2F;
 PORTB = 0x0B;

 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);

 boot_sys();

 Lcd_Cmd(_LCD_CLEAR);



 while(1)
 {

 read_bts();

 principal();




 }


}








void principal()
{
 switch(menu_num)
 {
 case 0: menu_1(); break;
 case 1: menu_2(); break;
 case 2: menu_3(); break;
 case 3: menu_4(); break;


 }

}




void menu_1()
{

 one_clear_LCD();
 lcd_msg(1);


}




void menu_2()
{

 one_clear_LCD();
 lcd_msg(2);


}




void menu_3()
{

 one_clear_LCD();
 lcd_msg(3);


}




void menu_4()
{

 one_clear_LCD();
 lcd_msg(4);



}




void read_bts()
{
 if(! RA0_bit )  flagsA.B0  = 0x01;
 if(! RA1_bit )  flagsA.B1  = 0x01;
 if(! RA2_bit )  flagsA.B2  = 0x01;


 if( RA0_bit  &&  flagsA.B0 )
 {
  flagsA.B0  = 0x00;

 if(!control) menu_num += 1;

 else if(menu_num == 2)
 {
 if(pos[control][menu_num] < 24) pos[control][menu_num] ++;
 }

 else pos[control][menu_num] = 1;



 if(menu_num > 3) menu_num = 0;

  flagsA.B3  = 1;


 }


 if( RA1_bit  &&  flagsA.B1 )
 {
  flagsA.B1  = 0x00;

 if(!control) menu_num -= 1;

 else if(menu_num == 2)
 {
 if(pos[control][menu_num]) pos[control][menu_num] --;
 }

 else pos[control][menu_num] = 0;



 if(menu_num < 0) menu_num = 3;

  flagsA.B3  = 1;


 }


 if( RA2_bit  &&  flagsA.B2 )
 {
  flagsA.B2  = 0x00;

 if(menu_num != 3) control += 1;

 if(control > 3) control = 0;

  flagsA.B3  = 1;


 }


}




void lcd_msg(char opt)
{
 char dez1, uni1, dez2, uni2, dez3, uni3;


 switch(opt)
 {
 case 1:
 Lcd_Chr(1,3,'A');
 Lcd_Chr_Cp ('c');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('o');
 Lcd_Chr_Cp ('n');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('r');
 Lcd_Chr_Cp (' ');
 Lcd_Chr_Cp ('s');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('d');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('s');

 Lcd_Chr(2,4,'O');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('T');
 Lcd_Chr_Cp ('1');

 Lcd_Chr(3,4,'O');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('T');
 Lcd_Chr_Cp ('2');

 Lcd_Chr(4,4,'O');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('T');
 Lcd_Chr_Cp ('3');
 break;

 case 2:
 Lcd_Chr(1,3,'T');
 Lcd_Chr_Cp ('e');
 Lcd_Chr_Cp ('s');
 Lcd_Chr_Cp ('t');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('r');
 Lcd_Chr_Cp (' ');
 Lcd_Chr_Cp ('D');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('g');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('t');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('l');

 Lcd_Chr(2,4,'I');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('1');

 Lcd_Chr(3,4,'I');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('2');

 Lcd_Chr(4,4,'I');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('3');
 break;

 case 3:
 Lcd_Chr(1,3,'T');
 Lcd_Chr_Cp ('e');
 Lcd_Chr_Cp ('s');
 Lcd_Chr_Cp ('t');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('r');
 Lcd_Chr_Cp (' ');
 Lcd_Chr_Cp ('A');
 Lcd_Chr_Cp ('n');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('l');
 Lcd_Chr_Cp ('o');
 Lcd_Chr_Cp ('g');
 Lcd_Chr_Cp ('s');

 Lcd_Chr(2,4,'A');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('1');

 Lcd_Chr(3,4,'A');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('2');

 Lcd_Chr(4,4,'A');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('3');
 break;

 case 4:
 Lcd_Chr(1,3,'R');
 Lcd_Chr_Cp ('e');
 Lcd_Chr_Cp ('s');
 Lcd_Chr_Cp ('u');
 Lcd_Chr_Cp ('m');
 Lcd_Chr_Cp ('o');
 Lcd_Chr_Cp (' ');
 Lcd_Chr_Cp ('C');
 Lcd_Chr_Cp ('o');
 Lcd_Chr_Cp ('n');
 Lcd_Chr_Cp ('f');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('g');
 Lcd_Chr_Cp ('s');
 break;


 }


 if(menu_num != 3)
 {

 if(menu_num == 2)
 {
 dez1 = pos[1][menu_num]/10;
 uni1 = pos[1][menu_num]%10;

 dez2 = pos[2][menu_num]/10;
 uni2 = pos[2][menu_num]%10;

 dez3 = pos[3][menu_num]/10;
 uni3 = pos[3][menu_num]%10;

 Lcd_Chr(2,12,dez1+48);
 Lcd_Chr_Cp (uni1+48);
 Lcd_Chr_Cp ('V');
 Lcd_Chr(3,12,dez2+48);
 Lcd_Chr_Cp (uni2+48);
 Lcd_Chr_Cp ('V');
 Lcd_Chr(4,12,dez3+48);
 Lcd_Chr_Cp (uni3+48);
 Lcd_Chr_Cp ('V');


 }

 else
 {
 Lcd_Chr(2,12,pos[1][menu_num]+48);
 Lcd_Chr(3,12,pos[2][menu_num]+48);
 Lcd_Chr(4,12,pos[3][menu_num]+48);


 }


 switch(control)
 {
 case 0: Lcd_Chr(1,1, '>');
 Lcd_Chr(1,20,'<'); break;
 case 1: Lcd_Chr(2,1, '*'); break;
 case 2: Lcd_Chr(3,1, '*'); break;
 case 3: Lcd_Chr(4,1, '*'); break;

 }


 }


 else
 {

 Lcd_Chr(2,1,'O');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('T');
 Lcd_Chr_Cp ('1');

 Lcd_Chr(3,1,'O');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('T');
 Lcd_Chr_Cp ('2');

 Lcd_Chr(4,1,'O');
 Lcd_Chr_Cp ('U');
 Lcd_Chr_Cp ('T');
 Lcd_Chr_Cp ('3');

 Lcd_Chr(2,6,pos[1][0]+48);
 Lcd_Chr(3,6,pos[2][0]+48);
 Lcd_Chr(4,6,pos[3][0]+48);


 Lcd_Chr(2,8,'I');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('1');

 Lcd_Chr(3,8,'I');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('2');

 Lcd_Chr(4,8,'I');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('3');

 Lcd_Chr(2,12,pos[1][1]+48);
 Lcd_Chr(3,12,pos[2][1]+48);
 Lcd_Chr(4,12,pos[3][1]+48);


 Lcd_Chr(2,14,'A');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('1');

 Lcd_Chr(3,14,'A');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('2');

 Lcd_Chr(4,14,'A');
 Lcd_Chr_Cp ('N');
 Lcd_Chr_Cp ('3');

 Lcd_Chr(2,18,dez1+48);
 Lcd_Chr_Cp (uni1+48);
 Lcd_Chr_Cp ('V');
 Lcd_Chr(3,18,dez2+48);
 Lcd_Chr_Cp (uni2+48);
 Lcd_Chr_Cp ('V');
 Lcd_Chr(4,18,dez3+48);
 Lcd_Chr_Cp (uni3+48);
 Lcd_Chr_Cp ('V');


 }


}




void boot_sys()
{
 char boot_cnt = 0;

 Lcd_Chr(1,5, 'C');
 Lcd_Chr_Cp ('L');
 Lcd_Chr_Cp ('P');
 Lcd_Chr_Cp (' ');
 Lcd_Chr_Cp ('W');
 Lcd_Chr_Cp ('R');
 Lcd_Chr_Cp (' ');
 Lcd_Chr_Cp ('K');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('t');
 Lcd_Chr_Cp ('s');

 Lcd_Chr(2,8, 'v');
 Lcd_Chr_Cp ('1');
 Lcd_Chr_Cp ('.');
 Lcd_Chr_Cp ('0');

 Lcd_Chr(3,5, 'I');
 Lcd_Chr_Cp ('n');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('c');
 Lcd_Chr_Cp ('i');
 Lcd_Chr_Cp ('a');
 Lcd_Chr_Cp ('n');
 Lcd_Chr_Cp ('d');
 Lcd_Chr_Cp ('o');
 Lcd_Chr_Cp ('.');
 Lcd_Chr_Cp ('.');
 Lcd_Chr_Cp ('.');

 Lcd_Chr(4,1,'#');

 while(boot_cnt < 20)
 {

 Lcd_Chr_Cp('#');
 delay_ms(100);
 boot_cnt += 1;

 }

  RA4_bit  = 0x01;


}




void one_clear_LCD()
{
 if( flagsA.B3 )
 {
 Lcd_Cmd(_LCD_CLEAR);
  flagsA.B3  = 0x00;

 }


}

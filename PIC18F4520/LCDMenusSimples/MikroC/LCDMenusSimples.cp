#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/LCDMenusSimples/MikroC/LCDMenusSimples.c"
#line 20 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/LCDMenusSimples/MikroC/LCDMenusSimples.c"
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;


sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;







void leitura_Botoes();
void apaga_Display();

void menu1();
void menu2();
void menu3();
void menu4();
void menu5();
void menu6();


char flagBotoes = 0x00;

bit apagaDisplay;
char menuControl = 0x01;

void main() {


 ADCON1 = 0x0F;
 TRISB = 0xFF;

 apagaDisplay = 0;

 lcd_init();
 lcd_cmd(_LCD_CLEAR);
 lcd_cmd(_LCD_CURSOR_OFF);


 while(1){

 leitura_Botoes();

 switch(menuControl){

 case 0x01: menu1();
 break;
 case 0x02: menu2();
 break;
 case 0x03: menu3();
 break;
 case 0x04: menu4();
 break;
 case 0x05: menu5();
 break;
 case 0x06: menu6();
 break;

 }

 }

}

void leitura_Botoes(){

 if(! RB6_bit ) flagBotoes.B0 = 0x01;
 if(! RB7_bit ) flagBotoes.B1 = 0x01;

 if( RB6_bit  && flagBotoes.B0){

 flagBotoes.B0 = 0x00;
 apagaDisplay = 1;
 menuControl--;

 if(menuControl == 0) menuControl =  6 ;

 }

 if( RB7_bit  && flagBotoes.B1){

 flagBotoes.B1 = 0x00;
 apagaDisplay = 1;
 menuControl++;

 if(menuControl == ( 6 +1)) menuControl = 0x01;

 }

}

void apaga_Display(){

 if(apagaDisplay){

 apagaDisplay = 0;

 lcd_cmd(_LCD_CLEAR);

 }

}

void menu1(){

 apaga_Display();

 lcd_chr(1, 2, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('m');
 lcd_chr_cp('p');
 lcd_chr_cp('e');
 lcd_chr_cp('r');
 lcd_chr_cp('a');
 lcd_chr_cp('t');
 lcd_chr_cp('u');
 lcd_chr_cp('r');
 lcd_chr_cp('a');

 lcd_chr(2, 2, 'I');
 lcd_chr_cp('n');
 lcd_chr_cp('t');
 lcd_chr_cp(':');

}

void menu2(){

 apaga_Display();

 lcd_chr(1, 2, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('m');
 lcd_chr_cp('p');
 lcd_chr_cp('e');
 lcd_chr_cp('r');
 lcd_chr_cp('a');
 lcd_chr_cp('t');
 lcd_chr_cp('u');
 lcd_chr_cp('r');
 lcd_chr_cp('a');

 lcd_chr(2, 2, 'E');
 lcd_chr_cp('x');
 lcd_chr_cp('t');
 lcd_chr_cp(':');

}


void menu3(){

 apaga_Display();

 lcd_chr(1, 2, 'V');
 lcd_chr_cp('o');
 lcd_chr_cp('l');
 lcd_chr_cp('t');
 lcd_chr_cp('i');
 lcd_chr_cp('m');
 lcd_chr_cp('e');
 lcd_chr_cp('t');
 lcd_chr_cp('r');
 lcd_chr_cp('o');

 lcd_chr(2, 2, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('s');
 lcd_chr_cp('a');
 lcd_chr_cp('o');
 lcd_chr_cp(':');

}


void menu4(){

 apaga_Display();

 lcd_chr(1, 2, 'C');
 lcd_chr_cp('o');
 lcd_chr_cp('n');
 lcd_chr_cp('t');
 lcd_chr_cp('a');
 lcd_chr_cp('d');
 lcd_chr_cp('o');
 lcd_chr_cp('r');

 lcd_chr(2, 2, 'P');
 lcd_chr_cp('u');
 lcd_chr_cp('l');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp('s');
 lcd_chr_cp(':');

}


void menu5(){

 apaga_Display();

 lcd_chr(1, 2, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('m');
 lcd_chr_cp('p');
 lcd_chr_cp('o');

}


void menu6(){

 apaga_Display();

 lcd_chr(1, 2, 'E');
 lcd_chr_cp('n');
 lcd_chr_cp('t');
 lcd_chr_cp('r');
 lcd_chr_cp('a');
 lcd_chr_cp('d');
 lcd_chr_cp('a');
 lcd_chr_cp('s');
 lcd_chr_cp(' ');
 lcd_chr_cp('H');
 lcd_chr_cp('I');
 lcd_chr_cp('G');
 lcd_chr_cp('H');


}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/LeitorPulsos2/MikroC/LeitorPulsos2.c"
#line 27 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/LeitorPulsos2/MikroC/LeitorPulsos2.c"
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;


sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;



void leitura_Sensor();
void display_Digital1();
void display_Digital2();
void display_Digital3();
void display_Digital4();
void display_Analogico1();
void display_Analogico2();
void display_Default();


unsigned short cont = 0x00,
 pulso = 0x00;

int baseTempo1 = 0x00;
int baseTempo2 = 0x00;



void interrupt(){

 if(INT0IF_bit){

 INT0IF_bit = 0x00;
 baseTempo1 = 0x00;
 baseTempo2 = 0x00;
 pulso++;
 cont = pulso;

 }

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

 baseTempo1++;
 baseTempo2++;

 if(baseTempo1 == 2000){

 baseTempo1 = 0;

 pulso = 0x00;

 }

 if(baseTempo2 == 6000){

 baseTempo2 = 0x00;

 cont = 0x00;

 }

 }

}


void main() {

 ADCON1 = 0x0F;
 TRISB = 0x03;

 INTCON = 0xD0;
 INTEDG0_bit = 0x01;
 TMR2ON_bit = 0x01;
 PR2 = 200;
 TMR2IE_bit = 0x01;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_chr(1, 1, 'P');
 lcd_chr_cp('u');
 lcd_chr_cp('l');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp(' ');
 lcd_chr_cp('S');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp('r');


 while(1){



 leitura_Sensor();

 }

}


void leitura_Sensor(){

 switch(cont){

 case 0x01: display_Digital1();
 break;
 case 0x02: display_Digital2();
 break;
 case 0x03: display_Digital3();
 break;
 case 0x04: display_Digital4();
 break;
 case 0x05: display_Analogico1();
 break;
 case 0x06: display_Analogico2();
 break;
 default: display_Default();

 }

}


void display_Digital1(){

 lcd_chr(2, 2, 'D');
 lcd_chr_cp('i');
 lcd_chr_cp('g');
 lcd_chr_cp('i');
 lcd_chr_cp('t');
 lcd_chr_cp('a');
 lcd_chr_cp('l');
 lcd_chr_cp(' ');
 lcd_chr_cp('1');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');


}


void display_Digital2(){

 lcd_chr(2, 2, 'D');
 lcd_chr_cp('i');
 lcd_chr_cp('g');
 lcd_chr_cp('i');
 lcd_chr_cp('t');
 lcd_chr_cp('a');
 lcd_chr_cp('l');
 lcd_chr_cp(' ');
 lcd_chr_cp('2');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');

}


void display_Digital3(){

 lcd_chr(2, 2, 'D');
 lcd_chr_cp('i');
 lcd_chr_cp('g');
 lcd_chr_cp('i');
 lcd_chr_cp('t');
 lcd_chr_cp('a');
 lcd_chr_cp('l');
 lcd_chr_cp(' ');
 lcd_chr_cp('3');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');

}


void display_Digital4(){

 lcd_chr(2, 2, 'D');
 lcd_chr_cp('i');
 lcd_chr_cp('g');
 lcd_chr_cp('i');
 lcd_chr_cp('t');
 lcd_chr_cp('a');
 lcd_chr_cp('l');
 lcd_chr_cp(' ');
 lcd_chr_cp('4');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');

}


void display_Analogico1(){

 lcd_chr(2, 2, 'A');
 lcd_chr_cp('n');
 lcd_chr_cp('a');
 lcd_chr_cp('l');
 lcd_chr_cp('o');
 lcd_chr_cp('g');
 lcd_chr_cp('i');
 lcd_chr_cp('c');
 lcd_chr_cp('o');
 lcd_chr_cp(' ');
 lcd_chr_cp('1');
 lcd_chr_cp(' ');

}


void display_Analogico2(){

 lcd_chr(2, 2, 'A');
 lcd_chr_cp('n');
 lcd_chr_cp('a');
 lcd_chr_cp('l');
 lcd_chr_cp('o');
 lcd_chr_cp('g');
 lcd_chr_cp('i');
 lcd_chr_cp('c');
 lcd_chr_cp('o');
 lcd_chr_cp(' ');
 lcd_chr_cp('2');
 lcd_chr_cp(' ');

}


void display_Default(){

 lcd_chr(2, 2, 'S');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp('r');
 lcd_chr_cp('e');
 lcd_chr_cp('s');
 lcd_chr_cp(' ');
 lcd_chr_cp('O');
 lcd_chr_cp('k');
 lcd_chr_cp('!');

}

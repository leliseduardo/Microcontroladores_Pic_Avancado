#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/LCDSubMenusFuncionais/MikroC/LCDSubMenusFuncionais.c"
#line 19 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/LCDSubMenusFuncionais/MikroC/LCDSubMenusFuncionais.c"
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










void CustomChar(char pos_row, char pos_char);
void leitura_Botoes();
void apaga_Display();

void menu1();
void subMenu_1a();
void subMenu_1b();
void subMenu_1c();

void menu2();
void menu3();
void menu4();
void menu5();
void menu6();

void celsius();
int mediaTemperatura();
void picos_Temperatura();
void voltimetro();
void conta_Pulsos();
void conta_Tempo();
void dipSwitch();


const char character[] = {6,9,6,0,0,0,0,0};
char flagBotoes = 0x00;
bit apagaDisplay;
char menuControl = 0x01;
char subMenuControl = 0x00;

float temperatura = 0.0;
float ultimaTemperatura = 0.0;
float temperaturaMaxima = 0.0;
float temperaturaMinima = 150.0;
bit tempControl;
bit tempControl2;
char textoTemp[5];
int media = 0;
char contTemp = 0x00;

float volt = 0.0;
char textoVoltimetro[5];

unsigned long contPulsos = 0;
char textoPulsos[12];

unsigned long contTempo = 0;
char contAux = 0x00;
char textoTempo[12];


void interrupt(){

 if(INT0IF_bit){

 INT0IF_bit = 0x00;

 contPulsos++;

 }

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xB0;
 TMR0H = 0x3C;

 contAux++;

 if(contAux == 20){

 contAux = 0x00;

 contTemp++;

 contTempo++;

 if(contTemp == 3){

 contTemp = 0x00;

 tempControl = ~tempControl;

 }

 }

 }

}


void main() {




 INTCON = 0xF0;


 INTEDG0_bit = 0x01;


 TMR0ON_bit = 0x01;
 T08BIT_bit = 0x00;
 T0CS_bit = 0x00;
 PSA_bit = 0x01;


 TMR0L = 0xB0;
 TMR0H = 0x3C;


 ADCON0 = 0x01;
 ADCON1 = 0x0D;


 TRISA = 0xFF;
 TRISB = 0xFF;
 PORTB = 0xF9;

 tempControl = 0;
 tempControl2 = 0;

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







void celsius(){

 ADCON0 = 0x01;

 media = mediaTemperatura();

 temperatura = ((media * 5.0)/1024.0);
 temperatura = temperatura * 100.0;

 if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5))
 ultimaTemperatura = temperatura;

 if(temperatura > temperaturaMaxima) temperaturaMaxima = temperatura;

 if(temperatura < temperaturaMinima) temperaturaMinima = temperatura;


 if(!tempControl2){
 FloatToStr(ultimaTemperatura, textoTemp);

 if(ultimaTemperatura < 0.05){
 lcd_chr(2, 6, 48);
 lcd_chr_cp(48);
 lcd_chr_cp('.');
 lcd_chr_cp(48);
 lcd_chr_cp(48);
 }
 else{
 lcd_chr(2, 6, textoTemp[0]);
 lcd_chr_cp(textoTemp[1]);
 lcd_chr_cp(textoTemp[2]);
 lcd_chr_cp(textoTemp[3]);
 lcd_chr_cp(textoTemp[4]);
 }
 customChar(2, 13);
 lcd_chr(2, 14, 'C');
 }
 else{
 if(!tempControl){
 FloatToStr(temperaturaMaxima, textoTemp);
 lcd_chr(2, 1, 'M');
 lcd_chr_cp('a');
 lcd_chr_cp('x');
 lcd_chr_cp(':');

 lcd_chr(2, 5, textoTemp[0]);
 lcd_chr_cp(textoTemp[1]);
 lcd_chr_cp(textoTemp[2]);
 lcd_chr_cp(textoTemp[3]);
 lcd_chr_cp(textoTemp[4]);
 customChar(2, 13);
 lcd_chr(2, 14, 'C');
 }
 else{
 FloatToStr(temperaturaMinima, textoTemp);
 lcd_chr(2, 1, 'M');
 lcd_chr_cp('i');
 lcd_chr_cp('n');
 lcd_chr_cp(':');

 lcd_chr(2, 5, textoTemp[0]);
 lcd_chr_cp(textoTemp[1]);
 lcd_chr_cp(textoTemp[2]);
 lcd_chr_cp(textoTemp[3]);
 lcd_chr_cp(textoTemp[4]);
 customChar(2, 13);
 lcd_chr(2, 14, 'C');
 }

 }
#line 292 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/LCDSubMenusFuncionais/MikroC/LCDSubMenusFuncionais.c"
}

int mediaTemperatura(){

 char i;
 int adc = 0;

 for(i = 0; i < 0x64; i++){

 if(!tempControl) adc += adc_read(0);
 else adc += adc_read(0);

 }

 return (adc/0x64);
}

void CustomChar(char pos_row, char pos_char) {
 char i;
 Lcd_Cmd(64);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 0);
}

void voltimetro(){

 char mil = 0x00, cen = 0x00, dez = 0x00, uni = 0x00;
 int adc = 0;

 adc = adc_read(1);

 volt = ((adc * 5.0)/1024.0);

 FloatToStr(volt, textoVoltimetro);

 if(volt < 0.01){
 lcd_chr(2, 8, 48);
 lcd_chr_cp(48);
 lcd_chr_cp('.');
 lcd_chr_cp(48);
 lcd_chr_cp(48);
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 }
 else{
 lcd_chr(2, 8, textoVoltimetro[0]);
 lcd_chr_cp(textoVoltimetro[1]);
 lcd_chr_cp(textoVoltimetro[2]);
 lcd_chr_cp(textoVoltimetro[3]);
 lcd_chr_cp(textoVoltimetro[4]);
 if(volt < 1){
 lcd_chr_cp('E');
 lcd_chr_cp('-');
 lcd_chr_cp(49);
 }
 else{
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');
 }
 lcd_chr(2, 16, 'V');
 }

}

void conta_Pulsos(){

 LongToStr(contPulsos, textoPulsos);

 lcd_Out(2, 2, textoPulsos);

}

void conta_Tempo(){

 LongToStr(contTempo, textoTempo);

 lcd_out(2, 2, textoTempo);

}

void dipSwitch(){

 if(! RB1_bit ) lcd_out(2, 1, "Ch1:Off");
 else lcd_out(2, 1, "Ch1:On ");

 if(! RB2_bit ) lcd_out(2, 9, "Ch2:Off");
 else lcd_out(2, 9, "Ch2:On ");

}








void leitura_Botoes(){

 if(! RB6_bit ) flagBotoes.B0 = 0x01;
 if(! RB7_bit ) flagBotoes.B1 = 0x01;
 if(! RB5_bit ) flagBotoes.B2 = 0x01;

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


 if( RB5_bit  && flagBotoes.B2){

 flagBotoes.B2 = 0x00;
 apagaDisplay = 1;
 subMenuControl++;

 if(subMenuControl > 0x03) subMenuControl = 0x00;

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

 switch(subMenuControl){
 case 0x00: lcd_chr(1, 2, 'T');
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

 lcd_chr(2, 1, 'I');
 lcd_chr_cp('n');
 lcd_chr_cp('t');
 lcd_chr_cp(':');

 tempControl2 = 0;
 celsius();
 break;
 case 0x01: subMenu_1a();
 break;
 case 0x02: subMenu_1b();
 break;
 case 0x03: subMenu_1c();
 break;
 }

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

 tempControl2 = 1;
 celsius();

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

 lcd_chr(2, 1, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('s');
 lcd_chr_cp('a');
 lcd_chr_cp('o');
 lcd_chr_cp(':');

 ADCON0 = 0x05;
 voltimetro();

}


void menu4(){

 apaga_Display();

 lcd_chr(1, 2, 'P');
 lcd_chr_cp('u');
 lcd_chr_cp('l');
 lcd_chr_cp('s');
 lcd_chr_cp('o');
 lcd_chr_cp('s');
 lcd_chr_cp(':');

 conta_Pulsos();

}


void menu5(){

 apaga_Display();

 lcd_chr(1, 2, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('m');
 lcd_chr_cp('p');
 lcd_chr_cp('o');

 conta_Tempo();

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

 dipSwitch();

}








void subMenu_1a(){

 lcd_chr(1, 2, 'S');
 lcd_chr_cp('u');
 lcd_chr_cp('b');
 lcd_chr_cp(' ');
 lcd_chr_cp('M');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('u');
 lcd_chr_cp(' ');
 lcd_chr_cp('1');
 lcd_chr_cp('a');

 FloatToStr(temperaturaMaxima, textoTemp);

 lcd_chr(2, 1, 'M');
 lcd_chr_cp('a');
 lcd_chr_cp('x');
 lcd_chr_cp(':');

 lcd_chr(2, 5, textoTemp[0]);
 lcd_chr_cp(textoTemp[1]);
 lcd_chr_cp(textoTemp[2]);
 lcd_chr_cp(textoTemp[3]);
 lcd_chr_cp(textoTemp[4]);
 customChar(2, 13);
 lcd_chr(2, 14, 'C');


}


void subMenu_1b(){

 lcd_chr(1, 2, 'S');
 lcd_chr_cp('u');
 lcd_chr_cp('b');
 lcd_chr_cp(' ');
 lcd_chr_cp('M');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('u');
 lcd_chr_cp(' ');
 lcd_chr_cp('1');
 lcd_chr_cp('b');

 FloatToStr(temperaturaMinima, textoTemp);

 lcd_chr(2, 1, 'M');
 lcd_chr_cp('i');
 lcd_chr_cp('n');
 lcd_chr_cp(':');

 lcd_chr(2, 5, textoTemp[0]);
 lcd_chr_cp(textoTemp[1]);
 lcd_chr_cp(textoTemp[2]);
 lcd_chr_cp(textoTemp[3]);
 lcd_chr_cp(textoTemp[4]);
 customChar(2, 13);
 lcd_chr(2, 14, 'C');

}


void subMenu_1c(){

 lcd_chr(1, 2, 'S');
 lcd_chr_cp('u');
 lcd_chr_cp('b');
 lcd_chr_cp(' ');
 lcd_chr_cp('M');
 lcd_chr_cp('e');
 lcd_chr_cp('n');
 lcd_chr_cp('u');
 lcd_chr_cp(' ');
 lcd_chr_cp('1');
 lcd_chr_cp('c');

 FloatToStr(((temperaturaMaxima+temperaturaMinima)/2), textoTemp);

 lcd_chr(2, 1, 'M');
 lcd_chr_cp('e');
 lcd_chr_cp('d');
 lcd_chr_cp(':');

 lcd_chr(2, 5, textoTemp[0]);
 lcd_chr_cp(textoTemp[1]);
 lcd_chr_cp(textoTemp[2]);
 lcd_chr_cp(textoTemp[3]);
 lcd_chr_cp(textoTemp[4]);
 customChar(2, 13);
 lcd_chr(2, 14, 'C');

}

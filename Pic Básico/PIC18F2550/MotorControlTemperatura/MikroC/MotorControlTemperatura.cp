#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/MotorControlTemperatura/MikroC/MotorControlTemperatura.c"
#line 22 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/MotorControlTemperatura/MikroC/MotorControlTemperatura.c"
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









void leitura_Botoes();
void base_Tempo();
void imprime_Display();
void inicia_Motor();
void celsius();
int media_Temperatura();
void CustomChar(char pos_row, char pos_char);



unsigned short valor = 0x80,
 baseTempo = 0x00,
 contBotao = 0x00,
 contTempo = 120,
 controlAdiciona = 0x00,
 duty = 0x00;

float temperatura = 0.0,
 ultimaTemperatura = 0.0;
int adc = 0x00;
char txt[7];
const char character[] = {6,9,6,0,0,0,0,0};

bit flagBotao;
bit controlRapido;
bit flagStart;


void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 baseTempo++;
 contTempo++;

 if(contTempo > 120){

  LATB1_bit  = 0x00;
 contTempo = 120;
 controlAdiciona = 0x00;

 }

 if(flagBotao) contBotao++;

 base_Tempo();

 }

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

 if(duty == 0x00)  LATC0_bit  = 0x00;
 else {
 if( LATC0_bit ){

 TMR2 = duty;
  LATC0_bit  = 0x00;

 }
 else{

 TMR2 = 255 - duty;
  LATC0_bit  = 0x01;

 }
 }
 }

}

void main() {


 ADCON0 = 0x01;
 ADCON1 = 0x0E;
 TRISB = 0x01;
 TRISC = 0xFC;
 LATC = 0xFC;

 INTCON = 0xE0;
 INTCON2.B7 = 0x00;

 T0CON = 0x81;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 T2CON = 0x05;
 PR2 = 0xFF;
 TMR2IE_bit = 0x01;

 flagBotao = 0x00;
 controlRapido = 0x00;
 flagStart = 0x00;


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_chr(1, 2, 'D');
 lcd_chr_cp('u');
 lcd_chr_cp('t');
 lcd_chr_cp('y');
 lcd_chr_cp(':');
 lcd_chr(2, 2, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('m');
 lcd_chr_cp('p');
 lcd_chr_cp(':');



 while(1){

 leitura_Botoes();

 imprime_Display();

 celsius();

 if(temperatura > 31){

 duty = 0x3C;
  LATC1_bit  = 0x01;

 }

 if(temperatura < 27 &&  LATC1_bit ){

 inicia_Motor();
  LATC1_bit  = 0x00;

 }

 }

}



void leitura_Botoes(){

 if(! RB0_bit ){

 flagBotao = 0x01;
  LATB1_bit  = 0x01;
 contTempo = 0x00;

 }

 if( RB0_bit  && flagBotao){

 flagBotao = 0x00;
 contBotao = 0x00;
 controlRapido = 0x00;
 controlAdiciona++;

 if(controlAdiciona > 1) valor++;

 }

 if(! LATC1_bit )
 if(! RC2_bit ) flagStart = 0x01;

 if( RC2_bit  && flagStart){

 flagStart = 0x00;

 inicia_Motor();

 }

}




void base_Tempo(){

 if(contBotao == 40) controlRapido = 0x01;

 if(baseTempo == 0x04){

 baseTempo = 0x00;

 if(controlRapido) valor += 1;

 }

}





void imprime_Display(){

 unsigned char dig3, dig2, dig1;

 dig3 = valor/100;
 dig2 = (valor%100)/10;
 dig1 = valor%10;

 lcd_chr(1, 8, dig3 + 0x30);
 lcd_chr_cp(dig2 + 0x30);
 lcd_chr_cp(dig1 + 0x30);

}



void inicia_Motor(){

 char i;
 duty = 0x00;

 for(i = 0x00; i < valor; i++){

 duty += 0x01;
 delay_ms(10);

 }

}


void celsius(){

 adc = media_Temperatura();

 temperatura = ((adc * 5.0) / 1024.0);

 temperatura = temperatura * 100.0;

 if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5)){

 ultimaTemperatura = temperatura;

 FloatToStr(temperatura, txt);

 lcd_chr(2, 8, txt[0]);
 lcd_chr_cp(txt[1]);
 lcd_chr_cp(txt[2]);
 lcd_chr_cp(txt[3]);
 lcd_chr_cp(txt[4]);
 lcd_chr_cp(txt[5]);
 CustomChar(2, 14);
 lcd_chr(2, 15, 'C');


 }

}


int media_Temperatura(){

 char i;
 int media = 0x00;

 for(i = 0x00; i < 0x64; i++)
 media += adc_read(0);

 return (media/0x64);

}



void CustomChar(char pos_row, char pos_char) {

 char i;
 Lcd_Cmd(72);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 1);

}

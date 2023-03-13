#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/IncInteligenteBackLight/MikroC/IncInteligenteBackLight.c"
#line 12 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/IncInteligenteBackLight/MikroC/IncInteligenteBackLight.c"
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


unsigned valor = 0x00,
 baseTempo = 0x00,
 contBotao = 0x00,
 contTempo = 120,
 controlAdiciona = 0x00;

bit flagBotao;
bit controlRapido;


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

}

void main() {


 ADCON1 = 0x0F;
 TRISB = 0x01;

 INTCON = 0xA0;
 INTCON2.B7 = 0x00;

 T0CON = 0x81;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 flagBotao = 0x00;
 controlRapido = 0x00;


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_chr(1, 2, 'V');
 lcd_chr_cp('a');
 lcd_chr_cp('l');
 lcd_chr_cp(':');


 while(1){

 leitura_Botoes();

 imprime_Display();

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

}




void base_Tempo(){

 if(contBotao == 40) controlRapido = 0x01;

 if(baseTempo == 0x04){

 baseTempo = 0x00;

 if(controlRapido) valor += 1;

 }

}





void imprime_Display(){

 unsigned char dig5, dig4, dig3, dig2, dig1;

 dig5 = valor/10000;
 dig4 = (valor%10000)/1000;
 dig3 = (valor%1000)/100;
 dig2 = (valor%100)/10;
 dig1 = valor%10;

 lcd_chr(1, 7, dig5 + 0x30);
 lcd_chr_cp(dig4 + 0x30);
 lcd_chr_cp(dig3 + 0x30);
 lcd_chr_cp(dig2 + 0x30);
 lcd_chr_cp(dig1 + 0x30);

}

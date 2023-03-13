#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PWMAjusteDigital/MikroC/PWMAjusteDigital.c"
#line 17 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PWMAjusteDigital/MikroC/PWMAjusteDigital.c"
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


unsigned short valor = 0x80,
 baseTempo = 0x00,
 contBotao = 0x00,
 contTempo = 120,
 controlAdiciona = 0x00,
 duty = 0x00;

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

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

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

void main() {


 ADCON1 = 0x0F;
 TRISB = 0x01;
 TRISC = 0xFE;

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


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_chr(1, 2, 'D');
 lcd_chr_cp('u');
 lcd_chr_cp('t');
 lcd_chr_cp('y');
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

 unsigned char dig3, dig2, dig1;

 dig3 = valor/100;
 dig2 = (valor%100)/10;
 dig1 = valor%10;

 lcd_chr(1, 8, dig3 + 0x30);
 lcd_chr_cp(dig2 + 0x30);
 lcd_chr_cp(dig1 + 0x30);

 duty = valor;

 if(duty == 0x00){

 TMR2ON_bit = 0x00;

  LATC0_bit  = 0x00;

 }
 else TMR2ON_bit = 0x01;

}

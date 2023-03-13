#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Cronometro/MikroC/Cronometro.c"
#line 34 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Cronometro/MikroC/Cronometro.c"
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







void cronometro();
void display_Cronometro();


char centesimo = 0x00, segundos = 0x00, minutos = 0x00, hora = 0x00;
char *texto = "00:00:00:00";
char flagBotoes = 0x00;


void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0L = 0xF0;
 TMR0H = 0xD8;

 cronometro();

  LATB0_bit  = ~ LATB0_bit ;
 }

}

void main() {


 INTCON = 0x80;


 TMR0ON_bit = 0x01;
 T08BIT_bit = 0x00;
 T0CS_bit = 0x00;
 PSA_bit = 0x01;

 TMR0L = 0xF0;
 TMR0H = 0xD8;

 ADCON1 = 0x0F;
 TRISB = 0xFE;
  LATB0_bit  = 0x00;


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_CMD(_LCD_CLEAR);


 while(1){

 if(! RB7_bit ) flagBotoes.B0 = 0x01;

 if(!TMR0IE_bit)
 if(! RB6_bit ) flagBotoes.B1 = 0x01;

 if( RB7_bit  && flagBotoes.B0){

 flagBotoes.B0 = 0x00;

 TMR0IE_bit = ~TMR0IE_bit;
 }

 if( RB6_bit  && flagBotoes.B1){

 flagBotoes.B1 = 0x00;

 hora = 0x00;
 minutos = 0x00;
 segundos = 0x00;
 centesimo = 0x00;
 }

 display_Cronometro();

 }

}

void cronometro(){

 centesimo++;

 if(centesimo == 0x64){

 centesimo = 0x00;

 segundos++;

 if(segundos == 0x3C){

 segundos = 0x00;

 minutos++;

 if(minutos == 0x6C){

 minutos = 0x00;

 hora++;

 if(hora == 0x18)
 hora = 0x00;


 }

 }

 }

}

void display_Cronometro(){

 texto[0] = hora/10 + '0';
 texto[1] = hora%10 + '0';
 texto[3] = minutos/10 + '0';
 texto[4] = minutos%10 + '0';
 texto[6] = segundos/10 + '0';
 texto[7] = segundos%10 + '0';
 texto[9] = centesimo/10 + '0';
 texto[10] = centesimo%10 + '0';

 lcd_out(1, 3, texto);

}

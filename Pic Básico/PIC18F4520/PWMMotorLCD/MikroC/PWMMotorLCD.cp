#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMMotorLCD/MikroC/PWMMotorLCD.c"
#line 30 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/PWMMotorLCD/MikroC/PWMMotorLCD.c"
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






void set_Duty();
void leitura_Botoes();


unsigned short duty = 128;
char i;
bit control;
char flagBotoes = 0x00;
char cont = 0x00;



void interrupt(){

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1L = 0xB0;
 TMR1H = 0x3C;

 cont++;

 if(cont == 40){

 cont = 0x00;
 control = 1;
 }

 }

}

void main() {


 INTCON = 0xC0;


 TMR1IE_bit = 0x01;

 T1CON = 0x00;


 TMR1L = 0xB0;
 TMR1H = 0x3C;

 ADCON1 = 0x0F;
 TRISB = 0xFF;
 control = 0;

 lcd_Init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);

 PWM1_Init(1000);
 PWM1_Stop();
 PWM1_Set_Duty(duty);


 set_Duty();
 for(i = 0; i < 17; i++) lcd_chr(1, i, ' ');
 lcd_out(1, 3, "Motor acionado");

 while(1){

 PWM1_start();
 PWM1_Set_Duty(duty);
 }

}

void set_Duty(){

 char cen = 0x00, dez = 0x00, uni = 0x00;

 while(!control){

 leitura_Botoes();

 lcd_chr(1, 3, 'S');
 lcd_chr_cp('e');
 lcd_chr_cp('t');
 lcd_chr_cp(' ');
 lcd_chr_cp('D');
 lcd_chr_cp('u');
 lcd_chr_cp('t');
 lcd_chr_cp('y');
 lcd_chr_cp('!');

 cen = duty/100;
 dez = (duty%100)/10;
 uni = duty%10;

 lcd_chr(2, 5, cen + 48);
 lcd_chr_cp(dez + 48);
 lcd_chr_cp(uni + 48);

 }
}


void leitura_Botoes(){

 if(! RB6_bit ){

 flagBotoes.B0 = 0x01;

 TMR1ON_bit = 0x01;
 }

 if(! RB7_bit ) {

 flagBotoes.B1 = 0x01;

 TMR1ON_bit = 0x01;
 }

 if( RB6_bit  && flagBotoes.B0){

 flagBotoes.B0 = 0x00;
 TMR1ON_bit = 0x00;
 TMR1L = 0xB0;
 TMR1H = 0x3C;
 cont = 0x00;
 duty--;
 }

 if( RB7_bit  && flagBotoes.B1){

 flagBotoes.B1 = 0x00;
 TMR1ON_bit = 0x00;
 TMR1L = 0xB0;
 TMR1H = 0x3C;
 cont = 0x00;
 duty++;
 }

}

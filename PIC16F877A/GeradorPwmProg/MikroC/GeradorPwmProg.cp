#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F877A/GeradorPwmProg/MikroC/GeradorPwmProg.c"




sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;
#line 39 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F877A/GeradorPwmProg/MikroC/GeradorPwmProg.c"
void guardaNum(unsigned num);
char concatenaNum(unsigned dez, unsigned uni);
void dutyHalf(unsigned duty);



char control = 0x01;
char dezena = 0;
char unidade = 0;
char guardaNume = 0;
char aux = 0;
char numero = 0;




void interrupt(){


 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0 = 0x00;

 if( RB1_bit  && control == 0x01){
  RB1_bit  = 0x00;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
 control = 0x02;

 if(! RB4_bit )
 guardaNum(1);
 else if(! RB5_bit )
 guardaNum(4);
 else if(! RB6_bit )
 guardaNum(7);
 else if(! RB7_bit )
 aux = 1;

 }
 else if( RB2_bit  && control == 0x02){
  RB1_bit  = 0x01;
  RB2_bit  = 0x00;
  RB3_bit  = 0x01;
 control = 0x03;

 if(! RB4_bit )
 guardaNum(2);
 else if(! RB5_bit )
 guardaNum(5);
 else if(! RB6_bit )
 guardaNum(8);
 else if(! RB7_bit )
 guardaNum(0);

 }
 else if( RB3_bit  && control == 0x03){
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x00;
 control = 0x01;

 if(! RB4_bit )
 guardaNum(3);
 else if(! RB5_bit )
 guardaNum(6);
 else if(! RB6_bit )
 guardaNum(9);
 else if(! RB7_bit )
 dutyHalf(50);

 }
 }
}

void main() {

 CMCON = 0x07;
 OPTION_REG = 0x87;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR0IE_bit = 0x01;
 TMR0 = 0x00;

 TRISB = 0xF0;
 TRISC = 0xFB;
 TRISD = 0x03;
 PORTB = 0x0F;





 PWM1_Init(2000);



 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 4, "Ajuste de PWM");



 PWM1_Start();

 while(1){

  Lcd_Out(2, 1, "Duty Cicle: "); lcd_chr_cp(dezena+48); lcd_chr_cp(unidade+48); ;

 if(aux == 1){
 numero = concatenaNum(dezena, unidade);

 guardaNume = 0;
 }

 PWM1_Set_Duty((numero*255)/100);
 delay_ms(100);
 }
}

void guardaNum(unsigned num){

 if(guardaNume == 0){
 dezena = num;
 delay_ms(300);
 guardaNume = 1;
 }
 else{
 unidade = num;
 delay_ms(300);
 }
}

char concatenaNum(unsigned dez, unsigned uni){

 unsigned char num;

 num = (dez*10) + uni;

 aux = 0;

 return num;
}

void dutyHalf(unsigned duty){
 numero = duty;
 delay_ms(100);
 dezena = 5;
 unidade = 0;
}

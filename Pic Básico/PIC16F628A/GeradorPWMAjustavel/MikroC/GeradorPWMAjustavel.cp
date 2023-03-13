#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/GeradorPWMAjustavel/MikroC/GeradorPWMAjustavel.c"

sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;


sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;








char *texto = "Ajuste de PWM";
char txt[7];
const unsigned freq = 1000;
unsigned char duty = 127;
char cont = 0x00;

void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;
 TMR0 = 0x64;

 cont++;

 if(cont == 0x02){

 cont = 0x00;

 if(! RA0_bit )
 duty++;
 if(! RA1_bit )
 duty--;
 }
 }
}

void main() {

 CMCON = 0x07;
 OPTION_REG = 0x86;
 INTCON = 0XA0;
 TMR0 = 0x64;

 TRISA = 0xFF;
 TRISB = 0x01;
 PORTA = 0xFF;
 PORTB = 0x00;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1,1,texto);
 delay_ms(100);

 PWM1_Init(freq);
 PWM1_Start();
 PWM1_Set_Duty(duty);

 while(1){

 PWM1_Set_Duty(duty);

 IntToStr(duty, txt);

 lcd_out(2,2, txt);

 delay_ms(100);
 }
}

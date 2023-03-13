#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/I2CSimples/MikroC/I2CSimples.c"
#line 12 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/I2CSimples/MikroC/I2CSimples.c"
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


unsigned short info = 0x00;
char txt[7];

void main() {

 TRISB = 0x00;
 PORTB = 0x00;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);

 I2C1_Init(100000);
 I2C1_Start();
 I2C1_Wr(0xA2);
 I2C1_Wr(2);
 I2C1_Wr(0xAB);
 I2C1_Stop();

 Delay_100ms();

 I2C1_Start();
 I2C1_Wr(0xA2);
 I2C1_Wr(2);
 I2C1_Repeated_Start();
 I2C1_Wr(0xA3);
 info = I2C1_Rd(0u);
 I2C1_Stop();

 IntToStr(info, txt);

 lcd_out(1, 7, txt);
}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/I2CSimples/MikroC/I2CSimples.c"
#line 14 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/I2CSimples/MikroC/I2CSimples.c"
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


unsigned short memoria = 0x00;
char txt[15];

void main() {

 ADCON1 = 0x0F;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1, 1, "EEPROM Externa");

 I2C1_Init(400000);
 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(0x05);
 I2C1_Wr(39);
 I2C1_Stop();

 delay_ms(100);

 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(0x05);
 I2C1_Repeated_Start();
 I2C1_Wr(0xA1);
 memoria = I2C1_Rd(0u);
 I2C1_Stop();

 IntToStr(memoria, txt);

 lcd_out(2, 1, txt);


 while(1){



 }

}

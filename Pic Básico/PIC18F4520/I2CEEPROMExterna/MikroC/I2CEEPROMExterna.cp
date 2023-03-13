#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/I2CEEPROMExterna/MikroC/I2CEEPROMExterna.c"
#line 19 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/I2CEEPROMExterna/MikroC/I2CEEPROMExterna.c"
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







void leitura_EEPROM();
void escrita_EEPROM(unsigned short info);


unsigned char flagEnter = 0x00,
 flagMais = 0x00,
 flagMenos = 0x00;

unsigned short cont = 0x00, memoria = 0x00;
char txt[7];

void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFF;
 PORTB = 0xFF;


 I2C1_Init(100000);
 I2C1_Start();
 I2C1_Wr(0xA2);
 I2C1_Wr(2);

 I2C1_Stop();
 delay_ms(100);


 lcd_init();
 lcd_cmd(_LCD_CLEAR);
 lcd_CMD(_LCD_CURSOR_OFF);

 if(! RB7_bit ){

 leitura_EEPROM();
 delay_ms(100);

 }


 while(1){

 if(! RB6_bit ) flagMais = 0x01;
 if(! RB5_bit ) flagMenos = 0x01;
 if(! RB7_bit ) flagEnter = 0x01;

 if( RB6_bit  && flagMais){

 flagMais = 0x00;
 cont++;

 }

 if( RB5_bit  && flagMenos){

 flagMenos = 0x00;
 cont--;

 }

 if( RB7_bit  && flagEnter){

 flagEnter = 0x00;
 escrita_EEPROM(cont);
 delay_ms(100);

 }

 IntToSTR(cont, txt);

 lcd_out(1, 5, txt);

 }

}

void leitura_EEPROM(){

 I2C1_Start();
 I2C1_Wr(0xA2);
 I2C1_Wr(2);
 I2C1_Repeated_Start();
 I2C1_Wr(0xA3);
 memoria = I2C1_Rd(0u);
 I2C1_Stop();

 cont = memoria;

}

void escrita_EEPROM(unsigned short info){

 I2C1_Init(100000);
 I2C1_Start();
 I2C1_Wr(0xA2);
 I2C1_Wr(2);
 I2C1_Wr(info);
 I2C1_Stop();

 delay_ms(100);

}

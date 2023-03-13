#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/EEPROMExterna16Bits/MikroC/EEPROMExterna16Bits.c"
#line 10 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/EEPROMExterna16Bits/MikroC/EEPROMExterna16Bits.c"
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






void imprime_Display();
void EEPROM_Escreve16bits();


int
 memoriaNova = 0x00;

unsigned short memoriaH = 0x00,
 memoriaL = 0x00;

void main() {

 ADCON1 = 0x0F;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1, 2, "Valor 16 bits");

 I2C1_Init(400000);


 while(1){

 imprime_Display();

 if(! RC0_bit ){

 memoriaNova += 0x01;
 EEPROM_Escreve16bits();

 }

 if(! RC1_bit ){

 memoriaNova -= 0x01;
 EEPROM_Escreve16bits();

 }

 }

}


void EEPROM_Escreve16bits(){

 memoriaH = memoriaNova >> 0x08;
 memoriaL = memoriaNova % 256;

 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(0x05);
 I2C1_Wr(memoriaH);
 I2C1_Stop();
 delay_ms(100);
 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(0x06);
 I2C1_Wr(memoriaL);
 I2C1_Stop();
 delay_ms(100);

}


void imprime_Display(){

 char dezmil, mil, cen, dez, uni;

 dezmil = memoriaNova/10000;
 mil = (memoriaNova%10000)/1000;
 cen = (memoriaNova%1000)/100;
 dez = (memoriaNova%100)/10;
 uni = memoriaNova%10;

 lcd_chr(2, 10, dezmil + 0x30);
 lcd_chr_cp(mil + 0x30);
 lcd_chr_cp(cen + 0x30);
 lcd_chr_cp(dez + 0x30);
 lcd_chr_cp(uni + 0x30);

}

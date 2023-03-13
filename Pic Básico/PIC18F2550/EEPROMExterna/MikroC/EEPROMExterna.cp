#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/EEPROMExterna/MikroC/EEPROMExterna.c"
#line 17 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/EEPROMExterna/MikroC/EEPROMExterna.c"
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


unsigned char memoriaVelha = 0x00,
 memoriaNova = 0x00;

void main() {

 ADCON1 = 0x0F;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1, 2, "Velho");
 lcd_out(1, 10, "Novo");

 I2C1_Init(400000);
 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(0x05);
 I2C1_Repeated_Start();
 I2C1_Wr(0xA1);
 memoriaVelha = I2C1_Rd(0u);
 I2C1_Stop();


 while(1){

 imprime_Display();

 if(! RC0_bit ){

 memoriaNova += 0x01;
 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(0x05);
 I2C1_Wr(memoriaNova);
 I2C1_Stop();
 delay_ms(250);

 }

 if(! RC1_bit ){

 memoriaNova -= 0x01;
 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(0x05);
 I2C1_Wr(memoriaNova);
 I2C1_Stop();
 delay_ms(250);

 }

 }

}



void imprime_Display(){

 char cenVelho, dezVelho, uniVelho, cenNovo, dezNovo, uniNovo;

 cenVelho = memoriaVelha/100;
 dezVelho = (memoriaVelha%100)/10;
 uniVelho = memoriaVelha%10;

 cenNovo = memoriaNova/100;
 dezNovo = (memoriaNova%100)/10;
 uniNovo = memoriaNova%10;

 lcd_chr(2, 3, cenVelho + 0x30);
 lcd_chr_cp(dezVelho + 0x30);
 lcd_chr_cp(uniVelho + 0x30);

 lcd_chr(2, 11, cenNovo + 0x30);
 lcd_chr_cp(dezNovo + 0x30);
 lcd_chr_cp(uniNovo + 0x30);

}

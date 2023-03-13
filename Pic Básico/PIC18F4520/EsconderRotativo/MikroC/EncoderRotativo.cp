#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/EsconderRotativo/MikroC/EncoderRotativo.c"
#line 16 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/EsconderRotativo/MikroC/EncoderRotativo.c"
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


void display_Encoder();
char leitura_Encoder();


char txt[5];

void main() {

 ADCON1 = 0x0F;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);


 while(1){

 lcd_out(1, 2, "Teste Enconder");
 display_Encoder();

 }

}

void display_Encoder(){

 static unsigned short cont = 0x00;
 unsigned char cen = 0x00, dez = 0x00, uni = 0x00;
 unsigned short encoder;

 encoder = leitura_Encoder();

 if(encoder){

 lcd_cmd(_LCD_CLEAR);
 cont += encoder;

 }

 cen = cont/100;
 dez = (cont%100)/10;
 uni = cont%10;

 lcd_chr(2, 7, cen + 48);
 lcd_chr_cp(dez + 48);
 lcd_chr_cp(uni + 48);

}

char leitura_Encoder(){

 static unsigned short estadosEncoder[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
 static unsigned short AB = 0x00;

 AB <<= 2;
 AB |= ( PORTC & 0x03);

 return ( estadosEncoder[( AB & 0x0F )]);

}

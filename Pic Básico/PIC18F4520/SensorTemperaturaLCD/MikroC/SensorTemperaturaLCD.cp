#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SensorTemperaturaLCD/MikroC/SensorTemperaturaLCD.c"
#line 36 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/SensorTemperaturaLCD/MikroC/SensorTemperaturaLCD.c"
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


void escreveDisplay();
void celsius();
int mediaADC();
void CustomChar(char linha, char coluna);



const char character[] = {7,5,7,0,0,0,0,0};
int mediaTemp = 0x00;
float tensao = 0.0;
float temperatura = 0.0;
float ultimaTemp = 0.0;
char txt[7];


void main() {

 ADCON0 = 0x01;
 ADCON1 = 0x0E;
 TRISA = 0xFF;
 TRISD = 0x03;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);

 escreveDisplay();

 while(1){

 celsius();
 }
}

void celsius(){

 mediaTemp = mediaADC();

 tensao = ((mediaTemp * 5.0) / 1024.0);

 temperatura = tensao * 100.0;

 if(temperatura > (ultimaTemp + 0.5) || temperatura < (ultimaTemp - 0.5)){

 ultimaTemp = temperatura;

 FloatToStr(ultimaTemp, txt);

 lcd_chr(2, 4, txt[0]);
 lcd_chr_cp(txt[1]);
 lcd_chr_cp(txt[2]);
 lcd_chr_cp(txt[3]);
 lcd_chr_cp(txt[4]);
 CustomChar(2, 9);
 lcd_chr(2, 10, 'C');
 }
}

int mediaADC(){

 int adc = 0x00;
 int i;

 for(i = 0x00; i < 0x64; i++)
 adc += adc_read(0);

 return (adc/0x64);
}

void CustomChar(char linha, char coluna) {

 char i;

 Lcd_Cmd(64);

 for (i = 0; i <= 7; i++) Lcd_Chr_CP(character[i]);

 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(linha, coluna, 0);
}

void escreveDisplay(){

 lcd_chr(1, 2, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('r');
 lcd_chr_cp('m');
 lcd_chr_cp('o');
 lcd_chr_cp('m');
 lcd_chr_cp('e');
 lcd_chr_cp('t');
 lcd_chr_cp('r');
 lcd_chr_cp('o');
 lcd_chr_cp(' ');
 lcd_chr_cp('P');
 lcd_chr_cp('I');
 lcd_chr_cp('C');
}

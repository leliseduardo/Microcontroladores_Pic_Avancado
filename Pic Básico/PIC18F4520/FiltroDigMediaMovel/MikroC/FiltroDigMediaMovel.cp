#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/FiltroDigMediaMovel/MikroC/FiltroDigMediaMovel.c"
#line 31 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/FiltroDigMediaMovel/MikroC/FiltroDigMediaMovel.c"
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
void CustomChar(char linha, char coluna);
void celsius();
long mediaMovel();



const char character[] = {6,9,6,0,0,0,0,0};
long movingAverage;
float temperatura = 0.0;
float ultimaTemperatura = 0.0;
char txt[7];
int media[ 50 ];
int adc = 0x00;


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

 movingAverage = mediaMovel();

 temperatura = ((movingAverage * 5.0)/1024.0);

 temperatura = temperatura * 100.0;

 if((temperatura > ultimaTemperatura + 0.8) || temperatura < ultimaTemperatura - 0.8){

 ultimaTemperatura = temperatura;

 floatToStr(ultimaTemperatura, txt);

 lcd_chr(2, 3, txt[0]);
 lcd_chr_cp(txt[1]);
 lcd_chr_cp(txt[2]);
 lcd_chr_cp(txt[3]);
 lcd_chr_cp(txt[4]);
 CustomChar(2, 8);
 lcd_chr(2, 9, 'C');
 }
}

long mediaMovel(){

 char i;
 long cont = 0;

 adc = adc_read(0);

 for(i =  50 -1; i > 0; i--)
 media[i] = media[i-1];

 media[0] = adc;

 for(i = 0; i <  50 ; i++)
 cont = cont + media[i];

 return (cont/ 50 );
}

void CustomChar(char linha, char coluna) {
 char i;
 Lcd_Cmd(64);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(linha, coluna, 0);
}

void escreveDisplay(){

 lcd_chr(1, 3, 'T');
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

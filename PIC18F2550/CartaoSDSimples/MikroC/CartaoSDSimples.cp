#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/CartaoSDSimples/MikroC/CartaoSDSimples.c"
#line 10 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/CartaoSDSimples/MikroC/CartaoSDSimples.c"
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


sbit Mmc_Chip_Select at LATC0_bit;
sbit Mmc_Chip_Select_Direction at TRISC0_bit;



void imprime_Display();
unsigned calcula_Tensao(int n);

extern void start_SD();
extern void novo_Arquivo();


int valorMaximo = 0x00,
 valorMinimo = 500;


unsigned valor = 0x00,
 adc = 0x00;

void main() {

 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 start_SD();
 lcd_cmd(_LCD_CLEAR);


 while(1){

 adc = adc_read(0);

 imprime_Display();

 delay_ms(1000);

 }

}


void imprime_Display(){

 char mil, cen, dez, uni;

 valor = calcula_Tensao(adc);

 if(valor > valorMaximo){

 valorMaximo = valor;

 }

 if(valor < valorMinimo){

 valorMinimo = valor;

 }

 lcd_out(1, 2, "Voltimetro");

 mil = valor/1000;
 cen = (valor%1000)/100;
 dez = (valor%100)/10;
 uni = valor%10;

 lcd_chr(2, 6, mil + 0x30);
 lcd_chr_cp(cen + 0x30);
 lcd_chr_cp('.');
 lcd_chr_cp(dez + 0x30);
 lcd_chr_cp(uni + 0x30);

}


unsigned calcula_Tensao(int n){

 float tensao;

 tensao = ((n * 500.0) / 1023.0);

 return (unsigned)tensao;

}

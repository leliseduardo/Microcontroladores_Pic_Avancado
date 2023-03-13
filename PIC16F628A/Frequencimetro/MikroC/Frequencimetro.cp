#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Frequencimetro/MikroC/Frequencimetro.c"
#line 50 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F628A/Frequencimetro/MikroC/Frequencimetro.c"
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


char flag0 = 0x00;
unsigned tempo1, tempo2;
char txt[12];
unsigned long frequencia;

void interrupt(){

 if(CCP1IF_bit){

 CCP1IF_bit = 0x00;

 if(!flag0.B0){

 tempo1 = (CCPR1H << 8) + CCPR1L;

 flag0.B0 = 0x01;
 }
 else{

 tempo2 = (CCPR1H << 8) + CCPR1L;

 flag0.B0 = 0x00;

 }
 }
}

void main() {

 CMCON = 0x07;
 T1CON = 0x01;
 CCP1CON = 0x07;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 CCP1IE_bit = 0x01;

 TRISA = 0xFF;
 TRISB = 0x09;
 PORTA = 0xFF;
 PORTB = 0x00;

 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1,1,"Frequencia");
 lcd_out(2,14,"Hz");
 delay_ms(100);

 while(1){

 tempo2 = abs(tempo2 - tempo1);

 tempo2 = (tempo2) >> 4;

 frequencia = 1 / (tempo2 * 1E-6);

 LongToSTR(frequencia, txt);

 lcd_out(2,2,txt);

 delay_ms(100);
 }
}

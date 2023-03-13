
// Lcd pinout settings
sbit LCD_RS at RB3_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB3_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;


void main() {

     CMCON = 0x07;
     TRISA = 0x00;
     TRISB = 0x00;
     PORTA = 0x00;
     PORTB = 0x00;
     
     Lcd_Init();
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     
     Lcd_Out(1, 1, "Inicializando...");
     delay_ms(1000);
     Lcd_Cmd(_LCD_CLEAR);
     delay_ms(100);
     
     while(1){

       Lcd_Out(1,1,"Hello World!");
       delay_ms(100);
     }

}
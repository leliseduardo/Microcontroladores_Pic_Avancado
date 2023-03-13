// Lcd pinout settings
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;

// Configuração de hardware

#define aumentaDuty RA0_bit
#define diminuiDuty RA1_bit

//Variáveis globais

char *texto = "Ajuste de PWM";
char txt[7];
const unsigned freq = 1000;
unsigned char duty = 127; // Incia com um duty de 50%, já que 100% é 255
char cont = 0x00;

void interrupt(){

     if(T0IF_bit){
     
       T0IF_bit = 0x00;
       TMR0 = 0x64;
       
       cont++;
       
       if(cont == 0x02){
       
         cont = 0x00;
         
         if(!aumentaDuty)
           duty++;
         if(!diminuiDuty)
           duty--;
       }
     }
}

void main() {

     CMCON = 0x07; // Desabilita os comparadores internos
     OPTION_REG = 0x86; // Desabilita os pull-ups internos e configura o prescaler para 1:128
     INTCON = 0XA0; // Habilita a interrupção global e habilita a interrupção pelo timer0
     TMR0 = 0x64; // Inicia a contagem em 100 decimal, logo, o tempo de overflow = 1us x 128 x 156 = 19.9ms

     TRISA = 0xFF; // Configura todo porta como entrada digital
     TRISB = 0x01; // Configura apenas RB0 como entrada digital
     PORTA = 0xFF; // Inicia todo porta em High
     PORTB = 0x00; // Inicia todo portb em Low

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);
     lcd_out(1,1,texto);
     delay_ms(100);
   
     PWM1_Init(freq);
     PWM1_Start();
     PWM1_Set_Duty(duty);
   
     while(1){
       
       PWM1_Set_Duty(duty);
       
       IntToStr(duty, txt);
       
       lcd_out(2,2, txt);
       
       delay_ms(100);
     }
}
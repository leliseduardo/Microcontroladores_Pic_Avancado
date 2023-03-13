#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PIDSimples/MikroC/PIDSimples.c"
#line 45 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PIDSimples/MikroC/PIDSimples.c"
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


void controle_PID();
void imprime_Display();


double erro,
 PID,
 kp = 1.0,
 ki = 0.0,
 kd = 0.0,
 proporcional,
 integral,
 derivativo,
 valorIdeal = 512.0;

int medidaADC,
 ultimaMedida = 0x00,
 baseTempo,
 duty = 128;


void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 baseTempo += 1;

 }

}

void main() {


 TRISA = 0xFF;

 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 INTCON = 0xA0;
 T0CON = 0x81;
 TMR0H = 0x9E;
 TMR0L = 0x58;


 PWM1_Init(1000);
 PWM1_Start();
 PWM1_Set_Duty(duty);


 lcd_Init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);
 lcd_out(1, 2, "ADC: ");
 lcd_out(2, 2, "PWM: ");


 while(1){

 medidaADC = adc_read(0);

 PWM1_Set_Duty(duty);

 if(baseTempo == 40){

 baseTempo = 0x00;

 controle_PID();

 imprime_Display();

 }

 }

}

void controle_PID(){

 erro = valorIdeal - medidaADC;

 proporcional = erro * kp;

 integral += (erro * ki * 1);

 derivativo = (((ultimaMedida - medidaADC) * kd) / 1);

 ultimaMedida = medidaADC;

 PID = proporcional + integral + derivativo;

 PID = PID/4;
 duty = PID + 128;
 if(duty == 256) duty = 255;
#line 167 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PIDSimples/MikroC/PIDSimples.c"
}


void imprime_Display(){

 char dig1, dig2, dig3, dig4;
 char cen, dez, uni;

 dig4 = medidaADC/1000;
 dig3 = (medidaADC%1000)/100;
 dig2 = (medidaADC%100)/10;
 dig1 = medidaADC%10;

 lcd_chr(1, 7, dig4 + 48);
 lcd_chr_cp(dig3 + 48);
 lcd_chr_cp(dig2 + 48);
 lcd_chr_cp(dig1 + 48);

 cen = duty/100;
 dez = (duty%100)/10;
 uni = duty%10;

 lcd_chr(2, 7, cen + 48);
 lcd_chr_cp(dez + 48);
 lcd_chr_cp(uni + 48);

}

#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PIDTemperatura/MikroC/PIDTemperatura.c"
#line 16 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PIDTemperatura/MikroC/PIDTemperatura.c"
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
void celsius();
int media_Temperatura();
void CustomChar(char pos_row, char pos_char);


double erro,
 PID,
 kp = 9.2,
 ki = 0.0,
 kd = 0.0,
 proporcional,
 integral,
 derivativo,
 valorIdeal = 25.0;

int medidaADC,
 ultimaMedida = 0x00,
 baseTempo = 0x00,
 duty = 128;

double temperatura = 0.0,
 ultimaTemperatura = 0.0;
int adc = 0x00;
char txt[7];
const char character[] = {6,9,6,0,0,0,0,0};


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
 lcd_out(1, 2, "Temp: ");
 lcd_out(2, 2, "PWM: ");


 while(1){

 celsius();

 PWM1_Set_Duty(duty);

 if(baseTempo == 4){

 baseTempo = 0x00;

 controle_PID();

 imprime_Display();

 }

 }

}

void controle_PID(){

 medidaADC = temperatura;

 erro = valorIdeal - medidaADC;

 proporcional = erro * kp;

 integral += (erro * ki * 100E-3);

 derivativo = (((ultimaMedida - medidaADC) * kd) / 100E-3);

 ultimaMedida = medidaADC;

 PID = proporcional + integral + derivativo;

 PID = PID/4;
 duty = PID + 128;
 if(duty == 256) duty = 255;
#line 149 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/PIDTemperatura/MikroC/PIDTemperatura.c"
}


void imprime_Display(){

 char cen, dez, uni;

 cen = duty/100;
 dez = (duty%100)/10;
 uni = duty%10;

 lcd_chr(2, 7, cen + 48);
 lcd_chr_cp(dez + 48);
 lcd_chr_cp(uni + 48);

}

void celsius(){

 adc = media_Temperatura();

 temperatura = ((adc * 5.0) / 1024.0);

 temperatura = temperatura * 100.0;

 if(temperatura > (ultimaTemperatura + 0.5) || temperatura < (ultimaTemperatura - 0.5)){

 ultimaTemperatura = temperatura;

 FloatToStr(temperatura, txt);

 lcd_chr(1, 8, txt[0]);
 lcd_chr_cp(txt[1]);
 lcd_chr_cp(txt[2]);
 lcd_chr_cp(txt[3]);
 lcd_chr_cp(txt[4]);
 lcd_chr_cp(txt[5]);
 CustomChar(1, 14);
 lcd_chr(1, 15, 'C');


 }

}


int media_Temperatura(){

 char i;
 int media = 0x00;

 for(i = 0x00; i < 0x64; i++)
 media += adc_read(0);

 return (media/0x64);

}



void CustomChar(char pos_row, char pos_char) {

 char i;
 Lcd_Cmd(72);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 1);

}

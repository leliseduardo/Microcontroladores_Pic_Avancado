#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/RelogioDespertadorTermometro/MikroC/RelogioDespertadorTermometro.c"
#line 23 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/RelogioDespertadorTermometro/MikroC/RelogioDespertadorTermometro.c"
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









void CustomChar(char pos_row, char pos_char, char option);

void relogio();
void display_Relogio();
void ajuste_Relogio();

void alarme();
void display_Alarme();
void ajuste_Alarme();

void troca_Display();
void ativa_Alarme();

void celcius();
long media_Temperatura();


char flags = 0x00;
char flags2 = 0x00;

char segundo = 0x00, minuto = 0x00, hora = 0x00, dia = 0x00;
char *texto = "00:00:00";
char controleAjuste = 0x04;

char minuto_a = 0x00, hora_a = 0x00, dia_a = 0x00;
char *texto2 = "00:00";
char controleAjuste_a;
bit ligaBuzzer;

unsigned long temperatura = 0x00;
unsigned long ultimaTemperatura = 0x00;


void interrupt() {

 if(TMR1IF_bit){

 asm BSF TMR1H,7;

 TMR1IF_bit = 0x00;

 relogio();

 if(ligaBuzzer)
  LATB0_bit  = ~ LATB0_bit ;
 }

}


void main() {




 INTCON = 0xC0;


 TMR1IE_bit = 0x01;


 T1CON = 0x0B;



 TMR1L = 0x00;
 TMR1H = 0x80;


 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA = 0xFF;
 TRISB = 0xFE;

  LATB0_bit  = 0x00;
 ligaBuzzer = 0;


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);


 while(1){

 troca_Display();

 ativa_Alarme();

 celcius();

 }
}




void troca_Display(){

 if(flags.B6){

 if(! RB4_bit ) flags.B7 = 0x01;

 controleAjuste_a = 0x00;

 }

 if(( RB4_bit  && flags.B7) || flags2.B0){

 flags.B6 = 0x00;
 flags.B7 = 0x00;
 flags2.B0 = 0x01;

 display_Alarme();
 ajuste_Alarme();

 if(flags2.B1){

 if(! RB4_bit ) flags2.B2 = 0x01;

 if( RB4_bit  && flags2.B2) flags2.B0 = 0x00;

 }

 }
 else {

 flags2.B1 = 0x00;
 flags2.B2 = 0x00;

 display_Relogio();
 Ajuste_Relogio();

 }

}

void ativa_Alarme(){

 if(flags2.B3){
 if(! RB5_bit ) flags2.B4 = 0x01;

 if(ligaBuzzer){

 if(! RB6_bit ) flags2.B7 = 0x01;

 if( RB6_bit  && flags2.B7){

 flags2.B7 = 0x00;

 ligaBuzzer = 0x00;
  LATB0_bit  = 0;
 flags2.B6 = 0x01;

 }

 }

 if(( RB5_bit  && flags2.B4) || flags2.B5){

 flags2.B5 = 0x01;

 CustomChar(1, 4, 1);
 alarme();

 if(! RB5_bit ) flags2.B6 = 0x01;

 if( RB5_bit  && flags2.B6){

 flags2.B6 = 0x00;
 flags2.B5 = 0x00;
 flags2.B4 = 0x00;
 ligaBuzzer = 0x00;
  LATB0_bit  = 0;

 lcd_chr(1, 4, ' ');

 }

 }

 }

}



void relogio(){

 segundo++;

 if(segundo == 0x3C){

 segundo = 0x00;
 minuto++;

 if(minuto == 0x3C){

 minuto = 0x00;
 hora++;

 if(hora == 0x18){

 hora = 0x00;
 dia++;

 if(dia == 0x07)
 dia = 0x00;

 }

 }

 }


}

void display_Relogio(){

 texto[7] = segundo%10 + '0';
 texto[6] = segundo/10 + '0';
 texto[4] = minuto%10 + '0';
 texto[3] = minuto/10 + '0';
 texto[1] = hora%10 + '0';
 texto[0] = hora/10 + '0';

 lcd_chr(1, 3, ' ');
 lcd_out(1, 5, texto);

 switch(dia){

 case 0: lcd_chr(1, 14, 'D');
 lcd_chr_cp('o');
 lcd_chr_cp('m');
 break;
 case 1: lcd_chr(1, 14, 'S');
 lcd_chr_cp('e');
 lcd_chr_cp('g');
 break;
 case 2: lcd_chr(1, 14, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('r');
 break;
 case 3: lcd_chr(1, 14, 'Q');
 lcd_chr_cp('u');
 lcd_chr_cp('a');
 break;
 case 4: lcd_chr(1, 14, 'Q');
 lcd_chr_cp('u');
 lcd_chr_cp('i');
 break;
 case 5: lcd_chr(1, 14, 'S');
 lcd_chr_cp('e');
 lcd_chr_cp('x');
 break;
 case 6: lcd_chr(1, 14, 'S');
 lcd_chr_cp('a');
 lcd_chr_cp('b');
 break;

 }

}

void ajuste_Relogio(){

 char i;

 if(! RB7_bit ) flags.B0 = 0x01;
 if(! RB6_bit ) flags.B1 = 0x01;
 if(! RB5_bit ) flags.B2 = 0x01;

 if( RB7_bit  && flags.B0){

 flags.B0 = 0x00;

 controleAjuste++;

 if(controleAjuste > 4)
 controleAjuste = 0x00;

 }

 switch(controleAjuste){

 case 0x00: lcd_chr(1, 1, 'H');
 lcd_chr(2, 5, '^');
 lcd_chr_cp('^');
 flags.B6 = 0x00;
 flags2.B3 = 0x00;
 break;
 case 0x01: lcd_chr(1, 1, 'M');
 lcd_chr(2, 5, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 8, '^');
 lcd_chr_cp('^');
 flags.B6 = 0x00;
 flags2.B3 = 0x00;
 break;
 case 0x02: lcd_chr(1, 1, 'S');
 lcd_chr(2, 8, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 11, '^');
 lcd_chr_cp('^');
 flags.B6 = 0x00;
 flags2.B3 = 0x00;
 break;
 case 0x03: lcd_chr(1, 1, 'D');
 lcd_chr(2, 11, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 14, '^');
 lcd_chr_cp('^');
 lcd_chr_cp('^');
 flags.B6 = 0x00;
 flags2.B3 = 0x00;
 break;
 case 0x04: lcd_chr(1, 1, ' ');
 for(i = 0; i < 12; i++)
 lcd_chr(2, i+5, ' ');
 flags.B6 = 0x01;
 flags2.B3 = 0x01;
 break;

 }

 if( RB6_bit  && flags.B1){

 flags.B1 = 0x00;

 switch(controleAjuste){

 case 0x00: hora++;
 if(hora == 0x18)
 hora = 0x00;
 break;
 case 0x01: minuto++;
 if(minuto == 0x3C)
 minuto = 0x00;
 break;
 case 0x02: segundo++;
 if(segundo == 0x3C)
 segundo = 0x00;
 break;
 case 0x03: dia++;
 if(dia == 0x07)
 dia = 0x00;
 break;

 }

 }

 if( RB5_bit  && flags.B2){

 flags.B2 = 0x00;

 switch(controleAjuste){

 case 0x00: hora = hora + 10;
 if(hora >= 0x18)
 hora = 0x00;
 break;
 case 0x01: minuto = minuto + 10;
 if(minuto >= 0x3C)
 minuto = 0x00;
 break;
 case 0x02: segundo = segundo + 10;
 if(segundo >= 0x3C)
 segundo = 0x00;
 break;

 }

 }

}







void alarme(){

 if(hora == hora_a){

 if(minuto == minuto_a){

 if(dia == dia_a)
 ligaBuzzer = 1;

 }

 }
}

void display_Alarme(){

 texto2[4] = minuto_a%10 + '0';
 texto2[3] = minuto_a/10 + '0';
 texto2[1] = hora_a%10 + '0';
 texto2[0] = hora_a/10 + '0';

 CustomChar(1, 1, 1);
 lcd_out(1, 5, texto2);
 lcd_chr(1, 10, ' ');
 lcd_chr_cp(' ');
 lcd_chr_cp(' ');

 switch(dia_a){

 case 0: lcd_chr(1, 14, 'D');
 lcd_chr_cp('o');
 lcd_chr_cp('m');
 break;
 case 1: lcd_chr(1, 14, 'S');
 lcd_chr_cp('e');
 lcd_chr_cp('g');
 break;
 case 2: lcd_chr(1, 14, 'T');
 lcd_chr_cp('e');
 lcd_chr_cp('r');
 break;
 case 3: lcd_chr(1, 14, 'Q');
 lcd_chr_cp('u');
 lcd_chr_cp('a');
 break;
 case 4: lcd_chr(1, 14, 'Q');
 lcd_chr_cp('u');
 lcd_chr_cp('i');
 break;
 case 5: lcd_chr(1, 14, 'S');
 lcd_chr_cp('e');
 lcd_chr_cp('x');
 break;
 case 6: lcd_chr(1, 14, 'S');
 lcd_chr_cp('a');
 lcd_chr_cp('b');
 break;

 }

}

void ajuste_Alarme(){

 char i;

 if(! RB7_bit ) flags.B3 = 0x01;
 if(! RB6_bit ) flags.B4 = 0x01;
 if(! RB5_bit ) flags.B5 = 0x01;

 if( RB7_bit  && flags.B3){

 flags.B3 = 0x00;

 controleAjuste_a++;

 if(controleAjuste_a > 0x03)
 controleAjuste_a = 0x00;

 }

 switch(controleAjuste_a){

 case 0x00: lcd_chr(1, 3, 'H');
 lcd_chr(2, 5, '^');
 lcd_chr_cp('^');
 flags2.B1 = 0x00;
 flags2.B3 = 0x00;
 break;
 case 0x01: lcd_chr(1, 3, 'M');
 lcd_chr(2, 5, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 8, '^');
 lcd_chr_cp('^');
 flags2.B1 = 0x00;
 flags2.B3 = 0x00;
 break;
 case 0x02: lcd_chr(1, 3, 'D');
 lcd_chr(2, 8, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 14, '^');
 lcd_chr_cp('^');
 lcd_chr_cp('^');
 flags2.B1 = 0x00;
 flags2.B3 = 0x00;
 break;
 case 0x03: lcd_chr(1, 3, ' ');
 for(i = 0; i < 12; i++)
 lcd_chr(2, i+5, ' ');
 flags2.B1 = 0x01;
 flags2.B3 = 0x01;
 break;

 }

 if( RB6_bit  && flags.B4){

 flags.B4 = 0x00;

 switch(controleAjuste_a){

 case 0x00: hora_a++;
 if(hora_a == 0x18)
 hora_a = 0x00;
 break;
 case 0x01: minuto_a++;
 if(minuto_a == 0x3C)
 minuto_a = 0x00;
 break;
 case 0x02: dia_a++;
 if(dia_a == 0x07)
 dia_a = 0x00;
 break;

 }

 }

 if( RB5_bit  && flags.B5){

 flags.B5 = 0x00;

 switch(controleAjuste_a){

 case 0x00: hora_a = hora_a + 10;
 if(hora_a >= 0x18)
 hora_a = 0x00;
 break;
 case 0x01: minuto_a = minuto_a + 10;
 if(minuto_a >= 0x3C)
 minuto_a = 0x00;
 break;

 }

 }

}






void celcius(){

 char dez_t = 0x00, uni_t = 0x00;
 long media = 0x00;

 media = media_Temperatura();

 temperatura = ((media * 500) / 1024);

 if(temperatura > (ultimaTemperatura + 1) || temperatura < (ultimaTemperatura - 1)){

 ultimaTemperatura = temperatura;

 uni_t = (ultimaTemperatura % 10);
 dez_t = (ultimaTemperatura / 10);

 lcd_chr(2, 1, dez_t+48);
 lcd_chr_cp(uni_t+48);
 CustomChar(2, 3, 2);
 lcd_chr(2, 4, 'C');

 }

}

long media_Temperatura(){

 int i;
 long adc = 0x00;

 for(i = 0x00; i < 0x64; i++)
 adc += adc_read(0);

 return (adc/0x64);

}






void CustomChar(char pos_row, char pos_char, char option) {

 const char character[] = {21,10,14,17,29,21,17,14};
 const char character2[] = {6,9,6,0,0,0,0,0};

 if(option == 1){

 char i;
 Lcd_Cmd(64);
 for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 0);

 }
 else if(option == 2){

 char j;
 Lcd_Cmd(72);
 for (j = 0; j <= 7; j++) Lcd_Chr_CP(character2[j]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 1);

 }
}

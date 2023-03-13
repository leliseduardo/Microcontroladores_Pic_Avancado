#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Relógio/MikroC/Relogio.c"
#line 33 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F4520/Relógio/MikroC/Relogio.c"
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







void relogio();
void display_Relogio();
void ajuste_Relogio();


char segundo = 0x00, minuto = 0x00, hora = 0x00, dia = 0x00;
char *texto = "00:00:00";
char flags = 0x00;
char controleAjuste = 0x05;


void interrupt() {

 if(TMR1IF_bit){

 asm BSF TMR1H,7;

 TMR1IF_bit = 0x00;

 relogio();
 }

}

void main() {




 INTCON = 0xC0;


 TMR1IE_bit = 0x01;


 T1CON = 0x0B;



 TMR1L = 0x00;
 TMR1H = 0x80;

 ADCON1 = 0x0F;
 TRISB = 0xFF;


 lcd_init();
 lcd_cmd(_LCD_CURSOR_OFF);
 lcd_cmd(_LCD_CLEAR);


 while(1){

 display_Relogio();
 ajuste_Relogio();
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
 break;
 case 0x01: lcd_chr(1, 1, 'M');
 lcd_chr(2, 5, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 8, '^');
 lcd_chr_cp('^');
 break;
 case 0x02: lcd_chr(1, 1, 'S');
 lcd_chr(2, 8, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 11, '^');
 lcd_chr_cp('^');
 break;
 case 0x03: lcd_chr(1, 1, 'D');
 lcd_chr(2, 11, ' ');
 lcd_chr_cp(' ');
 lcd_chr(2, 14, '^');
 lcd_chr_cp('^');
 lcd_chr_cp('^');
 break;
 case 0x04: lcd_chr(1, 1, ' ');
 for(i = 0; i < 12; i++)
 lcd_chr(2, i+5, ' ');
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

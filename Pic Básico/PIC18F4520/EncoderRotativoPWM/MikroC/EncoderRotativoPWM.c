/* 

        O objetivo deste programa � aplicar a leitura do encoder ao PWM do pic, alterando, assim, o Duty Cicle a partir do encoder. O projeto �
    exatamente igual ao �ltimo, denominado "EncoderRotativo", e acrescenta apenas a biblioteca PWM1 do MikroC.
    
        Na simula��o do proteus o circuito e o programa funcionam perfeitamente. N�o fiz na pr�tica pois n�o tenho o datasheet do meu encoder e ele
    parece n�o ter a mesma pinagem do encoder visto na v�deo aula. Ent�o, para realizar esta pr�tica preciso achar o datasheet do modelo do meu
    encoder ou comprar um encoder novo no qual eu consiga facilmente seu datasheet.

*/

// Configura��o do LCD
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

// Fun��es auxiliares
void display_Encoder();
char leitura_Encoder();

// Vari�veis auxiliares
char txt[5];

void main() {

     ADCON1 = 0x0F; // Configura todos os ports que poderiam ser anal�gicos como digitais
     TRISC = 0xFB; // Configura RC2 como sa�da digital, o resto como entrada
     PORTC = 0xFB; // Inicia todas as entradas em High
     
     PWM1_Init(2000);
     PWM1_Set_Duty(128);
     PWM1_Start();

     lcd_init();
     lcd_cmd(_LCD_CURSOR_OFF);
     lcd_cmd(_LCD_CLEAR);

     // Loop infinito
     while(1){

       lcd_out(1, 2, "PWM Encoder");
       display_Encoder();

     } // end Loop nnfinito

} // end void main

void display_Encoder(){

     static unsigned short cont = 128;
     unsigned char cen = 0x00, dez = 0x00, uni = 0x00;
     unsigned short encoder;

     encoder = leitura_Encoder();

     if(encoder){

       lcd_cmd(_LCD_CLEAR);
       cont += encoder;

     } // end if encoder
     
     PWM1_Set_Duty(cont);

     cen = cont/100;
     dez = (cont%100)/10;
     uni = cont%10;

     lcd_chr(2, 7, cen + 48);
     lcd_chr_cp(dez + 48);
     lcd_chr_cp(uni + 48);

} // end void display_Encoder

char leitura_Encoder(){

     static unsigned short estadosEncoder[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
     static unsigned short AB = 0x00;

     AB <<= 2;
     AB |= ( PORTC & 0x03);

     return ( estadosEncoder[( AB & 0x0F )]);

} // end void leitura_Encoder




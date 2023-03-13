#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Projetos Praticos/PIC16F876A/Termometro/MikroC/TermometroV1.c"
#line 36 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Projetos Praticos/PIC16F876A/Termometro/MikroC/TermometroV1.c"
void display(unsigned short n);
void celsius();




char control = 0x00;
unsigned short dezena = 0x00, unidade = 0x00;
long mediaMovel = 0x00;

long temperatura = 0x00, ultimaTemperatura = 0x00;
int media[40];


void interrupt(){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0 = 0xB2;



 if(! RB3_bit  && control == 0x00){

  RB1_bit  = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
  RB3_bit  = 0x01;
 display(dezena);
 control = 0x01;

 }
 else if(! RB1_bit  && control == 0x01){

  RB3_bit  = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
  RB1_bit  = 0x01;
 display(unidade);
 control = 0x00;

 }

 }

}


void main() {


 CMCON = 0x07;

 TRISB = 0x15;
 TRISC = 0x0F;
 TRISA = 0xFF;

 OPTION_REG = 0x85;
 INTCON = 0xA0;
 TMR0 = 0xB2;
  RB3_bit  = 0x00;
  RB1_bit  = 0x00;

 ADCON0 = 0x41;
 ADCON1 = 0x4E;



 while(1){

 celsius();

 delay_ms(1000);

 }

}




void celsius(){


 mediaMovel = adc_read(0);

 temperatura = ((mediaMovel * 500) / 1024);

 if((temperatura > ultimaTemperatura + 1) || (temperatura < ultimaTemperatura - 1)){

 ultimaTemperatura = temperatura;

 if(temperatura > 99){

 dezena = 0x09;
 unidade = 0x09;

 }
 else if(temperatura < 1){

 dezena = 0x00;
 unidade = 0x00;
 }
 else{

 dezena = temperatura / 10;
 unidade = temperatura % 10;

 }

 }


}
#line 192 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Projetos Praticos/PIC16F876A/Termometro/MikroC/TermometroV1.c"
void display(unsigned short n){

 switch(n){

 case 0: RC4_bit = 0x01;
 RC5_bit = 0x01;
 RC6_bit = 0x01;
 RC7_bit = 0x01;
 RB5_bit = 0x01;
 RB6_bit = 0x01;
 RB7_bit = 0x00;
 break;
 case 1: RC4_bit = 0x00;
 RC5_bit = 0x01;
 RC6_bit = 0x01;
 RC7_bit = 0x00;
 RB5_bit = 0x00;
 RB6_bit = 0x00;
 RB7_bit = 0x00;
 break;
 case 2: RC4_bit = 0x01;
 RC5_bit = 0x01;
 RC6_bit = 0x00;
 RC7_bit = 0x01;
 RB5_bit = 0x01;
 RB6_bit = 0x00;
 RB7_bit = 0x01;
 break;
 case 3: RC4_bit = 0x01;
 RC5_bit = 0x01;
 RC6_bit = 0x01;
 RC7_bit = 0x01;
 RB5_bit = 0x00;
 RB6_bit = 0x00;
 RB7_bit = 0x01;
 break;
 case 4: RC4_bit = 0x00;
 RC5_bit = 0x01;
 RC6_bit = 0x01;
 RC7_bit = 0x00;
 RB5_bit = 0x00;
 RB6_bit = 0x01;
 RB7_bit = 0x01;
 break;
 case 5: RC4_bit = 0x01;
 RC5_bit = 0x00;
 RC6_bit = 0x01;
 RC7_bit = 0x01;
 RB5_bit = 0x00;
 RB6_bit = 0x01;
 RB7_bit = 0x01;
 break;
 case 6: RC4_bit = 0x01;
 RC5_bit = 0x00;
 RC6_bit = 0x01;
 RC7_bit = 0x01;
 RB5_bit = 0x01;
 RB6_bit = 0x01;
 RB7_bit = 0x01;
 break;
 case 7: RC4_bit = 0x01;
 RC5_bit = 0x01;
 RC6_bit = 0x01;
 RC7_bit = 0x00;
 RB5_bit = 0x00;
 RB6_bit = 0x00;
 RB7_bit = 0x00;
 break;
 case 8: RC4_bit = 0x01;
 RC5_bit = 0x01;
 RC6_bit = 0x01;
 RC7_bit = 0x01;
 RB5_bit = 0x01;
 RB6_bit = 0x01;
 RB7_bit = 0x01;
 break;
 case 9: RC4_bit = 0x01;
 RC5_bit = 0x01;
 RC6_bit = 0x01;
 RC7_bit = 0x00;
 RB5_bit = 0x00;
 RB6_bit = 0x01;
 RB7_bit = 0x01;
 break;

 }

}

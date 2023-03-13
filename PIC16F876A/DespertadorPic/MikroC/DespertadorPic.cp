#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/DespertadorPic/MikroC/DespertadorPic.c"
#line 45 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/DespertadorPic/MikroC/DespertadorPic.c"
int display(int num);
void relogio();
void ajusteRelogio();
void alarme();



int milesimo, centena, dezena, unidade;
char seg = 0x00;
char minu = 0x00;
char hora = 0x00;
char control = 0x01;
char cont = 0x00;
char flag = 0x00;

char minuAlarme = 0x00;
char horaAlarme = 0x00;




void interrupt(){

 if(INTF_bit){

 INTF_bit = 0x00;

 flag.B3 = ~flag.B3;

 if(flag.B3)  RA2_bit  = 0x01;
 else  RA2_bit  = 0x00;
 }

 if(T0IF_bit){

 T0IF_bit = 0x00;

 if(flag.B3){
 if(minuAlarme == minu && horaAlarme == hora)
  RA1_bit  = 0x01;
 else
  RA1_bit  = 0x00;
 }
 else
  RA1_bit  = 0x00;

 if(!flag.B2){
 if(! RB1_bit  && control == 0x01){

  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
 control = 0x02;
 PORTC = 0x00;
 milesimo = (hora%100)/10;
  RB1_bit  = 0x01;
 PORTC = display(milesimo);
 }
 else if(! RB2_bit  && control == 0x02){

  RB1_bit  = 0x00;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
 control = 0x03;
 PORTC = 0x00;
 centena = hora%10;
  RB2_bit  = 0x01;
 PORTC = display(centena);
 }
 else if(! RB3_bit  && control == 0x03){

  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
  RB4_bit  = 0x00;
 control = 0x04;
 PORTC = 0x00;
 dezena = (minu%100)/10;
  RB3_bit  = 0x01;
 PORTC = display(dezena);
 }
 else if(! RB4_bit  && control == 0x04){

  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
 control = 0x01;
 PORTC = 0x00;
 unidade = minu%10;
  RB4_bit  = 0x01;
 PORTC = display(unidade);
 }
 }
 if(flag.B2){
 if(! RB1_bit  && control == 0x01){

  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
 control = 0x02;
 PORTC = 0x00;
 milesimo = (horaAlarme%100)/10;
  RB1_bit  = 0x01;
 PORTC = display(milesimo);
 }
 else if(! RB2_bit  && control == 0x02){

  RB1_bit  = 0x00;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
 control = 0x03;
 PORTC = 0x00;
 centena = horaAlarme%10;
  RB2_bit  = 0x01;
 PORTC = display(centena);
 }
 else if(! RB3_bit  && control == 0x03){

  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
  RB4_bit  = 0x00;
 control = 0x04;
 PORTC = 0x00;
 dezena = (minuAlarme%100)/10;
  RB3_bit  = 0x01;
 PORTC = display(dezena);
 }
 else if(! RB4_bit  && control == 0x04){

  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
 control = 0x01;
 PORTC = 0x00;
 unidade = minuAlarme%10;
  RB4_bit  = 0x01;
 PORTC = display(unidade);
 }
 }
 }

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1H = 0x0B;
 TMR1L = 0xDC;

  RB7_bit  = ~ RB7_bit ;

 cont++;

 if(cont == 0x02){

 cont = 0x00;
 seg++;
 }
 }
}

void main(){

 CMCON = 0x07;
 ADCON0 = 0x00;
 ADCON1 = 0x07;

 OPTION_REG = 0x83;
 INTCON = 0xB0;

 T1CON = 0x31;
 TMR1IE_bit = 0x01;
 TMR1H = 0x0B;
 TMR1L = 0xDC;

 TRISA = 0xF9;
 TRISB = 0x61;
 TRISC = 0x80;
 PORTA = 0xF9;
 PORTB = 0x30;
 PORTC = 0x80;

 while(1){

 relogio();

 if(! RA0_bit ) flag.B2 = ~flag.B2;
 delay_ms(70);

 if( RA0_bit  && !flag.B2)
 ajusteRelogio();
 else if( RA0_bit  && flag.B2)
 alarme();
 }
}

void relogio(){

 if(seg > 59){

 seg = 0;
 minu++;

 if(minu > 59){

 minu = 0;
 hora++;

 if(hora > 23)
 hora = 0;
 }
 }
}

void ajusteRelogio(){

 if(! RB5_bit )
 flag.B0 = 0x01;
 if(! RB6_bit )
 flag.B1 = 0x01;

 if( RB5_bit  && flag.B0){

 flag.B0 = 0x00;
 minu++;

 if(minu > 59) minu = 0;
 }
 if( RB6_bit  && flag.B1){

 flag.B1 = 0x00;
 hora++;

 if(hora > 23) hora = 0;
 }
}

void alarme(){

 if(! RB5_bit ) flag.B0 = 0x01;
 if(! RB6_bit ) flag.B1 = 0x01;

 if( RB5_bit  && flag.B0){

 flag.B0 = 0x00;
 minuAlarme++;

 if(minuAlarme > 59) minuAlarme = 0;
 }
 if( RB6_bit  && flag.B1){

 flag.B1 = 0x00;
 horaAlarme++;

 if(horaAlarme > 23) hora = 0;
 }
}

 int display(int num){

 int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67};
 int aux;

 aux = vetorDisplay[num];

 return aux;
}

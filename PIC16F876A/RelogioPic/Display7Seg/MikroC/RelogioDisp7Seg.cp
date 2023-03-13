#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/RelogioPic/Display7Seg/MikroC/RelogioDisp7Seg.c"
#line 46 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/RelogioPic/Display7Seg/MikroC/RelogioDisp7Seg.c"
int display(int num);
void relogio();
void arrumaRelogio();



int milesimo, centena, dezena, unidade;
char seg = 0x00;
char minu = 0x00;
char hora = 0x00;
char control = 0x01;
char cont = 0x00;
char flag = 0x00;



void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;

 if(! RB0_bit  && control == 0x01){

  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
 control = 0x02;
 PORTC = 0x00;
 milesimo = (hora%100)/10;
  RB0_bit  = 0x01;
 PORTC = display(milesimo);
 }
 else if(! RB1_bit  && control == 0x02){

  RB0_bit  = 0x00;
  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
 control = 0x03;
 PORTC = 0x00;
 centena = hora%10;
  RB1_bit  = 0x01;
 PORTC = display(centena);
 }
 else if(! RB2_bit  && control == 0x03){

  RB0_bit  = 0x00;
  RB1_bit  = 0x00;
  RB3_bit  = 0x00;
 control = 0x04;
 PORTC = 0x00;
 dezena = (minu%100)/10;
  RB2_bit  = 0x01;
 PORTC = display(dezena);
 }
 else if(! RB3_bit  && control == 0x04){

  RB0_bit  = 0x00;
  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
 control = 0x01;
 PORTC = 0x00;
 unidade = minu%10;
  RB3_bit  = 0x01;
 PORTC = display(unidade);
 }
 }

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR1H = 0x0B;
 TMR1L = 0xDC;

  RB6_bit  = ~ RB6_bit ;

 cont++;

 if(cont == 0x02){

 cont = 0x00;
 seg++;
 }
 }
}

void main(){

 CMCON = 0x07;

 OPTION_REG = 0x83;
 INTCON = 0xA0;

 T1CON = 0x31;
 TMR1IE_bit = 0x01;
 TMR1H = 0x0B;
 TMR1L = 0xDC;

 TRISB = 0xB0;
 TRISC = 0x80;
 PORTB = 0xB0;
 PORTC = 0x80;

 while(1){

 relogio();
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

 if(! RB4_bit )
 flag.B0 = 0x01;
 if(! RB5_bit )
 flag.B1 = 0x01;

 if( RB4_bit  && flag.B0){

 flag.B0 = 0x00;
 minu++;

 if(minu > 59){

 minu = 0;
 hora++;

 if(hora > 59)
 hora = 0;
 }
 }
 if( RB5_bit  && flag.B1){

 flag.B1 = 0x00;
 hora++;

 if(hora > 23)
 hora = 0;
 }
}


 int display(int num){

 int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67};
 int aux;

 aux = vetorDisplay[num];

 return aux;
}

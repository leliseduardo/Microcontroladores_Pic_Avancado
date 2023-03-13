#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/MultiplexacaoDispInterrup/MikroC/MultiplexacaoDispInterrup.c"
#line 19 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC16F876A/MultiplexacaoDispInterrup/MikroC/MultiplexacaoDispInterrup.c"
void contador();
int display(int num);


char control = 0x01;
unsigned cont = 0x00;
int mil = 0x00;
int cen = 0x00;
int dez = 0x00;
int uni = 0x00;

void interrupt(){

 if(T0IF_bit){

 T0IF_bit = 0x00;
 TMR0 = 0x00;

 if(! RB0_bit  && control == 0x01){

 control = 0x02;
  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
 PORTC = 0x00;
 mil = cont / 1000;
  RB0_bit  = 0x01;
 PORTC = display(mil);
 }
 else if(! RB1_bit  && control == 0x02){

 control = 0x03;
  RB0_bit  = 0x00;
  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
 PORTC = 0x00;
 cen = (cont%1000) / 100;
  RB1_bit  = 0x01;
 PORTC = display(cen);
 }
 else if(! RB2_bit  && control == 0x03){

 control = 0x04;
  RB0_bit  = 0x00;
  RB1_bit  = 0x00;
  RB3_bit  = 0x00;
 PORTC = 0x00;
 dez = (cont % 100) / 10;
  RB2_bit  = 0x01;
 PORTC = display(dez);
 }
 else if(! RB3_bit  && control == 0x04){

 control = 0x01;
  RB0_bit  = 0x00;
  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
 PORTC = 0x00;
 uni = cont%10;
  RB3_bit  = 0x01;
 PORTC = display(uni);
 }
 }
}

void main() {
 CMCON = 0x07;
 OPTION_REG = 0x83;
 INTCON = 0xA0;
 TMR0 = 0x00;

 TRISB = 0xF0;
 TRISC = 0x80;
 PORTB = 0xF0;
 PORTC = 0x80;

 while(1){

 contador();
 }
}

void contador(){

 if( Rb4_bit ){

 cont++;
 if(cont > 9999) cont = 0;
 delay_ms(100);
 }
 else{

 cont--;
 if(cont < 0) cont = 9999;
 delay_ms(100);
 }
}

int display(int num){

 int vetorDisplay[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67};
 int aux;

 aux = vetorDisplay[num];

 return aux;
}

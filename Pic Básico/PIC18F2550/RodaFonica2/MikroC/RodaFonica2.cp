#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/RodaFonica2/MikroC/RodaFonica2.c"
#line 69 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/RodaFonica2/MikroC/RodaFonica2.c"
void base_Tempo();
void leitura_Botao();


unsigned baseTempo1 = 0x00,
 baseTempo2 = 0x00,
 contMotor = 0x06,
 contTMR1 = 0x00;

unsigned short rpmEncoder = 0x00,
 rpmEncoder2 = 0x00,
 rpmEncoder3 = 0x00;

bit flagBotao;

void main() {

 ADCON1 = 0x0F;
 INTCON2.F7 = 0x00;
 TRISB = 0xC0;
 LATB = 0xC0;

 T0CON = 0x81;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 T1CON = 0xB1;
 TMR0H = 0x3C;
 TMR0L = 0xB0;

 T2CON = 0x7C;
 PR2 = 0xAA;

 flagBotao = 0x00;


 while(1){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 baseTempo1 += 1;
 baseTempo2 += 1;

 base_Tempo();

 }

 if(TMR1IF_bit){

 TMR1IF_bit = 0x00;
 TMR0H = 0x3C;
 TMR0L = 0xB0;

 contTMR1 += 1;

 if(contTMR1 == 0x0A){

 contTMR1 = 0x00;
 contMotor += 1;

 if(contMotor == 0x05){

 contMotor = 0x06;
  LATB2_bit  = 0x00;

 }

 }

 leitura_Botao();

 }

 if(TMR2IF_bit){

 TMR2IF_bit = 0x00;

 rpmEncoder += 1;
 rpmEncoder2 += 1;
 rpmEncoder3 += 1;


 if(rpmEncoder < 116)  LATB3_bit  = ~ LATB3_bit ;
 else  LATB3_bit  = 0x00;

 if(rpmEncoder == 120) rpmEncoder = 0x00;


 if(rpmEncoder2 < 14)  LATB4_bit  = ~ LATB4_bit ;
 else  LATB4_bit  = 0x00;

 if(rpmEncoder2 == 16) rpmEncoder2 = 0x00;


 if(rpmEncoder3 < 70)  LATB5_bit  = ~ LATB5_bit ;
 else  LATB5_bit  = 0x00;

 if(rpmEncoder3 == 72) rpmEncoder3 = 0x00;
#line 181 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/RodaFonica2/MikroC/RodaFonica2.c"
 }

 }

}



void base_Tempo(){

 if(baseTempo1 == 0x0A){

 baseTempo1 = 0x00;

  LATB0_bit  = ~ LATB0_bit ;

 }



 if(baseTempo2 == 0x014){

 baseTempo2 = 0x00;

  LATB1_bit  = ~ LATB1_bit ;

 }


}



void leitura_Botao(){

 if(! RB7_bit ) flagBotao = 0x01;

 if( RB7_bit  && flagBotao){

 flagBotao = 0x00;
  LATB2_bit  = 0x01;
 contMotor = 0x00;

 }

}

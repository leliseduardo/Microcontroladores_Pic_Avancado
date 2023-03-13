#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/MultiplasTarefas/MikroC/MultiplasTarefas.c"
#line 59 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/MultiplasTarefas/MikroC/MultiplasTarefas.c"
void base_Tempo();
void leitura_Botao();


unsigned baseTempo1 = 0x00,
 baseTempo2 = 0x00,
 contMotor = 0x06,
 contTMR1 = 0x00;

bit flagBotao;

void main() {

 ADCON1 = 0x0F;
 INTCON2.F7 = 0x00;
 TRISB = 0xF8;
 LATB = 0xF8;

 T0CON = 0x81;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 T1CON = 0xB1;
 TMR0H = 0x3C;
 TMR0L = 0xB0;

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

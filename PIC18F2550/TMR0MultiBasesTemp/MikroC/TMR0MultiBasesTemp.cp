#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/TMR0MultiBasesTemp/MikroC/TMR0MultiBasesTemp.c"
#line 46 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/TMR0MultiBasesTemp/MikroC/TMR0MultiBasesTemp.c"
void base_Tempo();


unsigned baseTempo1 = 0x00,
 baseTempo2 = 0x00,
 baseTempo3 = 0x00,
 baseTempo4 = 0x00;

void main() {

 ADCON1 = 0x0F;
 TRISB = 0xF0;
 LATB = 0xF0;

 T0CON = 0x81;
 TMR0H = 0x9E;
 TMR0L = 0x58;


 while(1){

 if(TMR0IF_bit){

 TMR0IF_bit = 0x00;
 TMR0H = 0x9E;
 TMR0L = 0x58;

 baseTempo1 += 1;
 baseTempo2 += 1;
 baseTempo3 += 1;
 baseTempo4 += 1;

 base_Tempo();

 }

 }

}



void base_Tempo(){

 if(baseTempo1 == 0x02){

 baseTempo1 = 0x00;

  LATB0_bit  = ~ LATB0_bit ;

 }



 if(baseTempo2 == 0x0A){

 baseTempo2 = 0x00;

  LATB1_bit  = ~ LATB1_bit ;

 }



 if(baseTempo3 == 0x14){

 baseTempo3 = 0x00;

  LATB2_bit  = ~ LATB2_bit ;

 }



 if(baseTempo4 == 0x28){

 baseTempo4 = 0x00;

  LATB3_bit  = ~ LATB3_bit ;

 }

}

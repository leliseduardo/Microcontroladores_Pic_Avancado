#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/DetectorFrequencias/MikroC/DetectorFrequencias.c"
#line 10 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/DetectorFrequencias/MikroC/DetectorFrequencias.c"
void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 LATB = 0xFE;

 T3CON = 0x83;

 while(1){

 if(TMR3IF_bit){

 TMR3IF_bit = 0x00;

  LATB0_bit  = ~ LATB0_bit ;

 }



 }

}

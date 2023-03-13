#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Projetos Praticos/PIC16F628A/PicDuino/MikroC/PicDuino.c"
#line 15 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Projetos Praticos/PIC16F628A/PicDuino/MikroC/PicDuino.c"
void main() {

 CMCON = 0x07;
 TRISA = 0xF3;
 TRISB = 0xFF;
  RA2_bit  = 0x00;
  RA3_bit  = 0x00;


 while(1){

 if(! RA0_bit )
  RA2_bit  = 0x01;
 else
  RA2_bit  = 0x00;

 if(! RA1_bit )
  RA3_bit  = 0x01;
 else
  RA3_bit  = 0x00;

 }

}

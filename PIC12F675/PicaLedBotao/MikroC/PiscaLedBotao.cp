#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic B�sico/PIC12F675/PicaLedBotao/MikroC/PiscaLedBotao.c"
void main() {

 ANSEL = 0x00;
 CMCON = 7;

 TRISIO4_bit = 1;
 TRISIO5_bit = 0;

 GPIO = 0;

 while(1){

 if(GPIO.F4){
 GPIO.F5 = 1;
 delay_ms(2000);
 }
 else
 GPIO.F5 = 0;

 }

}

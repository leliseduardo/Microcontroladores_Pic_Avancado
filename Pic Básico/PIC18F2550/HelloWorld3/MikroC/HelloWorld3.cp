#line 1 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/HelloWorld3/MikroC/HelloWorld3.c"
#line 21 "C:/Users/eleli/Documents/Cursos/Curso de Pic/Pic Básico/PIC18F2550/HelloWorld3/MikroC/HelloWorld3.c"
void pisca_Led();


long var1, var2, var3, var4, var5, var6, var7, var8;


void main() {

 ADCON1 = 0x0F;
 TRISB = 0xFE;
 PORTB = 0xFE;
 LATB0_bit = 0x00;


 while(1){

 pisca_Led();

 var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251;


 var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251; var1 = 5555;
 var2 = 888888;
 var3 = 4444;
 var4 = 7777;
 var5 = 777777;
 var6 = 8888;
 var7 = 666666;
 var8 = 555251;

 }

}

void pisca_Led(){

 LATB0_bit = 0x01;
 delay_ms(200);
 LATB0_bit = 0x00;
 delay_ms(200);

}
